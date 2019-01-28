Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C31C282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDF62082E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695827;
	bh=+FFnbIwCVDM4EzW0SOOkVepLIL3Hqi0vdNuDwfwCKHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9idE4bPEqduyLRga3tpO8Jp4blfyCSXUdFu31rxC6oWOiOvwGge2rAyemPyJQ/hM
	 WlQIxiCkVWXaYfkcIs6xC0Mq/qYIWHrTZrHrbykqfZ01cHz1MN33wx/Pi4Q1asVwY2
	 m0wl0HQhU+im41rIzF2UccVD/rRBxrG0t7fw90V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfA1QGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731428AbfA1QFz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A6A2147A;
        Mon, 28 Jan 2019 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691554;
        bh=+FFnbIwCVDM4EzW0SOOkVepLIL3Hqi0vdNuDwfwCKHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJkT0lPqgHWcFyfzuV6xOh3vNcghg5Cx1kRDmdWhg1717htUjklb2R4ja5gFvcgeQ
         zNNUhhZ91WqmovUK4inClEmPJty/IWRViJAtmFgCsYJVfYsANbyPUKTlzcGwOL+0R/
         58gdA/zrwZo2BM2YG//fo5Mh2+eGEosvzku+ktE4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 139/258] lightnvm: pblk: fix resubmission of overwritten write err lbas
Date:   Mon, 28 Jan 2019 10:57:25 -0500
Message-Id: <20190128155924.51521-139-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

[ Upstream commit c12fa401ac8c94a74aff68bb5736b3f1dc695fa8 ]

Make sure we only look up valid lba addresses on the resubmission path.

If an lba is invalidated in the write buffer, that sector will be
submitted to disk (as it is already mapped to a ppa), and that write
might fail, resulting in a crash when trying to look up the lba in the
mapping table (as the lba is marked as invalid).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 879227d584e7..c3e038d4b22e 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -158,9 +158,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
-		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
-		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
-			w_ctx->lba = ADDR_EMPTY;
+		if (w_ctx->lba != ADDR_EMPTY) {
+			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
+			if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
+				w_ctx->lba = ADDR_EMPTY;
+		}
 
 		/* Mark up the entry as submittable again */
 		flags = READ_ONCE(w_ctx->flags);
-- 
2.19.1

