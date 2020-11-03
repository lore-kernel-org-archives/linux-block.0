Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D6C388F2
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD632225E
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366548;
	bh=pS/wfuvgECeMv7tP2JsM2x5VhNzsY45wQ2MPzjvmbb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PW21F32ubTMjOxeDu1CU9eR+bEjhoasFsBAjZKC1W7vCRePNMDyov+8/lZfJ6UWsp
	 5vLDeN+8a3q0xhAq61qZewo0X5Pi+6RHoGbhoKVM6pwy3bvcDVHqSinNYc1WGyRmdZ
	 OpNzPJC3LRIpzY8wneP+8lysQ4XBM/u94oeGIWeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgKCBVG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgKCBVC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 20:21:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E742244C;
        Tue,  3 Nov 2020 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366461;
        bh=pS/wfuvgECeMv7tP2JsM2x5VhNzsY45wQ2MPzjvmbb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HShtYipL15ECiKG3KGMjsXkwBHLQ/RMDmkhOGcz7LcZDbzIKCGdDvPTgOwjLR8lD5
         u6JMMYHdE+fbJ1uRsgqKpNKh2kQSv3+GzoFYzsHqG64uq0joboeRV551vD8ODZdkho
         jZowZaE3HakjWPT11DM58eQHj408jEFSs2Pqs7RE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/10] blk-cgroup: Pre-allocate tree node on blkg_conf_prep
Date:   Mon,  2 Nov 2020 20:20:49 -0500
Message-Id: <20201103012054.183811-5-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103012054.183811-1-sashal@kernel.org>
References: <20201103012054.183811-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit f255c19b3ab46d3cad3b1b2e1036f4c926cb1d0c ]

Similarly to commit 457e490f2b741 ("blkcg: allocate struct blkcg_gq
outside request queue spinlock"), blkg_create can also trigger
occasional -ENOMEM failures at the radix insertion because any
allocation inside blkg_create has to be non-blocking, making it more
likely to fail.  This causes trouble for userspace tools trying to
configure io weights who need to deal with this condition.

This patch reduces the occurrence of -ENOMEMs on this path by preloading
the radix tree element on a GFP_KERNEL context, such that we guarantee
the later non-blocking insertion won't fail.

A similar solution exists in blkcg_init_queue for the same situation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a7217caea699d..34f8e69078cc1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -872,6 +872,12 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto fail;
 		}
 
+		if (radix_tree_preload(GFP_KERNEL)) {
+			blkg_free(new_blkg);
+			ret = -ENOMEM;
+			goto fail;
+		}
+
 		rcu_read_lock();
 		spin_lock_irq(q->queue_lock);
 
@@ -879,7 +885,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		if (IS_ERR(blkg)) {
 			ret = PTR_ERR(blkg);
 			blkg_free(new_blkg);
-			goto fail_unlock;
+			goto fail_preloaded;
 		}
 
 		if (blkg) {
@@ -888,10 +894,12 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg = blkg_create(pos, q, new_blkg);
 			if (unlikely(IS_ERR(blkg))) {
 				ret = PTR_ERR(blkg);
-				goto fail_unlock;
+				goto fail_preloaded;
 			}
 		}
 
+		radix_tree_preload_end();
+
 		if (pos == blkcg)
 			goto success;
 	}
@@ -901,6 +909,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	ctx->body = body;
 	return 0;
 
+fail_preloaded:
+	radix_tree_preload_end();
 fail_unlock:
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
-- 
2.27.0

