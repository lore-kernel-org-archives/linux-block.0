Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67445C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF0564E2B
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 05:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBAFNK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 00:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBAFLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 00:11:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1BC061793
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u14so18322560ybu.9
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 21:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tsR7HhO1/8EFXvkT3LKZR+I5g9ZmXVYdpiXsfnhKFQE=;
        b=QgFCJZ3xzkCAoqSWhXrvZT70j/Q7cwSPGtKhI7Je9lsUxvdvYXi1lsBrw7M0Nohodv
         0kcdEpCgZfznz6jmbcmulGx5B5I6PlZWZwaOijLJ0Mbh/r1QSAWvlnfV+fF6Yzp8lweX
         HzXR6CPtlPbERPMSWloeAVJ9Zsuce0qi/FR3F4W468QNwUL+/MYTOHBDEBckkQmJg8Qm
         3H8qMtyNUVq9QN1MjJY6BlxwgJOrhdzxU/ZiDHnCNBfvjYN60vqK5B/aUaI6cf3ycpxM
         eUgMYlSNik/htHhk6osRvPrf4MSzB1TwV/wvWNj0rPhov0g9hU/9G8waYxji5xqxD9rl
         Y+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tsR7HhO1/8EFXvkT3LKZR+I5g9ZmXVYdpiXsfnhKFQE=;
        b=U7MqOsnbUnH3RfzHwlGQox51j4pseyrxxIlqMfAzCeoLRSjnZ1dVsMcXayAs9z5KTF
         1W5Ud5JCUtLvbUkkPubHa0lBOoXNiAfTTqQlJqmsfU55FZNNGddbFhiHS1Epg+y3fZRK
         m+oakw4Xid85U1NgJA1pSr/9z8kravnnbpbbQ8qFZqJRPZAw0EKjq9PXZPxcgDdt1/gb
         SdCKv+5LT92R3Px0nlGSjhBGsW/8ZzRgLCWvkrRjUmagMGvYE6ODnqZb3Z0AfikyXpWP
         G6u4URPwEgIGoReY394J7KFv70iLA9nLpSAOdZHJkHVzzSRYG9YoNbo7lZ0/k6djMrku
         nxvQ==
X-Gm-Message-State: AOAM532jTe1mR62Zd2gjKc+oWoaMvhDansFNB6oxGbpiLjECEsCrMe+q
        uhDIzADZWfy1+wL9LP1TzxkGIqA3wFp/DhrGQAvXJOp+F/1DlXx9ldlghkEqlkNEJVTxnEpbtC3
        AkL3dXr7Fp8UPleshoGsK23lyuSkrx6YbfYrXCPeJ6m+gEOS6HCF067qpfMLTwWZxngBL
X-Google-Smtp-Source: ABdhPJzHvb+x5wi/WXBWFc/y/S6NWvFLWKYpHtLIzOFQg75s1lLXTb+FaOcNF1B8+TRzc4ds1FTwCDFqop4=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:1402:: with SMTP id 2mr19186874ybu.15.1612156236927;
 Sun, 31 Jan 2021 21:10:36 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:19 +0000
In-Reply-To: <20210201051019.1174983-1-satyat@google.com>
Message-Id: <20210201051019.1174983-6-satyat@google.com>
Mime-Version: 1.0
References: <20210201051019.1174983-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 5/5] dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm-linear and dm-flakey obviously can pass through inline crypto support.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 4 +++-
 drivers/md/dm-linear.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..30c6bc151213 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -482,8 +482,10 @@ static struct target_type flakey_target = {
 	.name   = "flakey",
 	.version = {1, 5, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
-	.features = DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = flakey_report_zones,
+#else
+	.features = DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = flakey_ctr,
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..fc9c4272c10d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -229,10 +229,11 @@ static struct target_type linear_target = {
 	.version = {1, 4, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
-		    DM_TARGET_ZONED_HM,
+		    DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = linear_report_zones,
 #else
-	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
+		    DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
-- 
2.30.0.365.g02bc693789-goog

