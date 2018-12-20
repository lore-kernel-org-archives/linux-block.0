Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83540C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F683217D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeLTSBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:01:08 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:47046 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeLTSBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:01:08 -0500
Received: by mail-pl1-f174.google.com with SMTP id t13so1213169ply.13
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXf5jSMnQO5miM2Bd5EY5xzeSakMfHGzuZw2UyBQ/Ec=;
        b=P+VzZ/hBI56m1MU6n51xgjE1brG7/BAOVv1neKWyuK5ZZyQZ7T+aW7JrGtoHoLEFQh
         YWasImMEdTzATSeNePBqnT1KBLsiWFl3DbGHr1hZl0+tmnwrZUqhFK7m7DUC1508MUsA
         EIlYogpFxU4z3Rgo+2FD4wtNUDR80OapqAmoj4i0Coe9OeDzf7RxPpli4RAvCGBCQkat
         T1gjbLXUg8h7Emo4weMPVk1Dao3VfgnB+Ms2Qdw9h0YGWn6rGVu/i8gPSuwi7MEzyS9A
         QkrfDz1S2GMo5pcbdqANrwUl9W6YT4PEMtEgiAy3yswJbzgcfyjcUPVSCZCkq1Ip9TZ4
         ei6w==
X-Gm-Message-State: AA+aEWb9QVStD/P9G254wb2ANP+fedQVuIbXY2+WJl+6XbDC8amKKUch
        mxw1oaQZ8jPrSEJZn82yVhQ=
X-Google-Smtp-Source: AFSGD/Wm69eFxbroKHk3ZxmFaLeXKP9yhfkANi+Aa2Nj9vP+BUA93NuymmuXhMOpNLb/gEJXBus+8A==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr25644801plb.335.1545328867531;
        Thu, 20 Dec 2018 10:01:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l19sm49096283pfi.71.2018.12.20.10.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:01:06 -0800 (PST)
Message-ID: <1545328865.185366.508.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 10:01:05 -0800
In-Reply-To: <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
         <1545265001.185366.496.camel@acm.org>
         <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
         <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
         <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
         <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
         <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
         <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
         <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
         <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 06:07 -0700, Jens Axboe wrote:
+AD4 On 12/20/18 6:02 AM, Jens Axboe wrote:
+AD4 +AD4 +AD4 I'm afraid this cannot work.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 The 'tags' here could be the hctx-+AD4-sched+AF8-tags, but what we need to
+AD4 +AD4 +AD4 clear is hctx-+AD4-tags-+AD4-rqs+AFsAXQ.
+AD4 +AD4 
+AD4 +AD4 You are right, of course, a bit too quick on the trigger. This one
+AD4 +AD4 should work better, and also avoids that silly quadratic loop. I don't
+AD4 +AD4 think we need the tag +AD0APQ -1 check, but probably best to be safe.
+AD4 
+AD4 Sent out the wrong one, here it is. Bart, if you can reproduce, can you
+AD4 give it a whirl?
+AD4 
+AD4 
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 2de972857496..fc04bb648f18 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -2025,7 +-2025,7 +AEAAQA void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4  +AHs
+AD4  	struct page +ACo-page+ADs
+AD4  
+AD4 -	if (tags-+AD4-rqs +ACYAJg set-+AD4-ops-+AD4-exit+AF8-request) +AHs
+AD4 +-	if (tags-+AD4-rqs) +AHs
+AD4  		int i+ADs
+AD4  
+AD4  		for (i +AD0 0+ADs i +ADw tags-+AD4-nr+AF8-tags+ADs i+-+-) +AHs
+AD4 +AEAAQA -2033,8 +-2033,14 +AEAAQA void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4  
+AD4  			if (+ACE-rq)
+AD4  				continue+ADs
+AD4 -			set-+AD4-ops-+AD4-exit+AF8-request(set, rq, hctx+AF8-idx)+ADs
+AD4 +-			if (set-+AD4-ops-+AD4-exit+AF8-request)
+AD4 +-				set-+AD4-ops-+AD4-exit+AF8-request(set, rq, hctx+AF8-idx)+ADs
+AD4  			tags-+AD4-static+AF8-rqs+AFs-i+AF0 +AD0 NULL+ADs
+AD4 +-
+AD4 +-			if (rq-+AD4-tag +AD0APQ -1)
+AD4 +-				continue+ADs
+AD4 +-			if (set-+AD4-tags+AFs-hctx+AF8-idx+AF0--+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0APQ rq)
+AD4 +-				set-+AD4-tags+AFs-hctx+AF8-idx+AF0--+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 NULL+ADs
+AD4  		+AH0
+AD4  	+AH0
+AD4  
+AD4 +AEAAQA -2113,6 +-2119,7 +AEAAQA static int blk+AF8-mq+AF8-init+AF8-request(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct request +ACo-rq,
+AD4  			return ret+ADs
+AD4  	+AH0
+AD4  
+AD4 +-	rq-+AD4-tag +AD0 -1+ADs
+AD4  	WRITE+AF8-ONCE(rq-+AD4-state, MQ+AF8-RQ+AF8-IDLE)+ADs
+AD4  	return 0+ADs
+AD4  +AH0

Hi Jens,

Are you sure this is sufficient? My understanding is that
blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter() iterates over all tags in the tag set. So if the
request queue on which part+AF8-in+AF8-flight() is called and the request queue for
which blk+AF8-mq+AF8-free+AF8-rqs() is called share their tag set then part+AF8-in+AF8-flight()
and blk+AF8-mq+AF8-free+AF8-rqs() can run concurrently. That can cause ugly race
conditions. Do you think it would be a good idea to modify the inflight
accounting code such that it only considers the requests of a single request
queue instead of all requests for a given tag set?

Thanks,

Bart.
