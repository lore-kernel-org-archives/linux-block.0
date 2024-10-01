Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C51CF5DD;
	Tue,  1 Oct 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821245; cv=none; b=OutVdappPiFsAXVo7iKmk6+6lmsOfzAgQWBZtGWh0AehNenF7EbLz5sb6j+9jlvxCMNQKcahi8oKYxeUxNh+riHBMNuepYHFTVuZv95ZpidhyJVgW4YzGfNATdDmUpqvo7FI3tHG6VFfidO+i5hAwtL8xjTwnzeIlNe5BkThopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821245; c=relaxed/simple;
	bh=uFj2dvFYNBFuFJirSb+yihT/EV1akv6TTLSHucJpP6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg1FnhugrBfr0LGgVw9qvxYmr+cVJNR4GJq/BPjH04/7qbJf4vM1nLUlVEPfWpCJx4C5ee+62bzwn8R1/1g0Y37UcVEJBljrIz0Mqt9OV7HK6P5A47ldE0v/zFZi1OEUQuoTCXpxssI0e93s7Tv7Wr4YqmH63d2pUBmNyMp9RDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm1WOQ9S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm1WOQ9S"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cc810ce73so3503705f8f.1;
        Tue, 01 Oct 2024 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821242; x=1728426042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvkeCfAFF2+TrOZNYfnjZ9TAqZKaKEt38PpwPlqvY1M=;
        b=Nm1WOQ9SgslqM8QNzwdi1DjVJkoHlE0e9LmeKdRHfjts3+fs1Z8I5eeUQkdHdDzaXy
         6VRUqzMUsORpb9BMyk2+TZRdmry+EA26oakcK64t0CsLq+85Kjj1NpgS192PbhMrclXH
         rqd443zFwG8SJI2iCP0LZRK0/+r9z2vFdWXeAQWd0+SvNXjfM3tvUq8tNELMVL4IPt7X
         ZKTXqx3rGhEmb9PdExJCeuKE12KvQRubKtPWReRTQJnwtq8SmLAl/MBTa+5wLWgtOT/z
         tuRk2FfRHFsDx8dv4ZTUDDskIkIkfFD9pI8ImN9RPVNNXQZBXBPwg06uI8M2tEulIYXV
         DgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821242; x=1728426042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvkeCfAFF2+TrOZNYfnjZ9TAqZKaKEt38PpwPlqvY1M=;
        b=ulIxoi4rfTiLK/l0DQO7f0UGLVqmS/AmxD/UQj1Ao2tBisWfr5iZJxog2xfUrbZaSv
         GjNhcCaouym+qkQsli7/tesc4HrYL7MLMtQQ3lTnjyBE3Z7n1fmiAOF2OYTBO4cYd1vE
         fronrp2yF4H+IYT1OOFsBdRSF4DhhnzKx/3TUVSPY2MmfEiMAvcF/mmVKCaLsiV5Rtu9
         tB13yX+ux8X2EisyPRTjZUimnyYYqbsWRtNXe5wssJWyS3JxG6lXIi38M5VXADvf654S
         b9ykxC8My5JGsrctQu+aUHSFfBuyjf8ybtAvkFj33GGoWlXG4L9m0klitPbgyGzKZoZ9
         nHGg==
X-Forwarded-Encrypted: i=1; AJvYcCV9UvND8BtfQJnbkChv9Xfk1cVzwBscRHHhO23ku08oXgGHI0tLQnE5AW9bydwPwh/pBYBt1a6YhQiH@vger.kernel.org, AJvYcCVsZmUnT3nwNpfyFGwW7gva99UzaRDln35rtLuW0PnUJb2CiSQvj5Cua43d1z4xLzgs/8dTynr58OY+@vger.kernel.org, AJvYcCWhODZzERSnSQxjL3BG4fKzLpm8UhrOu+IvOe166WWwQHGp3OMPGQeavMQ7Odu6IedjfM7wtlPhuBiAGz0=@vger.kernel.org, AJvYcCX+LDbE2D0esO68aKNlSLo2P6+iYb/3N67RpzURIPRCs0qULxFZ90V1+tS9Fh06qox/+XWrs5Q6P1s+QLWW@vger.kernel.org, AJvYcCXeaXKvz+edRlz0/EUAFh0y4+6LKSTSQuKTGaVd6F8/3DDyTbIxnLKBxSyc6JdUOjbYU5AKUU2UJviT@vger.kernel.org
X-Gm-Message-State: AOJu0YyPV/9+RM3bZ9OL6saLMXFSqbpU0NbJPz1D80bXU5+Xfx6qyOlu
	F/IKOhFsdd5n71e/GEJAyPelOCs74Amh/NiJ5hDI2osa0YuyD16S
X-Google-Smtp-Source: AGHT+IGdzj7eGjtzUH2e4oHAiqm3ikbyp7r4ZRQP5cTIPq03W/eHfzzj9TqfTqlU00uAZm44bq5y4A==
X-Received: by 2002:adf:f98f:0:b0:371:8688:1660 with SMTP id ffacd0b85a97d-37cfba08fd6mr566868f8f.51.1727821241723;
        Tue, 01 Oct 2024 15:20:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com
Subject: [PATCH v5 3/6] block: introduce device_add_of_disk()
Date: Wed,  2 Oct 2024 00:18:55 +0200
Message-ID: <20241001221931.9309-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001221931.9309-1-ansuelsmth@gmail.com>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device_add_of_disk() as a variant of device_add_disk() that
permits to pass and attach a fwnode to disk dev.

This variant can be useful for eMMC that might have the partition table
for the disk defined in DT. A parser can later make use of the attached
fwnode to parse the related table and init the hardcoded partition for
the disk.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/genhd.c          | 21 +++++++++++++++++++--
 include/linux/blkdev.h |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..0fc595895f1d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -391,8 +391,9 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
  * This function registers the partitioning information in @disk
  * with the kernel.
  */
-int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups)
+static int __device_add_disk(struct device *parent, struct gendisk *disk,
+			     const struct attribute_group **groups,
+			     struct fwnode_handle *fwnode)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -452,6 +453,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	ddev->parent = parent;
 	ddev->groups = groups;
 	dev_set_name(ddev, "%s", disk->disk_name);
+	if (fwnode)
+		device_set_node(ddev, fwnode);
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
@@ -553,8 +556,22 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		elevator_exit(disk->queue);
 	return ret;
 }
+
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups)
+{
+	return __device_add_disk(parent, disk, groups, NULL);
+}
 EXPORT_SYMBOL(device_add_disk);
 
+int __must_check device_add_of_disk(struct device *parent, struct gendisk *disk,
+				    const struct attribute_group **groups,
+				    struct fwnode_handle *fwnode)
+{
+	return __device_add_disk(parent, disk, groups, fwnode);
+}
+EXPORT_SYMBOL(device_add_of_disk);
+
 static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 {
 	struct block_device *bdev;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bf1aa951fda2..7d41f35f1065 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -725,6 +725,9 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 #define for_each_bio(_bio)		\
 	for (; _bio; _bio = _bio->bi_next)
 
+int __must_check device_add_of_disk(struct device *parent, struct gendisk *disk,
+				    const struct attribute_group **groups,
+				    struct fwnode_handle *fwnode);
 int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 				 const struct attribute_group **groups);
 static inline int __must_check add_disk(struct gendisk *disk)
-- 
2.45.2

