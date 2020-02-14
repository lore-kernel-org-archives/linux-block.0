Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB87EC2BA83
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E62468E
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699618;
	bh=alg3hx0ZsAVDxehLFVHesumGzR/P6vdWyx9Oo5Cvnrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2rHSPR3GByBw8N0JuRa/87XU8ygsKoi+hqm75v7BG+wUioAnC+mKyTghk11KFPPn
	 tn6l9GEncPia9N1FHY5b0UNywP++/WovWDQch0Cp/RhPcZZpHlYZXLhW8XAtc4+r3o
	 K+vd3b3PRPGY2ccaRrC/o/DkXmDf2N8x8Pk4b3NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbgBNQQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404308AbgBNQQh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7818324698;
        Fri, 14 Feb 2020 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696997;
        bh=alg3hx0ZsAVDxehLFVHesumGzR/P6vdWyx9Oo5Cvnrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNK5il/V09FrjRUBslZBhYAAMXBmM3UuKD7Zyh//RkSDKp8UGJ0oRnDL4x5rNwKaU
         QOJW3W14pkcnapsXEXCkXLBktD1ulOLbxf9ecHTGslC4Zi3JM/8u2nv/9yuPVTGfle
         Pd80mOLy9/b7E5GOS/FtXhg/txhFh1hPnFmIYN74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 230/252] rbd: work around -Wuninitialized warning
Date:   Fri, 14 Feb 2020 11:11:25 -0500
Message-Id: <20200214161147.15842-230-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a55e601b2f02df5db7070e9a37bd655c9c576a52 ]

gcc -O3 warns about a dummy variable that is passed
down into rbd_img_fill_nodata without being initialized:

drivers/block/rbd.c: In function 'rbd_img_fill_nodata':
drivers/block/rbd.c:2573:13: error: 'dummy' is used uninitialized in this function [-Werror=uninitialized]
  fctx->iter = *fctx->pos;

Since this is a dummy, I assume the warning is harmless, but
it's better to initialize it anyway and avoid the warning.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b942f4c8cea8c..d3ad1b8c133e6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2097,7 +2097,7 @@ static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
 			       u64 off, u64 len)
 {
 	struct ceph_file_extent ex = { off, len };
-	union rbd_img_fill_iter dummy;
+	union rbd_img_fill_iter dummy = {};
 	struct rbd_img_fill_ctx fctx = {
 		.pos_type = OBJ_REQUEST_NODATA,
 		.pos = &dummy,
-- 
2.20.1

