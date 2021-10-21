Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EAAC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9960EE2
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhJUNdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhJUNdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 09:33:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB5C0613B9;
        Thu, 21 Oct 2021 06:30:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p21so724599wmq.1;
        Thu, 21 Oct 2021 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1EZc8F3LGa37Y9tu7Tob6o+fpihU/+4iG2rIzfXu/A=;
        b=DSLfMGOH+4Vf+I5tVUhKt6iPK9QhlIK1peDZ/Rd1UA+3pGfTuY94UfTBLfe5O4tBWf
         /x+vRpqShCTOZp7w5M9oCPv5WxNrKMlf3XchuqaAXjLa2LrN4eauOYqDn/z+byCurgQG
         sxTQPqjBkQJpbIXMxnbruNnFS/VSx3lacEPdxKVowgsAD0etuK4dquzD3uHozStluJE8
         WpApuuhYMmhnKHyELAJ150q90k//oKBI0og1Snx+/yl6wp2kNRjsBPHPrJw0vOZYyhdm
         WneyBOd6yzDTTxUHJd3ziLgB70JVFCGBwcF31E/hEV7YUfEAccTrziTy80O/5N4HfgKy
         wrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1EZc8F3LGa37Y9tu7Tob6o+fpihU/+4iG2rIzfXu/A=;
        b=7KRgSsGltZeOZ7y8MNRHMuxkFykA00+QHbVbfOxgMijhYqdJ+VHwh16ChF+9G+SG1o
         qfTngd23MXbRZyTVKETzVpu4uagFrN/vebZn/J84TfmRBFFM8Ij41SuLRMsINObWBLwR
         AxeTHDBsQ3FLSaZHXeSwvtTzYlI5JNX09EY/9rC8okigwxc8Xhe8bLbqmaroiccMPMHY
         33z5ibsqlCWvIUQML7TW3Pxp7iaqDD9eyRkHweNwzLZvBXndGnDoAbzHNjyWxxMzMVxN
         xwLtyqq228WLnGyhBIVo2lbyagLfJLrOQ8x3CcREUGfkVlOA6yIpvo8BtBTsFsC5z81U
         m4eA==
X-Gm-Message-State: AOAM530eMupQBP/G4xyeORYYMpNXy0iccg6I8/8qq0NKbLnAcZxmkBUb
        DHl2JVoBIeIMHMAEAE46NS5MbTZ7iRJkTA==
X-Google-Smtp-Source: ABdhPJzePBePS8id/gMcA7dyBwnpRlvyOO68ZUrBYCXG1JbQEWIUK/7kzEExvq99mreV58pAFWYDAQ==
X-Received: by 2002:a1c:7f0a:: with SMTP id a10mr21627983wmd.60.1634823057945;
        Thu, 21 Oct 2021 06:30:57 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id q188sm1753987wma.1.2021.10.21.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:30:57 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 2/2] block: kill extra rcu lock/unlock in queue enter
Date:   Thu, 21 Oct 2021 14:30:52 +0100
Message-Id: <6b11c67ea495ed9d44f067622d852de4a510ce65.1634822969.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634822969.git.asml.silence@gmail.com>
References: <cover.1634822969.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_try_enter_queue() already takes rcu_read_lock/unlock, so we can
avoid the second pair in percpu_ref_tryget_live(), use a newly added
percpu_ref_tryget_live_rcu().

As rcu_read_lock/unlock imply barrier()s, it's pretty noticeable,
especially for for !CONFIG_PREEMPT_RCU (default for some distributions),
where __rcu_read_lock/unlock() are not inlined.

3.20%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
3.05%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

2.52%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
2.28%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 88752e51d2b6..20e76aeb50f5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL(blk_cleanup_queue);
 static bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
 	rcu_read_lock();
-	if (!percpu_ref_tryget_live(&q->q_usage_counter))
+	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
 		goto fail;
 
 	/*
-- 
2.33.1

