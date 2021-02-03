Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6634BC433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323E564F68
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 02:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBCChA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBCCg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 21:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612319730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j31I0qfJW8o1jTsGzPpgphG99t9GEJijgoDVPezyzDs=;
        b=YTdY2XqgrUYBHAz8DZFD4MkXkfyaKXS/dVRfI3TXx5DFwjzq/FbgdLKc9tBVjc6C93LyNL
        qvUZKsNQ6MqvGUYvKtqwOOM+Vs6IcMp5OXOCsAJ0XmnSOEtXQI9kaTLlBQckbWGlm0x0oo
        HgLI+iPzdsXeD6e7Fhgx+5syx9OMyL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-7J_PbA-0MUaJ6OiPyykl5A-1; Tue, 02 Feb 2021 21:35:29 -0500
X-MC-Unique: 7J_PbA-0MUaJ6OiPyykl5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24534107ACE3;
        Wed,  3 Feb 2021 02:35:28 +0000 (UTC)
Received: from T590 (ovpn-13-198.pek2.redhat.com [10.72.13.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EB811F6;
        Wed,  3 Feb 2021 02:35:22 +0000 (UTC)
Date:   Wed, 3 Feb 2021 10:35:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
Message-ID: <20210203023517.GA948998@T590>
References: <20210201164850.391332-1-djeffery@redhat.com>
 <20210202033343.GA165584@T590>
 <20210202204355.GA31803@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202204355.GA31803@redhat>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 02, 2021 at 03:43:55PM -0500, David Jeffery wrote:
> On Tue, Feb 02, 2021 at 11:33:43AM +0800, Ming Lei wrote:
> > 
> > On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > > When a stacked block device inserts a request into another block device
> > > using blk_insert_cloned_request, the request's nr_phys_segments field gets
> > > recalculated by a call to blk_recalc_rq_segments in
> > > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not know how to
> > > handle multi-segment discards. For disk types which can handle
> > > multi-segment discards like nvme, this results in discard requests which
> > > claim a single segment when it should report several, triggering a warning
> > > in nvme and causing nvme to fail the discard from the invalid state.
> > > 
> > >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700 nvme_setup_discard+0x170/0x1e0 [nvme_core]
> > >  ...
> > >  nvme_setup_cmd+0x217/0x270 [nvme_core]
> > >  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
> > >  __blk_mq_try_issue_directly+0xe7/0x1b0
> > >  blk_mq_request_issue_directly+0x41/0x70
> > >  ? blk_account_io_start+0x40/0x50
> > >  dm_mq_queue_rq+0x200/0x3e0
> > >  blk_mq_dispatch_rq_list+0x10a/0x7d0
> > >  ? __sbitmap_queue_get+0x25/0x90
> > >  ? elv_rb_del+0x1f/0x30
> > >  ? deadline_remove_request+0x55/0xb0
> > >  ? dd_dispatch_request+0x181/0x210
> > >  __blk_mq_do_dispatch_sched+0x144/0x290
> > >  ? bio_attempt_discard_merge+0x134/0x1f0
> > >  __blk_mq_sched_dispatch_requests+0x129/0x180
> > >  blk_mq_sched_dispatch_requests+0x30/0x60
> > >  __blk_mq_run_hw_queue+0x47/0xe0
> > >  __blk_mq_delay_run_hw_queue+0x15b/0x170
> > >  blk_mq_sched_insert_requests+0x68/0xe0
> > >  blk_mq_flush_plug_list+0xf0/0x170
> > >  blk_finish_plug+0x36/0x50
> > >  xlog_cil_committed+0x19f/0x290 [xfs]
> > >  xlog_cil_process_committed+0x57/0x80 [xfs]
> > >  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
> > >  xlog_ioend_work+0x2f/0x80 [xfs]
> > >  process_one_work+0x1b6/0x350
> > >  worker_thread+0x53/0x3e0
> > >  ? process_one_work+0x350/0x350
> > >  kthread+0x11b/0x140
> > >  ? __kthread_bind_mask+0x60/0x60
> > >  ret_from_fork+0x22/0x30
> > > 
> > > This patch fixes blk_recalc_rq_segments to be aware of devices which can
> > > have multi-segment discards. It calculates the correct discard segment
> > > count by counting the number of bio as each discard bio is considered its
> > > own segment.
> > > 
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > ---
> > >  block/blk-merge.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > > index 808768f6b174..fe7358bd5d09 100644
> > > --- a/block/blk-merge.c
> > > +++ b/block/blk-merge.c
> > > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
> > >  
> > >  	switch (bio_op(rq->bio)) {
> > >  	case REQ_OP_DISCARD:
> > > +		if (queue_max_discard_segments(rq->q) > 1) {
> > > +			struct bio *bio = rq->bio;
> > > +			for_each_bio(bio)
> > > +				nr_phys_segs++;
> > > +			return nr_phys_segs;
> > > +		}
> > > +		/* fall through */
> > >  	case REQ_OP_SECURE_ERASE:
> > 
> > REQ_OP_SECURE_ERASE needs to be covered since block layer treats
> > the two in very similar way from discard viewpoint.
> > 
> > Also single range discard should be fixed too, since block layer
> > thinks single-range discard req segment is 1. Otherwise, the warning in
> > virtblk_setup_discard_write_zeroes() still may be triggered, at least.
> > 
> > 
> > -- 
> > Ming
> >
> 
> The return 0 does seem to be an old relic that does not make sense anymore.
> Moving REQ_OP_SECURE_ERASE to be with discard and removing the old return 0,
> is this what you had in mind?
> 
>  
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 808768f6b174..68458aa01b05 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -383,8 +383,14 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
>  	switch (bio_op(rq->bio)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> +		if (queue_max_discard_segments(rq->q) > 1) {
> +			struct bio *bio = rq->bio;
> +			for_each_bio(bio)
> +				nr_phys_segs++;
> +			return nr_phys_segs;
> +		}
> +		/* fall through */
>  	case REQ_OP_WRITE_ZEROES:
> -		return 0;
>  	case REQ_OP_WRITE_SAME:
>  		return 1;

WRITE_SAME uses same buffer, so the nr_segment is still one; WRITE_ZERO
doesn't need extra payload, so nr_segments is zero, see
blk_bio_write_zeroes_split(), blk_bio_write_same_split, attempt_merge()
and blk_rq_merge_ok().

-- 
Ming

