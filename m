Return-Path: <efault@gmx.de>
Message-ID: <1501391551.17388.31.camel@gmx.de>
Subject: Re: blk-mq breaks suspend even with runtime PM patch
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sun, 30 Jul 2017 07:12:31 +0200
In-Reply-To: <5912148.iRCpNe8Dyb@natalenko.name>
References: <5912148.iRCpNe8Dyb@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-07-29 at 17:27 +0200, Oleksandr Natalenko wrote:
> Hello Jens, Christoph.
>=20
> Unfortunately, even with "block: disable runtime-pm for blk-mq" patch app=
lied=20
> blk-mq breaks suspend to RAM for me. It is reproducible on my laptop as w=
ell=20
> as in a VM.
>=20
> I use complex disk layout involving MD, LUKS and LVM, and managed to get =
these=20
> warnings from VM via serial console when suspend fails:
>=20
> =3D=3D=3D
> [  245.516573] INFO: task kworker/0:1:49 blocked for more than 120 second=
s.
> [  245.520025]       Not tainted 4.12.0-pf4 #1

FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
stable fixed it. =C2=A0If not, I'd find these two commits irresistible.

5f042e7cbd9eb=C2=A0blk-mq: Include all present CPUs in the default queue ma=
pping
4b855ad37194f blk-mq: Create hctx for each present CPU

'course applying random upstream bits does come with some risk, trying
a kernel already containing them has less "entertainment" potential.=C2=A0

	-Mike
