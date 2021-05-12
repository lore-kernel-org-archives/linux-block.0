Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10634C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68CA61289
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhELHDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:20 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46955 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhELHDM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:12 -0400
Received: by mail-pl1-f172.google.com with SMTP id s20so12026068plr.13
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 00:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZ8lqPuFLIIpyk4oWpBaJ8mqH+P94KTlykrkpl4Pmwo=;
        b=EOOe11Fa0YRexKvZcA4U3NSDu9NRSdDpL9shfXvmwBJBWOiwo1/DUbiRn0aJ09yHfr
         ZAHQVnRKz/4KDCNyfX/ndxqFOgQDpFW4OBFOyQ25TjiCnIc5ETWPNr/ZNJJCeelJiY6Z
         arg7Saf3b2GcXceNe2vvSQmQPGiilFCtetlQ32Vsa+MLf4RAPsOhInbg9L1zEBicD8Qa
         q1bqsY3ZfHKiCoM6IfyS81iXtICVbADGeVlt0pVjACP7YXpEzw3VBa+oBHLGXzgwzaab
         ivPPsErUskP1koCzS+Qnoty8eUjecny+ijg/fbYMt45eNnXyPptYGcMXN88zq3gqedih
         nV8Q==
X-Gm-Message-State: AOAM530ej0Dt+LiAMYVvAdXYU+fM/5NTyO+bF2/fBqma65Z/BqZ9rk+o
        KejisbDHbd/7DPdvby6Is+0=
X-Google-Smtp-Source: ABdhPJyweHRSz7HMB4o3L30kDMroEdFUE7EWnsZNUrPK2lXxV1yCHIRkJMLglwi7F2FL2V0EHVNmmQ==
X-Received: by 2002:a17:90a:d18b:: with SMTP id fu11mr38217472pjb.129.1620802924530;
        Wed, 12 May 2021 00:02:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w123sm14737285pfb.109.2021.05.12.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A884A400AF; Wed, 12 May 2021 06:14:24 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] null_blk: add ability to use a quiet modprobe
Date:   Wed, 12 May 2021 06:14:19 +0000
Message-Id: <20210512061420.13611-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512061420.13611-1-mcgrof@kernel.org>
References: <20210512061420.13611-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We may want to ignore modprobe errors. For instance when
doing error injection.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/null_blk | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/null_blk b/common/null_blk
index 6611db0..720dcd8 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -19,9 +19,15 @@ _init_null_blk() {
 	_remove_null_blk_devices
 
 	local zoned=""
+	local modprobe_load_args=""
+
+	if [ ! -z "$NULL_BLK_QUIET_MODPROBE" ]; then
+		modprobe_load_args="-q"
+	fi
+
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
 
-	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
+	if ! modprobe -r null_blk || ! modprobe null_blk $modprobe_load_args "$@" "${zoned}" ; then
 		return 1
 	fi
 
-- 
2.30.2

