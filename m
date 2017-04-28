Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50524 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423684AbdD1ULF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 16:11:05 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Date: Fri, 28 Apr 2017 20:11:01 +0000
Message-ID: <1493410261.2767.19.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
         <20170428151539.25514-4-ming.lei@redhat.com>
         <c8984e2a-ecdc-fdf7-afba-484b823270c9@fb.com>
In-Reply-To: <c8984e2a-ecdc-fdf7-afba-484b823270c9@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-28 at 12:22 -0600, Jens Axboe wrote:
> On 04/28/2017 09:15 AM, Ming Lei wrote: =20
> > +/*
> > + * If this queue has enough hardware tags and doesn't share tags with
> > + * other queues, just use hw tag directly for scheduling.
> > + */
> > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q=
)
> > +{
> > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > +		return false;
> > +
> > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > +		return false;
>=20
> I think we should leave a bigger gap. Ideally, for scheduling, we should
> have a hw queue depth that's around half of what the scheduler has to
> work with. That will always leave us something to schedule with, if the
> hw can't deplete the whole pool.

Hello Jens,

The scsi-mq core allocates exactly the same number of tags per hardware
queue as the SCSI queue depth. Requiring that there is a gap would cause
BLK_MQ_F_SCHED_USE_HW_TAG not to be enabled for any scsi-mq LLD. I'm not
sure that changing the tag allocation strategy in scsi-mq would be the best
solution. How about changing blk_mq_sched_may_use_hw_tag() into something
like the below to guarantee that the scheduler has sufficient tags availabl=
e?

static bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
{
=A0=A0=A0=A0=A0=A0=A0 return=A0blk_mq_get_queue_depth(q) >=3D max(q->nr_req=
uests, 16);
}

Thanks,

Bart.=
