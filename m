Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE366C4332B
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D60F64E6C
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBIObt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 09:31:49 -0500
Received: from mx2.veeam.com ([64.129.123.6]:55038 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhBIObr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 09:31:47 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 28B5C414BE;
        Tue,  9 Feb 2021 09:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612881063; bh=CYaL9LusoGHbduz1D+Gy81Me9TskPJ/xQvBoJAZkwvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WuxSMn9sk1iKplI26UZ4BzhRS2RMZjpSu1Ua3PTgs5wKkRuqv7wbjs1q7rzj8M+da
         gb4bjxVYLLtBX9eKAZ3DXxTM5/OyoVSKvfAwEVMTb6exrcf25exDKy9hte2fW4gvVm
         RsTZZrtTxI/YtemQgVqfRGxFl2K/8RKYV9EqUHM8=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 9 Feb 2021 15:30:51 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v5 2/6] block: add blk_mq_is_queue_frozen()
Date:   Tue, 9 Feb 2021 17:30:24 +0300
Message-ID: <1612881028-7878-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
References: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265617465
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_is_queue_frozen() allow to assert that the queue is frozen.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/blk-mq.c         | 13 +++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f285a9123a8b..924ec26fae5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
+
+bool blk_mq_is_queue_frozen(struct request_queue *q)
+{
+	bool ret;
+
+	mutex_lock(&q->mq_freeze_lock);
+	ret = percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(&q->q_usage_counter);
+	mutex_unlock(&q->mq_freeze_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
+
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d705b174d346..9d1e8c4e922e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -525,6 +525,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+bool blk_mq_is_queue_frozen(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.20.1

