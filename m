Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB30CC433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJKBRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKBRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:17:43 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E352AE09
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:17:42 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 03A3A34BDDD6; Mon, 10 Oct 2022 18:01:06 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 04/14] mm: Use part per 10000 for bdi ratios.
Date:   Mon, 10 Oct 2022 18:00:34 -0700
Message-Id: <20221011010044.851537-5-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To get finer granularity for ratio calculations use part per 10000
instead of percentiles. This is especially important if we want to
automatically convert byte values to ratios. Otherwise the values that
are actually used can be quite different. This is also important for
machines with more main memory (1% of 256GB is already 2.5GB).

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  3 +++
 mm/backing-dev.c            |  6 +++---
 mm/page-writeback.c         | 15 +++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 9c984ffc8a0a..f698befa76a0 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -102,6 +102,9 @@ static inline unsigned long wb_stat_error(void)
 #endif
 }
=20
+/* BDI ratio is expressed as part per 10000 for finer granularity. */
+#define BDI_RATIO_SCALE 100
+
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index f9aaa14ad98f..e64bc49561b1 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -178,7 +178,7 @@ static ssize_t min_ratio_store(struct device *dev,
=20
 	return ret;
 }
-BDI_SHOW(min_ratio, bdi->min_ratio)
+BDI_SHOW(min_ratio, bdi->min_ratio / BDI_RATIO_SCALE)
=20
 static ssize_t max_ratio_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
@@ -197,7 +197,7 @@ static ssize_t max_ratio_store(struct device *dev,
=20
 	return ret;
 }
-BDI_SHOW(max_ratio, bdi->max_ratio)
+BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
@@ -811,7 +811,7 @@ int bdi_init(struct backing_dev_info *bdi)
=20
 	kref_init(&bdi->refcnt);
 	bdi->min_ratio =3D 0;
-	bdi->max_ratio =3D 100;
+	bdi->max_ratio =3D 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac =3D FPROP_FRAC_BASE;
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e22aae0ecacd..4d5383d4da45 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -197,7 +197,7 @@ static void wb_min_max_ratio(struct bdi_writeback *wb=
,
 			min *=3D this_bw;
 			min =3D div64_ul(min, tot_bw);
 		}
-		if (max < 100) {
+		if (max < 100 * BDI_RATIO_SCALE) {
 			max *=3D this_bw;
 			max =3D div64_ul(max, tot_bw);
 		}
@@ -655,6 +655,8 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi, u=
nsigned int min_ratio)
 	unsigned int delta;
 	int ret =3D 0;
=20
+	min_ratio *=3D BDI_RATIO_SCALE;
+
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
 		ret =3D -EINVAL;
@@ -665,7 +667,7 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi, u=
nsigned int min_ratio)
 			bdi->min_ratio =3D min_ratio;
 		} else {
 			delta =3D min_ratio - bdi->min_ratio;
-			if (bdi_min_ratio + delta < 100) {
+			if (bdi_min_ratio + delta < 100 * BDI_RATIO_SCALE) {
 				bdi_min_ratio +=3D delta;
 				bdi->min_ratio =3D min_ratio;
 			} else {
@@ -684,6 +686,7 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, u=
nsigned max_ratio)
=20
 	if (max_ratio > 100)
 		return -EINVAL;
+	max_ratio *=3D BDI_RATIO_SCALE;
=20
 	spin_lock_bh(&bdi_lock);
 	if (bdi->min_ratio > max_ratio) {
@@ -776,15 +779,15 @@ static unsigned long __wb_calc_thresh(struct dirty_=
throttle_control *dtc)
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
=20
-	wb_thresh =3D (thresh * (100 - bdi_min_ratio)) / 100;
+	wb_thresh =3D (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100=
 * BDI_RATIO_SCALE);
 	wb_thresh *=3D numerator;
 	wb_thresh =3D div64_ul(wb_thresh, denominator);
=20
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
=20
-	wb_thresh +=3D (thresh * wb_min_ratio) / 100;
-	if (wb_thresh > (thresh * wb_max_ratio) / 100)
-		wb_thresh =3D thresh * wb_max_ratio / 100;
+	wb_thresh +=3D (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
+		wb_thresh =3D thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
=20
 	return wb_thresh;
 }
--=20
2.30.2

