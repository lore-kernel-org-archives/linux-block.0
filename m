Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31179 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdEAQ2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2017 12:28:39 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is
 big enough
Date: Mon, 1 May 2017 15:06:16 +0000
Message-ID: <1493651174.2665.1.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
         <20170428151539.25514-4-ming.lei@redhat.com>
         <1493402979.2767.10.camel@sandisk.com> <20170429103554.GC12421@ming.t460p>
In-Reply-To: <20170429103554.GC12421@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2017-04-29 at 18:35 +0800, Ming Lei wrote:
> On Fri, Apr 28, 2017 at 06:09:40PM +0000, Bart Van Assche wrote:
> > On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> > > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue =
*q)
> > > +{
> > > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > > +		return false;
> > > +
> > > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> >=20
> > The only user of shared tag sets I know of is scsi-mq. I think it's rea=
lly
> > unfortunate that this patch systematically disables BLK_MQ_F_SCHED_USE_=
HW_TAG
> > for scsi-mq.
>=20
> In previous patch, I actually allow driver to pass this flag, but this
> feature is dropped in this post, just for making it simple & clean.
> If you think we need it for shared tag set, I can add it in v1.
>=20
> For shared tag sets, I suggest to not enable it at default, because
> scheduler is per request queue now, and generaly more requests available,
> better it performs.  When tags are shared among several request
> queues, one of them may use tags up for its own scheduling, then
> starve others. But it should be possible and not difficult to allocate
> requests fairly for scheduling in this case if we switch to per-hctx
> scheduling.

Hello Ming,

Have you noticed that there is already a mechanism in the block layer to
avoid starvation if a tag set is shared? The hctx_may_queue() function
guarantees that each user that shares a tag set gets at least some tags.
The .active_queues counter keeps track of the number of hardware queues
that share a tag set.

Bart.=
