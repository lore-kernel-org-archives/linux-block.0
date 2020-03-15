Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FCC18E5B
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D999C206EB
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgCOWN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:13:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54201 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgCOWN3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 18:13:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so7134013pjb.3
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 15:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASmtf6nEOj9Kr+gzM5bPTz+sdllTCVAi3rAKiYoL4g8=;
        b=qm+H86GWOl98eVHgIaezfyu2I0xMrc6PQt70Ryiwlcyr6ULCbOYDXWy9O5mYuVKd/B
         v0GOVuSUpLKBpC6FG4b8Ws0L9e6rX3sGwBnWu3dU0g5yi7O8KHSl38scIOUKp2TAhSLu
         VSKvFtNADBBCw/TNuq6k/jInFn0glQnuDdnIcrRH0rjs9xSVJYCIVffIEwqAEbFOn06U
         z5yYmwt1NzadEUzi4CxT5rd7NZoPwW/pp+AyE2M+RRwT0nXuNteFp6aYTFlhD1+VhIm7
         /QXqqKHrh4+pno8GUpyoB6MLJtx0PFIiFoj3DXziJ4obpY2EqUScJX28eMUBg4oc8lpZ
         b6Cw==
X-Gm-Message-State: ANhLgQ3NXPGUP5LGcwEk2Qc8q6MV/iD8NmS4zixarZxJfb3jFJiYSuzG
        aSy9x8NedYCYgvqV4StuH3Q=
X-Google-Smtp-Source: ADFU+vtW3yJLAX1P6DM36OSv0BcjEeyIhrGGF6nI1U476eNxoJniJaerBHaMBZMpUhgzBgE6NTkQmg==
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr17351709pjr.54.1584310407848;
        Sun, 15 Mar 2020 15:13:27 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id d1sm39192976pfn.51.2020.03.15.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:13:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 1/4] Make _exit_null_blk remove all null_blk device instances
Date:   Sun, 15 Mar 2020 15:13:17 -0700
Message-Id: <20200315221320.613-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315221320.613-1-bvanassche@acm.org>
References: <20200315221320.613-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of making every test remove null_blk device instances before calling
_exit_null_blk(), move the null_blk device instance removal code into
_exit_null_blk().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/null_blk | 12 ++++++++----
 tests/block/022 |  3 ---
 tests/block/029 |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 2e300c20bbc7..6a5f99aaae9d 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -8,11 +8,14 @@ _have_null_blk() {
 	_have_modules null_blk
 }
 
+_remove_null_blk_devices() {
+	local d
+
+	for d in /sys/kernel/config/nullb/*; do [ -d "$d" ] && rmdir "$d"; done
+}
+
 _init_null_blk() {
-	if [[ -d /sys/kernel/config/nullb ]]; then
-		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
-		     -type d -delete
-	fi
+	_remove_null_blk_devices
 
 	local zoned=""
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
@@ -27,5 +30,6 @@ _init_null_blk() {
 
 _exit_null_blk() {
 	udevadm settle
+	_remove_null_blk_devices
 	modprobe -r null_blk
 }
diff --git a/tests/block/022 b/tests/block/022
index 1404aacef295..b2c53e266d81 100755
--- a/tests/block/022
+++ b/tests/block/022
@@ -50,9 +50,6 @@ test() {
 		wait $pid1
 	} 2>/dev/null
 
-	rmdir /sys/kernel/config/nullb/1
-	rmdir /sys/kernel/config/nullb/0
-
 	_exit_null_blk
 	echo "Test complete"
 }
diff --git a/tests/block/029 b/tests/block/029
index d298bac8db5c..0d521edb0cf6 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -58,7 +58,6 @@ test() {
 	else
 		echo "Skipping test because $sq cannot be modified" >>"$FULL"
 	fi
-	rmdir /sys/kernel/config/nullb/nullb0
 	_exit_null_blk
 	echo Passed
 }
