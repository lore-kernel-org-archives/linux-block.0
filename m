Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC790C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 15:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKBPUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKBPTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 11:19:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042F24BFA
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 08:19:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so25058102wrb.4
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12WSPtjWIVh7qXdWOGW7CSPnEqHMACEW2HlugAwiwI4=;
        b=EGzrKLjizyg+Wb0WMbXX6YC8X94uwHc4vswQAVzFwsSRBUt48R1WwSazu6XrpwjJfG
         qAf3qrQe+kl2eCpyFnXNvWxKXCXJWPOCcPGK/5BkX13WfsfcROLi4ZXJoBcjrYiOV2Kl
         U4+/6zUWGND2YiF1m7+pp53bo09G/ykP9Ymn7MwVDX+lr7AuDqlPIh0H2HB1RplsOVkG
         huTVH5i4UtHYCzxDExiSTbJLxRr1llYeBlhBVnt43eSILAA4g+AvVbuVccgR/WZvMX0g
         thDiwfPZLQ1vr/sfdyT2z2s8rZQXY2JT9dArHD92VgJB0cV3z4T4JyrfKTMuik7uJ+iu
         wwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12WSPtjWIVh7qXdWOGW7CSPnEqHMACEW2HlugAwiwI4=;
        b=QVESCel0Ys5nNsb725ie4AV/UvQbirSDG/ELcDBISwoRdtR/UgUk0VinnqWvOUE8EB
         suPLdb3cwqvmoS7xnTr5oi4J3e9Jd184zun4yr11z8NVdpA+rHkLO1iieCBoMN0bD7l1
         Fw9FDk6vBvKIHp4U6vGNEHOmPCVXiQd6AbEzW8421jzv1pMZPTw1f1nHwEzWSgPQJyBu
         az6Sju/QeekwlI9hp7g/PRWWOLZIrptbP2/Cy/8eYThUGhxkJcDp4z+NHA3PIG3hMfqV
         KTgKFpXPpCkkJBW2RCggalWsO7Ncvt9G4q2OntSvRdw+MSX6K+CcmVWex4F9WfUpPdIF
         kKqw==
X-Gm-Message-State: ACrzQf16sMcTo6+BEGEeLNRKWB0LYxd2vQmpv70KaJCJBjHh1v/P670x
        0jUkf5UPORtL3Ta7vaWLc8A=
X-Google-Smtp-Source: AMsMyM7Jt123QhX2Yy3qpqB0kFuVji3Gbf4u/851EAj9PzV/ltsUddkJVBQdGMx1ANuVGoR3R78KJA==
X-Received: by 2002:a5d:5233:0:b0:236:b893:9d81 with SMTP id i19-20020a5d5233000000b00236b8939d81mr13712590wra.503.1667402381958;
        Wed, 02 Nov 2022 08:19:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.186.241])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0022e66749437sm13043232wrq.93.2022.11.02.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:19:41 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next v4 5/6] bio: shrink max number of pcpu cached bios
Date:   Wed,  2 Nov 2022 15:18:23 +0000
Message-Id: <bc198e8efb27d8c740d80c8ce477432729075096.1667384020.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1667384020.git.asml.silence@gmail.com>
References: <cover.1667384020.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The downside of the bio pcpu cache is that bios of a cpu will be never
freed unless there is new I/O issued from that cpu. We currently keep
max 512 bios, which feels too much, half it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index d989e45583ac..6277a2f68ab8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -27,7 +27,7 @@
 
 #define ALLOC_CACHE_THRESHOLD	16
 #define ALLOC_CACHE_SLACK	64
-#define ALLOC_CACHE_MAX		512
+#define ALLOC_CACHE_MAX		256
 
 struct bio_alloc_cache {
 	struct bio		*free_list;
-- 
2.38.0

