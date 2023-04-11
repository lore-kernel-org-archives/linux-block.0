Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45515C7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 09:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDKJLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjDKJLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 05:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833F422C
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681204202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTO9rTFojqVhy2xhav9CqrQplmazA+EKzHDnc/5r8yA=;
        b=ISerRX9zhAY34HNxjzxMpbo4vE6lK6A7Vs+H3dYRbKnxqAi1Okl9xMhRhySkbuY8zdJu2I
        yC6O5s8BzkBtzt777PDC2vB+7ZBfrXTn3+hSde9lBpabDa2zvgjnpcCO5EDGObmM/LgydE
        m5cHi4B5s4OA1bC7yzYjRNHW82/UqAg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-WjgxFFSTPeO0wv49yRJWrw-1; Tue, 11 Apr 2023 05:10:00 -0400
X-MC-Unique: WjgxFFSTPeO0wv49yRJWrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B19993C0257D;
        Tue, 11 Apr 2023 09:09:59 +0000 (UTC)
Received: from mrjust8.localdomain.com (unknown [10.45.226.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B812440C20FA;
        Tue, 11 Apr 2023 09:09:57 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH v2 1/1] sed-opal: geometry feature reporting command
Date:   Tue, 11 Apr 2023 11:09:31 +0200
Message-Id: <20230411090931.9193-2-okozina@redhat.com>
In-Reply-To: <20230411090931.9193-1-okozina@redhat.com>
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Locking range start and locking range length
attributes may be require to satisfy restrictions
exposed by OPAL2 geometry feature reporting.

Geometry reporting feature is described in TCG OPAL SSC,
section 3.1.1.4 (ALIGN, LogicalBlockSize, AlignmentGranularity
and LowestAlignedLBA).

4.3.5.2.1.1 RangeStart Behavior:

[ StartAlignment = (RangeStart modulo AlignmentGranularity) - LowestAlignedLBA ]

When processing a Set method or CreateRow method on the Locking
table for a non-Global Range row, if:

a) the AlignmentRequired (ALIGN above) column in the LockingInfo
   table is TRUE;
b) RangeStart is non-zero; and
c) StartAlignment is non-zero, then the method SHALL fail and
   return an error status code INVALID_PARAMETER.

4.3.5.2.1.2 RangeLength Behavior:

If RangeStart is zero, then
	[ LengthAlignment = (RangeLength modulo AlignmentGranularity) - LowestAlignedLBA ]

If RangeStart is non-zero, then
	[ LengthAlignment = (RangeLength modulo AlignmentGranularity) ]

When processing a Set method or CreateRow method on the Locking
table for a non-Global Range row, if:

a) the AlignmentRequired (ALIGN above) column in the LockingInfo
   table is TRUE;
b) RangeLength is non-zero; and
c) LengthAlignment is non-zero, then the method SHALL fail and
   return an error status code INVALID_PARAMETER

In userspace we stuck to logical block size reported by general
block device (via sysfs or ioctl), but we can not read
'AlignmentGranularity' or 'LowestAlignedLBA' anywhere else and
we need to get those values from sed-opal interface otherwise
we will not be able to report or avoid locking range setup
INVALID_PARAMETER errors above.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/sed-opal.c              | 29 ++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 13 +++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 3fc4e65db111..c18339446ef3 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -83,8 +83,10 @@ struct opal_dev {
 	u16 comid;
 	u32 hsn;
 	u32 tsn;
-	u64 align;
+	u64 align; /* alignment granularity */
 	u64 lowest_lba;
+	u32 logical_block_size;
+	u8  align_required; /* ALIGN: 0 or 1 */
 
 	size_t pos;
 	u8 *cmd;
@@ -409,6 +411,8 @@ static void check_geometry(struct opal_dev *dev, const void *data)
 
 	dev->align = be64_to_cpu(geo->alignment_granularity);
 	dev->lowest_lba = be64_to_cpu(geo->lowest_aligned_lba);
+	dev->logical_block_size = be32_to_cpu(geo->logical_block_size);
+	dev->align_required = geo->reserved01 & 1;
 }
 
 static int execute_step(struct opal_dev *dev,
@@ -2956,6 +2960,26 @@ static int opal_get_status(struct opal_dev *dev, void __user *data)
 	return 0;
 }
 
+static int opal_get_geometry(struct opal_dev *dev, void __user *data)
+{
+	struct opal_geometry geo = {0};
+
+	if (check_opal_support(dev))
+		return -EINVAL;
+
+	geo.align = dev->align_required;
+	geo.logical_block_size = dev->logical_block_size;
+	geo.alignment_granularity =  dev->align;
+	geo.lowest_aligned_lba = dev->lowest_lba;
+
+	if (copy_to_user(data, &geo, sizeof(geo))) {
+		pr_debug("Error copying geometry data to userspace\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 {
 	void *p;
@@ -3029,6 +3053,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_GET_LR_STATUS:
 		ret = opal_locking_range_status(dev, p, arg);
 		break;
+	case IOC_OPAL_GET_GEOMETRY:
+		ret = opal_get_geometry(dev, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 042c1e2cb0ce..bbae1e52ab4f 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -46,6 +46,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_GENERIC_TABLE_RW:
 	case IOC_OPAL_GET_STATUS:
 	case IOC_OPAL_GET_LR_STATUS:
+	case IOC_OPAL_GET_GEOMETRY:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 3905c8ffedbf..dc2efd345133 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -161,6 +161,18 @@ struct opal_status {
 	__u32 reserved;
 };
 
+/*
+ * Geometry Reporting per TCG Storage OPAL SSC
+ * section 3.1.1.4
+ */
+struct opal_geometry {
+	__u8 align;
+	__u32 logical_block_size;
+	__u64 alignment_granularity;
+	__u64 lowest_aligned_lba;
+	__u8  __align[3];
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -179,5 +191,6 @@ struct opal_status {
 #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
 #define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
 #define IOC_OPAL_GET_LR_STATUS      _IOW('p', 237, struct opal_lr_status)
+#define IOC_OPAL_GET_GEOMETRY       _IOR('p', 238, struct opal_geometry)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.31.1

