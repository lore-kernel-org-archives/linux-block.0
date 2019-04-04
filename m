Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA6C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C40B2082E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDDP6a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:58:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44590 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDP6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 11:58:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so1569326pfm.11;
        Thu, 04 Apr 2019 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZyUnG07XXhOlm5o9LjAqKZNza7NwzeK75RB07k04cs=;
        b=eOijdr/wqT/J80BIcpNOhOKZrt5XaJ487Ddr0x5/hMgpTYGH5xjR8g36q2UobJTYH0
         G+93vXXIX0yRGPXJjLXfQuvoixV/G+R3x39vi36SaHpPjqkKJf1L0al9u3Yr7SHUM8zI
         E0KBGS8TifcMYf7gcKdtHd3LVWk+aEm4Cp1OCFmxYVcYKzO7UI+jWnq5JPt0SEnYkWwu
         LACBmPamkytbPr/m2gPeWZXFXCCXUZBzJQRxqsPcRDbrIrOXdJqDonzPIFTNHAgI06ul
         FTMImI8nyCy8K0Y1PuVP3bfUsGLhtu5pB9J2bWJLvDG476gcKZIjAS6DH9jWT1y5pL8f
         qS1w==
X-Gm-Message-State: APjAAAWd4gKS4AA7mCPIFuS4icZ3Wcey8gYcEu+3z5YjSOsAi4IIAaAf
        Er9Fu6AeqpptRr7tEDTZo7c=
X-Google-Smtp-Source: APXvYqykjgaRreIF+kWGVYSJndwUX4siz/634CkJ4D+0c0VsXp0CMZW8OI3d0x7hYup1r6cyuqQMUQ==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr6645476pgp.197.1554393509156;
        Thu, 04 Apr 2019 08:58:29 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h11sm22150529pgq.57.2019.04.04.08.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:58:28 -0700 (PDT)
Message-ID: <1554393507.118779.251.camel@acm.org>
Subject: Re: [PATCH V4 1/7] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Thu, 04 Apr 2019 08:58:27 -0700
In-Reply-To: <20190404084320.24681-2-ming.lei@redhat.com>
References: <20190404084320.24681-1-ming.lei@redhat.com>
         <20190404084320.24681-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 16:43 +-0800, Ming Lei wrote:
+AD4 Just like aio/io+AF8-uring, we need to grab 2 refcount for queuing one
+AD4 request, one is for submission, another is for completion.
+AD4 
+AD4 If the request isn't queued from plug code path, the refcount grabbed
+AD4 in generic+AF8-make+AF8-request() serves for submission. In theroy, this
+AD4 refcount should have been released after the sumission(async run queue)
+AD4 is done. blk+AF8-freeze+AF8-queue() works with blk+AF8-sync+AF8-queue() together
+AD4 for avoiding race between cleanup queue and IO submission, given async
+AD4 run queue activities are canceled because hctx-+AD4-run+AF8-work is scheduled with
+AD4 the refcount held, so it is fine to not hold the refcount when
+AD4 running the run queue work function for dispatch IO.
+AD4 
+AD4 However, if request is staggered into plug list, and finally queued
+AD4 from plug code path, the refcount in submission side is actually missed.
+AD4 And we may start to run queue after queue is removed because the queue's
+AD4 kobject refcount isn't guaranteed to be grabbed in flushing plug list
+AD4 context, then kernel oops is triggered, see the following race:
+AD4 
+AD4 blk+AF8-mq+AF8-flush+AF8-plug+AF8-list():
+AD4         blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests()
+AD4                 insert requests to sw queue or scheduler queue
+AD4                 blk+AF8-mq+AF8-run+AF8-hw+AF8-queue
+AD4 
+AD4 Because of concurrent run queue, all requests inserted above may be
+AD4 completed before calling the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue. Then queue can
+AD4 be freed during the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue().
+AD4 
+AD4 Fixes the issue by grab .q+AF8-usage+AF8-counter before calling
+AD4 blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests() in blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(). This way is
+AD4 safe because the queue is absolutely alive before inserting request.
+AD4 
+AD4 Cc: Dongli Zhang +ADw-dongli.zhang+AEA-oracle.com+AD4
+AD4 Cc: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
+AD4 Cc: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4
+AD4 Cc: linux-scsi+AEA-vger.kernel.org,
+AD4 Cc: Martin K . Petersen +ADw-martin.petersen+AEA-oracle.com+AD4,
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4,
+AD4 Cc: James E . J . Bottomley +ADw-jejb+AEA-linux.vnet.ibm.com+AD4,
+AD4 Cc: jianchao wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 Signed-off-by: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
+AD4 ---
+AD4  block/blk-mq.c +AHw 6 +-+-+-+-+-+-
+AD4  1 file changed, 6 insertions(+-)
+AD4 
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 3ff3d7b49969..5b586affee09 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -1728,9 +-1728,12 +AEAAQA void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4                 if (rq-+AD4-mq+AF8-hctx +ACEAPQ this+AF8-hctx +AHwAfA rq-+AD4-mq+AF8-ctx +ACEAPQ this+AF8-ctx) +AHs
+AD4                         if (this+AF8-hctx) +AHs
+AD4                                 trace+AF8-block+AF8-unplug(this+AF8-q, depth, +ACE-from+AF8-schedule)+ADs
+AD4 +-
+AD4 +-                               percpu+AF8-ref+AF8-get(+ACY-this+AF8-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4                                 blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(this+AF8-hctx, this+AF8-ctx,
+AD4                                                                 +ACY-rq+AF8-list,
+AD4                                                                 from+AF8-schedule)+ADs
+AD4 +-                               percpu+AF8-ref+AF8-put(+ACY-this+AF8-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4                         +AH0
+AD4  
+AD4                         this+AF8-q +AD0 rq-+AD4-q+ADs
+AD4 +AEAAQA -1749,8 +-1752,11 +AEAAQA void blk+AF8-mq+AF8-flush+AF8-plug+AF8-list(struct blk+AF8-plug +ACo-plug, bool from+AF8-schedule)
+AD4          +ACo-/
+AD4         if (this+AF8-hctx) +AHs
+AD4                 trace+AF8-block+AF8-unplug(this+AF8-q, depth, +ACE-from+AF8-schedule)+ADs
+AD4 +-
+AD4 +-               percpu+AF8-ref+AF8-get(+ACY-this+AF8-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4                 blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(this+AF8-hctx, this+AF8-ctx, +ACY-rq+AF8-list,
+AD4                                                 from+AF8-schedule)+ADs
+AD4 +-               percpu+AF8-ref+AF8-put(+ACY-this+AF8-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4         +AH0
+AD4  +AH0

Although this patch looks fine to me: have you considered to insert one
percpu+AF8-ref+AF8-get() call at the start of blk+AF8-mq+AF8-flush+AF8-plug+AF8-list() and one
percpu+AF8-ref+AF8-put() call at the end of the same function?

Thanks,

Bart.
