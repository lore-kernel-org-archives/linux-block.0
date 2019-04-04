Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E84C10F0E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222E02147C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDDP2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:28:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42887 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDP2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 11:28:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so1338509plb.9;
        Thu, 04 Apr 2019 08:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcYxH3AgJuUlQKc+2MqQOsi9um2JGiLB1jqi3kmJkFU=;
        b=oEB6cPf5IVK5rcghBVRY/9rqhs7jJZA8J2i/bv5hcHvlly0uuZsn2qA038jSeuxvDj
         1gCoyzFrLYQI7aeScTQnji33ZSGPHSEpS90GkFVpIFPyg6ns30qBD6R5shvj1upGLw/a
         yX5HoHQFncJCrGSYa/WF/3Llr2lQmRQVFKUicOwXDvRIicABCwCCNHj3CDKjiU3sSsOm
         wBnseJAzH/a1CS1SZZCBf58IMU+ccp8vlL/K9LUw0PMkZDIkk5e/3KQsHPETUqHznBxQ
         3eL7kAdyRYmk1vAX8dbQEJipVUmD80YBLp4CoKikl36lUkCxpYWhHg6LGaAnaXRMh++m
         zsUQ==
X-Gm-Message-State: APjAAAX5z/7caGsUSRGhTOcjGzNyl2Rcf07IW4+7jjUkBkbLGE9UEdNN
        TgehIhYX7Ry7ZuOQuzOzQw0=
X-Google-Smtp-Source: APXvYqy7ub4D69XYaIcAzGP3XUBUBouWotEUC+EcM1ZZ294HK0VuoL37PTpvLjYdCjPV0snbuyX5dg==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr6775237plg.213.1554391730819;
        Thu, 04 Apr 2019 08:28:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p2sm65333880pfi.73.2019.04.04.08.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:28:49 -0700 (PDT)
Message-ID: <1554391728.118779.241.camel@acm.org>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 08:28:48 -0700
In-Reply-To: <2b049ffa57ccac27b876c674bc1fa06faca5d3b6.camel@redhat.com>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <20190404070849.GD5004@ming.t460p> <1554389983.118779.237.camel@acm.org>
         <2b049ffa57ccac27b876c674bc1fa06faca5d3b6.camel@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 11:09 -0400, Laurence Oberman wrote:
+AD4 When I bisected and got to that commit I was unable to revert it to
+AD4 test without it.
+AD4 I showed that in an earlier update, had merge issues.
+AD4 
+AD4 loberman+AEA-lobewsrhel linux+AF8-torvalds+AF0AJA git revert 7f556a44e61d
+AD4 error: could not revert 7f556a4... blk-mq: refactor the code of issue
+AD4 request directly
+AD4 hint: after resolving the conflicts, mark the corrected paths
+AD4 hint: with 'git add +ADw-paths+AD4' or 'git rm +ADw-paths+AD4'
+AD4 hint: and commit the result with 'git commit'

Hi Laurence,

On my setup the following commits revert cleanly if I revert them in the
following order:
 +ACo d6a51a97c0b2 (+ACI-blk-mq: replace and kill blk+AF8-mq+AF8-request+AF8-issue+AF8-directly+ACI) +ACM v5.0.
 +ACo 5b7a6f128aad (+ACI-blk-mq: issue directly with bypass 'false' in blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests+ACI) +ACM v5.0.
 +ACo 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.

The result of these three reverts is the patch below. Test feedback for
this patch would be appreciated.

Thanks,

Bart.


Subject: +AFs-PATCH+AF0 block: Revert recent blk+AF8-mq+AF8-request+AF8-issue+AF8-directly() changes

blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() can return BLK+AF8-STS+ACoAXw-RESOURCE for requests that
have been queued. If that happens when blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() is called
by the dm-mpath driver then the dm-mpath will try to resubmit a request that
is already queued and a kernel crash follows. Since it is nontrivial to fix
blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(), revert the most recent
blk+AF8-mq+AF8-request+AF8-issue+AF8-directly() changes.

