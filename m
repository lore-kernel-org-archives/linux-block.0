Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA06C433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKSCJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKSCJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:09:45 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A9228E03
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:09:45 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 95A1E19380ED; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 18/20] mm: add bdi_set_min_ratio_no_scale() function
Date:   Fri, 18 Nov 2022 16:52:13 -0800
Message-Id: <20221119005215.3052436-19-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces bdi_set_min_ratio_no_scale(). It uses the max
granularity for the ratio. This function by the new sysfs knob
min_ratio_fine.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h | 1 +
 mm/page-writeback.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d9acbb22ff25..fbad4fcd408e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -109,6 +109,7 @@ u64 bdi_get_min_bytes(struct backing_dev_info *bdi);
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_min_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t min_ratio);
 int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t max_ratio);
 int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f44ade72966c..ad608ef2a243 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -690,6 +690,8 @@ static int __bdi_set_min_ratio(struct backing_dev_inf=
o *bdi, unsigned int min_ra
 	unsigned int delta;
 	int ret =3D 0;
=20
+	if (min_ratio > 100 * BDI_RATIO_SCALE)
+		return -EINVAL;
 	min_ratio *=3D BDI_RATIO_SCALE;
=20
 	spin_lock_bh(&bdi_lock);
@@ -734,6 +736,11 @@ static int __bdi_set_max_ratio(struct backing_dev_in=
fo *bdi, unsigned int max_ra
 	return ret;
 }
=20
+int bdi_set_min_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t min_ratio)
+{
+	return __bdi_set_min_ratio(bdi, min_ratio);
+}
+
 int bdi_set_max_ratio_no_scale(struct backing_dev_info *bdi, unsigned in=
t max_ratio)
 {
 	return __bdi_set_max_ratio(bdi, max_ratio);
--=20
2.30.2

