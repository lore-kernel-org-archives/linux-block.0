Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B888C3A5A2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649B520644
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181035;
	bh=nLBmpST4CMAjbXYt20w4xU7PrLmWj0RW/y6RZSzDzaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+Zx2HMit3FxZLUlSKUEF2tIRTijAdJ7kfCq03efzzoGF2a2MI+GwvDxBdTtWqNqI
	 rFJ1NKRMWLiATbGNcJtp7CseIu0dmTci5PVM7xdT6eenrDJVnrAIjB5lGF6Q60iB+P
	 eS/qebbsbET30oBIejduAarZglxRTmlGxm5xo4eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbfIVSpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389638AbfIVSpx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9D7206C2;
        Sun, 22 Sep 2019 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177953;
        bh=nLBmpST4CMAjbXYt20w4xU7PrLmWj0RW/y6RZSzDzaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0SbaxB2PIw6cjJsgboXFiuS2P9Bcz/E1jnj34dsr2rErVR3R5X3rqbqpchBDXCv2
         CW3nUfvQ9JKY+7dQzwuI1bxb4SBRl8sVwnJT3CyyGbd+5Sd4kQ80kcpYz/WM7MDfi8
         AIjFqbx8PskmT1MRAiYNuyQk7qB4H1UNLuIEoYGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 059/203] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Sun, 22 Sep 2019 14:41:25 -0400
Message-Id: <20190922184350.30563-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alessio Balsini <balsini@android.com>

[ Upstream commit fdbe4eeeb1aac219b14f10c0ed31ae5d1123e9b8 ]

Enabling Direct I/O with loop devices helps reducing memory usage by
avoiding double caching.  32 bit applications running on 64 bits systems
are currently not able to request direct I/O because is missing from the
lo_compat_ioctl.

This patch fixes the compatibility issue mentioned above by exporting
LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
The input argument for this ioctl is a single long converted to a 1-bit
boolean, so compatibility is preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..1410fa8936538 100644
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
2.20.1

