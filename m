Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DDC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B4C2070D
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfCZPMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:12:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37897 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZPMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 11:12:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so8219227pfo.5
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 08:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbmRpoHJZqw9XFd2eUUpScbKNS/j5evrVkQLsVRFIV0=;
        b=DqQVWzPwg++91DpVxTWmSpyXEoOAk9VX8CXL+K1/5zWl1F9CReaZdegCorlfNJ1Gzu
         72A2ffy/mDV7AuCOZmUVSr/8t+LyJcOw3PL9YZhnyt09hxwyw/DL4WDQ+olSxgPcPZ/n
         BKPJMu9VHbv7nqeFKvw0vo8SVxSv/t4qGVI49TwAzRAfjWfSK4HPjnciDgUNHQ/LYS7G
         YHIUim6sXasm1r4lgsc/Nbyz9Rb43EuMOjAT/rj/QtUjdvO6PqYCTz3j4M8ZXMHCCcdZ
         Mo2PhvpoJmt1ZX8frwMtKWONxgLvYh6d0sm2Ip9hHNYfMHAHq+WpmRzGmfi1pBvJJAxM
         iuIg==
X-Gm-Message-State: APjAAAVAgqOT+yT2Cy1QTiNf0AIiKCxt3H98vxUjlKpws9kZc/GU3BVW
        PS6YpG8wDGl0gse3YqhHIik=
X-Google-Smtp-Source: APXvYqyb0WX+tgJFF1OVPPbJXYKlSrDg2FYfqsvmiXI/emc2ZXcLg2Q+THckcKoMDoQIv4zRU1fS9g==
X-Received: by 2002:a65:6109:: with SMTP id z9mr3832097pgu.419.1553613166335;
        Tue, 26 Mar 2019 08:12:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v20sm9054734pfn.116.2019.03.26.08.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:12:45 -0700 (PDT)
Message-ID: <1553613164.118779.50.camel@acm.org>
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
From:   Bart Van Assche <bvanassche@acm.org>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Date:   Tue, 26 Mar 2019 08:12:44 -0700
In-Reply-To: <a95b94e1-ee6f-a534-a1f0-d55d6b8bffe0@suse.de>
References: <20190326120712.41657-1-hare@suse.de>
         <82fca840-bce0-938e-abc5-1faff5c255d0@acm.org>
         <a95b94e1-ee6f-a534-a1f0-d55d6b8bffe0@suse.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-03-26 at 15:08 +-0100, Hannes Reinecke wrote:
+AD4 On 3/26/19 2:43 PM, Bart Van Assche wrote:
+AD4 +AD4 On 3/26/19 5:07 AM, Hannes Reinecke wrote:
+AD4 +AD4 +AD4 When a queue is dying or dead there is no point in calling
+AD4 +AD4 +AD4 blk+AF8-mq+AF8-run+AF8-hw+AF8-queues() in blk+AF8-mq+AF8-unquiesce+AF8-queue()+ADs in fact, doing
+AD4 +AD4 +AD4 so might crash the machine as the queue structures are in the
+AD4 +AD4 +AD4 process of being deleted.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4   block/blk-mq.c +AHw 3 +-+--
+AD4 +AD4 +AD4   1 file changed, 2 insertions(+-), 1 deletion(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 +AD4 index a9c181603cbd..b1eeba38bc79 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq.c
+AD4 +AD4 +AD4 +AEAAQA -258,7 +-258,8 +AEAAQA void blk+AF8-mq+AF8-unquiesce+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4 +AD4 +AD4       blk+AF8-queue+AF8-flag+AF8-clear(QUEUE+AF8-FLAG+AF8-QUIESCED, q)+ADs
+AD4 +AD4 +AD4       /+ACo dispatch requests which are inserted during quiescing +ACo-/
+AD4 +AD4 +AD4 -    blk+AF8-mq+AF8-run+AF8-hw+AF8-queues(q, true)+ADs
+AD4 +AD4 +AD4 +-    if (+ACE-blk+AF8-queue+AF8-dying(q) +ACYAJg +ACE-blk+AF8-queue+AF8-dead(q))
+AD4 +AD4 +AD4 +-        blk+AF8-mq+AF8-run+AF8-hw+AF8-queues(q, true)+ADs
+AD4 +AD4 +AD4   +AH0
+AD4 +AD4 +AD4   EXPORT+AF8-SYMBOL+AF8-GPL(blk+AF8-mq+AF8-unquiesce+AF8-queue)+ADs
+AD4 +AD4 
+AD4 +AD4 Hi Hannes,
+AD4 +AD4 
+AD4 +AD4 Please provide more context information. In the +ACI-dead+ACI state the queue 
+AD4 +AD4 must be run to make sure that all requests that were queued before the 
+AD4 +AD4 +ACI-dead+ACI state get processed. The blk+AF8-cleanup+AF8-queue() function is 
+AD4 +AD4 responsible for stopping all code that can run the queue after all 
+AD4 +AD4 requests have finished and before destruction of the data structures 
+AD4 +AD4 needed for request processing starts.
+AD4 +AD4 
+AD4 
+AD4 I have a crash with two processes competing for the same controller:
+AD4 
+AD4 +ACM-0  0xffffffff983d3bcb in sbitmap+AF8-any+AF8-bit+AF8-set (sb+AD0-0xffff8a1b874ba0d8)
+AD4      at ../lib/sbitmap.c:181
+AD4 +ACM-1  0xffffffff98366c05 in blk+AF8-mq+AF8-hctx+AF8-has+AF8-pending (hctx+AD0-0xffff8a1b874ba000)
+AD4      at ../block/blk-mq.c:66
+AD4 +ACM-2  0xffffffff98366c85 in blk+AF8-mq+AF8-run+AF8-hw+AF8-queues (q+AD0-0xffff8a1b874ba0d8, 
+AD4 async+AD0-true) at ../block/blk-mq.c:1292
+AD4 +ACM-3  0xffffffff98366d3a in blk+AF8-mq+AF8-unquiesce+AF8-queue (q+AD0APA-optimized out+AD4)
+AD4      at ../block/blk-mq.c:265
+AD4 +ACM-4  0xffffffffc01f3e0e in nvme+AF8-start+AF8-queues (ctrl+AD0APA-optimized out+AD4)
+AD4      at ../drivers/nvme/host/core.c:3658
+AD4 +ACM-5  0xffffffffc01e843c in nvme+AF8-fc+AF8-delete+AF8-association 
+AD4 (ctrl+AD0-0xffff8a1f9be5a000)
+AD4      at ../drivers/nvme/host/fc.c:2843
+AD4 +ACM-6  0xffffffffc01e8544 in nvme+AF8-fc+AF8-delete+AF8-association (ctrl+AD0APA-optimized out+AD4)
+AD4      at ../drivers/nvme/host/fc.c:2918
+AD4 +ACM-7  0xffffffffc01e8544 in +AF8AXw-nvme+AF8-fc+AF8-terminate+AF8-io (ctrl+AD0-0xffff8a1f9be5a000)
+AD4      at ../drivers/nvme/host/fc.c:2911
+AD4 +ACM-8  0xffffffffc01e8f09 in nvme+AF8-fc+AF8-reset+AF8-ctrl+AF8-work (work+AD0-0xffff8a1f9be5a6d0)
+AD4      at ../drivers/nvme/host/fc.c:2927
+AD4 +ACM-9  0xffffffff980a224a in process+AF8-one+AF8-work (worker+AD0-0xffff8a1b73934f00, 
+AD4 work+AD0-0xffff8a1f9be5a6d0) at ../kernel/workqueue.c:2092
+AD4 +ACM-10 0xffffffff980a249b in worker+AF8-thread (+AF8AXw-worker+AD0-0xffff8a1b73934f00)
+AD4      at ../kernel/workqueue.c:2226
+AD4 
+AD4 +ACM-7  0xffffffff986d2e9a in wait+AF8-for+AF8-completion (x+AD0-0xffffa48eca88bc40)
+AD4      at ../kernel/sched/completion.c:125
+AD4 +ACM-8  0xffffffff980f25ae in +AF8AXw-synchronize+AF8-srcu (sp+AD0-0xffffffff9914fc20 
+AD4 +ADw-debugfs+AF8-srcu+AD4, do+AF8-norm+AD0APA-optimized out+AD4) at ../kernel/rcu/srcutree.c:851
+AD4 +ACM-9  0xffffffff982d18b1 in debugfs+AF8-remove+AF8-recursive (dentry+AD0APA-optimized out+AD4)
+AD4      at ../fs/debugfs/inode.c:741
+AD4 +ACM-10 0xffffffff98398ac5 in blk+AF8-mq+AF8-debugfs+AF8-unregister+AF8-hctx 
+AD4 (hctx+AD0-0xffff8a1b7cccc000) at ../block/blk-mq-debugfs.c:897
+AD4 +ACM-11 0xffffffff983661cf in blk+AF8-mq+AF8-exit+AF8-hctx (q+AD0-0xffff8a1f825e4040, 
+AD4 set+AD0-0xffff8a1f9be5a0c0, hctx+AD0-0xffff8a1b7cccc000, hctx+AF8-idx+AD0-2) at 
+AD4 ../block/blk-mq.c:1987
+AD4 +ACM-12 0xffffffff9836946a in blk+AF8-mq+AF8-exit+AF8-hw+AF8-queues (nr+AF8-queue+AD0APA-optimized 
+AD4 out+AD4, set+AD0APA-optimized out+AD4, q+AD0APA-optimized out+AD4) at ../block/blk-mq.c:2017
+AD4 +ACM-13 0xffffffff9836946a in blk+AF8-mq+AF8-free+AF8-queue (q+AD0-0xffff8a1f825e4040)
+AD4      at ../block/blk-mq.c:2506
+AD4 +ACM-14 0xffffffff9835aac5 in blk+AF8-cleanup+AF8-queue (q+AD0-0xffff8a1f825e4040)
+AD4      at ../block/blk-core.c:691
+AD4 +ACM-15 0xffffffffc01f5bc8 in nvme+AF8-ns+AF8-remove (ns+AD0-0xffff8a1f819e8f80)
+AD4      at ../drivers/nvme/host/core.c:3138
+AD4 +ACM-16 0xffffffffc01f6fea in nvme+AF8-validate+AF8-ns (ctrl+AD0-0xffff8a1f9be5a308, nsid+AD0-5)
+AD4      at ../drivers/nvme/host/core.c:3164
+AD4 +ACM-17 0xffffffffc01f9053 in nvme+AF8-scan+AF8-ns+AF8-list (nn+AD0APA-optimized out+AD4, 
+AD4 ctrl+AD0APA-optimized out+AD4) at ../drivers/nvme/host/core.c:3202
+AD4 +ACM-18 0xffffffffc01f9053 in nvme+AF8-scan+AF8-work (work+AD0APA-optimized out+AD4)
+AD4      at ../drivers/nvme/host/core.c:3280
+AD4 +ACM-19 0xffffffff980a224a in process+AF8-one+AF8-work (worker+AD0-0xffff8a1b7349f6c0, 
+AD4 work+AD0-0xffff8a1f9be5aba0) at ../kernel/workqueue.c:2092
+AD4 
+AD4 Point is that the queue is already dead by the time nvme+AF8-start+AF8-queues() 
+AD4 tries to flush existing requests (of which there are none, of course).
+AD4 I had been looking into synchronizing scan+AF8-work and reset+AF8-work, but then 
+AD4 I wasn't sure if that wouldn't deadlock somewhere.

James, do you agree that nvme+AF8-fc+AF8-reset+AF8-ctrl+AF8-work should be canceled before
nvme+AF8-ns+AF8-remove() is allowed to call blk+AF8-cleanup+AF8-queue()?

Thanks,

Bart.
