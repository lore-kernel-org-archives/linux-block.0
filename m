Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D619E98C;
	Wed,  2 Oct 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907235; cv=none; b=W3X88Z+jyJ6KVLPaUckQclT0k90aMTJrJ2h/35RF7rWUagkVYTRJ1E3L9bGh3prANougdk7tlhr2V4/E3sOV9xQgXg3AGRg0XT28/5GhaSW7au0fZ60zLKm7VNrl6qZ1iuzzuHApR5f1wslk1oP266tewlfM8bsyY/uJ9Ws7iXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907235; c=relaxed/simple;
	bh=qBrpQ0OapihIETdTqtZmWQZZ6yy1lqfSHQgAjBqAJ8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6fuSqW3P9N97osr+WyJ0B62icVCbJNPFQsgDu+odujBuwhIy24U8xoNc4rIZ5snymrBj5YivI27RfJ1Wm7KzA+3XFzHtq6Y17p5zJDFgzZ9EUiqRYmFZsoJNSxtPXpqbz8vC0KWG1gS1BfwqY9xQZK9/Kor1sXI7/Uc3I5GVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxm8O27n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxm8O27n"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cafda818aso1928935e9.2;
        Wed, 02 Oct 2024 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907232; x=1728512032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oc8lpQtVqxlF5EBGWgyVqr5bkZcHuTE/5Ln0cX5+BQ8=;
        b=lxm8O27ndD1IovRPmEHIyBt4dfqminLY6UmhRfL7quK31n3BbKZqN8GdxBRyCFWB42
         W81y5qhVDty4pppgD0PgfHjeWjtB2X20jckpQ/GqnVmMnxqtLM3R8MHjtrqUEsf+v0oi
         woq+xNJFx3W40ECzPUJqyPEKae/4qPZIvcOwBheAZxokqcPO4/rzCshronGjtjAKuCgL
         6w/U/53MHkJ54ziZdKVAhNOcqzoc1Wy+x2y/Wizw2qcQS3YJuaCSxL94jG0JY9FQZGjJ
         34WbO4pCgXaIXrBMP0Mcz0F3y4RWQceyaMSiHajo1jSjvzN0E8TumAF5zopv11pWSgqS
         7acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907232; x=1728512032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc8lpQtVqxlF5EBGWgyVqr5bkZcHuTE/5Ln0cX5+BQ8=;
        b=lnNmgS+mIU7WCAryE5wzUqkwUDQDm3K2J3WCD+NVNk6rGdyePWAkdamYFdVeFNFGCX
         Mnwo3EiMZjI9J4U7akig+uO2emomfiy4IkYwcD1PU5+7tHhbQHIqSGy7y+fH3A3/pRyU
         ct9TYK8GBXLcFoSv9XfZFFaeZwH4V/l/4JDgTwfOSIXXfecI3TG3PfcxnUHlxoZLuXD/
         ThrbZtFCetJ4updBEuV/ETD+mVyqXeC60hw/+eKh7U/ws1sxv3UJLcjTVzZQ0nZqVKBn
         fl1AzSV23oFLhcfYa8vdRSSxSmj/mGn2fKZjc35wNlH3uy8HEvNJ07WGITZDYrRfo1Sq
         BaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2o0k/neOQ7FAUzZz7IOvIGIt00zGxtnIx5u61lECmz2HGrhZzuA9Xc8XKxlkaCDmMcaDiZivAxxXS@vger.kernel.org, AJvYcCUgoCHLSCWcXeVWg0N1We5pxgVQw31j5GP/w7b9yJTfM5V9Th5d43Qtm+l22e0H05vxhbBr/mJ00PAS@vger.kernel.org, AJvYcCWP0v8Tb0+GUZWUUAF0Z5CLJB4vvN+YC/UkkPJVIYS/uPzXx18BmzL0Ab6SjYKYhL6hhc6PMDJlS0rNTuM=@vger.kernel.org, AJvYcCXSiplaGOtrYufMBz9c0cF8QXu7kkY9zmcJzyoBsFy2mIkkGTa9JXN+2yp6GNuFis68VewzNshwXO1J@vger.kernel.org, AJvYcCXW4JlmXsEDHQHpWQ4Bx4QZV+0Q0cboHaX5FjlllgM6qVyYOh6htZQrACf3fkK1M/xeUrAp5CO4YhMVRy23@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFsR3kV6ZfLFjZCNbbI3eZTfGbEqC+czqATMmrwwQz3klAhrD
	iu0eqZkI25CNEKDd61c1AMZZG7YdLT7jfFHuEjYYm8Zmc14O6ZnZ
