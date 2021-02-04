Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B4C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE1B64DF5
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhBDQrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238139AbhBDQoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 11:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612456997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NL/hGyxQxHl7d50dBo9b5vP+PtbfiIT7+xqssL/xqJw=;
        b=QrtPugUNQYYuQ6OODNTPYIEKU5VwIcAq3DVWNAc5ClM8UIKbZylzh8NHZY3trYXuMFa9Jv
        Cc6it77nE/RH+8IjY2EBdhcOLPtE4xAwWBVSSEdd4tJ6qTff5VlgBIcxyGyPcRgOs9gW/C
        ox+ldZUWNe5U1GE9lQz2iPkVJ2UxOrI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-YGZ1Tm94MSKjkOJ0kH3D9Q-1; Thu, 04 Feb 2021 11:43:15 -0500
X-MC-Unique: YGZ1Tm94MSKjkOJ0kH3D9Q-1
Received: by mail-qk1-f200.google.com with SMTP id u66so3143636qkd.13
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 08:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NL/hGyxQxHl7d50dBo9b5vP+PtbfiIT7+xqssL/xqJw=;
        b=qQWh+RrHJpyTwFMZW6mJKfX4VcP1e+c96+Kh4tMFlLQhCs9pexoDWL7xpMGZRPbsrI
         FLkF/q4ZTH7KqZA8nn1M5PJ6WVjCdFar812yySQlGyVqSnRFXBNoEyWLHd8X+G73iA4g
         aqH1l5UADoC2CQlX91+4MFrMazmyYp5HDyqtT8/TUkiVXp5P+JhWgk48M32FMo4cKNB3
         A5qvE6P4Yya1gbuD4awB4eZuiNJWC68w2o8ynp8eiVWxsZMIRlNIe+PhJ2MjG9R27znJ
         dn0rgqOKfII2TJZaby0Z24p0gvXWyvfW+jTViiJsfN1wW/10ZvVwMCwVkAJYFpc7c9zT
         /aXw==
X-Gm-Message-State: AOAM5332ugsWhQP24ci34LqPAnWsuprIbcEDcxQn6cWmmEXHrIaUJ6nq
        8vNoqFuLbXZKOu5S7BqRCNquYOZjiJWC3M7NdY7GNcTXwKjvsWusRoaRpDlx/8nTj0wn1Cd8N6b
        rNkTU1rggsGuJwhugcncMekM=
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr8710515qkb.201.1612456995247;
        Thu, 04 Feb 2021 08:43:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/zFRFml2EJzN07EyuZAIoICrKhLwwhJRRSgoHH5GwsiKMlWYv4rxda/9teezeclY+Bpc0fw==
X-Received: by 2002:a37:4fd1:: with SMTP id d200mr8710491qkb.201.1612456994986;
        Thu, 04 Feb 2021 08:43:14 -0800 (PST)
Received: from loberhel7laptop ([2600:6c64:4e7f:cee0:ccad:a4ca:9a69:d8bc])
        by smtp.gmail.com with ESMTPSA id b16sm5432387qkh.21.2021.02.04.08.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 08:43:14 -0800 (PST)
Message-ID: <8ce70420d1dcb5dd0ffc73aaa38d8ce61eb19cff.camel@redhat.com>
Subject: Re: [PATCH] block: recalculate segment count for multi-segment
 discard requests correctly
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, David Jeffery <djeffery@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Feb 2021 11:43:08 -0500
In-Reply-To: <20210204022740.GB1108591@T590>
References: <20210201164850.391332-1-djeffery@redhat.com>
         <20210204022740.GB1108591@T590>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2021-02-04 at 10:27 +0800, Ming Lei wrote:
