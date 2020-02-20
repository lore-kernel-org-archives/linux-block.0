Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42EC5ACC4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEC421D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBTCo4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:44:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39990 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgBTCo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so936313plp.7
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSZ9WoMz732W6+HJg8zmXiY2NNitNQdJi2okPnkNQ04=;
        b=MZj68CxKWsiuE4p9dK2A9UHzDhsdxsfajdixZIxyMaE88bot4uLEHL8BCWKGljmYBZ
         0Umb5kDMm6Ot1XlYKtCNsqKyRh5zgQCJ70JLr0F9y70/Y6THpVDzlOyGmWDZwcKErUAn
         /ZX870iejSbPO8GdURexynQqoLvwyL85zAfO0BUNaUCYedEwoR8qWtrd8USFjscSWmQY
         ishDO0VRxF3a84ZEmo0fDfSX9enSMgMbYCa4+wEGRN6JTULdSTZMqQQl4slZPhb3yeHm
         vO8YmSUQpZzoPcsojN+eiBIvmtHMbDNXwV4AYVZeEnLkxjyI109hWvIECPzwk1gaa3e5
         dz2A==
X-Gm-Message-State: APjAAAXnRav8ITb3RJEhcpJCJRdZ0Kh+rpZfzNdHUbs9J0iSg3FWF9Sj
        BeFUncB2uXhyZ08YmoXRNmQ=
X-Google-Smtp-Source: APXvYqxXmYNCDhnMncdWR4EBXZjvUtVfOZEvXC6d7XmQUyXrim+x7ly0dKbBTQw4lELmIAavhJM5BQ==
X-Received: by 2002:a17:902:6508:: with SMTP id b8mr28964178plk.201.1582166695903;
        Wed, 19 Feb 2020 18:44:55 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:55 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 6/8] null_blk: Fix the null_add_dev() error path
Date:   Wed, 19 Feb 2020 18:44:39 -0800
Message-Id: <20200220024441.11558-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If null_add_dev() fails, clear dev->nullb.

This patch fixes the following KASAN complaint:

BUG: KASAN: use-after-free in nullb_device_submit_queues_store+0xcf/0x160 [null_blk]
Read of size 8 at addr ffff88803280fc30 by task check/8409

Call Trace:
 dump_stack+0xa5/0xe6
 print_address_description.constprop.0+0x26/0x260
 __kasan_report.cold+0x7b/0x99
 kasan_report+0x16/0x20
 __asan_load8+0x58/0x90
 nullb_device_submit_queues_store+0xcf/0x160 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x145/0x2c0
 ksys_write+0xd7/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7ff370926317
Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff2dd2da48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff370926317
RDX: 0000000000000002 RSI: 0000559437ef23f0 RDI: 0000000000000001
RBP: 0000559437ef23f0 R08: 000000000000000a R09: 0000000000000001
R10: 0000559436703471 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ff370a006a0 R14: 00007ff370a014a0 R15: 00007ff370a008a0

Allocated by task 8409:
 save_stack+0x23/0x90
 __kasan_kmalloc.constprop.0+0xcf/0xe0
 kasan_kmalloc+0xd/0x10
 kmem_cache_alloc_node_trace+0x129/0x4c0
 null_add_dev+0x24a/0xe90 [null_blk]
 nullb_device_power_store+0x1b6/0x270 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x145/0x2c0
 ksys_write+0xd7/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8409:
 save_stack+0x23/0x90
 __kasan_slab_free+0x112/0x160
 kasan_slab_free+0x12/0x20
 kfree+0xdf/0x250
 null_add_dev+0xaf3/0xe90 [null_blk]
 nullb_device_power_store+0x1b6/0x270 [null_blk]
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
Fixes: 2984c8684f96 ("nullb: factor disk parameters")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 31678c9af43f..9846648780b6 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1819,6 +1819,7 @@ static int null_add_dev(struct nullb_device *dev)
 	cleanup_queues(nullb);
 out_free_nullb:
 	kfree(nullb);
+	dev->nullb = NULL;
 out:
 	return rv;
 }
