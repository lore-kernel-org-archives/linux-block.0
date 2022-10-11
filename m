Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E63C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJKB0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJKB0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:26:02 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18718285A
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:25:40 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id EC6BD34BDDD2; Mon, 10 Oct 2022 18:01:05 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 02/14] mm: Add new knob /sys/class/bdi/<bdi>/strict_limit
Date:   Mon, 10 Oct 2022 18:00:32 -0700
Message-Id: <20221011010044.851537-3-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221011010044.851537-1-shr@devkernel.io>
References: <20221011010044.851537-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new knob to /sys/class/bdi/<bdi>/strict_limit. This new knob
allows to set/unset the flag BDI_CAP_STRICTLIMIT in the bdi
capabilities.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index de65cb1e5f76..f9aaa14ad98f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -209,11 +209,40 @@ static ssize_t stable_pages_required_show(struct de=
vice *dev,
 }
 static DEVICE_ATTR_RO(stable_pages_required);
=20
+static ssize_t strict_limit_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned int strict_limit;
+	ssize_t ret;
+
+	ret =3D kstrtouint(buf, 10, &strict_limit);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_strict_limit(bdi, strict_limit);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+
+static ssize_t strict_limit_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n",
+			!!(bdi->capabilities & BDI_CAP_STRICTLIMIT));
+}
+static DEVICE_ATTR_RW(strict_limit);
+
 static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
 	&dev_attr_stable_pages_required.attr,
+	&dev_attr_strict_limit.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(bdi_dev);
--=20
2.30.2

