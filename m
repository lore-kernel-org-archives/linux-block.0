Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F8C433FE
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 01:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiKSB4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKSB4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 20:56:31 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFDC4C2F
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 17:45:41 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 6B4AF19380D6; Fri, 18 Nov 2022 16:52:18 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        akpm@linux-foundation.org
Subject: [RFC PATCH v4 08/20] mm: add knob /sys/class/bdi/<bdi>/max_bytes
Date:   Fri, 18 Nov 2022 16:52:03 -0800
Message-Id: <20221119005215.3052436-9-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119005215.3052436-1-shr@devkernel.io>
References: <20221119005215.3052436-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the new knob max_bytes to specify a dirty memory limit for the
corresponding bdi. The specified bytes value is converted to a ratio.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 90fa517123dc..95d3229fc81f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -199,6 +199,34 @@ static ssize_t max_ratio_store(struct device *dev,
 }
 BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
+static ssize_t max_bytes_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", bdi_get_max_bytes(bdi));
+}
+
+static ssize_t max_bytes_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	u64 bytes;
+	ssize_t ret;
+
+	ret =3D kstrtoull(buf, 10, &bytes);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_max_bytes(bdi, bytes);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+DEVICE_ATTR_RW(max_bytes);
+
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -241,6 +269,7 @@ static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
+	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
 	&dev_attr_strict_limit.attr,
 	NULL,
--=20
2.30.2

