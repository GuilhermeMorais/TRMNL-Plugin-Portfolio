import sys
import urllib.request
import urllib.error

URL = (
	"http://trmnl.<YOUR_DOMAIN>.com/index.php?refresh=true&pass=XXXXYYYYZZZZ"
)


def check_url_status(url: str, timeout: int = 15) -> int:
	req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
	with urllib.request.urlopen(req, timeout=timeout) as resp:
		# `status` attribute is present in modern Python; fall back to `getcode()`
		return getattr(resp, "status", resp.getcode())


def main() -> int:
	try:
		status = check_url_status(URL)
		print(f"HTTP {status}")
		if status != 200:
			print("Error: unexpected status code")
			return 1
		return 0
	except urllib.error.HTTPError as e:
		print(f"HTTPError: {e.code} - {e.reason}")
		return 1
	except urllib.error.URLError as e:
		print(f"URLError: {e.reason}")
		return 1
	except Exception as e:
		print(f"Unexpected error: {e}")
		return 1

if __name__ == "__main__":
	sys.exit(main())

