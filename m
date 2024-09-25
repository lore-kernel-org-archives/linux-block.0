Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA62155733;
	Wed, 25 Sep 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300804; cv=none; b=JopIF5jdQ2CGrCQR17O3706Yz26fuSfe3tS00qfljSrRQoJAK8JL9LZKeO9n3jaQgFvJYg77uANw+TxS5NJw8AyeVVsd/71dqTX3Uf3tZ1ltI8JJ15tqEqGdxID1/8hmCX2YSdA55F7kY+u8liEiE3HXWUtfxNrodu+ZuR9XIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300804; c=relaxed/simple;
	bh=vIZUmOhkctrpxNjE/bq31Se+xRGgI8VKyz9uNEv0GsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeJITD+oFK/npaSCwqtudPtO+OeaCGPWdBIH3mAWH+mZsIELftO5N5LHPF6liD3ZL3MOtQRa9WPfMoh4bdXCWi11dEMSFgzh946hlS6PIHXUL5QIg5Y0MhZRgmSjJDJS9bHZVsqnVecGvO306PqF3tLiK2jNATHW/UCgrRrbUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jen2M9UI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jen2M9UI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so2336675e9.1;
        Wed, 25 Sep 2024 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300801; x=1727905601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=jen2M9UIvNnpuNnpADilgCuXxN91dsPXb0y1OBOAXBcdXNrbOEaNoxH9dHZTPqnW2P
         /UcBhRYSVD2W8CrrTOyoEy7Hu42y/Y2aJ3kdsWt9jy9quMU+4PzPLl7i/h1M7MweznAm
         7rOmpMFpgF22QStPELnXxE9jm7l892MzswpgvEgLULE57TM8h9YRsNO8bpPZ8XxsxGkQ
         mOtYKjNDQJMjg1qG4FZqJj0FE16pz08ct082r0tx2vTUs+FE+6ojGNAmKpUryWj798u5
         B2+8rcK6eq71FvqaRp26KRFJspPNAW/1ncsK+b9EFDPK3RHzQYRnglMOotNlsrc/fSK8
         TwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300801; x=1727905601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=Whf8o5bATHnzWh+jYkYjOTrs90Guj3AKJZnByJMbU1Zu7QNWWg9DJ4k889UR8TE99g
         qsAdqtfCuQtzLRbeiqfCHIBAE8ZylnqiE2j4FA/xqEs3S2WQzwnefBQvKlmsv1mCJnvn
         kkBiH+3j9KHoNfTRv/rAntGxg+BX7UFGIQKGIh1EVBSYo50RlIJV7bztkRrIgfSgcQip
         Ihh5WbX97DhFeQeUzX6eCdHFoeYZiQKRUzvFuXPHXJb4rUCY6eB3sHIamc06lOC6NDJw
         kkvRD1ZLzRpgqT107pwEts0is6EKR9eSgAFjSiWhxiike3ArOA5cOQFBlVROxUDempJt
         IDhg==
X-Forwarded-Encrypted: i=1; AJvYcCUFq+kxRifTaihgr/LCEcWFO4+7FWnvw1pAGLqzk5q9uJJpbZtRJPsIfPlJ4uzIpMr6P1YqTv2HrvA1@vger.kernel.org, AJvYcCUrHEhUPNseaq9pEtUAG/4fNaEbTtE2oBc+ByqH8S0NIGF1EDOw8LlIs+VWB7DQL7wXJYbjQymyN/jf@vger.kernel.org, AJvYcCVKjlsLvuJQ1NwDa6tDE/NN6l4fLytxZzf4xadN02e5hOm65lpMcDuGNNRYeIdH6BDoo0nESRCIlPF8Wtv9@vger.kernel.org, AJvYcCVnxj/WuMWZq1Mfoi2QuPK+koww0YiUPipVdC228wbP3+zlqlK4sAy0mvRaXjP9YueRtfBlOWW31S+FXpo=@vger.kernel.org, AJvYcCXUaar8G2rfDg5itex5JYZFbr5XHoUL9tU3T+DDBNz/oR5sWlBb9XVyt/wsB1uaQulDfklH6YuVwkfE@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4+SLnsL8JKYWTvSSezp5tr1/RAKXRSuAsB9EM96ekyDLdbHT
	LQzhDZ48QJuT7H61d6fJAeK93cGnmvvDuWQkmwayWxpCCOYDKVcN
X-Google-Smtp-Source: AGHT+IFoBL1R6dV7SQmlZLkBLTdCPdCS80FZbnIfOFtYbfTr6iXHb66aYiNtJGIPYb/itJ2vx6/jEQ==
X-Received: by 2002:a05:600c:8a7:b0:42c:c003:edd8 with SMTP id 5b1f17b1804b1-42e96953e43mr23751955e9.6.1727300801042;
        Wed, 25 Sep 2024 14:46:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 1/5] block: add support for defining read-only partitions
Date: Wed, 25 Sep 2024 23:45:21 +0200
Message-ID: <20240925214544.6114-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925214544.6114-1-ansuelsmth@gmail.com>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for defining read-only partitions and complete support for
it in the cmdline partition parser as the additional "ro" after a
partition is scanned but never actually applied.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h                | 1 +
 block/partitions/cmdline.c | 3 +++
 block/partitions/core.c    | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index c718e4291db0..f300212d3e98 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -558,6 +558,7 @@ void blk_free_ext_minor(unsigned int minor);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
+#define ADDPART_FLAG_READONLY	4
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 int bdev_del_partition(struct gendisk *disk, int partno);
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 152c85df92b2..da3e719d8e51 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -237,6 +237,9 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 	put_partition(state, slot, subpart->from >> 9,
 		      subpart->size >> 9);
 
+	if (subpart->flags & PF_RDONLY)
+		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
+
 	info = &state->parts[slot].info;
 
 	strscpy(info->volname, subpart->name, sizeof(info->volname));
diff --git a/block/partitions/core.c b/block/partitions/core.c
index ab76e64f0f6c..abad6c83db8f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -373,6 +373,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_del;
 	}
 
+	if (flags & ADDPART_FLAG_READONLY)
+		bdev_set_flag(bdev, BD_READ_ONLY);
+
 	/* everything is up and running, commence */
 	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
 	if (err)
-- 
2.45.2

