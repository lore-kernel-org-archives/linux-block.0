Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87975C43331
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFF21D7F
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgL2I4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgL2I4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:53 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32D2C0617A6
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:54 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f27so10117128qkh.0
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3bO6YItz9vvTQJgokX465W6GGn8iDP/PMw/J2QDO/So=;
        b=qt4nW1TtN3vSNgIGdyu19lUtFHsVWuR3MeUBrUmhT19aLj3ZcPjez61n26uGT+H95h
         5tcLJ1375oK/zFIjSjeC3fAN/INVwBSIq9Nm5ScVlw7t84DRqEg8YYiRDYRDt4TPArRK
         oBB6wXkztBTuST2NYqsfxqsityuBpstl9esliPLnYtnFQjHHaYkYbfZb9WjANtuhJ07c
         FaUdCvUnjkxdCiYr2KHr1MNLyPFQ3P0Ngr+09MDIv4q770sHyuU5dNIPUIllfyrixLSG
         NPkAW501swO4Gq3RzVJodfbT+qPUZhDyNDZceY5LVNjRs5w06RHC5vV4mE+5YM5w59Jz
         Ue5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3bO6YItz9vvTQJgokX465W6GGn8iDP/PMw/J2QDO/So=;
        b=RU1XpdPbg226PmEzxx4VA6fVB5ytu0NI1vSAn2fCU0c08pb3JU0o7WXQVeVBuU+l5g
         zhb0SmEU/d75HdRjRJ0yhbmGHGagEaTIRFeKEnVG07BWys4mlap9QrRyMjCze7n8I2gu
         sv2CHPMeLpntVz9OPBGClombwTRauU8X6T0KLIWPeIL+ksK4sV8qIRvwKK59VaLqK54M
         2ug7hdUoLsvGrbDhs0wmCeE1PWyJmpMLLjvUFc9Y6DFcRrcXFHLKiYURdFKcFzTyXb5Z
         HjxUGFVcpk8tYHINQQjRGybIi/Gw44osW2ytmUAKqdglWgPw5uYlMekBs5FPn/h7rAOR
         S7yQ==
X-Gm-Message-State: AOAM5338CU7DRxXWxLw+FakX6nxELh1t1KqlzLplNMHfGUfYO4qP1X31
        V20V5VS1hzXe0ChEGtt+x8ncMASWmrMwlFNoVRqxrglIkQnSuNba8Lt6Pny8RMfzyYXxju1VSOY
        q6h1iVlkdjo1CpcR/D0mVqcQLRuj+HKLYYHq49UCReV0u12GUekkH2fjEOa2Cur+Icoat
X-Google-Smtp-Source: ABdhPJxhU4q7GN5C1Z1AyzKVyRUGN5znZ+v3G/MJUPuiA4RVAhWGOcFupFszWQEI8exuXS9BJFU+l6WmdIw=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:99c8:: with SMTP id y8mr50020306qve.35.1609232154123;
 Tue, 29 Dec 2020 00:55:54 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:24 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-7-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 6/6] dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
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
2.29.2.729.g45daf8777d-goog

