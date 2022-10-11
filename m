Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DDBC433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJKBQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJKBQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:16:41 -0400
X-Greylist: delayed 928 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 18:16:40 PDT
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E73C7B78A
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:16:39 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 2F60834BDDE6; Mon, 10 Oct 2022 18:01:06 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 12/14] mm: add bdi_set_min_bytes() function
Date:   Mon, 10 Oct 2022 18:00:42 -0700
Message-Id: <20221011010044.851537-13-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
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
index cdb131b57fcb..8db058f331bc 100644
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
index 7733dcf96d7e..04c4a142098b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -750,6 +750,21 @@ unsigned long long bdi_get_min_bytes(struct backing_=
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

