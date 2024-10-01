Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C91CEEAF;
	Tue,  1 Oct 2024 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821239; cv=none; b=cnbzKjm2D/ZZxRtusBjaoSGs4Kv3MkLrFrWedtENaD1lUiwfYt5bRRfqjZxOlqnst2I95rJfHdL3zLLVnz6+JfDo3yYWLC+K/sTL4hWjJ56bCHRSf1d8TpSWlaEIJ5ZhE6p8pdvEiLnVAHk5+GBmRtEoUTBRxWngjPtx0EoKVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821239; c=relaxed/simple;
	bh=vIZUmOhkctrpxNjE/bq31Se+xRGgI8VKyz9uNEv0GsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZH2dVBRkTkm7YlZfK5z0yh/3mcEC6ch1jnjaFHshAzYjvUUEMzhkfy5XmGpbLLjS2PCD7o+ws0II7ne8f3p0lHItT+bAq5esVFKrcIBflo5lmeAckV8JKKwfeeTSaPMRdsU5YbWn2lsZDXP4DLhMkcVQmbXQDOIoxJo80dM9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmk7GpL8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmk7GpL8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3770320574aso4047754f8f.2;
        Tue, 01 Oct 2024 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821236; x=1728426036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=Fmk7GpL8Qvb5P/c+KfqQtQQ3He9GYc0x071DBDbVPe5sW+/cQsb6eQC6FPRmGx8QS9
         JFM/FT0ih8mwEVNvrw/MxUQvNYqh+eJFk2CPUfv9uwI6Xygl3yeuJaTRkgQgbcvHh94s
         7OvAakFRbFtT0X0TjhfCCrX1KcXrGs+QmbgqHMLC41/aSJr1AHmjTFmck9I+yG8IqS4g
         OkonA5ob+mPJu50XYsUO9MABr3Emi6F+fC0M1H+wo/xDQoWl8Og5DQtlI9QF0NOEuNUx
         Z62ZuSUb8NI4tgx4euaYcPq7+HOvyP/Oz0ox2Ad3fNWC/snKhmTImb0KIxzr7MZJdcB5
         fHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821236; x=1728426036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=CoBWvqnAeogQORiFvgzsBpEhxv00zPSbxFwXjC9ii2/zy1W2BF0Zz99W+9SiHfiiXW
         FFNpC2NQ9qi5zPPIjC0mGbQQmfNI79m61zPvx7o2d4fFmKmPTIb29zrmxKlobWcV5tSy
         bYrkT52PTV9FJdBi75DLLIUuLU3WL63NGjhcIct6Aiq/PBXTRp430B6Eg9JjOuTMv4q0
         nNJYnoc1x7Vb7gbcIQjs+CZ3rhvxaf/XTuTZt16oT+4Zh+Tm9Z3PVL5dFX4blh0Alswn
         Ql3unXJ86AqgOeQvxLV3bucsY75uKLN1fQbV3UOY02vMCm2tw8P4/T3GpLavMP9RCTeq
         uLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCULeFuyrHJRDxectYtkKxO+JVvj8/rGL4Otx1qPqLQBTPO4tBq6VYR9BILomeVx3wEuqE2zMkyoenr7NyE=@vger.kernel.org, AJvYcCVfnBE3Esen9RSEgz294vNCMcSPIDFIRXDckpNB01ykDfL54NinSJuoYmIbfAyWDomgv1/gy3Uiy4Dj@vger.kernel.org, AJvYcCVplV7xHdLh4Xdo8Rp1XAjmelnjpZgcVuyWtQobf3uDY7cFY0hLkNqOnZMaGZEhgiW/NFbMp25oRSEBdVd6@vger.kernel.org, AJvYcCWc47F34IefXi5CM5bk2yXz4a6XZEaNrndV6YTvz0oFmThiNJ05BXjbNaN6h2LzcPN0uqzVkFwhAtnU@vger.kernel.org, AJvYcCWleUFUpHlb/Ef10+/+GvERAtKc6OXFFqlspS4vBmYF3GLH9dYoxOXmTTA2VZBLswKTrvYTJlMqtCqp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8m3cfu/oVuxYKyuP3aOjqrReR2Li5nDFm+XgzmzkkdAeGpX7R
	te9KtiGnFOS3KXj/oRm/RG0bPXYH0PizhykK8+1PYFK502mioy7c
X-Google-Smtp-Source: AGHT+IEt+YQcOoLcKfh2IDWaQAcIDbyDapw5vyX/WVp3rTT/HXNLy7PwAC3w39nnsMjur95PNYjA3Q==
X-Received: by 2002:a05:6000:18a1:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cfba20c94mr705520f8f.59.1727821235960;
        Tue, 01 Oct 2024 15:20:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:34 -0700 (PDT)
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
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 1/6] block: add support for defining read-only partitions
Date: Wed,  2 Oct 2024 00:18:53 +0200
Message-ID: <20241001221931.9309-2-ansuelsmth@gmail.com>
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