This patch reverts the following commits:
+ACo d6a51a97c0b2 (+ACI-blk-mq: replace and kill blk+AF8-mq+AF8-request+AF8-issue+AF8-directly+ACI) +ACM v5.0.
+ACo 5b7a6f128aad (+ACI-blk-mq: issue directly with bypass 'false' in blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests+ACI) +ACM v5.0.
+ACo 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.

Cc: Christoph Hellwig +ADw-hch+AEA-infradead.org+AD4
Cc: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
Cc: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
Cc: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
Cc: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
Cc: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
Cc: Dongli Zhang +ADw-dongli.zhang+AEA-oracle.com+AD4
Cc: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
Cc: +ADw-stable+AEA-vger.kernel.org+AD4
Reported-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
Fixes: 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.
Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
---
 block/blk-core.c     +AHw   4 +--
 block/blk-mq-sched.c +AHw   8 +---
 block/blk-mq.c       +AHw 122 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----------------------
 block/blk-mq.h       +AHw   6 +---
 4 files changed, 71 insertions(+-), 69 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2921af6f8d33..5bca56016575 100644
--- a/block/blk-core.c
+-+-+- b/block/blk-core.c
+AEAAQA -1232,8 +-1232,6 +AEAAQA static int blk+AF8-cloned+AF8-rq+AF8-check+AF8-limits(struct request+AF8-queue +ACo-q,
  +ACo-/
 blk+AF8-status+AF8-t blk+AF8-insert+AF8-cloned+AF8-request(struct request+AF8-queue +ACo-q, struct request +ACo-rq)
 +AHs
-	blk+AF8-qc+AF8-t unused+ADs
-
 	if (blk+AF8-cloned+AF8-rq+AF8-check+AF8-limits(q, rq))
 		return BLK+AF8-STS+AF8-IOERR+ADs
 
+AEAAQA -1249,7 +-1247,7 +AEAAQA blk+AF8-status+AF8-t blk+AF8-insert+AF8-cloned+AF8-request(struct request+AF8-queue +ACo-q, struct request +ACo
 	 +ACo bypass a potential scheduler on the bottom device for
 	 +ACo insert.
 	 +ACo-/
-	return blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(rq-+AD4-mq+AF8-hctx, rq, +ACY-unused, true, true)+ADs
+-	return blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(rq, true)+ADs
 +AH0
 EXPORT+AF8-SYMBOL+AF8-GPL(blk+AF8-insert+AF8-cloned+AF8-request)+ADs
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 40905539afed..aa6bc5c02643 100644
--- a/block/blk-mq-sched.c
+-+-+- b/block/blk-mq-sched.c
+AEAAQA -423,10 +-423,12 +AEAAQA void blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 		 +ACo busy in case of 'none' scheduler, and this way may save
 		 +ACo us one extra enqueue +ACY dequeue to sw queue.
 		 +ACo-/
-		if (+ACE-hctx-+AD4-dispatch+AF8-busy +ACYAJg +ACE-e +ACYAJg +ACE-run+AF8-queue+AF8-async)
+-		if (+ACE-hctx-+AD4-dispatch+AF8-busy +ACYAJg +ACE-e +ACYAJg +ACE-run+AF8-queue+AF8-async) +AHs
 			blk+AF8-mq+AF8-try+AF8-issue+AF8-list+AF8-directly(hctx, list)+ADs
-		else
-			blk+AF8-mq+AF8-insert+AF8-requests(hctx, ctx, list)+ADs
+-			if (list+AF8-empty(list))
+-				return+ADs
+-		+AH0
+-		blk+AF8-mq+AF8-insert+AF8-requests(hctx, ctx, list)+ADs
 	+AH0
 
 	blk+AF8-mq+AF8-run+AF8-hw+AF8-queue(hctx, run+AF8-queue+AF8-async)+ADs
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 652d0c6d5945..403984a557bb 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA -1808,74 +-1808,76 +AEAAQA static blk+AF8-status+AF8-t +AF8AXw-blk+AF8-mq+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 	return ret+ADs
 +AH0
 
-blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+-static blk+AF8-status+AF8-t +AF8AXw-blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 						struct request +ACo-rq,
 						blk+AF8-qc+AF8-t +ACo-cookie,
-						bool bypass, bool last)
+-						bool bypass+AF8-insert, bool last)
 +AHs
 	struct request+AF8-queue +ACo-q +AD0 rq-+AD4-q+ADs
 	bool run+AF8-queue +AD0 true+ADs