> On Mon, Feb 01, 2021 at 11:48:50AM -0500, David Jeffery wrote:
> > When a stacked block device inserts a request into another block
> > device
> > using blk_insert_cloned_request, the request's nr_phys_segments
> > field gets
> > recalculated by a call to blk_recalc_rq_segments in
> > blk_cloned_rq_check_limits. But blk_recalc_rq_segments does not
> > know how to
> > handle multi-segment discards. For disk types which can handle
> > multi-segment discards like nvme, this results in discard requests
> > which
> > claim a single segment when it should report several, triggering a
> > warning
> > in nvme and causing nvme to fail the discard from the invalid
> > state.
> > 
> >  WARNING: CPU: 5 PID: 191 at drivers/nvme/host/core.c:700
> > nvme_setup_discard+0x170/0x1e0 [nvme_core]
> >  ...
> >  nvme_setup_cmd+0x217/0x270 [nvme_core]
> >  nvme_loop_queue_rq+0x51/0x1b0 [nvme_loop]
> >  __blk_mq_try_issue_directly+0xe7/0x1b0
> >  blk_mq_request_issue_directly+0x41/0x70
> >  ? blk_account_io_start+0x40/0x50
> >  dm_mq_queue_rq+0x200/0x3e0
> >  blk_mq_dispatch_rq_list+0x10a/0x7d0
> >  ? __sbitmap_queue_get+0x25/0x90
> >  ? elv_rb_del+0x1f/0x30
> >  ? deadline_remove_request+0x55/0xb0
> >  ? dd_dispatch_request+0x181/0x210
> >  __blk_mq_do_dispatch_sched+0x144/0x290
> >  ? bio_attempt_discard_merge+0x134/0x1f0
> >  __blk_mq_sched_dispatch_requests+0x129/0x180
> >  blk_mq_sched_dispatch_requests+0x30/0x60
> >  __blk_mq_run_hw_queue+0x47/0xe0
> >  __blk_mq_delay_run_hw_queue+0x15b/0x170
> >  blk_mq_sched_insert_requests+0x68/0xe0
> >  blk_mq_flush_plug_list+0xf0/0x170
> >  blk_finish_plug+0x36/0x50
> >  xlog_cil_committed+0x19f/0x290 [xfs]
> >  xlog_cil_process_committed+0x57/0x80 [xfs]
> >  xlog_state_do_callback+0x1e0/0x2a0 [xfs]
> >  xlog_ioend_work+0x2f/0x80 [xfs]
> >  process_one_work+0x1b6/0x350
> >  worker_thread+0x53/0x3e0
> >  ? process_one_work+0x350/0x350
> >  kthread+0x11b/0x140
> >  ? __kthread_bind_mask+0x60/0x60
> >  ret_from_fork+0x22/0x30
> > 
> > This patch fixes blk_recalc_rq_segments to be aware of devices
> > which can
> > have multi-segment discards. It calculates the correct discard
> > segment
> > count by counting the number of bio as each discard bio is
> > considered its
> > own segment.
> > 
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> > ---
> >  block/blk-merge.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 808768f6b174..fe7358bd5d09 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -382,6 +382,13 @@ unsigned int blk_recalc_rq_segments(struct
> > request *rq)
> >  
> >  	switch (bio_op(rq->bio)) {
> >  	case REQ_OP_DISCARD:
> > +		if (queue_max_discard_segments(rq->q) > 1) {
> > +			struct bio *bio = rq->bio;
> > +			for_each_bio(bio)
> > +				nr_phys_segs++;
> > +			return nr_phys_segs;
> > +		}
> > +		/* fall through */
> >  	case REQ_OP_SECURE_ERASE:
> >  	case REQ_OP_WRITE_ZEROES:
> >  		return 0;
> 
> blk_rq_nr_discard_segments() always returns >=1 segments, so no
> similar
> issue in case of single range discard.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> And it can be thought as:
> 
> Fixes: 1e739730c5b9 ("block: optionally merge discontiguous discard
> bios into a single request")
> 
> 

Great, can we get enough acks and push this through its urgent for me
Reviewed-by: Laurence Oberman <loberman@redhat.com>

