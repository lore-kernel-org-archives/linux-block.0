Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BBFA3741
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 21:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJXVDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJXVCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 17:02:51 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CE1CF556
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 12:08:14 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 932FB3ED5922; Mon, 24 Oct 2022 12:06:12 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v3 13/14] mm: add /sys/class/bdi/<bdi>/min_bytes knob
Date:   Mon, 24 Oct 2022 12:06:02 -0700
Message-Id: <20221024190603.3987969-14-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024190603.3987969-1-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdi has two existing knobs to limit the amount of dirty memory:
min_ratio and max_ratio. However the granularity of the knobs is limited
and often it is more convenient to specify limits in terms of bytes.
This change adds the min_bytes knob.

It does not store the min_bytes value, instead it converts the max_bytes
value to a ratio. The value is therefore more an approximation than an
absolute value.

It also maintains the sum over all the bdi min_ratio values stored in
the variable bdi_min_ratio.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/backing-dev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d5f9a8a45550..53dc46ffdb9b 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -199,6 +199,34 @@ static ssize_t max_ratio_store(struct device *dev,
 }
 BDI_SHOW(max_ratio, bdi->max_ratio / BDI_RATIO_SCALE)
=20
+static ssize_t min_bytes_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", bdi_get_min_bytes(bdi));
+}
+
+static ssize_t min_bytes_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned long long bytes;
+	ssize_t ret;
+
+	ret =3D kstrtoull(buf, 10, &bytes);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_min_bytes(bdi, bytes);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+DEVICE_ATTR_RW(min_bytes);
+
 static ssize_t max_bytes_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -269,6 +297,7 @@ static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
+	&dev_attr_min_bytes.attr,
 	&dev_attr_max_bytes.attr,
 	&dev_attr_stable_pages_required.attr,
 	&dev_attr_strict_limit.attr,
--=20
2.30.2

