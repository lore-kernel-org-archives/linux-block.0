Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15078C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiKSBn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiKSBm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:42:58 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA9B9B98
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 16:52:30 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 4D58F19380C8; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 01/20] mm: add bdi_set_strict_limit() function
Date:   Fri, 18 Nov 2022 16:51:56 -0800
Message-Id: <20221119005215.3052436-2-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the bdi_set_strict_limit function to be able to set/unset the
BDI_CAP_STRICTLIMIT flag.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 439815cc1ab9..9c984ffc8a0a 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -104,6 +104,7 @@ static inline unsigned long wb_stat_error(void)
=20
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
 /*
  * Flags in backing_dev_info::capability
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..3745b886722f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -698,6 +698,21 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
+{
+	if (strict_limit > 1)
+		return -EINVAL;
+
+	spin_lock_bh(&bdi_lock);
+	if (strict_limit)
+		bdi->capabilities |=3D BDI_CAP_STRICTLIMIT;
+	else
+		bdi->capabilities &=3D ~BDI_CAP_STRICTLIMIT;
+	spin_unlock_bh(&bdi_lock);
+
+	return 0;
+}
+
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)
 {
--=20
2.30.2

