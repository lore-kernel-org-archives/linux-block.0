Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719D1CF7AE;
	Tue,  1 Oct 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821247; cv=none; b=XkXJrAyJrHlgXALHeT0BfTstk+V5Sj1PnECbnqPitxkGb/Y2uiSKpQ4EQvk8fbTUqw5zmHe0e94PQDLlnk5gpnws8LPJa1ZCkRRYVoe6Z4CyLaMqLc9Lkvlrm7BcV1CygG0VE43Q3Dlct6huisdFNGVSTeB0akWNFHE+d+GRtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821247; c=relaxed/simple;
	bh=TW0txKX9e4roa0YNw5Cx9O90dBfiPbgGU4uRu7+BdK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivVUu6Hsqc6aj9puKy9GX+Un/9/dMuiZNLvLharILxnTTsmqi5pTYiTlgNzlSwJXQ6TCeIOMceOlSoe+x5hn9amTvtAhFqR5ZDFO4wHa9SicGeSNb8ohFDVBp+eznUAFfCEa/hchyv30IL18hJFVEneEBZzhKUJVYfBBmbuAsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9dTqUbN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9dTqUbN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so53475895e9.3;
        Tue, 01 Oct 2024 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821244; x=1728426044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJzhFl4gjtFcw96QhqUK28d5tLTRI0Tg3FOFtHUxokA=;
        b=e9dTqUbN/YyFK2E4NxY3xfUrrrTeO5jN0zP1zV1uPT7bQ9zBc8Sygke9ypVKlijBdb
         zVnJNFnwIwPaMYg/Aot3vxAzELcjUNqt6HyDCfHiW92eVU8zoTt9SQ4I/FPnoOfRuV9Q
         Sw6ZZTL+nRXdiYOBuJJLcxDeTeIfbNgZfZgqWJ/zJrTgFq5RXoB6GyXRnHMCDXqlc/9p
         sDM4PpwHCOzwxA0ijpAZPoDO1ExHIuoPiSrOcVkaQrGiA3wbuFPgysrnhkyxJbH3dO9P
         6iZS7dZvLZyRRUgZBT3ZaVrIzVSZaoteegkaxuOltIzsKsD/Zgzouyi6E7eS3w6DDbeL
         bSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821244; x=1728426044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJzhFl4gjtFcw96QhqUK28d5tLTRI0Tg3FOFtHUxokA=;
        b=ngOI7lY0FUsZ/xz0pcNHiV2m9NuhKvxcnSf5yvkLTL1/Y+W0G2yvijLYIn2NB8d7P0
         dSwu8RlXBuW2xBRc2CbbyZI+QXCOzGGlIfB2KetfV+jlMBld8gPwb1EvLLUdAGv6CzCk
         uKIGaNzTWpMk5Jzpk4U5/TW1pNAYFjaPkG5I0GlPGKbN7LBBHG/9gkBUze6KPuyYNpuY
         iAg0k2n9s/2X6kmeqjBuOvq5PfN0zYFw4hCj2ytZQnKMXqsASlL0BruvDSgUfvpldNNL
         KmWKsMqBSe2Bte5KWWuEubHZj36225OxzUCH3YbPNClTRSuZbbmqxjNynl0M4/FQiKns
         Qn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZA7vZJvQg7e6xLLws8F0ZjFLp+f0dp3/wvMr6e9gcwrkLdOntQJW4TwqYAZAAjBQS4+5+0IbMQ8wG@vger.kernel.org, AJvYcCV4psNMoupdiVle57366UuMnNFTfCoIK2VTrj1Mx0qrqAQKf1FCMYJH4n5vVK+a/62IAFwh4Dtg6PnR@vger.kernel.org, AJvYcCV8ZWVeH5clE7t32m+DTGRyGse8wSus8WU9dctxNINmyJLgi5s1+yf2V2XJoX9wyxLrr65HpMv6BHu5@vger.kernel.org, AJvYcCWefwe9I0cmaiAweQLyYtNze/zrIZmFeFriG+9R23as/P2RsaCI5LyvvVItc/oG9zo9XXzE+ELymH7PA/wV@vger.kernel.org, AJvYcCXEYkSyGEFi8IYoFEy6/GCDIDstkfhZAhGfzj/qhPXwTylYQADQSSVqA9l1yNay5xz343Ke5Ta8qIbSwDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLLta3j0vK6EZYtrjIRxhYIUKphpTKFdcC14X5g7OD35tqVSk
	5QcwirH5B9pcCcrhprr0zY3yq7Td+zSX3lAIef+vfmOZmFi4iwDs
X-Google-Smtp-Source: AGHT+IF3fiUQP9TkqnLPw81ZBK96R8d2ahsysc3BpTVUjWAy4kA0+9Xy4jNeUdlI0vwXFMGBkZFFbA==
X-Received: by 2002:a5d:4532:0:b0:374:c64e:3fe7 with SMTP id ffacd0b85a97d-37cfba25cacmr671779f8f.59.1727821244244;
        Tue, 01 Oct 2024 15:20:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:43 -0700 (PDT)
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
Subject: [PATCH v5 4/6] mmc: block: attach partitions fwnode if found in mmc-card
Date: Wed,  2 Oct 2024 00:18:56 +0200
Message-ID: <20241001221931.9309-5-ansuelsmth@gmail.com>
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
---
 drivers/mmc/core/block.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f58bea534004..01c4ee223156 100644
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
+	ret = device_add_of_disk(md->parent, md->disk, mmc_disk_attr_groups,
+				 disk_fwnode);
 	if (ret)
 		goto err_put_disk;
 	return md;
-- 
2.45.2

