Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93EC67871
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 21:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJXVCZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiJXVBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 17:01:49 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A01C06BC
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 12:07:31 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 4C3843ED5908; Mon, 24 Oct 2022 12:06:12 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v3 01/14] mm: add bdi_set_strict_limit() function
Date:   Mon, 24 Oct 2022 12:05:50 -0700
Message-Id: <20221024190603.3987969-2-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024190603.3987969-1-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the bdi_set_strict_limit function to be able to set/unset the
BDI_CAP_STRICTLIMIT flag.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 include/linux/backing-dev.h |  1 +
 mm/page-writeback.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 439815cc1ab9..9c984ffc8a0a 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -104,6 +104,7 @@ static inline unsigned long wb_stat_error(void)
=20
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_rat=
io);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_rat=
io);
+int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit);
=20
 /*
  * Flags in backing_dev_info::capability
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..e22aae0ecacd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -698,6 +698,22 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, =
unsigned max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+int bdi_set_strict_limit(struct backing_dev_info *bdi, unsigned int stri=
ct_limit)
+{
+	if (strict_limit > 1)
+		return -EINVAL;
+
+	spin_lock_bh(&bdi_lock);
+	if (strict_limit)
+		bdi->capabilities |=3D BDI_CAP_STRICTLIMIT;
+	else
+		bdi->capabilities &=3D ~BDI_CAP_STRICTLIMIT;
+	spin_unlock_bh(&bdi_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdi_set_strict_limit);
+
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)
 {
--=20
2.30.2

