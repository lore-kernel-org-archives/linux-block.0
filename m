Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA8C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiKSB70 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiKSB6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:58:25 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A284D5D5
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:51:41 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 7CD5419380DF; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 12/20] mm: add bdi_set_min_bytes() function
Date:   Fri, 18 Nov 2022 16:52:07 -0800
Message-Id: <20221119005215.3052436-13-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces the bdi_set_min_bytes() function. The min_bytes function
does not store the min_bytes value. Instead it converts the min_bytes
value into the corresponding ratio value.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e04567727e6..572669758c7f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -109,6 +109,7 @@ u64 bdi_get_min_bytes(struct backing_dev_info *bdi);
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cefee7210d83..3d151e7a9b6c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -750,6 +750,20 @@ u64 bdi_get_min_bytes(struct backing_dev_info *bdi)
 	return bdi_get_bytes(bdi->min_ratio);
 }
=20
+int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
+{
+	int ret;
+	unsigned long pages =3D min_bytes >> PAGE_SHIFT;
+	unsigned long min_ratio;
+
+	ret =3D bdi_check_pages_limit(pages);
+	if (ret)
+		return ret;
+
+	min_ratio =3D bdi_ratio_from_pages(pages);
+	return __bdi_set_min_ratio(bdi, min_ratio);
+}
+
 u64 bdi_get_max_bytes(struct backing_dev_info *bdi)
 {
 	return bdi_get_bytes(bdi->max_ratio);
--=20
2.30.2

