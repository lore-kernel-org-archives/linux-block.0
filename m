Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "markus@trippelsdorf.de" <markus@trippelsdorf.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove leading whitespace and trailing newline in
 elevator switch error message
Date: Mon, 8 May 2017 16:52:34 +0000
Message-ID: <1494262353.2591.11.camel@sandisk.com>
References: <20170506052243.GB291@x4> <1494258478.2591.7.camel@sandisk.com>
	 <20170508164836.GA17152@x4>
In-Reply-To: <20170508164836.GA17152@x4>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-05-08 at 18:48 +0200, markus@trippelsdorf.de wrote:
> On 2017.05.08 at 15:47 +0000, Bart Van Assche wrote:
> > On Sat, 2017-05-06 at 07:22 +0200, markus@trippelsdorf.de wrote:
> > > -	ret =3D __elevator_change(q, name);
> > > +	strlcpy(elevator_name, skip_spaces(name), sizeof(elevator_name));
> >=20
> > Please include the version number of a patch in the e-mail subject line=
 when
> > posting a second or later version. Regarding the strlcpy() call, in the
> > FreeBSD strlcpy() man page I found the following: "If the src and dst s=
trings
> > overlap, the behavior is undefined." Since the Linux kernel implementat=
ion of
> > strlcpy() uses memcpy() and since the ANSI C standard does not allow th=
at
> > memcpy() input and output buffers overlap, please rework this code. See=
 e.g.
> > http://pubs.opengroup.org/onlinepubs/9699919799/functions/memcpy.html
>=20
> I don't see how src and dst could possibly overlap here.

Hello Markus,

Sorry - I misread your patch. Since that was the only comment I had:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
