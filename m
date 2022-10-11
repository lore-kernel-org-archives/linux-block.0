Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CABC433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJKBTB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKBS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:18:59 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D037695E
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:18:59 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 0949134BDDD8; Mon, 10 Oct 2022 18:01:06 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 05/14] mm: add bdi_get_max_bytes() function
Date:   Mon, 10 Oct 2022 18:00:35 -0700
Message-Id: <20221011010044.851537-6-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a function to return the specified value for max_bytes. It
converts the stored max_ratio of the bdi to the corresponding bytes
value. It introduces the bdi_get_bytes helper function to do the
conversion. This is an approximation as it is based on the value that is
returned by global_dirty_limits(), which can change. The helper function
will also be used by the min_bytes bdi knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f698befa76a0..94fedf66c915 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
 /* BDI ratio is expressed as part per 10000 for finer granularity. */
 #define BDI_RATIO_SCALE 100
=20
+unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4d5383d4da45..0b9dcf5afda2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -650,6 +650,18 @@ void wb_domain_exit(struct wb_domain *dom)
  */
 static unsigned int bdi_min_ratio;
=20
+static unsigned long long bdi_get_bytes(unsigned int ratio)
+{
+	unsigned long background_thresh;
+	unsigned long dirty_thresh;
+	unsigned long long bytes;
+
+	global_dirty_limits(&background_thresh, &dirty_thresh);
+	bytes =3D (dirty_thresh * PAGE_SIZE * ratio) / BDI_RATIO_SCALE / 100;
+
+	return bytes;
+}
+
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io)
 {
 	unsigned int delta;
@@ -701,6 +713,12 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi)
+{
+	return bdi_get_bytes(bdi->max_ratio);
+}
+EXPORT_SYMBOL_GPL(bdi_get_max_bytes);
+
 int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
 {
 	if (strict_limit > 1)
--=20
2.30.2

