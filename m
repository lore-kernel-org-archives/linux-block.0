Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB5C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EB722460
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vq2w2pJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgEMNj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbgEMNjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:39:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5BC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:39:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so28531399wmh.3
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73y2EkDX2Dlo8B8Rg2AO0hZwVG6UoIFuwEH7MmnfvIk=;
        b=vq2w2pJBraCI2zP4u8/588HjpEAoDfIH0FZKaHxdyRonCuEfO683f7KTY2yLjJGUlM
         gOXQBdQ0eWCv6MF492fCviR57ZNLYFhTwqgZYPQDNuNoS9WEZIPQ9b2UvGARh2BqvvhJ
         aRc43kp0XLknxr4aWOdzc6E1LOflni8eDsTaG3f597SMVZMcVHcBBq37hIjU4Qya+Q+h
         sZrTWs5UHsg6zKBXf32OF5dz+3wDFyGkSnP4RzYHSYY9RtPxxHvc7Kuvh+3eYMlazV24
         T/IbHPUaqX7uKFWcbEOrbYkzOsqk4jeBYrTBGdpnO9TAkuSjwFadeByWhgnZJcqcOvxk
         UKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73y2EkDX2Dlo8B8Rg2AO0hZwVG6UoIFuwEH7MmnfvIk=;
        b=V5KJFMzaNmT+tr0B2aMOMe9IRtkSIsIG5Ycp9H/AyiOesnHkVOsLRBStntGKKUBOoi
         gKriqCW4wX9PW8Wj/Wq8lGWOr5yVyUlJog7CxDyCbA4u62o/7qTHsOXWfmvUFs2acfw3
         MfxkBTm3p0xoWpS0TG8h6iGAeszXI+L0M6x+pMJri+MwNFu/m5g5X4ypwHQFobit35jL
         OaTd81jDUfBPMvagNxebvifAV+sjhQdyP9shz0bzyuzcWWl/OIHownjn+1LHxKK+6ozE
         BVSY+TtBKc4R7q2xDxLaYo/8Yy8HDp5wTnRsQpZZuRvD+x5M2KdE0s4JnEoNssX+MS6m
         7ogg==
X-Gm-Message-State: AGi0PuYJZRF/h0Oi6Q+mGe4E53DmaZYKvAy/7W+OGaC4qJKyp7Ahrv+J
        zTMbWUHI6Av3fmYqAVZRw//koQ==
X-Google-Smtp-Source: APiQypJKNnonUlim7ZOi25FTphWD9VrUisBBoAjjUOwOam2+35TMRzU9Zm7owMB+f9WKPUwv0LlXnA==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr32474479wma.150.1589377140295;
        Wed, 13 May 2020 06:39:00 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:59 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 09/11] loop: Rework lo_ioctl() __user argument casting
Date:   Wed, 13 May 2020 15:38:43 +0200
Message-Id: <20200513133845.244903-10-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for a new ioctl that needs to copy_from_user(); makes the
code easier to read as well.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4dc11d954169..31f10da4945e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1634,6 +1634,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *) arg;
 	int err;
 
 	switch (cmd) {
@@ -1646,21 +1647,19 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status_old(lo,
-					(struct loop_info __user *)arg);
+			err = loop_set_status_old(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		return loop_get_status_old(lo, (struct loop_info __user *) arg);
+		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status64(lo,
-					(struct loop_info64 __user *) arg);
+			err = loop_set_status64(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS64:
-		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-- 
2.26.2.645.ge9eca65c58-goog

