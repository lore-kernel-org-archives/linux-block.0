Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>, "hare@suse.com" <hare@suse.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v7 9/9] block, scsi: Make SCSI quiesce and resume work reliably
Date: Thu, 12 Oct 2017 21:53:57 +0200
Message-ID: <3970766.W9abtXnTZN@merkaba>
In-Reply-To: <1507649241.2815.9.camel@wdc.com>
References: <20171009231400.562-1-bart.vanassche@wdc.com> <2538545.nE4DvSpPT1@merkaba> <1507649241.2815.9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Bart Van Assche - 10.10.17, 15:27:
> On Tue, 2017-10-10 at 09:57 +0200, Martin Steigerwald wrote:
>=20
> > Bart Van Assche - 09.10.17, 16:14:
> >=20
> > > The contexts from which a SCSI device can be quiesced or resumed are:
> > > [ ... ]
> >=20
> >=20
> > Does this as reliably fix the issue as the patches from Ming? I mean in
> > *real world* scenarios? Or is it just about the same approach as Ming
> > has taken.=20
> > I ask cause I don=B4t see any Tested-By:=B4s here? I know I tested Ming=
=B4s
> > patch series and I know it fixes the hang after resume from suspend
> > with blk-mq + BFQ issue for me. I have an uptime of 7 days and I didn=
=B4t
> > see any uptime even remotely like that in a long time (before that issue
> > Intel gfx drivers caused hangs, but thankfully that seems fixed
> > meanwhile).
> >=20
> > I=B4d be willing to test. Do you have a 4.14.x tree available with these
> > patches applied I can just add as a remote and fetch from?

> A previous version of this patch series passed Oleksandr's tests. This
> series is close to that previous version so I think it is safe to assume
> that this version will also pass Oleksandr's tests. Anyway, more testing =
is
> definitely welcome so if you want to verify this series please start from
> the following tree (Jens' for-next branch + this series):
> https://github.com/bvanassche/linux/tree/blk-mq-pm-v7=20

Several suspend to ram and resume, and suspend to disk and resume cycles=20
without issues. So I think this is good.

Tested-By: Martin Steigerwald <martin@lichtvoll.de>

Thanks,
=2D-=20
Martin
