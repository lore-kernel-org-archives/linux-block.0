Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36391C43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKBPUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKBPTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF5D1704C
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1500249wmq.4
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vaKIUeUGBd2XcHhMkOucioiZX3YOY/Xwk36yuAh4aE=;
        b=SMPVoEcnmpjpWpOIfBwY/KnyKs3CRx77848wtFgxK+9C4zYohcvhTNGNGFP5XkChR6
         ED/B9ch8j+BAAqYgUtK25sIBqGDVmuHOfEJvQCdIUBAqNwT+GjXTEaUT7RfIrW/zMQwL
         h7tVJgYoZ3LQKGI0frdwlzmNN8n2RbnU6/NO3R+8ukknLe34s1IWDiFAQS8jHDYE6Ted
         o/xJvjRBf1VmOrr3j87h5H70rcop8lpfBkfZQNlFKn6F2xuKAeQ9cZEfkrlT8FBj4qBu
         Mov/Vd1nSG6D6qD7z75nGmdO4KYkU8tyJK2sL3ZDlk1YFrLLo159bSV3il4Mdx4f9pBz
         KPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vaKIUeUGBd2XcHhMkOucioiZX3YOY/Xwk36yuAh4aE=;
        b=q80T1t4a7UC/FFXF7LnFkcpGCyElIAo1DNc4hxNDqC0nct4plWBW3iuFeCnmuhvpxO
         7oT8cioDfvzE+Xd1QHz1BbTMkZaS4Ar9dm/OrJy9SXjLwxzkL+RThuu2BmvAX/49ps03
         w5MmYJ1qU7qPDHwgVxUbPs2EE+GNYCj8lHmIWghjQISe4wd+t4J/sYzRed3wty3d+ido
         sVrJyW0wSsHCx5eeQlI9Ed8mm+G/MF984DHPHLlAubvj/zWZQtaCqJhePhAU7xQP3fPt
         +JLtyOfrZRz35nvLey+lJemSVq0+JLl7gBHv5I6Mgaz7xgF1LidgKSTmiIx4szTBUA79
         1lTQ==
X-Gm-Message-State: ACrzQf2bGML5Mo1pbvfhzFFZDIp7b7po4yKwRbg3Gu4wHkEdUSyiyORb
        TiANlyfiJsah+atRF4Vyudg=
X-Google-Smtp-Source: AMsMyM4B3oR7+dgj8lw6zRqTrgMRYIARqQAIzT7kVhBg9U8a1NcckjVFmZxVIrfrvGyXtYQcMDSMsA==
X-Received: by 2002:a05:600c:1e2a:b0:3c8:353b:253f with SMTP id ay42-20020a05600c1e2a00b003c8353b253fmr16111973wmb.51.1667402376065;
        Wed, 02 Nov 2022 08:19:36 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:35 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 1/6] mempool: introduce mempool_is_saturated
Date:   Wed,  2 Nov 2022 15:18:19 +0000
Message-Id: <636aed30be8c35d78f45e244998bc6209283cccc.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper mempool_is_saturated(), which tells if the mempool is
under-filled or not. We need it to figure out whether it should be
freed right into the mempool or could be cached with top level caches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/mempool.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..4aae6c06c5f2 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -30,6 +30,11 @@ static inline bool mempool_initialized(mempool_t *pool)
 	return pool->elements != NULL;
 }
 
+static inline bool mempool_is_saturated(mempool_t *pool)
+{
+	return READ_ONCE(pool->curr_nr) >= pool->min_nr;
+}
+
 void mempool_exit(mempool_t *pool);
 int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      mempool_free_t *free_fn, void *pool_data,
-- 
2.38.0

