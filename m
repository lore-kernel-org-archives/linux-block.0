Return-Path: <massimo@burcheri.de>
Message-ID: <1535698162.6624.31.camel@burcheri.de>
Subject: Re: blk-mq crashing on battery mode
From: Massimo Burcheri <massimo@burcheri.de>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
In-Reply-To: <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
References: <1534926011.18658.29.camel@burcheri.de>
	 <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
	 <1535092156.11909.8.camel@burcheri.de>
	 <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-43iEQBTRbqeAJEy0+Dhb"
Date: Fri, 31 Aug 2018 08:49:22 +0200
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-43iEQBTRbqeAJEy0+Dhb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-24 at 15:12 +0800, jianchao.wang wrote:
> So this issue should not related with io scheduler.

Hi, I can't localize the specific issue and have changed the subject to blk=
-mq.

> Would you please share the entire dmesg log or backtrace you got on 4.18.=
3 ?

Have you been able to reproduce this? I reproduced the backtrace on a vanil=
la
4.18.3:
https://ibin.co/4E3q5dETqA5T.jpg

Best regards,
Massimo
--=-43iEQBTRbqeAJEy0+Dhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAluI5PIACgkQlQj3p5VS
ZjLWOg/+OoHTqFGVd1DSUkWeie6Z0a3PmgFyFESfIIQDOz1xNIR4j/XPvxDR1gut
BXa+lydeJ062GQI+QZZYfhCIOAh1QvrZ2A6dOabar1zM8cDUzaVuRV49a8CK7QOu
DFN5Nh40G2uYRF8mrd6szurzJlTUm8dRixpTxQk5+pwfB3TZU3H2w/d7MAKIxDPH
FzfUup+qLpXSoxUpz1JXSpeOsTVPPTgOqcTMI+nTnnY/WJAMfRr4mFP3MUOTpsWs
ovQoHveFZK9OiWs2xlr+ybEQ3JHMqPecnD8PvKu5xkPA3tODbUYj/bxt+0swzrio
bEZx4ZMWKhLXWppgRAbsPxFb9lXK7kIDDF3AGf3uorFtdPuiKaTd/oxt91oLagKt
SR3xHG1bvyI0AqCQ1PSF4xlg+U7nRWmrramU63VIuoxGpxxRe2CqQP3wgL72UFOt
YCyGFrfPaCmbIltczhkVZoA+UpY+yB2eoZIbYugVirqiZ3znTmbFYNZn3t8/jyqL
sQBWmtuNIkakhqciF9w4AU385iCUpwkpQxUtXGzgKhyNmfaDV/u6ZcIvqpQi2y6D
6kmFD8pTfDkSWCZblOC/c+e2TV3Xvg2HjzyT6Av0xEhs11vwZV2mzug69lrb++Et
yj1xOwB/LU/q3/OzTGpq4RUDWoy/8qApi7yBryw0JSHreie5NSQ=
=hEIB
-----END PGP SIGNATURE-----

--=-43iEQBTRbqeAJEy0+Dhb--
