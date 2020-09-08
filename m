Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1EBC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5622087C
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="AKeahh29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIHTAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgIHTAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 15:00:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D0AC061755
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 12:00:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so73612pjr.4
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GV/iqESZ2B/JWCPhKBYdc1HMXEWUP6X/GFX7ukcYRCc=;
        b=AKeahh29FRXDGBXnQjzSIcarVKtmq38CxwAoB6TIwDU1z5eEMqESkkM6AOI3qcWUXI
         QXybrGeceZuWdooQd6Ahhr7FZanmq04jcIgL/NxxY16dTqLalRglfGD5RSGwXJlgHohK
         lQi+Xam2gpoIu02XBhynueixypqoi1xRQaah1Du8lrzaymU1uXk0uO2EXr/QnAYJNtGE
         RIjrrhv2zVCxniSFcfmbBvcG3BYOSnEHVDzLJ2liwgfW3aukQQ6apEaTOcX2iWGqAWCw
         7LuXe2v/HVoJdiX92R3JHlHIatuZJC6rx47wnHvXOTWIRv7mOliX/C2jGR7BNmW0KFwV
         MFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GV/iqESZ2B/JWCPhKBYdc1HMXEWUP6X/GFX7ukcYRCc=;
        b=Kc+oDR5oZKSvJm43sEEtGPBuGRr8+KfKuMxznTCgE5rhYCIQoEJ3ugPIEPiun4ja1H
         hZxTQieKWAo2HoQcjXV03N7m4Eu7K92EnEzA+tSvdKBeb+TcI7z45WlSq+/1IZ/YI3+j
         jDhYtANUrX/fLFbJHcoVL6JnK8Mo0VfT0QqiKV3PnWVgPuZyFzwVq3+s1HeZ3qHF/HKf
         ZCYTe83Mee4sUdIbWua3F68yDn3jgAn/IUa6FoR9u6UvgXO5m61IcvxTtuXY9b5eG8he
         nTpfumVGt7VA+Zm/Q6z2qJOd42pD6jcBZSx2B9fnoH3atkSWV7b7CK951w73bIj/HspY
         MnTA==
X-Gm-Message-State: AOAM5327raNV+oKWovqdEOCAzq2SmvmP9hrDXeNyNe4RAMKaNe9yIrut
        pCMV7TD1WZEkUEbuDKfNRG0Mww==
X-Google-Smtp-Source: ABdhPJx5rumcfM7Ht6IyzlNP3RKqgmYM/0YyydX7QIAP1xK9uKQOzi1qgTWBBWjVdlyxgacb07hiEA==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr212478pjr.207.1599591612227;
        Tue, 08 Sep 2020 12:00:12 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:ec83])
        by smtp.gmail.com with ESMTPSA id e125sm159782pfe.154.2020.09.08.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:00:11 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:00:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, onlyfever@icloud.com
Subject: Re: [PATCH] kyber: Fix crash in kyber_finish_request()
Message-ID: <20200908190009.GA142421@relinquished.localdomain>
References: <20200907074346.5383-1-yang.yang@vivo.com>
 <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 07, 2020 at 10:41:16AM -0600, Jens Axboe wrote:
> CC Omar
> 
> On 9/7/20 1:43 AM, Yang Yang wrote:
> > Kernel crash when requeue flush request.
> > It can be reproduced as below:
> > 
> > [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
> > ...
> > [    2.517468] pc : clear_bit+0x18/0x2c
> > [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
> > [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
> > ...
> > [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
> > [    2.517602] Call trace:
> > [    2.517606]  clear_bit+0x18/0x2c
> > [    2.517619]  kyber_finish_request+0x74/0x80
> > [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
> > [    2.517637]  __scsi_queue_insert+0x11c/0x148
> > [    2.517640]  scsi_softirq_done+0x114/0x130
> > [    2.517643]  blk_done_softirq+0x7c/0xb0
> > [    2.517651]  __do_softirq+0x208/0x3bc
> > [    2.517657]  run_ksoftirqd+0x34/0x60
> > [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
> > [    2.517667]  kthread+0x110/0x120
> > [    2.517669]  ret_from_fork+0x10/0x18
> > 
> > Signed-off-by: Yang Yang <yang.yang@vivo.com>
> > ---
> >  block/kyber-iosched.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> > index a38c5ab103d1..af73afe7a05c 100644
> > --- a/block/kyber-iosched.c
> > +++ b/block/kyber-iosched.c
> > @@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
> >  {
> >  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
> >  
> > +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
> > +		return;
> > +
> >  	rq_clear_domain_token(kqd, rq);
> >  }
> >  
> > 

It looks like BFQ also has this check. Wouldn't it make more sense to
check it in blk-mq, like we do for .finish_request() in
blk_mq_free_request()? Something along these lines:

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c34b090178a9..fa98470df3f0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5895,18 +5895,6 @@ static void bfq_finish_requeue_request(struct request *rq)
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
 
-	/*
-	 * Requeue and finish hooks are invoked in blk-mq without
-	 * checking whether the involved request is actually still
-	 * referenced in the scheduler. To handle this fact, the
-	 * following two checks make this function exit in case of
-	 * spurious invocations, for which there is nothing to do.
-	 *
-	 * First, check whether rq has nothing to do with an elevator.
-	 */
-	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
-		return;
-
 	/*
 	 * rq either is not associated with any icq, or is an already
 	 * requeued request that has not (yet) been re-inserted into
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021fc3a11..e81ca1bf6e10 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -66,7 +66,7 @@ static inline void blk_mq_sched_requeue_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 
-	if (e && e->type->ops.requeue_request)
+	if ((rq->rq_flags & RQF_ELVPRIV) && e && e->type->ops.requeue_request)
 		e->type->ops.requeue_request(rq);
 }
 
