Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB818A6CF
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946673; cv=none; b=MaLh56LYIoAopqLyHj0AO7E7HOp7FzKKUSSVIADw9qmc/UxBasBDs4bvaK6wvTShEyTNGwcbyUg+TsAhoJOTi2VoKWKMTbq/BmHo0HscXWBwObxNrYl7lfY+4bb+hmoTQmBqKVJJ4fnZJJixkSTv5d5D7waaNj9dsbXEuvzZCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946673; c=relaxed/simple;
	bh=MZsFcGXKcqIYZOJVjit9xq4t4F/X93oHkysgJTxx5Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtDMm1zT4+d5nd2qskCBERUmmtyE6W8jNDVhh0oaDFGQ0ZWU/s2EiJJMhbXn8xMRD+0qasJ4864cv6CyEIHuwxP+VfwP8C6hZLkFkUC73JK6TP3wkP7Xl/eZ6hwSipkmLVbzRn+0RRjxKTgcanaYf6BtuINCoKcppOamUeUMeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI3hslxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI3hslxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D272DC2BCAF;
	Thu, 23 Apr 2026 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776946672;
	bh=MZsFcGXKcqIYZOJVjit9xq4t4F/X93oHkysgJTxx5Yo=;
	h=From:To:Cc:Subject:Date:From;
	b=oI3hslxJKBcijV5ACPnX3SjXcBDy1ayDPzvJxZqIp7P5PdQ939gpORDoa4/LLFKz7
	 LNp6G58XQvAnXk9RG9+JH71HZkJoKyeNOlahDb39BpNbAoGbsZJJuPEM2YSYGguGxk
	 j2vXkoqqP7XxD93Iss6a7RZaioTkdmD0EgRD+wKY58XVzxYjka3MR1/byEXdwXJCCj
	 zzpCwnnao19nJerfMleNBreJmEg35PFGU6uLqgLnW5LFdbCZx707ubxsP1pQp3M0nI
	 Wq/NJcPKlqZaNMfLgem/1dA5B9igwioKHHRqkBRgGxsU4UvIwLvt+k/KsW9E600njb
	 zYNW0vAUSV2sA==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3] ublk: persistent device links
Date: Thu, 23 Apr 2026 14:17:39 +0200
Message-ID: <20260423121739.7694-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 55 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  6 ++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index eb96010625e5..2c7bbea27cbe 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -92,7 +92,7 @@
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
-	 UBLK_PARAM_TYPE_INTEGRITY)
+	 UBLK_PARAM_TYPE_INTEGRITY | UBLK_PARAM_TYPE_UUID)
 
 #define UBLK_BATCH_F_ALL  \
 	(UBLK_BATCH_F_HAS_ZONE_LBA | \
@@ -938,6 +938,14 @@ static int ublk_validate_params(const struct ublk_device *ub)
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
 
@@ -4251,6 +4259,49 @@ static int ublk_add_chdev(struct ublk_device *ub)
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
@@ -4446,7 +4497,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 			goto out_put_cdev;
 	}
 
-	ret = add_disk(disk);
+	ret = device_add_disk(NULL, disk, ublk_attr_groups);
 	if (ret)
 		goto out_put_cdev;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..897848b869df 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -717,6 +717,10 @@ struct ublk_param_integrity {
 	__u8	pad[5];
 };
 
+struct ublk_param_uuid {
+	__u8	uuid[16];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -732,6 +736,7 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 #define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
 #define UBLK_PARAM_TYPE_INTEGRITY       (1 << 6) /* requires UBLK_F_INTEGRITY */
+#define UBLK_PARAM_TYPE_UUID            (1 << 7)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
@@ -741,6 +746,7 @@ struct ublk_params {
 	struct ublk_param_dma_align	dma;
 	struct ublk_param_segment	seg;
 	struct ublk_param_integrity	integrity;
+	struct ublk_param_uuid		uuid;
 };
 
 #endif
-- 
2.51.0

