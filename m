Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BCC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJQSQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJQSQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:16:51 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045474CCC
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:16:46 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 44E9F39C99C6; Mon, 17 Oct 2022 11:13:56 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v2 10/14] mm: add bdi_get_min_bytes() function.
Date:   Mon, 17 Oct 2022 11:13:33 -0700
Message-Id: <20221017181337.3884657-11-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017181337.3884657-1-shr@devkernel.io>
References: <20221017181337.3884657-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a function to return the specified value for min_bytes. It
converts the stored min_ratio of the bdi to the corresponding bytes
value. This is an approximation as it is based on the value that is
returned by global_dirty_limits(), which can change. The returned
value can be different than the value when the min_bytes value was set.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h | 1 +
 mm/page-writeback.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 5eb1ae3410b2..621329f25bbe 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -105,6 +105,7 @@ static inline unsigned long wb_stat_error(void)
 /* BDI ratio is expressed as part per 1000 for finer granularity. */
 #define BDI_RATIO_SCALE 10
=20
+unsigned long long bdi_get_min_bytes(struct backing_dev_info *bdi);
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi);
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a6594ebdcbd8..a37a25994ad8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -739,6 +739,12 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned int max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+unsigned long long bdi_get_min_bytes(struct backing_dev_info *bdi)
+{
+	return bdi_get_bytes(bdi->min_ratio);
+}
+EXPORT_SYMBOL_GPL(bdi_get_min_bytes);
+
 unsigned long long bdi_get_max_bytes(struct backing_dev_info *bdi)
 {
 	return bdi_get_bytes(bdi->max_ratio);
--=20
2.30.2

