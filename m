Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DCC43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAB1215EA
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfD2SJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:09:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38838 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SJn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 14:09:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so5533460pgl.5;
        Mon, 29 Apr 2019 11:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJOGlGYSH3SlE0jeCS3dML9u9I8zbarnCLYGrnCr3q8=;
        b=bLXUW2izYVHJMquGToXtydDXIiyHtZF8/eVFtQ6SoaJb/gPji4vCYsCJGgK/snCn8k
         l9vYpGr55h1QelrNixDzdjaThWgJCu6vxYnA/Yo8mdXyK8YqGcJ/vqXk4n4zRnH0bJlO
         XjM5nGAA9mCM/s40/ZsFPBsjFz6ecfGWp75VPbkP28GTo2rmYMGOWW8yzcD/F7MSQnGV
         u2+HBQEvTxkMeEFA1No8hhhBMp+HBWxENgLoleNajWwobQoi5/Uon9XV/qraGCCFRKOL
         MonEO+5DcOrKl3agpaxg6NwyCvpilV0s4DDdJxnpAcG5o1U+HFZy1DX8byhbA7xhYJNC
         Ao+g==
X-Gm-Message-State: APjAAAWyA/tTtRdLA2grLMkhs/Ow0h5z0oc7f2PwQzBY9Kf6maEWx7EJ
        As2CsFda4rIAToWcG1C90/Q=
X-Google-Smtp-Source: APXvYqxpm6pt2uhPLrUrNcLGRVhy+/zQYUH4BBAI6i7WoPXoNFn9sTz9+/hE2Det0la+5/d4hUd4Ww==
X-Received: by 2002:a62:480d:: with SMTP id v13mr65987357pfa.125.1556561381957;
        Mon, 29 Apr 2019 11:09:41 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l10sm75561710pfc.46.2019.04.29.11.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:09:40 -0700 (PDT)
Message-ID: <1556561379.161891.164.camel@acm.org>
Subject: Re: [PATCH V8 1/7] blk-mq: grab .q_usage_counter when queuing
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
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Date:   Mon, 29 Apr 2019 11:09:39 -0700
In-Reply-To: <20190428081408.27331-2-ming.lei@redhat.com>
References: <20190428081408.27331-1-ming.lei@redhat.com>
         <20190428081408.27331-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-04-28 at 16:14 +-0800, Ming Lei wrote:
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
+AD4 Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 Reviewed-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4
+AD4 Reviewed-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
+AD4 Tested-by: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
+AD4 Signed-off-by: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4

I added my +ACI-Reviewed-by+ACI to a previous version of this patch but not
to this version of this patch. Several +ACI-Reviewed-by+ACI tags probably
should be removed.

+AD4 diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
+AD4 index aa6bc5c02643..dfe83e7935d6 100644
+AD4 --- a/block/blk-mq-sched.c
+AD4 +-+-+- b/block/blk-mq-sched.c
+AD4 +AEAAQA -414,6 +-414,13 +AEAAQA void blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4  +AHs
+AD4         struct elevator+AF8-queue +ACo-e+ADs
+AD4  
+AD4 +-       /+ACo
+AD4 +-        +ACo blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests() is called from flush plug
+AD4 +-        +ACo context only, and hold one usage counter to prevent queue
+AD4 +-        +ACo from being released.
+AD4 +-        +ACo-/
+AD4 +-       percpu+AF8-ref+AF8-get(+ACY-hctx-+AD4-queue-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4 +-
+AD4         e +AD0 hctx-+AD4-queue-+AD4-elevator+ADs
+AD4         if (e +ACYAJg e-+AD4-type-+AD4-ops.insert+AF8-requests)
+AD4                 e-+AD4-type-+AD4-ops.insert+AF8-requests(hctx, list, false)+ADs
+AD4 +AEAAQA -432,6 +-439,8 +AEAAQA void blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4         +AH0
+AD4  
+AD4         blk+AF8-mq+AF8-run+AF8-hw+AF8-queue(hctx, run+AF8-queue+AF8-async)+ADs
+AD4 +-
+AD4 +-       percpu+AF8-ref+AF8-put(+ACY-hctx-+AD4-queue-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4  +AH0

I think that 'hctx' can disappear if all requests queued by this function
finish just before blk+AF8-mq+AF8-run+AF8-hw+AF8-queue() returns and if the number of hardware
queues is changed from another thread. Shouldn't the request queue pointer be
stored in a local variable instead of reading hctx-+AD4-queue twice?

Bart.
