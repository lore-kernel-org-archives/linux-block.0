Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52698C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD4521904
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeLTU4G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:56:06 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:38427 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbeLTU4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 15:56:06 -0500
Received: by mail-pl1-f176.google.com with SMTP id e5so1421743plb.5
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3D2tjLQ6alNdxsOQQRorHN1aIoPS73/q58+cBkyO1/Q=;
        b=LRDTnA916nzhPHfeDMfSuD8qQqZ4wgTEc8NPK66tbhqzHiChykO91eOcfoiWgs8G7B
         9IPUz/rixZmwLfi3wK5ozhtrkffJhbfqkBTllioBxxOW6sM5Mrbgzizo1WXKPjbV9g1v
         GTNOTmSc4UeGSNdjhekV8gno0mXWKy4Jh98cvybhP81iyLg9inory3l6ACC6MbpRekL2
         6j0XFFZqyezyHmS6ps28OKiLabnnTUSM6if8IkwbjhEGIOQmUdh2GmrEf+7UgxWgd0r0
         wX1jyWm2TKm9/vSGJqQA6kzU1mEb1HktgLDiEYVfu426cB1fIh0eyL2uOmcHm5i1/OM6
         587Q==
X-Gm-Message-State: AA+aEWZbI6bELM3BEsmf4CONUFiNQyJ10vXMow2YCgUbqxO2fNY7MGRA
        JjtiHmReKl3wXSeahcF771U=
X-Google-Smtp-Source: AFSGD/WJFcUdMf32vTPPjqY1h5dDa1ZU8MaNTJAhXuNRIO39IeLohdF/uCMeMStbzyVCrnWtTjC6bA==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr26224937pll.305.1545339364751;
        Thu, 20 Dec 2018 12:56:04 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m67sm37475873pfb.25.2018.12.20.12.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:56:03 -0800 (PST)
Message-ID: <1545339362.185366.511.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 12:56:02 -0800
In-Reply-To: <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
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
         <1545328865.185366.508.camel@acm.org>
         <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
         <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 11:33 -0700, Jens Axboe wrote:
