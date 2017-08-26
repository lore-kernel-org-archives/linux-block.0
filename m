Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Wols Lists <antlists@youngman.org.uk>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shli@kernel.org>
Subject: Re: I/O hangs after resuming from suspend-to-ram
Date: Sat, 26 Aug 2017 21:33:04 +0200
Message-ID: <3987895.gqtK3X00tl@merkaba>
In-Reply-To: <59A1AD17.70208@youngman.org.uk>
References: <3926917.BCSovyVWdL@natalenko.name> <4679671.be02cq1OFG@merkaba> <59A1AD17.70208@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Wols Lists - 26.08.17, 18:17:
> On 26/08/17 12:19, Martin Steigerwald wrote:
> > Also=E2=80=A6 when a hang happened the mouse pointer was frozen, Ctrl-A=
lt-F1
> > didn=C2=B4t
> > work and so on=E2=80=A6 so it may easily be a completely different issu=
e.
> >=20
> > I did not see much point in reporting it so far=E2=80=A6 as I have no i=
dea on how
> > to reliably pin-point the issue. It happens once every few days, so a
> > bisect again is out of questions =E2=80=93 (it is anyway for a producti=
on machine
> > for me) =E2=80=93, it appears to be a hard freeze, so no debug data=E2=
=80=A6 its one of
> > these "you don=C2=B4t get to debug me" hangs again. I really have no id=
ea how
> > to a get hold on such complexity. I am hoping to at least pin-point the
> > exact kernel option that triggers this issue, but it may take weeks to =
do
> > so. I=C2=B4d really love a way for the kernel to at least to write out =
debug
> > data before doing hanging completely.
>=20
> This sounds like what I'm getting - SuSE 42.3, no raid, doesn't happen
> when the power lead is in (but I think the laptop is configured not to
> suspend when powered, precisely to avoid exactly this).
>=20
> It happens to me quite often, unfortunately, but it seems a KDE issue in
> that applications work fine, UNTIL KDE seems to get control of the mouse
> at which point I can't do anything.
>=20
> I've got a feeling it's related to wireless networking actually, my
> setup is somewhat borked because KDE, systemd, and wifi don't seem to
> work nicely together :-(

Well my issue isn=C2=B4t related to wireless networking as my laptop at hom=
e is=20
using good old cable based ethernet. I do use Plasma tough. The issue of th=
e=20
original poster appears to be blk-mq related.

As written, I have no idea whether my issue is related to blk-mq in any way=
=2E=20
Thats the next step I=C2=B4d test. If the current kernel runs stable=E2=80=
=A6 then I=C2=B4d=20
enable blk-mq by default again and test whether the hangs reappear. Unless =
I=20
can pinpoint the issue to blk-mq=E2=80=A6 I have nothing further to comment=
 here, I=20
think. (And I didn=C2=B4t intend to use the thread for every hang on resume=
 issue=20
that currently may exist. I just don=C2=B4t know yet whether my issue is re=
lated to=20
blk-mq so I chimed in.)

Thanks,
=2D-=20
Martin
