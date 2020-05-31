Return-Path: <SRS0=tY2F=7N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B365DC433E0
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9EC2074B
	for <linux-block@archiver.kernel.org>; Sun, 31 May 2020 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="X15XYZ63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgEaQdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 May 2020 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 May 2020 12:33:20 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E283C061A0E;
        Sun, 31 May 2020 09:33:19 -0700 (PDT)
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5A5D82E0A0D;
        Sun, 31 May 2020 19:33:15 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id FnnZx2bYyP-XCI8SNsx;
        Sun, 31 May 2020 19:33:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590942795; bh=iJVjU4rwDPnmE8hHnwj5S3ufe8dG+OTautxuIMN4pfY=;
        h=Message-ID:Date:To:From:Subject;
        b=X15XYZ63AITIZ7pnvj1HKf/JZsztiQh9EAlfGOcch49UUXYAxmaXZxknYju4wYMkt
         xnGcODda08swEUQ6nXThRJWyYWFttqF93aZCFW/44pGsfBgFUu8uvyBvxoATiEcOb9
         Uv4qtRfeGb40hd1ETfRstIY7K9FCnuxVozvFiF9Q=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:111::1:4])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id vxZdZDgham-XCW8Jfs6;
        Sun, 31 May 2020 19:33:12 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] block: really remove REQ_NOWAIT_INLINE
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Sun, 31 May 2020 19:33:12 +0300
Message-ID: <159094279217.155550.11478547618029899022.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 7b6620d7db56 ("block: remove REQ_NOWAIT_INLINE") removed it,
but some pieces left. Probably something went wrong with git merge.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/blk_types.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 31eb92876be7..59b2e9bd9bd8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -322,8 +322,7 @@ enum req_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
-	__REQ_NOWAIT,           /* Don't wait if request will block */
-	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */
+	__REQ_NOWAIT,		/* Don't wait if request will block */
 	/*
 	 * When a shared kthread needs to issue a bio for a cgroup, doing
 	 * so synchronously can lead to priority inversions as the kthread
@@ -358,7 +357,6 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
-#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
@@ -452,13 +450,12 @@ static inline int op_stat_group(unsigned int op)
 
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
-#define BLK_QC_T_EAGAIN		-2U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
 static inline bool blk_qc_t_valid(blk_qc_t cookie)
 {
-	return cookie != BLK_QC_T_NONE && cookie != BLK_QC_T_EAGAIN;
+	return cookie != BLK_QC_T_NONE;
 }
 
 static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)

