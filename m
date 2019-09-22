Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A7C4740C
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E73921BE5
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178263;
	bh=YQCsBXeCa08TPq18aZLL+PQPhGsFsnWxhGKvatllFvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M7voicyNZGyJMKu1CLNRfAa6/AlogfE2fbdEbKMC+eDA/OMoe/Zs7DLxf7Bjho62a
	 zQ55dSOyRKzt7wcQiVMbRygqAvg7U/3FDdK4G3sO9dzEGGhpw3VE7ep28u4068n1zQ
	 EEsI1MCanX4YH5sfhnR0zTB2nRdWoN6CQPChBga0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404792AbfIVSvC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404746AbfIVSvC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 14:51:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC55521BE5;
        Sun, 22 Sep 2019 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178261;
        bh=YQCsBXeCa08TPq18aZLL+PQPhGsFsnWxhGKvatllFvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/1pyVY+/lFrNnWpc9x2509PjDtcG0vnlCpZ1BtuFHsjtUqVGrlklwOQJOpY9nR3k
         uKXzjZ9zI2bm/CdyYHILoTpVp1smrpc9lahWdwIazp47zFIHPbSPsJKKLoHdtUOrIy
         tvXs4bnH/ndjRBHSXTFkzIb+LavV1B3AnJwN/olk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 050/185] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Sun, 22 Sep 2019 14:47:08 -0400
Message-Id: <20190922184924.32534-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
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
index e1739efca37eb..8e32930f65a1d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1763,6 +1763,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.20.1

