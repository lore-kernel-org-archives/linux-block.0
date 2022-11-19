Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E23C433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 02:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKSCJo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKSCJn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 21:09:43 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406B28E15
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 18:09:42 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 8D4A619380E8; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 16/20] mm: add /sys/class/bdi/<bdi>/max_ratio_fine knob
Date:   Fri, 18 Nov 2022 16:52:11 -0800
Message-Id: <20221119005215.3052436-17-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the max_ratio_fine knob. The knob specifies the values not
based on 1 of 100, but instead 1 per million.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 3fab79061ade..94c2382367cf 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -199,6 +199,25 @@ static ssize_t max_ratio_store(struct device *dev,
 }
 BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
+static ssize_t max_ratio_fine_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned int ratio;
+	ssize_t ret;
+
+	ret =3D kstrtouint(buf, 10, &ratio);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_max_ratio_no_scale(bdi, ratio);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+BDI_SHOW(max_ratio_fine, bdi->max_ratio)
+
 static ssize_t min_bytes_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -297,6 +316,7 @@ static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
+	&dev_attr_max_ratio_fine.attr,
 	&dev_attr_min_bytes.attr,
 	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
--=20
2.30.2

