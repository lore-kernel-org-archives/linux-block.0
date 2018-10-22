Return-Path: <konrad.r.wilk@gmail.com>
Return-Path: <konrad.r.wilk@gmail.com>
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date: Mon, 22 Oct 2018 15:31:33 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
Subject: [GIT PULL] (xen) stable/for-jens-4.20
Message-ID: <20181022193132.GB20677@dhcp-10-175-29-12.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
List-ID: <linux-block@vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Jens,

Please git pull the following branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-jens-4.20

which has exactly one tiny patch fixing an NULL pointer issue (also has stable tree CCed).

Thank you!

drivers/block/xen-blkfront.c | 3 +++
 1 file changed, 3 insertions(+)

Vasilis Liaskovitis (2):
      xen/blkfront: avoid NULL blkfront_info dereference on device removal


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbziWUAAoJEFKlDoTx2wm/LeEP/jzfxixLC5x9JxlYAg9G3VwF
h0pzABE7VDNPfeRTIV152g63xdtiBjWMTK74bO/hkqxvmtsCEeKzIm8MQPj+QF7P
jWadDoVLFds7yKxSJq6vm5wPqd+C6hZsmQUFVjNAnLX1nfxy8GjjsavMyJxHVMCe
oB2WF9Frk9K6yn4gUxmjOyWWD0N2eNNFuPNb+OLjx0/l/lG7p0ADCZ0fwEZgywJ4
6yFgHy8DBsWYqfe1RMT3t5wULFxNeaV3hiI+2YLcYtcmCoHJHwSQd4DjPhO1WsNx
LyhK37BIhX3P4aqLwVxMlSEuBR+VPxRH6mslrJoxOAhZJCloYEEjivNUadKlO1kR
BjM/1fVlDsHF5IbtreBghCO3mlZ+QJI7Zzr3ijh0jy5Il61VKp2BdbjxCgmbZPLq
IeAO4h+Q/kBLrBrU2HPda0NACjah9Eq/5ajY7TcG/CoHY+V9TkNsBLL5qG4ioq5Q
OokX1ZFbOvFvOVwLZmaJTvC9IsPnUeQrWbgr7JAPqiq7+A/CSz9uT6cXJ1mDrfZB
I9B5M3lhugaqPcL+LkGpXFPcl+yie2LAHWUGxDTBzYMmpER+Wy8DQiw1qzcDFhzh
L/XnPK05Kr1Dt4IROoWunwzMb53B/QJ1u3yttoQ1sTpFLi+La46O9ej7HL2l7/Hn
oaxGGpPP4yhb8t9WJ6CQ
=HN4e
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
