Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D9C43219
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiKSB4t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiKSB4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:56:33 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5CEBDEC7
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:45:42 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 788A819380DD; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 11/20] mm: split off __bdi_set_min_ratio() function
Date:   Fri, 18 Nov 2022 16:52:06 -0800
Message-Id: <20221119005215.3052436-12-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This splits off the __bdi_set_min_ratio() function from the
bdi_set_min_ratio() function. The __bdi_set_min_ratio() function will
also be called from the bdi_set_min_bytes() function, which will be
introduced in the next patch.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/page-writeback.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c47824464f4c..cefee7210d83 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -685,7 +685,7 @@ static u64 bdi_get_bytes(unsigned int ratio)
 	return bytes;
 }
=20
-int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io)
+static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned in=
t min_ratio)
 {
 	unsigned int delta;
 	int ret =3D 0;
@@ -731,6 +731,11 @@ static int __bdi_set_max_ratio(struct backing_dev_in=
fo *bdi, unsigned int max_ra
 	return ret;
 }
=20
+int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io)
+{
+	return __bdi_set_min_ratio(bdi, min_ratio * BDI_RATIO_SCALE);
+}
+
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io)
 {
 	if (max_ratio > 100)
--=20
2.30.2

