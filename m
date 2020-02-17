Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB717C3402B
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C71520725
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgBQVIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so9544970pfn.0
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2020 13:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nm1uikhWNlAKb3TDjKxNmMKyI+HvYEOE+5FD96oknrE=;
        b=EGsqr1FHnNpUU4WdEQ72jCmKdcbpOtI5GtpTmxNaGIaT1JSEoDFsdTBQqBpxrHnYO2
         2R4BODpAfa5yL2wx8Y+grm9u6RRYb2DHoYUvKnZVWzhdnUH2ZfyhINfqBRRTmU04vW29
         9QUVhEinySPXfODuvzs8FYrL/jTHooEOeXHnhAhNmuVbDj+hybvE+6/YV10DBzdh4b/y
         eXuP4cO6yp4O9g7oWrsa8rieonsT7JUH6MqW+hdLbMPoa97T0UdoaBV8Kp43Fpj/GxxF
         +1b1Z/neqg8nBNV9J5IysDoZ4pcwpVxGcAQeyErCSYmqmcx/hMFeN9sxuMhC+1KGtk9Q
         uqgQ==
X-Gm-Message-State: APjAAAV4E2lbv1IjaiHUqDXeksdvrYqxtttcE6anohlQ59YCeKphQDAe
        e2c+1f0uhYwev4fko2ERX34=
X-Google-Smtp-Source: APXvYqwjCdFjvRhJFpTvSUTYPWmjQwZTAbke+p6ziOc7ZLHRTQ21I3FxeFzTFKgGI1wd4qIP24irKw==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr17956578pfy.117.1581973730295;
        Mon, 17 Feb 2020 13:08:50 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id h13sm362952pjc.9.2020.02.17.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:08:49 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/5] blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()
Date:   Mon, 17 Feb 2020 13:08:37 -0800
Message-Id: <20200217210839.28535-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217210839.28535-1-bvanassche@acm.org>
References: <20200217210839.28535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->nr_hw_queues must only be updated once it is known that
blk_mq_realloc_hw_ctxs() has succeeded. Otherwise it can happen that
reallocation fails and that q->nr_hw_queues is larger than the number of
allocated hardware queues. This patch fixes the following crash if
increasing the number of hardware queues fails:

BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x775/0x810
Write of size 8 at addr 0000000000000118 by task check/977

CPU: 3 PID: 977 Comm: check Not tainted 5.6.0-rc1-dbg+ #8
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0xa5/0xe6
 __kasan_report.cold+0x65/0x99
 kasan_report+0x16/0x20
 check_memory_region+0x140/0x1b0
 memset+0x28/0x40
 blk_mq_map_swqueue+0x775/0x810
 blk_mq_update_nr_hw_queues+0x468/0x710
 nullb_device_submit_queues_store+0xf7/0x1a0 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x145/0x2c0
 ksys_write+0xd7/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Fixes: ac0d6b926e74 ("block: Reduce the amount of memory required per request queue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2b9f490f5a64..5408098b58f2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2824,7 +2824,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
 		q->queue_hw_ctx = new_hctxs;
-		q->nr_hw_queues = set->nr_hw_queues;
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