-	blk+AF8-status+AF8-t ret +AD0 BLK+AF8-STS+AF8-RESOURCE+ADs
-	int srcu+AF8-idx+ADs
-	bool force +AD0 false+ADs
 
-	hctx+AF8-lock(hctx, +ACY-srcu+AF8-idx)+ADs
 	/+ACo
-	 +ACo hctx+AF8-lock is needed before checking quiesced flag.
+-	 +ACo RCU or SRCU read lock is needed before checking quiesced flag.
 	 +ACo
-	 +ACo When queue is stopped or quiesced, ignore 'bypass', insert
-	 +ACo and return BLK+AF8-STS+AF8-OK to caller, and avoid driver to try to
-	 +ACo dispatch again.
+-	 +ACo When queue is stopped or quiesced, ignore 'bypass+AF8-insert' from
+-	 +ACo blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(), and return BLK+AF8-STS+AF8-OK to caller,
+-	 +ACo and avoid driver to try to dispatch again.
 	 +ACo-/
-	if (unlikely(blk+AF8-mq+AF8-hctx+AF8-stopped(hctx) +AHwAfA blk+AF8-queue+AF8-quiesced(q))) +AHs
+-	if (blk+AF8-mq+AF8-hctx+AF8-stopped(hctx) +AHwAfA blk+AF8-queue+AF8-quiesced(q)) +AHs
 		run+AF8-queue +AD0 false+ADs
-		bypass +AD0 false+ADs
-		goto out+AF8-unlock+ADs
+-		bypass+AF8-insert +AD0 false+ADs
+-		goto insert+ADs
 	+AH0
 
-	if (unlikely(q-+AD4-elevator +ACYAJg +ACE-bypass))
-		goto out+AF8-unlock+ADs
+-	if (q-+AD4-elevator +ACYAJg +ACE-bypass+AF8-insert)
+-		goto insert+ADs
 
 	if (+ACE-blk+AF8-mq+AF8-get+AF8-dispatch+AF8-budget(hctx))
-		goto out+AF8-unlock+ADs
+-		goto insert+ADs
 
 	if (+ACE-blk+AF8-mq+AF8-get+AF8-driver+AF8-tag(rq)) +AHs
 		blk+AF8-mq+AF8-put+AF8-dispatch+AF8-budget(hctx)+ADs
-		goto out+AF8-unlock+ADs
+-		goto insert+ADs
 	+AH0
 
