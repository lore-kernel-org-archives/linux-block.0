Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E87C32751
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464EF21880
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="F0Ff2uTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfHFWFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:05:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56194 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfHFWFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 18:05:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so79698768wmj.5
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7kIZFgGybpcf1I/lUbPOT+bnIDjPdUpNNf2NGVocZo=;
        b=F0Ff2uTwa31Ysn929Q7uzlxnogUkI+Bcnwayo/cc/LIGOsaIOOlAz7+Wdb7VJkG6Md
         9m5KPfc04xft/5DxMlp/Ck+BPif+B/vzc/PpDntW/kB5iYyHDMSkLYofitvUt9JX+ASo
         45JHolnWmY1CaGLCIk18wK3TkpAMpJv1xEGa0J7kSIq/BlA+tgfTiO2JXgMhFxcdfgIM
         /9cb0eaGWIuWgZVevaHBsHlEZIqDuhZJV/yZUJsam/AQ94bLbMw88PvDE1x7WbInouGq
         Hwnc/tfdixHMePg7Gk2rrzIHmRL1cWFt2r23/1XCmzM6xLht4/rC1WBdQVJNuS9NSbSr
         4c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7kIZFgGybpcf1I/lUbPOT+bnIDjPdUpNNf2NGVocZo=;
        b=OtKcIaaXmlybw5aH1gEpE0D/8jKCb/8bT/xHIAjVCNVBiyLfmizr5wfq9+QDgxBgvA
         731XMeurrBGUY8hFA1TUcMkpMhFRPNWsgS3KyycnUDYUlNBaVw3VAgXtUPryuSPWzfEg
         VuFuoP0D9tY3ml/fMJ0YR6fStrZW3qd/8tdIbmP2GBwvxP92WtVxED+y/ZY92LpU5HiC
         ncTYdEtPYtyuTZpv1dv8wjxHmLbIMKlIlT+veBoz8rRAFplnnq2pJ1wnJOyTUcmzN/L8
         9GxHxzZNGoI3p4CeSQ6uUzQtgHuqnBy80C3QjKGHIh7AWw08m62bNFlMVUHVtbAsVF9I
         b6NQ==
X-Gm-Message-State: APjAAAVZA71U4V+ditngjoYGbCr+lMGRceAzCDpeVJ9PMpEtKYQ28sp1
        6rD+lMfptczcjk3dLBp2D++MzN3+Vto=
X-Google-Smtp-Source: APXvYqxOLRZTDczeSVrI3miadMJLEFaxVK0c2u1bVfx0uaVXU9QKEAFYtItXHnkQIlI/Sgy9gwK73g==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr6375286wmc.13.1565129149305;
        Tue, 06 Aug 2019 15:05:49 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id s3sm93652190wmh.27.2019.08.06.15.05.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:05:48 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, dvander@gmail.com,
        elsk@google.com, gregkh@linuxfoundation.org,
        kernel-team@android.com
Subject: [PATCH] loop: Add LOOP_SET_DIRECT_IO in compat ioctl
Date:   Tue,  6 Aug 2019 23:05:24 +0100
Message-Id: <20190806220524.251404-1-balsini@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Export LOOP_SET_DIRECT_IO as additional lo_compat_ioctl.
The input argument for this ioctl is a single long, in the end converted
to a 1-bit boolean. Compatibility is then preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3036883fc9f8..a7461f482467 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1755,6 +1755,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.22.0.770.g0f2c4a37fd-goog

