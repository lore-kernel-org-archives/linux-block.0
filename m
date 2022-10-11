Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24449C4332F
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJKBYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJKBYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:24:23 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7184E77
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:23:46 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 143E934BDDDC; Mon, 10 Oct 2022 18:01:06 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 07/14] mm: add bdi_set_max_bytes() function.
Date:   Mon, 10 Oct 2022 18:00:37 -0700
Message-Id: <20221011010044.851537-8-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces the bdi_set_max_bytes() function. The max_bytes function
does not store the max_bytes value. Instead it converts the max_bytes
value into the corresponding ratio value.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 94fedf66c915..a10598f90d4d 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -108,6 +108,7 @@ static inline unsigned long wb_stat_error(void)
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_max_bytes(struct backing_dev_info *bdi, unsigned long long m=
ax_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
 /*
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8b8936603783..a6594ebdcbd8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -650,6 +650,28 @@ void wb_domain_exit(struct wb_domain *dom)
  */
 static unsigned int bdi_min_ratio;
=20
+static int bdi_check_pages_limit(unsigned long pages)
+{
+	unsigned long max_dirty_pages =3D global_dirtyable_memory();
+
+	if (pages > max_dirty_pages / 2)
+		return -EINVAL;
+
+	return 0;
+}
+
+static unsigned long bdi_ratio_from_pages(unsigned long long pages)
+{
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	unsigned long ratio;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+	ratio =3D (pages * 100 * BDI_RATIO_SCALE) / dirty_thresh;
+
+	return ratio;
+}
+
 static unsigned long long bdi_get_bytes(unsigned int ratio)
 {
 	unsigned long background_thresh;
@@ -723,6 +745,21 @@ unsigned long long bdi_get_max_bytes(struct backing_=
dev_info *bdi)
 }
 EXPORT_SYMBOL_GPL(bdi_get_max_bytes);
=20
+int bdi_set_max_bytes(struct backing_dev_info *bdi, unsigned long long m=
ax_bytes)
+{
+	int ret;
+	unsigned long pages =3D max_bytes >> PAGE_SHIFT;
+	unsigned long max_ratio;
+
+	ret =3D bdi_check_pages_limit(pages);
+	if (ret)
+		return ret;
+
+	max_ratio =3D bdi_ratio_from_pages(pages);
+	return __bdi_set_max_ratio(bdi, max_ratio);
+}
+EXPORT_SYMBOL_GPL(bdi_set_max_bytes);
+
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
 {
 	if (strict_limit > 1)
--=20
2.30.2

