Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734DDC11D24
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228B24654
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBUDW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:22:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:22:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so292415pgk.0
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJCLdqILp21uMrXCuSy7CxSeezDCusWqSkTR2T0a8u4=;
        b=AybcCkoo6d9tkCBo+g3wzN1viKL3LcO8QfKF9nmYdeA9QXP19TTHeAcwH7WMKIHHZd
         1HuNzWkOJhSGVXUSlvefKmXqt6Ww5QOCoEutu+mvIKyKPqPYvOeoVt1j9Q/w7xG1b5UJ
         ZrpDm5LRqGog8WGVSpjKOjI69S4LxQR06gXqwy/rrEH4EiZIn/LBJO/33A8v4/VsB0DY
         JhPcKMDZKbXPbOGdRyUHBMwHfgAiWpVghy6Clf5Exgp4qrKIyPUwYqwqcU3od6VHKfvQ
         uyrKj71a/S4b0VbbrJAC0lT4mywD3N2km1TSaHrHFwXsz5fhX+A+jCEcjcmoSVnjJ+ll
         YHGQ==
X-Gm-Message-State: APjAAAXAoNfAf/wG2DmpsiexgEsVQI5RmuXMCRwWKQwFir1ar+J5vqkF
        J66Z9dazss6kkmmNEylDvBk=
X-Google-Smtp-Source: APXvYqyt1qE5WymJzmSDtLLLBVWcQ36bqsbOqWjRh/sm8A9keisUV0e9nAofkpjcHS2MPM4LtcWNxQ==
X-Received: by 2002:a63:78c7:: with SMTP id t190mr38039402pgc.416.1582255377749;
        Thu, 20 Feb 2020 19:22:57 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:22:57 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 3/8] blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()
Date:   Thu, 20 Feb 2020 19:22:38 -0800
Message-Id: <20200221032243.9708-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221032243.9708-1-bvanassche@acm.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Fixes: ac0d6b926e74 ("block: Reduce the amount of memory required per request queue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a92444c077bc..49fa56fc48de 100644
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
