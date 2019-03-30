Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B0EC43381
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525822064A
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908162;
	bh=OVDdFsHkAiFR6Flvp3sumRBwcEdXOJv+M+UY/23p34Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fg15zXO4QJhdBXwXBWYtdUD4iC/Yx4LusIV5/OXjwgu1XH61Ftwouynu9CgH2IbVN
	 l8aUyAj2a+regIQfLXVwK3pUVp2QBBP16lFGtNPvdTPbpTkYTMTDbZ4t61nYPABQTT
	 NDukUXQwT5BVK9SYwgVtl0ALRJ7tDPMt62UhNCdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfC3BJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731027AbfC3Awd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B6F218D9;
        Sat, 30 Mar 2019 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907152;
        bh=OVDdFsHkAiFR6Flvp3sumRBwcEdXOJv+M+UY/23p34Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nc65qiAfuFb0C4HrXJD4AtQttLW5RD1tyx4qQHvpnvvWYVGhwc6xSfoZwIKCmNcvM
         DDEEQTYCRhF4rRTMR7FugXbQpEu2D52sPrzsg214ddcKy/Ft+JAcy7gJlyxVjT1YAy
         BGLSaFYq2q5mQbNrEQoagw7AHbsBqKRANkN1U4vo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 51/67] blk-iolatency: #include "blk.h"
Date:   Fri, 29 Mar 2019 20:50:31 -0400
Message-Id: <20190330005047.25998-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 373e915cd8e84544609eced57a44fbc084f8d60f ]

This patch avoids that the following warning is reported when building
with W=1:

block/blk-iolatency.c:734:5: warning: no previous prototype for 'blk_iolatency_init' [-Wmissing-prototypes]

Cc: Josef Bacik <jbacik@fb.com>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller") # v4.19
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iolatency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2620baa1f699..507212d75ee2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -75,6 +75,7 @@
 #include <linux/blk-mq.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
+#include "blk.h"
 
 #define DEFAULT_SCALE_COOKIE 1000000U
 
-- 
2.19.1