-	/+ACo
-	 +ACo Always add a request that has been through
-	 +ACo.queue+AF8-rq() to the hardware dispatch list.
-	 +ACo-/
-	force +AD0 true+ADs
-	ret +AD0 +AF8AXw-blk+AF8-mq+AF8-issue+AF8-directly(hctx, rq, cookie, last)+ADs
-out+AF8-unlock:
+-	return +AF8AXw-blk+AF8-mq+AF8-issue+AF8-directly(hctx, rq, cookie, last)+ADs
+-insert:
+-	if (bypass+AF8-insert)
+-		return BLK+AF8-STS+AF8-RESOURCE+ADs
+-
+-	blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, run+AF8-queue)+ADs
+-	return BLK+AF8-STS+AF8-OK+ADs
+-+AH0
+-
+-static void blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+-		struct request +ACo-rq, blk+AF8-qc+AF8-t +ACo-cookie)
+-+AHs
+-	blk+AF8-status+AF8-t ret+ADs
+-	int srcu+AF8-idx+ADs
+-
+-	might+AF8-sleep+AF8-if(hctx-+AD4-flags +ACY BLK+AF8-MQ+AF8-F+AF8-BLOCKING)+ADs
+-
+-	hctx+AF8-lock(hctx, +ACY-srcu+AF8-idx)+ADs
+-
+-	ret +AD0 +AF8AXw-blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(hctx, rq, cookie, false, true)+ADs
+-	if (ret +AD0APQ BLK+AF8-STS+AF8-RESOURCE +AHwAfA ret +AD0APQ BLK+AF8-STS+AF8-DEV+AF8-RESOURCE)
+-		blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, true)+ADs
+-	else if (ret +ACEAPQ BLK+AF8-STS+AF8-OK)
+-		blk+AF8-mq+AF8-end+AF8-request(rq, ret)+ADs
+-
+-	hctx+AF8-unlock(hctx, srcu+AF8-idx)+ADs
+-+AH0
+-
+-blk+AF8-status+AF8-t blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(struct request +ACo-rq, bool last)
+-+AHs
+-	blk+AF8-status+AF8-t ret+ADs
+-	int srcu+AF8-idx+ADs
+-	blk+AF8-qc+AF8-t unused+AF8-cookie+ADs
+-	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 rq-+AD4-mq+AF8-hctx+ADs
+-
+-	hctx+AF8-lock(hctx, +ACY-srcu+AF8-idx)+ADs
+-	ret +AD0 +AF8AXw-blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(hctx, rq, +ACY-unused+AF8-cookie, true, last)+ADs
 	hctx+AF8-unlock(hctx, srcu+AF8-idx)+ADs
-	switch (ret) +AHs
-	case BLK+AF8-STS+AF8-OK:
-		break+ADs
-	case BLK+AF8-STS+AF8-DEV+AF8-RESOURCE:
-	case BLK+AF8-STS+AF8-RESOURCE:
-		if (force) +AHs
-			blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, run+AF8-queue)+ADs
-			/+ACo
-			 +ACo We have to return BLK+AF8-STS+AF8-OK for the DM
-			 +ACo to avoid livelock. Otherwise, we return
-			 +ACo the real result to indicate whether the
-			 +ACo request is direct-issued successfully.
-			 +ACo-/
-			ret +AD0 bypass ? BLK+AF8-STS+AF8-OK : ret+ADs
-		+AH0 else if (+ACE-bypass) +AHs
-			blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(rq, false,
-						    run+AF8-queue, false)+ADs
-		+AH0
-		break+ADs
-	default:
-		if (+ACE-bypass)
-			blk+AF8-mq+AF8-end+AF8-request(rq, ret)+ADs
-		break+ADs
-	+AH0
 
 	return ret+ADs
 +AH0
+AEAAQA -1883,20 +-1885,22 +AEAAQA blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 void blk+AF8-mq+AF8-try+AF8-issue+AF8-list+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 		struct list+AF8-head +ACo-list)
 +AHs
-	blk+AF8-qc+AF8-t unused+ADs
-	blk+AF8-status+AF8-t ret +AD0 BLK+AF8-STS+AF8-OK+ADs
-
 	while (+ACE-list+AF8-empty(list)) +AHs
+-		blk+AF8-status+AF8-t ret+ADs
 		struct request +ACo-rq +AD0 list+AF8-first+AF8-entry(list, struct request,
 				queuelist)+ADs
 
 		list+AF8-del+AF8-init(+ACY-rq-+AD4-queuelist)+ADs
