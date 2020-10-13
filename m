Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE57C43457
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 12:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F3F22247
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602591336;
	bh=qdz3piIzX1wpe0r/0uZBhudtd/hwLAcckI0SXN+J6n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaxxwP9yTcGtSBvTtGPhQzTDGjqq2Cxd1SeRfnE7AOe1E1WGY2AzBOevcoGBS0urW
	 88xMGaWR3MrKxxNpGuK7PTV75iByXCVHanp2yg+JG8EyDQjbej00NLaVj90ATqiIjM
	 COPWeUNvafQJXkR29r2dThXt4l9rtxX3eFFP7xss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgJMMPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 08:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgJMMO5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D4F2242F;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591296;
        bh=qdz3piIzX1wpe0r/0uZBhudtd/hwLAcckI0SXN+J6n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPVOBrDn2Q7AGL2qOPD5oyQT2fyKLF0FykpUpaTQEhuV3n2eI9iwweBhXHA5HQAsx
         mvkfMSyNG6a0PvUhdx10P1P3UBzzUpOgpiyqkqHB9+z17/k8AOKYSeEFc1FTNTAgRu
         QM450yHUgsEyVk2j3BhNMLR+ii31Hzn2jBZkWxho=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006Co1-RQ; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        John Garry <john.garry@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/24] blk-mq: docs: add kernel-doc description for a new struct member
Date:   Tue, 13 Oct 2020 14:14:33 +0200
Message-Id: <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As reported by kernel-doc:
	./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'

There is now a new member for struct blk_mq_tag_set. Add a
description for it, based on the commit that introduced it.

Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/blk-mq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..794b2a33a2c3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -235,6 +235,8 @@ enum hctx_type {
  * @flags:	   Zero or more BLK_MQ_F_* flags.
  * @driver_data:   Pointer to data owned by the block driver that created this
  *		   tag set.
+ * @active_queues_shared_sbitmap:
+ * 		   number of active request queues per tag set.
  * @__bitmap_tags: A shared tags sbitmap, used over all hctx's
  * @__breserved_tags:
  *		   A shared reserved tags sbitmap, used over all hctx's
-- 
2.26.2

