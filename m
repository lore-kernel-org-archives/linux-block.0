Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63A287265
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600018; cv=none; b=hpAuxe07Tt8ycbjK83ZlZn5uZJ49LjlHmX+cRB6pqHjnBCqkFv/KPp33/MWn1RExeIyFmrD3fNf+dHbQ9x12CzoUssFWB6MCqqqAEg2wqdALs4k5IkHtr2Mnst5HK8wGQU8pkkgp6BXDw1xlSOHDgLZ8e1IpFMDTykqW5WX3wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600018; c=relaxed/simple;
	bh=AtLHCsoItyYh/Vsz/TF0v0lQ+IzD9c/qK0RySEIugW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKEJA/7XGMEmelDmDzwHVP8/O7TmSfjjeZAh2iLYFE+OYrkIaEB0x1/Lk6NUHPnHLetOW6kJRio+q+8rvR/4x5agRPkRVukmLCJ2IwKV47fee6lPOc0bi56gx54DdgvLHm69VTTmKKo91G1cryzZzrVBOzFDi69w8CMkaLyX738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X00e3LJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X00e3LJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AE8C116C6;
	Fri, 20 Feb 2026 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771600017;
	bh=AtLHCsoItyYh/Vsz/TF0v0lQ+IzD9c/qK0RySEIugW4=;
	h=From:To:Cc:Subject:Date:From;
	b=X00e3LJILcdoWsadziPkREiYCCeBsgR1ix0xt0vLdHdM33vJF44PrOCi9e6jKPYZs
	 26rbo6R6yEt5iNVfcspIdUrQBfm3VzHKLpoKKdZIK5cV2ey6pVnqSv0v8C5SKZKMzK
	 EqyY+P8y+t7b8Jahi4/xlssZps7bjmosx6DZxjVv/ZP0Hqn/IGu0bQGzl6oUCF2NT9
	 VsmyHtCR9RrJJx+qr1XlR1Z2cqx+7oteXOZAO6Yy3+vyuxcOaX6Xvw5FpLJ8M0fk30
	 hsS5cEPNBkaIH0Rk1Vo2ZbNVScgWwlKVd0Tt1SvW5VVo485GTs8zkGWqw70wASFgD3
	 lXqKynIVv9Cqg==
From: Hannes Reinecke <hare@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2] ublk: persistent device links
Date: Fri, 20 Feb 2026 16:06:51 +0100
Message-ID: <20260220150651.19309-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a 'uuid' parameter to export a device UUID in a sysfs
attribute 'uuid'. The ublk server is required to set the uuid
parameter when creating the device.
This allows udev to create persistent device links for ublk devices
eg with this rule:

KERNEL=="ublk*", ATTRS{uuid}=="?*", SYMLINK+="disk/by-id/ublk-$attr{uuid}"

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/block/ublk_drv.c      | 55 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  6 ++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index aaf94d2fb789..ffbd5acda36b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -89,7 +89,7 @@
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
-	 UBLK_PARAM_TYPE_INTEGRITY)
+	 UBLK_PARAM_TYPE_INTEGRITY | UBLK_PARAM_TYPE_UUID)
 
 struct ublk_uring_cmd_pdu {
 	/*
@@ -761,6 +761,14 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_UUID) {
+		const struct ublk_param_uuid *p = &ub->params.uuid;
+		uuid_t uuid;
+
+		import_uuid(&uuid, p->uuid);
+		if (uuid_is_null(&uuid))
+			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -2971,6 +2979,49 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	return ret;
 }
 
+static ssize_t uuid_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ublk_device *ub = disk->private_data;
+	const struct ublk_param_uuid *p = &ub->params.uuid;
+	uuid_t uuid;
+
+	import_uuid(&uuid, p->uuid);
+	return sprintf(buf, "%pU\n", &uuid);
+}
+
+static DEVICE_ATTR_RO(uuid);
+
+static struct attribute *ublk_attrs[] = {
+	&dev_attr_uuid.attr,
+	NULL,
+};
+
+static umode_t ublk_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ublk_device *ub = disk->private_data;
+
+	if (a == &dev_attr_uuid.attr &&
+	    (ub->params.types & UBLK_PARAM_TYPE_UUID))
+		return S_IRUGO;
+
+	return a->mode;
+}
+
+static const struct attribute_group ublk_attr_group = {
+	.attrs = ublk_attrs,
+	.is_visible = ublk_attrs_are_visible,
+};
+
+static const struct attribute_group *ublk_attr_groups[] = {
+	&ublk_attr_group,
+	NULL,
+};
+
 /* align max io buffer size with PAGE_SIZE */
 static void ublk_align_max_io_size(struct ublk_device *ub)
 {
@@ -3149,7 +3200,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 			goto out_put_cdev;
 	}
 
-	ret = add_disk(disk);
+	ret = device_add_disk(NULL, disk, ublk_attr_groups);
 	if (ret)
 		goto out_put_cdev;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 90f47da4f435..b30a0de44b85 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -630,6 +630,10 @@ struct ublk_param_integrity {
 	__u8	pad[5];
 };
 
+struct ublk_param_uuid {
+	__u8	uuid[16];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -645,6 +649,7 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
 #define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6) /* requires UBLK_F_INTEGRITY */
+#define UBLK_PARAM_TYPE_UUID            (1 << 7)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
@@ -654,6 +659,7 @@ struct ublk_params {
 	struct ublk_param_dma_align	dma;
 	struct ublk_param_segment	seg;
 	struct ublk_param_integrity	integrity;
+	struct ublk_param_uuid		uuid;
 };
 
 #endif
-- 
2.43.0

