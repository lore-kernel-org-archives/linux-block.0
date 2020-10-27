Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F1C388F9
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 10:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629AA2071A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603792954;
	bh=lFtkOa6eB5wVoP21aYD3evpLemSog4PLhpFnxfTANWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vYQCOLywyP6NLefubtvV50/NWWPmc2CCgfU0GFGhd5YOigN3v5ueW0uUfzgz+qUlC
	 kZbJfVb07uVDbSRcvVZ6clF77PWBTFr5k08vQ+OZOPfCzHF5vestVloYqINcX3XTbw
	 Qzaaknwegmaj5PBu/Kr3tJd8mku4LLN76i8H8Eiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896914AbgJ0KC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896027AbgJ0Jvm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:42 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E35D222D9;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=lFtkOa6eB5wVoP21aYD3evpLemSog4PLhpFnxfTANWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qomxFSmJWXaiRnqz5k1F2QyT6LJc/Bz7phcLrrfYgw9Dd9TV85cho0p+S5oQhXreU
         eZXfGcCwIiXdsbN/IsJI2WiqoolBd84mqt51qs4Ik2eS3f4IoJe+mLf2RVf8p1vWLG
         3QhUk71s77ZyUtI/3M2OOHajkxmkhftzxUWgE6/0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEp-7G; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        John Garry <john.garry@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/32] blk-mq: docs: add kernel-doc description for a new struct member
Date:   Tue, 27 Oct 2020 10:51:13 +0100
Message-Id: <8e513153b83eefc05e358f51f2632b592c3f6772.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: John Garry <john.garry@huawei.com>
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

