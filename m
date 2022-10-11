Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34953C433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJKBZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJKBYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:24:51 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA65E019
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:24:49 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 0ED0134BDDDA; Mon, 10 Oct 2022 18:01:06 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 06/14] mm: split off __bdi_set_max_ratio() function
Date:   Mon, 10 Oct 2022 18:00:36 -0700
Message-Id: <20221011010044.851537-7-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This splits off the __bdi_set_max_ratio() function from the
bdi_set_max_ratio() function. The __bdi_set_max_ratio() function will
also be called from the bdi_set_max_bytes() function, which will be
introduced in the next patch.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/page-writeback.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0b9dcf5afda2..8b8936603783 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,14 +692,10 @@ int bdi_set_min_ratio(struct backing_dev_info *bdi,=
 unsigned int min_ratio)
 	return ret;
 }
=20
-int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned max_ratio)
+static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned in=
t max_ratio)
 {
 	int ret =3D 0;
=20
-	if (max_ratio > 100)
-		return -EINVAL;
-	max_ratio *=3D BDI_RATIO_SCALE;
-
 	spin_lock_bh(&bdi_lock);
 	if (bdi->min_ratio > max_ratio) {
 		ret =3D -EINVAL;
@@ -711,6 +707,14 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
=20
 	return ret;
 }
+
+int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io)
+{
+	if (max_ratio > 100)
+		return -EINVAL;
+
+	return __bdi_set_max_ratio(bdi, max_ratio * BDI_RATIO_SCALE);
+}
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi)
--=20
2.30.2

