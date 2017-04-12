Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [PATCH] blk-mq: Fix blk_execute_rq_nowait() handling of dying
 queues
Date: Wed, 12 Apr 2017 18:24:24 +0000
Message-ID: <1492021462.2764.13.camel@sandisk.com>
References: <20170411235848.8686-1-bart.vanassche@sandisk.com>
	 <CACVXFVOg3C-H14z5Qt1qz79qQeeg1zg6Xs2noHTHApwJ6+zwaw@mail.gmail.com>
In-Reply-To: <CACVXFVOg3C-H14z5Qt1qz79qQeeg1zg6Xs2noHTHApwJ6+zwaw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-12 at 13:01 +0800, Ming Lei wrote:
> On Wed, Apr 12, 2017 at 7:58 AM, Bart Van Assche
> <bart.vanassche@sandisk.com> wrote:
> >=20
> > diff --git a/block/blk-exec.c b/block/blk-exec.c
> > index 8cd0e9bc8dc8..f7d9bed2cb15 100644
> > --- a/block/blk-exec.c
> > +++ b/block/blk-exec.c
> > @@ -57,10 +57,13 @@ void blk_execute_rq_nowait(struct request_queue *q,=
 struct gendisk *bd_disk,
> >         rq->end_io =3D done;
> >=20
> >         /*
> > -        * don't check dying flag for MQ because the request won't
> > -        * be reused after dying flag is set
> > +        * The blk_freeze_queue() call in blk_set_queue_dying() and the
> > +        * test of the "dying" flag in blk_queue_enter() guarantee that
> > +        * blk_execute_rq_nowait() won't be called anymore after the "d=
ying"
> > +        * flag has been set.
>=20
> That never be guaranteed, see the following case:
>=20
> 1) blk_get_request() is called just before queue is set as dying in anoth=
er path
>=20
> 2) the request is allocated successfully and passed to
> blk_execute_rq_nowait() even
> though queue has been set as dying

Hello Ming,

Shouldn't the blk-mq code guarantee that blk_execute_rq_nowait() won't be
called anymore after the "dying" flag has been set? I think changing the
blk_freeze_queue_start() call into blk_freeze_queue() in blk_set_queue_dyin=
g()
is sufficient to achieve this.

Note: after I had posted this patch I have been able to reproduce the issue
described in the patch description. Although I still think we need the patc=
h
at the start of this e-mail thread, it doesn't fix the issue I described.

Bart.=
