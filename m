Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86040C4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D9120709
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCTWYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:24:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40855 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so3096263plk.7
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 15:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeJIz+7B03dDhcjcSMTJpVikoWrMy9gQNrpLQWee6yg=;
        b=GgvInCvVBdriq39nMeHeK816Iw6ViVSFSrRpeyd+vdti2AvNwHYpP49hBore15cXTG
         Pblksb+cpx+8u8rzV60A9x60EphsmZ9hq5SZQ2/5IDqTbBY16S7SszqVUqwl/EDc+vwC
         O2Ymal4kJABW3+LyGCvEJBk1Exb5sYDN9SNBWWLq0kZsLYM3LxtMVaSFANOhfZOQvSrA
         Xlrf+UA8XmeecmVVxrhhcdgVFzuOGNlZwqwGl1Uol8b9HudERih1uX0vSEEQgJQtKxi5
         iqO0bk1WVY/9IPogkeTKgzUIBQJf/Jb9svfltms4VnLLw+lBOaI5ktvu5W8grr6EA4jU
         m1BA==
X-Gm-Message-State: ANhLgQ1E05J6k+Vn24w+gA+s44A9nrWgFPSWV07nU/0eshGyvznitCtc
        HtXSyOUEVRKBfz9R8mLri1s=
X-Google-Smtp-Source: ADFU+vuPI1Dmvt0zb8zYvsb1xVnhRJB7d+8LJJaPGD3wVBNE4kY5heb5+xsQ3T/KWWoPtOT2ycINlQ==
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr11747958pjb.81.1584743062106;
        Fri, 20 Mar 2020 15:24:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c142:5d77:5a3f:9429])
        by smtp.gmail.com with ESMTPSA id z20sm6050530pge.62.2020.03.20.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:24:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v3 1/4] Make _exit_null_blk remove all null_blk device instances
Date:   Fri, 20 Mar 2020 15:24:10 -0700
Message-Id: <20200320222413.24386-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320222413.24386-1-bvanassche@acm.org>
References: <20200320222413.24386-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of making every test remove null_blk device instances before calling
_exit_null_blk(), move the null_blk device instance removal code into
_exit_null_blk().

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/null_blk | 7 ++++++-
 tests/block/022 | 3 ---
 tests/block/029 | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 2e300c20bbc7..a4140e365955 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -8,11 +8,15 @@ _have_null_blk() {
 	_have_modules null_blk
 }
 
-_init_null_blk() {
+_remove_null_blk_devices() {
 	if [[ -d /sys/kernel/config/nullb ]]; then
 		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
 		     -type d -delete
 	fi
+}
+
+_init_null_blk() {
+	_remove_null_blk_devices
 
 	local zoned=""
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
@@ -26,6 +30,7 @@ _init_null_blk() {
 }
 
 _exit_null_blk() {
+	_remove_null_blk_devices
 	udevadm settle
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
