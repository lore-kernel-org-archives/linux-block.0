Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07DFA3744
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiJ0WPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiJ0WPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 18:15:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFE844C2
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g12so4471891wrs.10
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE5+CC9OXzgT2TfGQc5mWPdC8YMTjecZPW7uRhWvCKU=;
        b=lwzIIHcrBsVtLAdDEmhpioFOwjMtNn9FUU9S0OatRkq8hKHoZ9sGRVXZpTPb8Q0lHN
         vOY+SktYi8i89Kvyc92jpcO9BQ2Z4fPyxnB8ViVl4lSkEdiU1tK2XRCOL6OcM16w73ha
         DrO+sv3y3jI5FHxKGXHRcdUmdlk4imk/oDOcUCQGOomu+rglyUMazpKCJsPc85dTI2ED
         PmFPPVjVCc4j52WVEQ7wmpKsGsWEOR1F+Zr9I4WyqaHSc9Uq1cX8ZXw/reQJRWopX+Vb
         C7LNEr9tG2AS6cKAiEhbSHNIz5hltwO5Tu0zb8O2jQew+gfaAmHt566+9VGmLbjAW19K
         7KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE5+CC9OXzgT2TfGQc5mWPdC8YMTjecZPW7uRhWvCKU=;
        b=K1OFIKX2ugx+HZaUl5KY1rMT6iaQPtvCt8Fii+e4iaMzAtzjrnK3YMRiwUs+3jrNcb
         S2kJ4N2X8FI8V+JsscR/20bnifOiWhzGWrojAq66xUjnNjqlHQAjT8cGMpy3qSUbkmdR
         xqHptWphD+MewuQI9mHTeguYkC9YviTwo5+0AWMTMHjx5pZg9vw02St2NLolK9xXpB40
         5OeEgUCnYzc5oDdowrrTLIMes7oJwpyEyW5bVsZ0haQE9/UsjNgA6ZJxpzS4qh33QNeT
         +/PGgDrt2BSYN2Jz+TmDvqbJd4ZJS8CgAyJdrqYMGdALzWGNd347+Yy8QAscZLVijTkf
         EzYA==
X-Gm-Message-State: ACrzQf0A7QLyUYVrl+r3nUhBqWqHgq+MdmALW4OFxJqAJv0MzKJCQgs3
        szNvdvSQK2HsQlXfNI74tbFs1RAYnd9CfA==
X-Google-Smtp-Source: AMsMyM572SMSH09liAGB2TU6pHtJoE5Efxjw6WohVpL0X66FoRg90Fmg9SaUtRoz28IJgptQfWCXyg==
X-Received: by 2002:adf:d1c4:0:b0:230:7771:f618 with SMTP id b4-20020adfd1c4000000b002307771f618mr31417479wrd.203.1666908929490;
        Thu, 27 Oct 2022 15:15:29 -0700 (PDT)
Received: from 127.0.0.1localhost (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id bs5-20020a056000070500b00236674840e9sm2085460wrb.59.2022.10.27.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:15:28 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-6.1 1/2] mempool: introduce mempool_is_saturated
Date:   Thu, 27 Oct 2022 23:14:21 +0100
Message-Id: <205ff5240ef32578ca6f689851d9132871f4c9f8.1666886282.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1666886282.git.asml.silence@gmail.com>
References: <cover.1666886282.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper mempool_is_saturated(), which tells if the mempool is
under-filled or not. We need it to figure out whether it should be
freed right into the mempool or could be cached with top level caches.

Cc: <stable@vger.kernel.org> # 5.15+
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

