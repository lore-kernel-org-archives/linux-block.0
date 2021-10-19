Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8987C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C368661355
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhJSV0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJSV0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CDC061746
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p21so14494355wmq.1
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+s1e1YWVl/iKcwmsT/qfM381a1sl+3GwTljlw0r+aQ=;
        b=gl71a5b9lIzPndqoWCOF9I/ihOVM9i/ZlmLPjO6oyG6hcOKuC5+HJUCJAwsFr0DIko
         WEUbKK9hRqzlhN0oCcVujNBxe3H/CZhk536J+kWbINmziYYGTud6Nw0dG8Gcc2Ov8P8B
         MaTVRU1BoDxh/qLataqs3+SKV6f5zt8gy06jQ4OGzXYvEijWG+8S/z4WCucVusiGWwfG
         XJ84kPGYxQbm+fsX/DuXKRqGPAYHrpY7IXmjgUxVF3n1e/kMwiRZRqmmCTtEl9ZEn6h/
         ywDK6dL8RkjUl7xmLjcL+U6hoQBhql74p033vur85PrwV4jPBKE9baaiDNYYgDH+LZlv
         KKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+s1e1YWVl/iKcwmsT/qfM381a1sl+3GwTljlw0r+aQ=;
        b=psd4a/j4bGVhPbI7w2kwQIpNztl5LRZ4whGK6cmf9FYDiVQzEwvZ9dHE2Pe/UHyamS
         eV+/RyI5bxavZw1+Kmvdibe89X0BqC11ImXCkJ4dM8GDo2w3VT1A3vLK13waGSZvFlt9
         d6wRDOKa1hyY+/d00CxaYFG7poelrLuzcXErZDkQdaPM4Oqs3BgBI+KhaHiW/Gv2bXYi
         1NneGKGJjZ+wvURB7+jljLMen3T96LXxKm9apcB5tjIAh0locgdP9R1sUTEUy1UWJhu7
         /AC1w86jvOkSAoCu2qSo3pczUGuIA4oe227cerC4NqHLErRsZ8KfGilDZHzkMYLtSWxE
         48/w==
X-Gm-Message-State: AOAM530moquR60CpA7kaCUknF08YZ6BeELZf5IeXAmlWsMa93Y2FIP5w
        CVv/jiz7qfnDAfAIdgEzvRD611oZR49WgA==
X-Google-Smtp-Source: ABdhPJyn66wHvg3KF1ol/deW1sla//ZiNN0kIjkC1cZH1D/IxZbxAM6H5IxaXvWH4b4C1uRYA4nJMA==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr8661714wmn.155.1634678676074;
        Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:35 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 04/16] block: don't bloat enter_queue with percpu_ref
Date:   Tue, 19 Oct 2021 22:24:13 +0100
Message-Id: <49bff6b10644a6c789414bf72452edb7d54c132f.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

percpu_ref_put() are inlined for performance and bloat the binary, we
don't care about the fail case of blk_try_enter_queue(), so we can
replace it with a call to blk_queue_exit().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c1ba34777c6d..88752e51d2b6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -404,7 +404,7 @@ static bool blk_try_enter_queue(struct request_queue *q, bool pm)
 	return true;
 
 fail_put:
-	percpu_ref_put(&q->q_usage_counter);
+	blk_queue_exit(q);
 fail:
 	rcu_read_unlock();
 	return false;
-- 
2.33.1