X-Google-Smtp-Source: AGHT+IHrLc+U7lAjjtGt7GZ1uGyyMTu09XhAfXdEeCsNqOHh9RGHrZ02SW/Rm37DHFy3T1Yd4xOG8g==
X-Received: by 2002:a05:600c:3b05:b0:42c:acb0:ddb6 with SMTP id 5b1f17b1804b1-42f777b7325mr34382125e9.9.1727907231663;
        Wed, 02 Oct 2024 15:13:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:50 -0700 (PDT)
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
Subject: [PATCH v6 4/6] mmc: block: attach partitions fwnode if found in mmc-card
Date: Thu,  3 Oct 2024 00:11:44 +0200
Message-ID: <20241002221306.4403-5-ansuelsmth@gmail.com>
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

Attach partitions fwnode if found in mmc-card and register disk with it.

This permits block partition to reference the node and register a
partition table defined in DT for the special case for embedded device
that doesn't have a partition table flashed but have an hardcoded
partition table passed from the system.

JEDEC BOOT partition boot0/boot1 are supported but in DT we refer with
the JEDEC name of boot1 and boot2 to better adhere to documentation.

Also JEDEC GP partition gp0/1/2/3 are supported but in DT we refer with
the JEDEC name of gp1/2/3/4 to better adhere to documentration.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f58bea534004..d7eadf2b407f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2501,6 +2501,56 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
+/*
+ * Search for a declared partitions node for the disk in mmc-card related node.
+ *
+ * This is to permit support for partition table defined in DT in special case
+ * where a partition table is not written in the disk and is expected to be
+ * passed from the running system.
+ *
+ * For the user disk, "partitions" node is searched.
+ * For the special HW disk, "partitions-" node with the appended name is used
+ * following this conversion table (to adhere to JEDEC naming)
+ * - boot0 -> partitions-boot1
+ * - boot1 -> partitions-boot2
+ * - gp0 -> partitions-gp1
+ * - gp1 -> partitions-gp2
+ * - gp2 -> partitions-gp3
+ * - gp3 -> partitions-gp4
+ */
+static struct fwnode_handle *mmc_blk_get_partitions_node(struct device *mmc_dev,
+							 const char *subname)
+{
+	const char *node_name = "partitions";
+
+	if (subname) {
+		mmc_dev = mmc_dev->parent;
+
+		/*
+		 * Check if we are allocating a BOOT disk boot0/1 disk.
+		 * In DT we use the JEDEC naming boot1/2.
+		 */
+		if (!strcmp(subname, "boot0"))
+			node_name = "partitions-boot1";
+		if (!strcmp(subname, "boot1"))
+			node_name = "partitions-boot2";
+		/*
+		 * Check if we are allocating a GP disk gp0/1/2/3 disk.
+		 * In DT we use the JEDEC naming gp1/2/3/4.
+		 */
+		if (!strcmp(subname, "gp0"))
+			node_name = "partitions-gp1";
+		if (!strcmp(subname, "gp1"))
+			node_name = "partitions-gp2";
+		if (!strcmp(subname, "gp2"))
+			node_name = "partitions-gp3";
+		if (!strcmp(subname, "gp3"))
+			node_name = "partitions-gp4";
+	}
+
+	return device_get_named_child_node(mmc_dev, node_name);
+}
+
 static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      struct device *parent,
 					      sector_t size,
@@ -2509,6 +2559,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      int area_type,
 					      unsigned int part_type)
 {
+	struct fwnode_handle *disk_fwnode;
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
@@ -2610,7 +2661,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	/* used in ->open, must be set before add_disk: */
 	if (area_type == MMC_BLK_DATA_AREA_MAIN)
 		dev_set_drvdata(&card->dev, md);
-	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
+	disk_fwnode = mmc_blk_get_partitions_node(parent, subname);
+	ret = add_disk_fwnode(md->parent, md->disk, mmc_disk_attr_groups,
+			      disk_fwnode);
 	if (ret)
 		goto err_put_disk;
 	return md;
-- 
2.45.2

