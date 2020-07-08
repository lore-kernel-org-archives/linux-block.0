Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C9BC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3739A207DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594223012;
	bh=NAbFpu8g4lg42BP7xntLAmpxriEiKBROrvqWTxwFY6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xEAenqYQ2/1vlOW004U+TjtTvVM86TghXkhJ9kKwlERg6iyvu1g9KV2YIoIk9Zem7
	 dMipOZD3WuRABSRkoS9sDRSqcqUmnDZwe/uj9n8J0twJDjZlxdMvcQJ9/LFjFjcSVz
	 6qfL2GLztJ8VDOjpPuqeRdkyzNKjGgMqCllz34Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgGHPlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbgGHPlq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FEF0206DF;
        Wed,  8 Jul 2020 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222906;
        bh=NAbFpu8g4lg42BP7xntLAmpxriEiKBROrvqWTxwFY6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNLoHk+UHNX1HlHFbbfNlS3CtVB3fafeJLF7qRvnzmO0mwwb9aq7c58yvKInynKG2
         Fsj/1EQv2E9XqcA3pxIn9Q9//Jvi7wr/8J2vF8+vhT9wxquPVNxr8cuTze5G6KAolZ
         /MCHu6MmZUZWNr91B9D2QwcBUNS1RfseSEZSnE/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Tao <houtao1@huawei.com>, Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/16] blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flags
Date:   Wed,  8 Jul 2020 11:41:27 -0400
Message-Id: <20200708154135.3199907-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154135.3199907-1-sashal@kernel.org>
References: <20200708154135.3199907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit bfe373f608cf81b7626dfeb904001b0e867c5110 ]

Else there may be magic numbers in /sys/kernel/debug/block/*/state.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992d..121f4c1e0697b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -125,6 +125,9 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
+	QUEUE_FLAG_NAME(PCI_P2PDMA),
+	QUEUE_FLAG_NAME(ZONE_RESETALL),
+	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bff1def62eed9..d5338b9ee5502 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -592,6 +592,7 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
+/* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-- 
2.25.1

