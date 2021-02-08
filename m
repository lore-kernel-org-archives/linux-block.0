Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F8C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572D464E59
	for <linux-block@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhBHS4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235904AbhBHSzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 13:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612810439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slz549sLXmgGbJvvPg5wWcJ6ZSBY84ldKi8yzbg/etU=;
        b=jVd/9LiQw2jV1o63PFSXj8w8PidjL517HTFOM7rx5E7g+iP4glixR2ZZrVIq3WsNXUNYIM
        X7gbrkbafJZG0lsS4VL1Kz57tl0idZpCiXL2xUfp6u2+0PHMJ8D3HF3IoiCZVpQhUX1Rkn
        TuBw15VTSuY8cIfInodm7xXwAZVucDE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-4zgSolbXNOqrSO83fvt1uQ-1; Mon, 08 Feb 2021 13:53:56 -0500
X-MC-Unique: 4zgSolbXNOqrSO83fvt1uQ-1
Received: by mail-qv1-f69.google.com with SMTP id dh16so11247034qvb.11
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 10:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slz549sLXmgGbJvvPg5wWcJ6ZSBY84ldKi8yzbg/etU=;
        b=A/qDBo8mmPjOXNTQnBZinhLMty60xJ6twTIY+rbUzL5X+jleA6SyZyFnYPIz6NP0Fs
         UzNfwcWV64mFTlC1u6vwYy4Dc/sXuZ6Jr36i5VP1YkM25kbpm9xtmf2sbM1Hb1hVrWWi
         hPf4aAz5opr973GxLdQW8T+zOSochG0tMshUfc0x2pmsKVnPlkElfPsAxG/KROCpU16y
         oumsCjFoVTkMOq3fRRBOLFQqT7UERj5yqvaluxGEhQ7q+NNyTYJzMvWaZvKk44gvxPQr
         bYvvgPl6XPywzrqL34XQ2gxJszkP8ZVGktjT02ZBXsxH7fYH0dPQm4OPLdbmiTcYwDVy
         tPKA==
X-Gm-Message-State: AOAM530ARHL4ZpnAMDcYHbZZ/QSnjiKOAf7b8BihnAJyDsB9sjJ9Euos
        gaA3hrEucLLA2tHyEZi7zsHFTqr5mkroSwx83xsUCtskcCwqVOB5Ksb+ugbCvnCWEVOxrUK5QCh
        7WGWuHzoUmos0YHGhvzLv4zA=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr18629462qkb.277.1612810436132;
        Mon, 08 Feb 2021 10:53:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze/vZYB6khb8nVddmoCq0bMtl4uT0Lxt0tZZ6qwjGopLDPGzl08g+Ds/Uo4WqOV/h94QBbtg==
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr18629441qkb.277.1612810435857;
        Mon, 08 Feb 2021 10:53:55 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id h6sm15066375qtx.39.2021.02.08.10.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 10:53:55 -0800 (PST)
Message-ID: <0ea759fa112b495cff9e7e1da3f02e922e8cc6a0.camel@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, David Jeffery <djeffery@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 13:53:52 -0500
In-Reply-To: <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
References: <20210201164850.391332-1-djeffery@redhat.com>
         <20210204022740.GB1108591@T590>
         <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2021-02-04 at 11:43 -0500, Laurence Oberman wrote:
> On Thu, 2021-02-04 at 10:27 +0800, Ming Lei wrote:
> > On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > > When a stacked block device inserts a request into another block
> > > device
> > > using blk_insert_cloned_request, the request's nr_phys_segments
> > > field gets
> > > recalculated by a call to blk_recalc_rq_segments in
> > > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not
> > > know how to
> > > handle multi-segment discards. For disk types which can handle
> > > multi-segment discards like nvme, this results in discard
> > > requests
> > > which
> > > claim a single segment when it should report several, triggering
> > > a
> > > warning
> > > in nvme and causing nvme to fail the discard from the invalid
> > > state.
> > > 
> > >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700
> > > nvme_setup_discard+0x170/0x1e0 [nvme_core]
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
> > > This patch fixes blk_recalc_rq_segments to be aware of devices
> > > which can
> > > have multi-segment discards. It calculates the correct discard
> > > segment
> > > count by counting the number of bio as each discard bio is
> > > considered its
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
> > > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct
> > > request *rq)
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
> > >  	case REQ_OP_WRITE_ZEROES:
> > >  		return 0;
> > 
> > blk_rq_nr_discard_segments() always returns >=1 segments, so no
> > similar
> > issue in case of single range discard.
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > 
> > And it can be thought as:
> > 
> > Fixes: 1e739730c5b9 ("block: optionally merge discontiguous discard
> > bios into a single request")
> > 
> > 
> 
> Great, can we get enough acks and push this through its urgent for me
> Reviewed-by: Laurence Oberman <loberman@redhat.com>

Hate to ping again, but we cant take this into RHEL unless its
upstream, can we get enough acks to get this in.

Many Thanks
Laurence 

