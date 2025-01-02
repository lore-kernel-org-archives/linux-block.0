Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AA7DA9C;
	Thu,  2 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819305; cv=none; b=d8v6hyC7OxbkXpgOLMyVsddscMOd9g0gJWDEXsmlQdiFDa3NT6EH64g1FGEdJwpeuCu1yFDaHWzjSc4YsY3phDuGaPzdw+NLB2GxTZbEcYgUvzaFLPeeRBXdqL5Dkgurlx8jE9I/wklQD1Byl5dhkrzXf2lBbOloXm2hNFhpFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819305; c=relaxed/simple;
	bh=A7tmEh5g1RF0O8e+nNgPoFqTEpOsQ/LwXFI2flN3GLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCqQiy9vp5ZPFOcz+SGI+WDy965R2H9lOjSVJoKj6QFdWVLW1V2/1Ci7Tbp1UZE0NP6iy/RfJA1Tu5QrbAmhEtMmhkl0UhqGpnPHilLAHI9dqIWFNIh7fUge0wA2peGCrVShnhCyqG8fphiCElrxiFt5Qvb7x1qiT0LP4L5uh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fgUQW8HZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fgUQW8HZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735819292;
	bh=A7tmEh5g1RF0O8e+nNgPoFqTEpOsQ/LwXFI2flN3GLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgUQW8HZOqnOpSBEcOqr8tCFGf9MmfZfKkIe/Uu3OnWvPv9baz62WDDrE4lNPLgtN
	 tHGudBlwwLqKko4Mlxq9pjfgRoB4C72JT81R4UKsx/QpTjquNPOXTCXKrHP2RU0Hk/
	 4UH+YmU5soxFhz4FIMeWPibHOwPzNx0iqMTmE1vI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Jan 2025 13:01:31 +0100
Subject: [PATCH 1/4] elevator: Enable const sysfs attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250102-sysfs-const-attr-elevator-v1-1-9837d2058c60@weissschuh.net>
References: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
In-Reply-To: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735819292; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=A7tmEh5g1RF0O8e+nNgPoFqTEpOsQ/LwXFI2flN3GLw=;
 b=zgnf9hGcztJO1koRepY+g9DqNcoSBFwq4pD/vRbYg3OcpO32vuZHCmV+qDt8biSozaZSjxVs1
 pKounLIhRJNB3Ebx7oxYHPy5RLuQJIKlq3rwNWGVNv5BtInCTmsFQoE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The elevator core does not need to modify the sysfs attributes added by
the elevators. Reflect this in the types, so the attributes can be moved
into read-only memory.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/elevator.c | 8 ++++----
 block/elevator.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 7c3ba80e5ff4a390e62bb4318d364e95da92cd3c..0254ff79a696032e032781c4d9519e9ab7f52cb7 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -405,12 +405,12 @@ struct request *elv_former_request(struct request_queue *q, struct request *rq)
 	return NULL;
 }
 
-#define to_elv(atr) container_of((atr), struct elv_fs_entry, attr)
+#define to_elv(atr) container_of_const((atr), struct elv_fs_entry, attr)
 
 static ssize_t
 elv_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
-	struct elv_fs_entry *entry = to_elv(attr);
+	const struct elv_fs_entry *entry = to_elv(attr);
 	struct elevator_queue *e;
 	ssize_t error;
 
@@ -428,7 +428,7 @@ static ssize_t
 elv_attr_store(struct kobject *kobj, struct attribute *attr,
 	       const char *page, size_t length)
 {
-	struct elv_fs_entry *entry = to_elv(attr);
+	const struct elv_fs_entry *entry = to_elv(attr);
 	struct elevator_queue *e;
 	ssize_t error;
 
@@ -461,7 +461,7 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
 	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
 	if (!error) {
-		struct elv_fs_entry *attr = e->type->elevator_attrs;
+		const struct elv_fs_entry *attr = e->type->elevator_attrs;
 		if (attr) {
 			while (attr->attr.name) {
 				if (sysfs_create_file(&e->kobj, &attr->attr))
diff --git a/block/elevator.h b/block/elevator.h
index dbf357ef4fab9362b7fb2f53724b6bea2ff057b7..e526662c5dbb1f313cb2346b72f713e1cd58665e 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -71,7 +71,7 @@ struct elevator_type
 
 	size_t icq_size;	/* see iocontext.h */
 	size_t icq_align;	/* ditto */
-	struct elv_fs_entry *elevator_attrs;
+	const struct elv_fs_entry *elevator_attrs;
 	const char *elevator_name;
 	const char *elevator_alias;
 	struct module *elevator_owner;

-- 
2.47.1

