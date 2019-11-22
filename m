Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566FC43215
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543122068F
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402760;
	bh=L6UADT7WrITQLvYS1P2NX/sJ3asPZ165Aiv3SC8XTnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nq5JDk87IWX3EWPICE5iNJw49SCgLsumQlZGxDiOwopqg2r/r2jNgyTVdg6f932H5
	 K85PNQyrO92l93gs4I7lORAV2OBl0irj2uhBGyv3dqmfCueRQDb3pAWko9vXlMBz0S
	 UEJZIHPEmvGxcu+RQhgzhkhjZukxegHTbB0NslRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKVGFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfKVGCa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A2B2068E;
        Fri, 22 Nov 2019 06:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402549;
        bh=L6UADT7WrITQLvYS1P2NX/sJ3asPZ165Aiv3SC8XTnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fy+bvDK1ONRTrx+EBJ5J+nCpLe/hyg9ePz1TVXu1f9qRHGFLjPk/kfxCqboczhLp8
         Zl5+QCWHDDbxeP5a0z1MbFQ564tyBrquQuRFQuZniYhKzPjkO8V4PrGYYHpX9qdAeK
         WqLVboxnDEvH6jGSrL/nzIuvc22H55clQiJyldYs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 55/91] drbd: fix print_st_err()'s prototype to match the definition
Date:   Fri, 22 Nov 2019 01:00:53 -0500
Message-Id: <20191122060129.4239-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 2c38f035117331eb78d0504843c79ea7c7fabf37 ]

print_st_err() is defined with its 4th argument taking an
'enum drbd_state_rv' but its prototype use an int for it.

Fix this by using 'enum drbd_state_rv' in the prototype too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index 6c9d5d4a8a753..110f64d9e91c1 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -126,7 +126,7 @@ extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state
 					  enum chg_state_flags,
 					  struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, int);
+			union drbd_state, enum drbd_state_rv);
 
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
-- 
2.20.1

