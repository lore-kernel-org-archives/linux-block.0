Return-Path: <oleksandr@natalenko.name>
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg KH <gregkh@linuxfoundation.org>, Mike Galbraith <efault@gmx.de>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: blk-mq breaks suspend even with runtime PM patch
Date: Tue, 08 Aug 2017 18:36:01 +0200
Message-ID: <2416479.dXsOYsr7UT@natalenko.name>
In-Reply-To: <843d7ee7-63b9-d34c-6d91-dea0b940d330@kernel.dk>
References: <5912148.iRCpNe8Dyb@natalenko.name> <20170808162252.GC23338@kroah.com> <843d7ee7-63b9-d34c-6d91-dea0b940d330@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Could you queue "block: disable runtime-pm for blk-mq" too please? It is al=
so=20
related to suspend-resume freezes that were observed by multiple users.

Thanks.

On =C3=BAter=C3=BD 8. srpna 2017 18:33:29 CEST Jens Axboe wrote:
> On 08/08/2017 10:22 AM, Greg KH wrote:
> > On Sun, Jul 30, 2017 at 03:50:15PM +0200, Oleksandr Natalenko wrote:
> >> Hello Mike et al.
> >>=20
> >> On ned=C4=9Ble 30. =C4=8Dervence 2017 7:12:31 CEST Mike Galbraith wrot=
e:
> >>> FWIW, first thing I'd do is update that 4.12.0 to 4.12.4, and see if
> >>> stable fixed it.
> >>=20
> >> My build already includes v4.12.4.
> >>=20
> >>> If not, I'd find these two commits irresistible.
> >>>=20
> >>> 5f042e7cbd9eb blk-mq: Include all present CPUs in the default queue
> >>> mapping
> >>> 4b855ad37194f blk-mq: Create hctx for each present CPU
> >>=20
> >> I've applied these 2 commits, and cannot reproduce the issue anymore.
> >> Looks
> >> like a perfect hit, thanks!
> >>=20
> >>> 'course applying random upstream bits does come with some risk, trying
> >>> a kernel already containing them has less "entertainment" potential.
> >>=20
> >> Should you consider applying them to v4.12.x stable series? CC'ing Greg
> >> just in case.
> >=20
> > I can queue these up if I get an ack from the developers/maintainers
> > that it is ok to do so...
>=20
> You can add those two commits to stable.
