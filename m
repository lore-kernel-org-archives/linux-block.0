Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB717BEB7;
	Sun, 29 Sep 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618899; cv=none; b=ohKq+DVlAGEBJ0mM282awoFodVGeLmAKF73yQvZANEl9cdadoNjyUyLsRFO8k3u2VRuxBYiMnpx5zR9XfhVnLH6L9fB2W6gfqq37koEtTBjPGqaCGo2/jsGxLI58PDNtAhqgM7vqh8ViBOyltlYUWp+33JLa4hbvuMu3eIqkkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618899; c=relaxed/simple;
	bh=vIZUmOhkctrpxNjE/bq31Se+xRGgI8VKyz9uNEv0GsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzcpDZUbKO0gmjJzzlhNMorT/hfZGmNy2u1LRJg928jI7J/WnOJj3YnbRY5pYz4kgcDw4OeMO54zHOszMJoDBGzOgoeZJgOytSYeDv7hVTD3BTM/IRU9ugyCk+4+GAgEYcxPYKNQ5TSiga1857ZUbGQHpoVsgcRLhuQaQUO3BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrgLegqu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrgLegqu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso27299535e9.0;
        Sun, 29 Sep 2024 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727618896; x=1728223696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=lrgLegquYAuTu6uY7eJJ1TIxn5FwaJ6WPpM44y1Y52NWLthB7LBG1w/tqSohVx9Huf
         E9GlIRSXa7MQhx1giItDrfl5qfLZh2DoRnudExgJJCLBNvsT1dwkiyJTocKf85SJUJJn
         ca9RSM0K3doyqGKjCGZNTQtEP0hsNliSYb0I0NZ/mqNemtYi+LMzHdtHgo/7bQz5bwv5
         fxDVV6UMTcWAstZ09Cre3we36QQudm3h38iZt5WkWUk1USOV0UdjdqvO3E0mKWmZ70Mk
         3jXdcZO5Y2KcRf1teIdtzJ2Xzoyic8zs/rUfvr5WXPfDHeKfStlWoGdrJjlKVnAN/odw
         A+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618896; x=1728223696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=Stl27JDh4IRoUHn23nkKHDUfqhRh3KyS3fwW5bGNaT8k4hclHsUHKZmFa0YLL9gGIK
         hYBz1qvYt5sYVc8kKzZHcW/bwQoFXh8Kzjz8EdHSC5JMiwOdFPVxhyMr6EeDXGZaK2yy
         8mDUh3CBIIvb5DUjN93d/SQYumFAOOh1NCpac2oAPYGQHUXTPYdudZ4SitDLEukBGrtf
         2EOND3n3m5RETpRDOehmV4CRKZw4YcbiBtjkp6xXBEd0oCcdW1UsWl2ZcmoMPgIFLeNo
         /h6oHPHnAW0fPIIasdFOpkwGHk7lmaIHJ9Nd69pUrU+mAyFMczTZVTMeVAg0VwkJlsh5
         3B6g==
X-Forwarded-Encrypted: i=1; AJvYcCUHqepvQax5WQiLw+3FJUJ7AmdfMaLAO5QZMosWkSSJ1VtGIcbLe4RWJuv3GoAYirPw0530vzZyNunl@vger.kernel.org, AJvYcCUV1a4NwWx7/DYwluBVelaJlncHKqYvCA4+SB5ckeZgiOQ2TIaJpXS7sG22aW4MojsgM4WSI616hRcOyDGd@vger.kernel.org, AJvYcCVDBNOfcrnCjKpghtnoKArQehSKIgELP7c1lGwDRkid887EZvEzVxRrwL+hmVblFHFH9MwnffDI2U1p@vger.kernel.org, AJvYcCWVLAIPk7UdDf429USLaYqLwlrd4OP8fJTlZUnUwZN8bf9ucLqx6LgbwBFOgtCvWLFGN7ySNBFFQE2ZbtM=@vger.kernel.org, AJvYcCWv/MsqK3XR5vi8oNdDHIyt/f7OSqpg/g/hPAhGit53rfYA8sWK+Jp/EJFRRofpvrHyp7fSk3jyv4ie@vger.kernel.org
X-Gm-Message-State: AOJu0YzS57zFc1XjdtogilU8fTpFj06efzfh9TLg+MeMtKbfN7MV7pY2
	OqkF4UL4yr8pab/u0ZFI0oAI5V90RoLBxnNIAQIhtXBVynLBX8E/
X-Google-Smtp-Source: AGHT+IHXC9+7csQPIjoe/7saRtUaNLdxTZ+PIvoa34staMYR9XMAPk/Nqpjyg4a5WE1aJ21G12OGlA==
X-Received: by 2002:a05:600c:5252:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42f521ce279mr75719125e9.6.1727618896050;
        Sun, 29 Sep 2024 07:08:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm77856005e9.7.2024.09.29.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:08:15 -0700 (PDT)
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
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] block: add support for defining read-only partitions
Date: Sun, 29 Sep 2024 16:06:17 +0200
Message-ID: <20240929140713.6883-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929140713.6883-1-ansuelsmth@gmail.com>
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
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

