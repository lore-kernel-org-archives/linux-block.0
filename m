Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F1EC433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 02:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7E92070A
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 02:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ90dy8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgG1C2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:28:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726237AbgG1C2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 22:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595903297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiDsW1mxODuDRagWOcYLyjZA51GVxAdT/vgWQXKJytE=;
        b=bQ90dy8lEVnyylGW0Fv5VJkSxXTRQul+YWgvkxpYHPBt0RdisMOUzy8eeWcuh5joed3WLk
        K8n/9PA4aPo2keFQVmor/QMqeOcMH9F8X4xVeIZdWcaoZUcjlQKspXhe13ad7pdrekwD1r
        j7zT8p0UstM4Z27bbvHwmT50NcqOUAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-cWzPJ-mtMWWxGoe2LqL3_w-1; Mon, 27 Jul 2020 22:28:15 -0400
X-MC-Unique: cWzPJ-mtMWWxGoe2LqL3_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DC1100CCC0;
        Tue, 28 Jul 2020 02:28:14 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E942C71D06;
        Tue, 28 Jul 2020 02:28:06 +0000 (UTC)
Date:   Tue, 28 Jul 2020 10:28:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728022802.GC1305646@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
 <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 08:23:15PM -0600, Jens Axboe wrote:
> On 7/27/20 8:17 PM, Ming Lei wrote:
> > On Mon, Jul 27, 2020 at 07:51:16PM -0600, Jens Axboe wrote:
> >> On 7/27/20 7:40 PM, Ming Lei wrote:
> >>> On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> >>>> drivers that have shared tagsets may need to quiesce potentially a lot
> >>>> of request queues that all share a single tagset (e.g. nvme). Add an interface
> >>>> to quiesce all the queues on a given tagset. This interface is useful because
> >>>> it can speedup the quiesce by doing it in parallel.
> >>>>
> >>>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> >>>> in parallel such that all of them wait for the same rcu elapsed period with
> >>>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> >>>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> >>>> sufficient.
> >>>>
> >>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>>> ---
> >>>>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
> >>>>  include/linux/blk-mq.h |  4 +++
> >>>>  2 files changed, 70 insertions(+)
> >>>>
> >>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>>> index abcf590f6238..c37e37354330 100644
> >>>> --- a/block/blk-mq.c
> >>>> +++ b/block/blk-mq.c
> >>>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> >>>>  
> >>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
> >>>> +{
> >>>> +	struct blk_mq_hw_ctx *hctx;
> >>>> +	unsigned int i;
> >>>> +
> >>>> +	blk_mq_quiesce_queue_nowait(q);
> >>>> +
> >>>> +	queue_for_each_hw_ctx(q, hctx, i) {
> >>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> >>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> >>>> +		if (!hctx->rcu_sync)
> >>>> +			continue;
> >>>
> >>> This approach of quiesce/unquiesce tagset is good abstraction.
> >>>
> >>> Just one more thing, please allocate a rcu_sync array because hctx is
> >>> supposed to not store scratch stuff.
> >>
> >> I'd be all for not stuffing this in the hctx, but how would that work?
> >> The only thing I can think of that would work reliably is batching the
> >> queue+wait into units of N. We could potentially have many thousands of
> >> queues, and it could get iffy (and/or unreliable) in terms of allocation
> >> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
> >> doesn't take a lot of devices at current CPU counts to make an alloc
> >> covering all of it huge. Let's say 64 threads, and 32 devices, then
> >> we're already at 64*32*48 bytes which is an order 5 allocation. Not
> >> friendly, and not going to be reliable when you need it. And if we start
> >> batching in reasonable counts, then we're _almost_ back to doing a queue
> >> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
> >> the time for single page allocations.
> > 
> > We can convert to order 0 allocation by one extra indirect array. 
> 
> I guess that could work, and would just be one extra alloc + free if we
> still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
> round, potentially way less of course if we have more CPUs. So still
> somewhat limiting, rather than do all at once.

With the approach in blk_mq_alloc_rqs(), each allocated page can be added
to one list, so the indirect array can be saved. Then it is possible to allocate
for any size queues/devices since every allocation is just for single page
in case that it is needed, even no pre-calculation is required.


Thanks,
Ming