+AD4 +AFs ... +AF0
+AD4 Something like this, totally untested. If the queue matches, we know it's
+AD4 safe to dereference it.
+AD4 
+AD4 A safer API to export as well...
+AD4 
+AD4 
+AD4 diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
+AD4 index 2089c6c62f44..78192b544fa2 100644
+AD4 --- a/block/blk-mq-tag.c
+AD4 +-+-+- b/block/blk-mq-tag.c
+AD4 +AEAAQA -228,13 +-228,15 +AEAAQA static bool bt+AF8-iter(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4  
+AD4  	if (+ACE-reserved)
+AD4  		bitnr +-+AD0 tags-+AD4-nr+AF8-reserved+AF8-tags+ADs
+AD4 -	rq +AD0 tags-+AD4-rqs+AFs-bitnr+AF0AOw
+AD4 +-	if (tags-+AD4-rqs+AFs-bitnr+AF0.queue +ACEAPQ hctx-+AD4-queue)
+AD4 +-		return true+ADs
+AD4  
+AD4  	/+ACo
+AD4  	 +ACo We can hit rq +AD0APQ NULL here, because the tagging functions
+AD4  	 +ACo test and set the bit before assigning -+AD4-rqs+AFsAXQ.
+AD4  	 +ACo-/
+AD4 -	if (rq +ACYAJg rq-+AD4-q +AD0APQ hctx-+AD4-queue)
+AD4 +-	rq +AD0 tags-+AD4-rqs+AFs-bitnr+AF0.rq+ADs
+AD4 +-	if (rq)
+AD4  		return iter+AF8-data-+AD4-fn(hctx, rq, iter+AF8-data-+AD4-data, reserved)+ADs
+AD4  	return true+ADs
+AD4  +AH0
+AD4 +AEAAQA -268,6 +-270,7 +AEAAQA static void bt+AF8-for+AF8-each(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct sbitmap+AF8-queue +ACo-bt,
+AD4  
+AD4  struct bt+AF8-tags+AF8-iter+AF8-data +AHs
+AD4  	struct blk+AF8-mq+AF8-tags +ACo-tags+ADs
+AD4 +-	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4  	busy+AF8-tag+AF8-iter+AF8-fn +ACo-fn+ADs
+AD4  	void +ACo-data+ADs
+AD4  	bool reserved+ADs
+AD4 +AEAAQA -287,7 +-290,7 +AEAAQA static bool bt+AF8-tags+AF8-iter(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4  	 +ACo We can hit rq +AD0APQ NULL here, because the tagging functions
+AD4  	 +ACo test and set the bit before assining -+AD4-rqs+AFsAXQ.
+AD4  	 +ACo-/
+AD4 -	rq +AD0 tags-+AD4-rqs+AFs-bitnr+AF0AOw
+AD4 +-	rq +AD0 tags-+AD4-rqs+AFs-bitnr+AF0.rq+ADs
+AD4  	if (rq +ACYAJg blk+AF8-mq+AF8-request+AF8-started(rq))
+AD4  		return iter+AF8-data-+AD4-fn(rq, iter+AF8-data-+AD4-data, reserved)+ADs
+AD4  
+AD4 diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
+AD4 index 61deab0b5a5a..bb84d1f099c7 100644
+AD4 --- a/block/blk-mq-tag.h
+AD4 +-+-+- b/block/blk-mq-tag.h
+AD4 +AEAAQA -4,6 +-4,11 +AEAAQA
+AD4  
+AD4  +ACM-include +ACI-blk-mq.h+ACI
+AD4  
+AD4 +-struct rq+AF8-tag+AF8-entry +AHs
+AD4 +-	struct request+AF8-queue +ACo-queue+ADs
+AD4 +-	struct request +ACo-rq+ADs
+AD4 +-+AH0AOw
+AD4 +-
+AD4  /+ACo
+AD4   +ACo Tag address space map.
+AD4   +ACo-/
+AD4 +AEAAQA -16,7 +-21,7 +AEAAQA struct blk+AF8-mq+AF8-tags +AHs
+AD4  	struct sbitmap+AF8-queue bitmap+AF8-tags+ADs
+AD4  	struct sbitmap+AF8-queue breserved+AF8-tags+ADs
+AD4  
+AD4 -	struct request +ACoAKg-rqs+ADs
+AD4 +-	struct rq+AF8-tag+AF8-entry +ACo-rqs+ADs
+AD4  	struct request +ACoAKg-static+AF8-rqs+ADs
+AD4  	struct list+AF8-head page+AF8-list+ADs
+AD4  +AH0AOw
+AD4 +AEAAQA -78,7 +-83,8 +AEAAQA static inline void blk+AF8-mq+AF8-tag+AF8-idle(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4  static inline void blk+AF8-mq+AF8-tag+AF8-set+AF8-rq(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4  		unsigned int tag, struct request +ACo-rq)
+AD4  +AHs
+AD4 -	hctx-+AD4-tags-+AD4-rqs+AFs-tag+AF0 +AD0 rq+ADs
+AD4 +-	hctx-+AD4-tags-+AD4-rqs+AFs-tag+AF0.queue +AD0 hctx-+AD4-queue+ADs
+AD4 +-	hctx-+AD4-tags-+AD4-rqs+AFs-tag+AF0.rq +AD0 rq+ADs
+AD4  +AH0
+AD4  
+AD4  static inline bool blk+AF8-mq+AF8-tag+AF8-is+AF8-reserved(struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 3ba37b9e15e9..4f194946dbd9 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -298,13 +-298,16 +AEAAQA static struct request +ACo-blk+AF8-mq+AF8-rq+AF8-ctx+AF8-init(struct blk+AF8-mq+AF8-alloc+AF8-data +ACo-data,
+AD4  		rq-+AD4-tag +AD0 -1+ADs
+AD4  		rq-+AD4-internal+AF8-tag +AD0 tag+ADs
+AD4  	+AH0 else +AHs
+AD4 -		if (data-+AD4-hctx-+AD4-flags +ACY BLK+AF8-MQ+AF8-F+AF8-TAG+AF8-SHARED) +AHs
+AD4 +-		struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 data-+AD4-hctx+ADs
+AD4 +-
+AD4 +-		if (hctx-+AD4-flags +ACY BLK+AF8-MQ+AF8-F+AF8-TAG+AF8-SHARED) +AHs
+AD4  			rq+AF8-flags +AD0 RQF+AF8-MQ+AF8-INFLIGHT+ADs
+AD4 -			atomic+AF8-inc(+ACY-data-+AD4-hctx-+AD4-nr+AF8-active)+ADs
+AD4 +-			atomic+AF8-inc(+ACY-hctx-+AD4-nr+AF8-active)+ADs
+AD4  		+AH0
+AD4  		rq-+AD4-tag +AD0 tag+ADs
+AD4  		rq-+AD4-internal+AF8-tag +AD0 -1+ADs
+AD4 -		data-+AD4-hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 rq+ADs
+AD4 +-		hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0.queue +AD0 hctx-+AD4-queue+ADs
+AD4 +-		hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0.rq +AD0 rq+ADs
+AD4  	+AH0
+AD4  
+AD4  	/+ACo csd/requeue+AF8-work/fifo+AF8-time is initialized before use +ACo-/
+AD4 +AEAAQA -797,8 +-800,8 +AEAAQA EXPORT+AF8-SYMBOL(blk+AF8-mq+AF8-delay+AF8-kick+AF8-requeue+AF8-list)+ADs
+AD4  struct request +ACo-blk+AF8-mq+AF8-tag+AF8-to+AF8-rq(struct blk+AF8-mq+AF8-tags +ACo-tags, unsigned int tag)
+AD4  +AHs
+AD4  	if (tag +ADw tags-+AD4-nr+AF8-tags) +AHs
+AD4 -		prefetch(tags-+AD4-rqs+AFs-tag+AF0)+ADs
+AD4 -		return tags-+AD4-rqs+AFs-tag+AF0AOw
+AD4 +-		prefetch(tags-+AD4-rqs+AFs-tag+AF0.rq)+ADs
+AD4 +-		return tags-+AD4-rqs+AFs-tag+AF0.rq+ADs
+AD4  	+AH0
+AD4  
+AD4  	return NULL+ADs
+AD4 +AEAAQA -809,10 +-812,11 +AEAAQA static bool blk+AF8-mq+AF8-rq+AF8-inflight(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct request +ACo-rq,
+AD4  			       void +ACo-priv, bool reserved)
+AD4  +AHs
+AD4  	/+ACo
+AD4 -	 +ACo If we find a request that is inflight and the queue matches,
+AD4 -	 +ACo we know the queue is busy. Return false to stop the iteration.
+AD4 +-	 +ACo We're only called here if the queue matches. If the rq state is
+AD4 +-	 +ACo inflight, we know the queue is busy. Return false to stop the
+AD4 +-	 +ACo iteration.
+AD4  	 +ACo-/
+AD4 -	if (rq-+AD4-state +AD0APQ MQ+AF8-RQ+AF8-IN+AF8-FLIGHT +ACYAJg rq-+AD4-q +AD0APQ hctx-+AD4-queue) +AHs
+AD4 +-	if (rq-+AD4-state +AD0APQ MQ+AF8-RQ+AF8-IN+AF8-FLIGHT) +AHs
+AD4  		bool +ACo-busy +AD0 priv+ADs
+AD4  
+AD4  		+ACo-busy +AD0 true+ADs
+AD4 +AEAAQA -1049,11 +-1053,14 +AEAAQA bool blk+AF8-mq+AF8-get+AF8-driver+AF8-tag(struct request +ACo-rq)
+AD4  	shared +AD0 blk+AF8-mq+AF8-tag+AF8-busy(data.hctx)+ADs
+AD4  	rq-+AD4-tag +AD0 blk+AF8-mq+AF8-get+AF8-tag(+ACY-data)+ADs
+AD4  	if (rq-+AD4-tag +AD4APQ 0) +AHs
+AD4 +-		struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 data.hctx+ADs
+AD4 +-
+AD4  		if (shared) +AHs
+AD4  			rq-+AD4-rq+AF8-flags +AHwAPQ RQF+AF8-MQ+AF8-INFLIGHT+ADs
+AD4  			atomic+AF8-inc(+ACY-data.hctx-+AD4-nr+AF8-active)+ADs
+AD4  		+AH0
+AD4 -		data.hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 rq+ADs
+AD4 +-		hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0.queue +AD0 hctx-+AD4-queue+ADs
+AD4 +-		hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0.rq +AD0 rq+ADs
+AD4  	+AH0
+AD4  
+AD4  done:
+AD4 +AEAAQA -2069,7 +-2076,7 +AEAAQA struct blk+AF8-mq+AF8-tags +ACo-blk+AF8-mq+AF8-alloc+AF8-rq+AF8-map(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set,
+AD4  	if (+ACE-tags)
+AD4  		return NULL+ADs
+AD4  
+AD4 -	tags-+AD4-rqs +AD0 kcalloc+AF8-node(nr+AF8-tags, sizeof(struct request +ACo),
+AD4 +-	tags-+AD4-rqs +AD0 kcalloc+AF8-node(nr+AF8-tags, sizeof(struct rq+AF8-tag+AF8-entry),
+AD4  				 GFP+AF8-NOIO +AHw +AF8AXw-GFP+AF8-NOWARN +AHw +AF8AXw-GFP+AF8-NORETRY,
+AD4  				 node)+ADs
+AD4  	if (+ACE-tags-+AD4-rqs) +AHs

Hi Jens,

How about the patch below? Its behavior should be similar to your patch but I think
this patch is simpler.

Thanks,

Bart.


---
 block/blk-mq.c +AHw 18 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
 1 file changed, 16 insertions(+-), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a7566244de3..c57611b1f2a8 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA -86,6 +-86,7 +AEAAQA static void blk+AF8-mq+AF8-hctx+AF8-clear+AF8-pending(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 +AH0
 
 struct mq+AF8-inflight +AHs
+-	struct request+AF8-queue +ACo-q+ADs
 	struct hd+AF8-struct +ACo-part+ADs
 	unsigned int +ACo-inflight+ADs
 +AH0AOw
+AEAAQA -96,6 +-97,9 +AEAAQA static void blk+AF8-mq+AF8-check+AF8-inflight(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 +AHs
 	struct mq+AF8-inflight +ACo-mi +AD0 priv+ADs
 
+-	if (rq-+AD4-q +ACEAPQ mi-+AD4-q)
+-		return+ADs
+-
 	/+ACo
 	 +ACo index+AFs-0+AF0 counts the specific partition that was asked for. index+AFs-1+AF0
 	 +ACo counts the ones that are active on the whole device, so increment
+AEAAQA -110,7 +-114,11 +AEAAQA static void blk+AF8-mq+AF8-check+AF8-inflight(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 void blk+AF8-mq+AF8-in+AF8-flight(struct request+AF8-queue +ACo-q, struct hd+AF8-struct +ACo-part,
 		      unsigned int inflight+AFs-2+AF0)
 +AHs
-	struct mq+AF8-inflight mi +AD0 +AHs .part +AD0 part, .inflight +AD0 inflight, +AH0AOw
+-	struct mq+AF8-inflight mi +AD0 +AHs
+-		.q +AD0 q,
+-		.part +AD0 part,
+-		.inflight +AD0 inflight,
+-	+AH0AOw
 
 	inflight+AFs-0+AF0 +AD0 inflight+AFs-1+AF0 +AD0 0+ADs
 	blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(q, blk+AF8-mq+AF8-check+AF8-inflight, +ACY-mi)+ADs
+AEAAQA -129,7 +-137,11 +AEAAQA static void blk+AF8-mq+AF8-check+AF8-inflight+AF8-rw(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 void blk+AF8-mq+AF8-in+AF8-flight+AF8-rw(struct request+AF8-queue +ACo-q, struct hd+AF8-struct +ACo-part,
 			 unsigned int inflight+AFs-2+AF0)
 +AHs
-	struct mq+AF8-inflight mi +AD0 +AHs .part +AD0 part, .inflight +AD0 inflight, +AH0AOw
+-	struct mq+AF8-inflight mi +AD0 +AHs
+-		.q +AD0 q,
+-		.part +AD0 part,
+-		.inflight +AD0 inflight,
+-	+AH0AOw
 
 	inflight+AFs-0+AF0 +AD0 inflight+AFs-1+AF0 +AD0 0+ADs
 	blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter(q, blk+AF8-mq+AF8-check+AF8-inflight+AF8-rw, +ACY-mi)+ADs
+AEAAQA -477,6 +-489,8 +AEAAQA static void +AF8AXw-blk+AF8-mq+AF8-free+AF8-request(struct request +ACo-rq)
 	const int sched+AF8-tag +AD0 rq-+AD4-internal+AF8-tag+ADs
 
 	blk+AF8-pm+AF8-mark+AF8-last+AF8-busy(rq)+ADs
+-	/+ACo Avoid that blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter() picks up this request. +ACo-/
+-	rq-+AD4-q +AD0 NULL+ADs
 	if (rq-+AD4-tag +ACEAPQ -1)
 		blk+AF8-mq+AF8-put+AF8-tag(hctx, hctx-+AD4-tags, ctx, rq-+AD4-tag)+ADs
 	if (sched+AF8-tag +ACEAPQ -1)


