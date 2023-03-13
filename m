Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B8DC6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 22:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCMWaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCMWaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 18:30:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE8E69CCB
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a2so14618733plm.4
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678746599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPLn+orVfSK+z4tupCE3vvaGTo6pOxRCWsTN9XiJPXw=;
        b=jwVQFnAZvTbL1m3KsEL+nj7y4CkOYqkthOJJZum4ez+s9ehzdY/jhGB0JirvrTvSCM
         7SR9W1NWfEuWwA6QbUBpgU0GPxwrjZmm2fE5jYhi23JHRYR5Q3ZCDyPrpG03hgw3sark
         ZA4S2l4uR/NYjZU1VXsKl+FSisRWndkN9o27U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678746599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPLn+orVfSK+z4tupCE3vvaGTo6pOxRCWsTN9XiJPXw=;
        b=Jxg6Zs/7J05KC5Qb7qxERPAfaChWN+OaNwV8ygq9FDmIOhXE+efku2SWhxUK2b0NJs
         TMnzaGRKm0WBPzKQtc3/JOGwvUNekYadciu7Kal72xfEjEnrUshssbUcWqx1dUioZH6b
         GZ1va1sB5VOyeHD0euEj6xhhJhnPss3YuTCITsP1hDkaA6b+Fi/a9ggRExgkcItvMIuk
         pv6X+RYSJbOd8/8kzr8lRiqnffzab2pMkwqB6HOrVtCwIOjK+W8Xy5HKLNLfcTOKGMte
         MaWr88mk3Sw3PVGqNTX1THokCbRcyhRpSj5k3bw2gun9xPE1/6Jl0k5rZmRm6qXQt2Dg
         U6OA==
X-Gm-Message-State: AO0yUKUwmNtpIoTXvQU2HwaS7cLJsUF8nKt1ZKwi5om742H6BA+ooPRX
        Rb175N1asNYD6m9VyQThofwigw==
X-Google-Smtp-Source: AK7set+bwCXPeXXJYiHoIs21LWog9BcgfWy0JQjslrBQOlmossB4jqnklmjuEP81ZHtlr8WCPOmtjQ==
X-Received: by 2002:a17:903:446:b0:1a0:48ff:53a0 with SMTP id iw6-20020a170903044600b001a048ff53a0mr3867362plb.35.1678746599155;
        Mon, 13 Mar 2023 15:29:59 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:157:b07d:930a:fb24])
        by smtp.gmail.com with ESMTPSA id km8-20020a17090327c800b0019aa8149cb9sm352440plb.79.2023.03.13.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:29:58 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v5.10 5/5] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Date:   Mon, 13 Mar 2023 15:27:57 -0700
Message-Id: <20230313222757.1103179-6-khazhy@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313222757.1103179-1-khazhy@google.com>
References: <20230313222757.1103179-1-khazhy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit b600de2d7d3a16f9007fad1bdae82a3951a26af2 ]

After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
bic->bfqq will be freed, and bic_set_bfqq() is called with the freed
bic->bfqq.

Fix the problem by always freeing bfqq after bic_set_bfqq().

Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230130014136.591038-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 2f440b79183d..1f9ccc661d57 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -748,8 +748,8 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				 * request from the old cgroup.
 				 */
 				bfq_put_cooperator(sync_bfqq);
-				bfq_release_process_ref(bfqd, sync_bfqq);
 				bic_set_bfqq(bic, NULL, true);
+				bfq_release_process_ref(bfqd, sync_bfqq);
 			}
 		}
 	}
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 016d7f32af9f..6687b805bab3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5070,9 +5070,11 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bfqq = bic_to_bfqq(bic, false);
 	if (bfqq) {
-		bfq_release_process_ref(bfqd, bfqq);
+		struct bfq_queue *old_bfqq = bfqq;
+
 		bfqq = bfq_get_queue(bfqd, bio, false, bic);
 		bic_set_bfqq(bic, bfqq, false);
+		bfq_release_process_ref(bfqd, old_bfqq);
 	}
 
 	bfqq = bic_to_bfqq(bic, true);
-- 
2.40.0.rc1.284.g88254d51c5-goog

