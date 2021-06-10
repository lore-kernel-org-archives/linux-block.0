Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D89C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A34B61403
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJHo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:44:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:44:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0wpy0q5NzYrnJ;
        Thu, 10 Jun 2021 15:39:38 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:42:28 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 15:42:27 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiaosong2@huawei.com>
Subject: [PATCH -next] partitions/aix: fix doc warnings
Date:   Thu, 10 Jun 2021 15:48:45 +0800
Message-ID: <20210610074845.58503-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix gcc W=1 warnings:

block/partitions/aix.c:130: warning: Function parameter or member 'lba' not described in 'alloc_pvd'
block/partitions/aix.c:130: warning: Function parameter or member 'state' not described in 'alloc_pvd'
block/partitions/aix.c:155: warning: Function parameter or member 'lba' not described in 'alloc_lvn'
block/partitions/aix.c:155: warning: Function parameter or member 'state' not described in 'alloc_lvn'
block/partitions/aix.c:97: warning: Function parameter or member 'buffer' not described in 'read_lba'
block/partitions/aix.c:97: warning: Function parameter or member 'count' not described in 'read_lba'
block/partitions/aix.c:97: warning: Function parameter or member 'lba' not described in 'read_lba'
block/partitions/aix.c:97: warning: Function parameter or member 'state' not described in 'read_lba'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 block/partitions/aix.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index c7b4fd1a4a97..44397139cae0 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -84,10 +84,10 @@ static u64 last_lba(struct block_device *bdev)
 
 /**
  * read_lba(): Read bytes from disk, starting at given LBA
- * @state
- * @lba
- * @buffer
- * @count
+ * @state: Pointer to "struct parsed_partitions"
+ * @lba: Logical block address
+ * @buffer: Pointer to "u8"
+ * @count: Bytes reads from @state->bdev into @buffer
  *
  * Description:  Reads @count bytes from @state->bdev into @buffer.
  * Returns number of bytes read on success, 0 on error.
@@ -119,8 +119,8 @@ static size_t read_lba(struct parsed_partitions *state, u64 lba, u8 *buffer,
 
 /**
  * alloc_pvd(): reads physical volume descriptor
- * @state
- * @lba
+ * @state: Pointer to "struct parsed_partitions"
+ * @lba: Logical block address
  *
  * Description: Returns pvd on success,  NULL on error.
  * Allocates space for pvd and fill it with disk blocks at @lba
@@ -144,8 +144,8 @@ static struct pvd *alloc_pvd(struct parsed_partitions *state, u32 lba)
 
 /**
  * alloc_lvn(): reads logical volume names
- * @state
- * @lba
+ * @state: Pointer to "struct parsed_partitions"
+ * @lba: Logical block address
  *
  * Description: Returns lvn on success,  NULL on error.
  * Allocates space for lvn and fill it with disk blocks at @lba
-- 
2.25.4

