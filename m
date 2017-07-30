Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Date: Sun, 30 Jul 2017 15:50:15 +0200
Message-ID: <1662218.y9oETEnj5A@natalenko.name>
In-Reply-To: <1501391551.17388.31.camel@gmx.de>
References: <5912148.iRCpNe8Dyb@natalenko.name> <1501391551.17388.31.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hello Mike et al.

On ned=C4=9Ble 30. =C4=8Dervence 2017 7:12:31 CEST Mike Galbraith wrote:
> FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
> stable fixed it.

My build already includes v4.12.4.

> If not, I'd find these two commits irresistible.
>=20
> 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue mappi=
ng
> 4b855ad37194f blk-mq: Create hctx for each present CPU

I've applied these 2 commits, and cannot reproduce the issue anymore. Looks=
=20
like a perfect hit, thanks!

> 'course applying random upstream bits does come with some risk, trying
> a kernel already containing them has less "entertainment" potential.=20

Should you consider applying them to v4.12.x stable series? CC'ing Greg jus=
t=20
in case.
