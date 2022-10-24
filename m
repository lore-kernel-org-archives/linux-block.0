Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C9C67871
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJXVDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiJXVCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 17:02:50 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8912C4CB3
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 12:08:13 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 8D48A3ED5920; Mon, 24 Oct 2022 12:06:12 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v3 12/14] mm: add bdi_set_min_bytes() function
Date:   Mon, 24 Oct 2022 12:06:01 -0700
Message-Id: <20221024190603.3987969-13-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024190603.3987969-1-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
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
 mm/page-writeback.c         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 621329f25bbe..659e9cb8c643 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -109,6 +109,7 @@ unsigned long long bdi_get_min_bytes(struct backing_d=
ev_info *bdi);
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_min_bytes(struct backing_dev_info *bdi, unsigned long long m=
in_bytes);
 int bdi_set_max_bytes(struct backing_dev_info *bdi, unsigned long long m=
ax_bytes);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 07f59ed60d4a..ca6cbf8e63bb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -751,6 +751,21 @@ unsigned long long bdi_get_min_bytes(struct backing_=
dev_info *bdi)
 }
 EXPORT_SYMBOL_GPL(bdi_get_min_bytes);
=20
+int bdi_set_min_bytes(struct backing_dev_info *bdi, unsigned long long m=
in_bytes)
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
+EXPORT_SYMBOL_GPL(bdi_set_min_bytes);
+
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi)
 {
 	return bdi_get_bytes(bdi->max_ratio);
--=20
2.30.2

