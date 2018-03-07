Return-Path: <jonathan.derrick@intel.com>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "Bauer, Scott" <scott.bauer@intel.com>,
	"jonas.rabenstein@studium.uni-erlangen.de"
	<jonas.rabenstein@studium.uni-erlangen.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH][RESEND] block: sed-opal: fix response string extraction
Date: Wed, 7 Mar 2018 00:23:24 +0000
Message-ID: <1520382203.4178.87.camel@intel.com>
References: <20180301132637.1230-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20180301132637.1230-1-jonas.rabenstein@studium.uni-erlangen.de>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-ADUGnyFcKkq7uWI66hkK"
MIME-Version: 1.0
Return-Path: jonathan.derrick@intel.com
List-ID: <linux-block@vger.kernel.org>

--=-ADUGnyFcKkq7uWI66hkK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks correct.

Adding my Ack unless Scott has objections

Acked-by: Jonathan Derrick <jonathan.derrick@intel.com>

On Thu, 2018-03-01 at 14:26 +0100, Jonas Rabenstein wrote:
> Tokens are prefixed by a variable length of bytes. If a bytestring is
> not stored in an tiny or short atom, we have to skip more than one
> byte
> in order to have the actual bytes not prefixed by the bytes
> describing
> the actual length of the string.
>=20
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlange
> n.de>
> ---
>  block/sed-opal.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 525506bed399..33052d0111de 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -876,6 +876,9 @@ static int response_parse(const u8 *buf, size_t
> length,
>  static size_t response_get_string(const struct parsed_resp *resp,
> int n,
>  				  const char **store)
>  {
> +	u8 skip;
> +	const struct opal_resp_tok *token;
> +
>  	*store =3D NULL;
>  	if (!resp) {
>  		pr_debug("Response is NULL\n");
> @@ -888,13 +891,30 @@ static size_t response_get_string(const struct
> parsed_resp *resp, int n,
>  		return 0;
>  	}
> =20
> -	if (resp->toks[n].type !=3D OPAL_DTA_TOKENID_BYTESTRING) {
> +	token =3D &resp->toks[n];
> +	if (token->type !=3D OPAL_DTA_TOKENID_BYTESTRING) {
>  		pr_debug("Token is not a byte string!\n");
>  		return 0;
>  	}
> =20
> -	*store =3D resp->toks[n].pos + 1;
> -	return resp->toks[n].len - 1;
> +	switch (token->width) {
> +	case OPAL_WIDTH_TINY:
> +	case OPAL_WIDTH_SHORT:
> +		skip =3D 1;
> +		break;
> +	case OPAL_WIDTH_MEDIUM:
> +		skip =3D 2;
> +		break;
> +	case OPAL_WIDTH_LONG:
> +		skip =3D 4;
> +		break;
> +	default:
> +		pr_debug("Token has invalid width!\n");
> +		return 0;
> +	}
> +
> +	*store =3D token->pos + skip;
> +	return token->len - skip;
>  }
> =20
>  static u64 response_get_u64(const struct parsed_resp *resp, int n)
--=-ADUGnyFcKkq7uWI66hkK
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
AG6qjTBc2iB2iz6IVnzrBtQT5DR3KM6EqbMTwur8keTC11xls7lwWexzsSgt37V9UNKAqfsZPgcX
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQUJRdznv8EeAa3g+3F5NKtNNctuBcwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA5LNb+VnWY0V21FlNjnQ2BIb5gmlED29zwQiC5yezn
2SexgvN31129iJSkXuiBHdcVJiUAUPHYuxPRwumwbrkY6m+sYi9kIzKt+ZKNNAN4WbnavsbyRBlb
cIn2E5swqD+sks8AmKivHmg+gFeboLaOf+EqVihIz1Wec1PpbX98R1t2ep7Y/81DD1fIjAWHl6Mq
TJwjKQuYB01kkJdXZAGPXUQSARR1y2D1YpCkDqfGH2STaB4nenD4INSyhTGo5RV9wwTAibyrIq50
rnmvBnHTmICQVdHuIhG1gGmDLUAGqfrU3W2QJr9gkICdrTMgIEdd8s73wknaZxZKqfRxnMVQMYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAKye+0C3syvSXOcAAAAArJ4wCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMwNzAwMjMyM1owIwYJ
KoZIhvcNAQkEMRYEFMoUDmHaV0YKNifiGMFQnXytUht7MA0GCSqGSIb3DQEBAQUABIIBAFK+qDM/
IBP1B+s5Qsk/paTmZ+7zH+RbKtOzPmthsnNTYY/Sxrfo3E7WZUrpcqoT65dEBS2BS2Aa8A/4DZ8k
b9xzgXDEvSFpdn/7hEdaqv1Ms06Gg/8s9wrEbZjKDcvFQ9mQRDozvM5aNIZ72NELh+crnOmi+JF5
rUXk6n89z5D4R+RfTgS5J5KmKs0BPp+oYntUaizxDjw/GngiwKGRBkCEvJZ+bt3808N8jrnTq62z
fNsJ46q6G8F0UQlS2qKumJOdibiEFKoYrgjh/kjiE6we0Mj3SiDUnOwwm0g0KIyPWZ6xLvdMB3yj
t0a30Xp7Wnsepl9Iyed/S8EkOnZIrsQAAAAAAAA=


--=-ADUGnyFcKkq7uWI66hkK--
