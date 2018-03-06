Return-Path: <jonathan.derrick@intel.com>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "Bauer, Scott" <scott.bauer@intel.com>,
	"jonas.rabenstein@studium.uni-erlangen.de"
	<jonas.rabenstein@studium.uni-erlangen.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH][RESEND] block: sed-opal: fix u64 short atom length
Date: Tue, 6 Mar 2018 23:45:14 +0000
Message-ID: <1520379912.4178.83.camel@intel.com>
References: <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-d8NuL9zfMejDWQd2LDRh"
MIME-Version: 1.0
Return-Path: jonathan.derrick@intel.com
List-ID: <linux-block@vger.kernel.org>

--=-d8NuL9zfMejDWQd2LDRh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Thu, 2018-03-01 at 14:27 +0100, Jonas Rabenstein wrote:
> The length must be given as bytes and not as 4 bit tuples.
>=20
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlange
> n.de>
> ---
>  block/sed-opal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 36842bfa572e..d5f565e1557a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -562,7 +562,7 @@ static void add_token_u64(int *err, struct
> opal_dev *cmd, u64 number)
>  	}
> =20
>  	msb =3D fls(number);
> -	len =3D DIV_ROUND_UP(msb, 4);
> +	len =3D DIV_ROUND_UP(msb, 8);

This change looks partially correct, but I believe we should be doing
fls64() on 'number' as well.

It looks like it currently coincidentally works with u64 numbers
falling in 32-bit ranges.


> =20
>  	if (cmd->pos >=3D IO_BUFFER_LENGTH - len - 1) {
>  		pr_debug("Error adding u64: end of buffer.\n");
--=-d8NuL9zfMejDWQd2LDRh
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMwNjIzNDUxMlowIwYJ
KoZIhvcNAQkEMRYEFC6UnZxFJwQK9vn9TlAhodBQ1j3pMA0GCSqGSIb3DQEBAQUABIIBAKijeo2x
ZBA6lxKukdGNDA8EobA+UwDMb/JXSpHrepK51mykwgM8z6aFR+HlzisMHAMV4ix/tPn4t6XqTyk/
UPqbt0qFVHNSs+NnPeNmCeX2VE0+d00bBcP9b32uGXmIpibDUzeck092s+Q8/0PBScMzgP4gRfnt
AuUTdDTw0KC1SaNk6rpZRLExujt5fYRZ51g3tdA8mDyXJEFBfkQaTH2DlvL82fqZG4xk9OSUHTiC
Skx9wI9Gl2zZnZ9xeHCMJWBiJzEJA7SIa/iD3HNlkMfIbt13sNbFKik0ljD2C+WG+EVHq+xVdiKx
uoWOgUVmp0aI6U9xe+Gxn+vHs6/m/78AAAAAAAA=


--=-d8NuL9zfMejDWQd2LDRh--