-		if (ret +AD0APQ BLK+AF8-STS+AF8-OK)
-			ret +AD0 blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(hctx, rq, +ACY-unused,
-							false,
+-		ret +AD0 blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(rq, list+AF8-empty(list))+ADs
+-		if (ret +ACEAPQ BLK+AF8-STS+AF8-OK) +AHs
+-			if (ret +AD0APQ BLK+AF8-STS+AF8-RESOURCE +AHwAfA
+-					ret +AD0APQ BLK+AF8-STS+AF8-DEV+AF8-RESOURCE) +AHs
+-				blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq,
 							list+AF8-empty(list))+ADs
-		else
-			blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(rq, false, true, false)+ADs
+-				break+ADs
+-			+AH0
+-			blk+AF8-mq+AF8-end+AF8-request(rq, ret)+ADs
+-		+AH0
 	+AH0
 
 	/+ACo
+AEAAQA -1904,7 +-1908,7 +AEAAQA void blk+AF8-mq+AF8-try+AF8-issue+AF8-list+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 	 +ACo the driver there was more coming, but that turned out to
 	 +ACo be a lie.
 	 +ACo-/
-	if (ret +ACEAPQ BLK+AF8-STS+AF8-OK +ACYAJg hctx-+AD4-queue-+AD4-mq+AF8-ops-+AD4-commit+AF8-rqs)
+-	if (+ACE-list+AF8-empty(list) +ACYAJg hctx-+AD4-queue-+AD4-mq+AF8-ops-+AD4-commit+AF8-rqs)
 		hctx-+AD4-queue-+AD4-mq+AF8-ops-+AD4-commit+AF8-rqs(hctx)+ADs
 +AH0
 
+AEAAQA -2017,13 +-2021,13 +AEAAQA static blk+AF8-qc+AF8-t blk+AF8-mq+AF8-make+AF8-request(struct request+AF8-queue +ACo-q, struct bio +ACo-bio)
 		if (same+AF8-queue+AF8-rq) +AHs
 			data.hctx +AD0 same+AF8-queue+AF8-rq-+AD4-mq+AF8-hctx+ADs
 			blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(data.hctx, same+AF8-queue+AF8-rq,
-					+ACY-cookie, false, true)+ADs
+-					+ACY-cookie)+ADs
 		+AH0
 	+AH0 else if ((q-+AD4-nr+AF8-hw+AF8-queues +AD4 1 +ACYAJg is+AF8-sync) +AHwAfA (+ACE-q-+AD4-elevator +ACYAJg
 			+ACE-data.hctx-+AD4-dispatch+AF8-busy)) +AHs
 		blk+AF8-mq+AF8-put+AF8-ctx(data.ctx)+ADs
 		blk+AF8-mq+AF8-bio+AF8-to+AF8-request(rq, bio)+ADs
-		blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(data.hctx, rq, +ACY-cookie, false, true)+ADs
+-		blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(data.hctx, rq, +ACY-cookie)+ADs
 	+AH0 else +AHs
 		blk+AF8-mq+AF8-put+AF8-ctx(data.ctx)+ADs
 		blk+AF8-mq+AF8-bio+AF8-to+AF8-request(rq, bio)+ADs
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..423ea88ab6fb 100644
--- a/block/blk-mq.h
+-+-+- b/block/blk-mq.h
+AEAAQA -70,10 +-70,8 +AEAAQA void blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(struct request +ACo-rq, bool run+AF8-queue)+ADs
 void blk+AF8-mq+AF8-insert+AF8-requests(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx, struct blk+AF8-mq+AF8-ctx +ACo-ctx,
 				struct list+AF8-head +ACo-list)+ADs
 
-blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
-						struct request +ACo-rq,
-						blk+AF8-qc+AF8-t +ACo-cookie,
-						bool bypass, bool last)+ADs
+-/+ACo Used by blk+AF8-insert+AF8-cloned+AF8-request() to issue request directly +ACo-/
+-blk+AF8-status+AF8-t blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(struct request +ACo-rq, bool last)+ADs
 void blk+AF8-mq+AF8-try+AF8-issue+AF8-list+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 				    struct list+AF8-head +ACo-list)+ADs
 

