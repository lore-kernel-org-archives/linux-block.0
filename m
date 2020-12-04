Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6318C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8583C22BF3
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgLDPWA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgLDPWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 10:22:00 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B3BC061A4F;
        Fri,  4 Dec 2020 07:21:20 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so3264196plo.6;
        Fri, 04 Dec 2020 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stxdKLjkawSzgni2iKOcapaYxt02iCojFmRSwnh2uv4=;
        b=Xu9r1WgGtDgJyFPqSCEaH1eaqpDrKVqg3UeHFPVrzwYIvxsCVSVsAFW2SQGE5y6Lep
         cS15BR3dGK4w5VOJgSde5oK9xubzlj4QeqL4MzOWzul2PXycueYhM4RGYqrbp9TeDpkf
         OAbsm6fu5NKzcBX0aCjK+DPzLryiNPiRZ1XF+eofmoW+jCdMc6PdCcP11k7i9fAddxGW
         6iyfnjzXMr+0All5cClowI3UiWtjpHLFvWseOodks9F4+Rd7RP7l7d7Bv+g9ybZnWkhF
         O4Bka/DXrbft3B7xQ8nMVRrKRNgx6cgdUWe/TOHPKOHi6djfEI4YhlzJWmZU+28NZ8VR
         K3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stxdKLjkawSzgni2iKOcapaYxt02iCojFmRSwnh2uv4=;
        b=UP5kUMvOASoSvPyuTkO21a6oQwkb1LcY5B3T+25rD531L1UyT6KIFqZJNqIhiSBtLC
         K59j1dcwAECaiuidYXCqpW5wTnj7lrv5ElSoeMRicPWk2e9GZDnm9OwLoPNE+/lsqNXF
         aCZtL0LdWYpe4K8NR26WpnGIWRwBcjC67RialAOCn/l2cDRXgk7y6SfC4FrBfFpZy6ei
         8hgg2lcU5ALpyhOpZP83bf6N55E/VzQduZl3U3pKpBYIbWVPtMtvn4gcbWUAyjXZBiXd
         kqAvsnfBKgDrWdrzHhkfqLYAQ2Yy1I8x4pQs/GBttVoXn/I0TezcA1rkQcDNmofZq7dR
         YDPw==
X-Gm-Message-State: AOAM531opqyozUPYS5wGpw2csYLtmXaUtN6SmjIOK81Kjh9ouPyczgr6
        iWoI5XcE0qSBHgHmtmznYhpHihzbXMf4qg==
X-Google-Smtp-Source: ABdhPJyh0UJjst4bpJ88fcYURqLnMib2+KJI0IFQthlFH6h7KvBn2yCUeMH1KbRWU+MW3qXVEtN0+w==
X-Received: by 2002:a17:90a:de95:: with SMTP id n21mr4538015pjv.62.1607095279801;
        Fri, 04 Dec 2020 07:21:19 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id d20sm2407286pjz.3.2020.12.04.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:21:19 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 1/3] blk-mq: add helper allocating tagset->tags
Date:   Sat,  5 Dec 2020 00:20:53 +0900
Message-Id: <20201204152055.31605-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tagset->set is allocated from blk_mq_alloc_tag_set() rather than being
reallocated.  This patch added a helper to make its meaning explicitly
which is to allocate rather than to reallocate.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37c682855a63..69771ba18f1f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3377,6 +3377,12 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	return 0;
 }
 
+static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
+				int new_nr_hw_queues)
+{
+	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
+}
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -3430,7 +3436,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	if (blk_mq_realloc_tag_set_tags(set, 0, set->nr_hw_queues) < 0)
+	if (blk_mq_alloc_tag_set_tags(set, set->nr_hw_queues) < 0)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
-- 
2.17.1

