Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7119E7F3;
	Wed,  2 Oct 2024 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907232; cv=none; b=nq3YEWBhjz0qlIp1NZ2Dod5ZDrqdKdB5g2kHj/v90O8viXPW7RJMiyatjOdLXy9T7n8HJw69r+p98j5P9K26xXCZbeI3HEG2nfgVeiOg5vAjJntyqV0/kkEr6xlURXz2wjFf2YdXpFvypUjGCoKC9UGCGpXVkslJAGjCFyb3v8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907232; c=relaxed/simple;
	bh=R6u21lJQXFNnRlPRZqRDOeZ1baSlH/7f2ouLC6yhy+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAmwyUuV7X6LcK1eTPOVqU8PZfEBbPZb9IizLgV8/swdQ+5NuOMOSxWvs9aHSf/1fmwMEfFZXnMdfsUpRabi5sYxmJDRIVdfPHCMMOxwn+HfUp0JLir+7U1ouSE0ssyAyTq3CFQCny/YXHevx9bttSbdKBlGy5ldc6kjVLxgorw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqVw/CPG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqVw/CPG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso1995135e9.2;
        Wed, 02 Oct 2024 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907229; x=1728512029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCCt52yzo7zLbL4p9hv8SgURf+U+fcbnakLfmIN0V0o=;
        b=YqVw/CPGnoMfQouLXiqelVg4lmh4kMwym9QSDfr1k5itzEN6IOjnVhJhMa+6wOpHOy
         oBHJpR90UV87QqrVPIWePwrd0uZxW4d/p51R98WMxvSOtV1uyhI6in7CgxsDm5qkZX/w
         2JKYpV9/B0U7oa/1GABgCxdJpXiVIuB/NeQPtFHOI3MasTZ1omHiS/S7cy1BNfaeeO9s
         MsrpaHscRCAa6n5CBuqdxM0hxvBq98bTHxs8Sa2w4kvI/vnbU75VPuolmDNXdqJ32AIc
         GHb4ldy2hjHjGO3tiBbaw2tmQfelXOpO8+jubynqposfqZtyo9b4iwboUVjNhzGMha16
         GT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907229; x=1728512029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCCt52yzo7zLbL4p9hv8SgURf+U+fcbnakLfmIN0V0o=;
        b=mmjhwBeKBrlZ5OdDu9dRHUX31xsC7BWA6RC+Ft8s6zsd9SpGB8nQHyLa17Ytfj7y+q
         JatcIAlqhFVkxmFnP1gJJeOhIBhT1tG2JZgIBVxCtv8vVt92CUUvImmqwhRyPgYgP0AA
         j44StvAa1METDfNoRI0JpksQ83nrS0oyHA1ehj9Tm8ugR+x6zcs+KGVsvMfddGOzbuSV
         7w8i6JVHa2fBnOtgz/fplYs0rxPRCl+JIbQp7YgHG88z2SbvyynzcTHCAKcj8G7LZOIr
         tAyCHl/gQimIlgx/jDLBH2zHmYoK1mMknfBY10tpzjRmcBTFmS+RjHfl9k99ph6d9g4v
         YOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbBNjT2qwNnFVZWnpmuXdSMtjmdYkD6xz6z7v285kBpRnnH15QzP6FWLMUICFZc803+WXRph+mh7L1@vger.kernel.org, AJvYcCVMeHZdkOQfpR61NxEBEP5hdhmPTqaiX70lFzJR9ETvRSk/TGZEYjCOZ7xm7LzsQ00ut2lV8wT5zRR2@vger.kernel.org, AJvYcCVOmwsbbdz7Waq8F6vzbjLIiikKsicR6hQUca5dFO/o6OlGMpikysznS2P1LPErsStTTf5Q2aekdW6/223z@vger.kernel.org, AJvYcCVPDJwO0t8xHnBgTNoPMOH/A1lFl3b9S9x+Tm7p63vgl/o4VXDy7vq+BjAxVtDDEYkaHgfQOgtVtx2baUw=@vger.kernel.org, AJvYcCWTF70gHdyupaKCGW96EBAmP6VtcARJizkDwVHfr+7mdvcY3VnPQHsJGT2OL08JaKvEzSo7SfS4sjxu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7guvnPpiVoDSDLax5jP6ZBwmD2HYspPS6Nm54ocWdKzeonBri
	G4HJSNahkqoBa32TuxmiFHdYaUsdynvf2q36JNGC0neL2OWJcbCs
X-Google-Smtp-Source: AGHT+IHbJ2VGvDWq9QrfhQabMZJM8rJ89EGNrryJEQbKFGMgmxsiqQCKWjbdtW00ydatiZXlORy+OA==
X-Received: by 2002:a05:600c:4fc8:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42f778f3821mr39279815e9.22.1727907229071;
        Wed, 02 Oct 2024 15:13:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 3/6] block: introduce add_disk_fwnode()
Date: Thu,  3 Oct 2024 00:11:43 +0200
Message-ID: <20241002221306.4403-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002221306.4403-1-ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce add_disk_fwnode() as a replacement of device_add_disk() that
permits to pass and attach a fwnode to disk dev.

This variant can be useful for eMMC that might have the partition table
for the disk defined in DT. A parser can later make use of the attached
fwnode to parse the related table and init the hardcoded partition for
the disk.

device_add_disk() is converted to a simple wrapper of add_disk_fwnode()
with the fwnode entry set as NULL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/genhd.c          | 28 ++++++++++++++++++++++++----
 include/linux/blkdev.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..bc30eee7ab16 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -383,16 +383,18 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 }
 
 /**
- * device_add_disk - add disk information to kernel list
+ * add_disk_fwnode - add disk information to kernel list with fwnode
  * @parent: parent device for the disk
  * @disk: per-device partitioning information
  * @groups: Additional per-device sysfs groups
+ * @fwnode: attached disk fwnode
  *
  * This function registers the partitioning information in @disk
- * with the kernel.
+ * with the kernel. Also attach a fwnode to the disk device.
  */
-int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups)
+int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups,
+				 struct fwnode_handle *fwnode)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -452,6 +454,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	ddev->parent = parent;
 	ddev->groups = groups;
 	dev_set_name(ddev, "%s", disk->disk_name);
+	if (fwnode)
+		device_set_node(ddev, fwnode);
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
@@ -553,6 +557,22 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		elevator_exit(disk->queue);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(add_disk_fwnode);
+
+/**
+ * device_add_disk - add disk information to kernel list
+ * @parent: parent device for the disk
+ * @disk: per-device partitioning information
+ * @groups: Additional per-device sysfs groups
+ *
+ * This function registers the partitioning information in @disk
+ * with the kernel.
+ */
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups)
+{
+	return add_disk_fwnode(parent, disk, groups, NULL);
+}
 EXPORT_SYMBOL(device_add_disk);
 
 static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bf1aa951fda2..c0f50f977f5e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -725,6 +725,9 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 #define for_each_bio(_bio)		\
 	for (; _bio; _bio = _bio->bi_next)
 
+int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups,
+				 struct fwnode_handle *fwnode);
 int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 				 const struct attribute_group **groups);
 static inline int __must_check add_disk(struct gendisk *disk)
-- 
2.45.2

