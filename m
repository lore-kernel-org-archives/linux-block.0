Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA519885B;
	Wed,  2 Oct 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907226; cv=none; b=DVa0wwuBeoWDGEP8gZvTY6Jr5P902fUPSPk87ThuRNVILrht/XhDKc1VXdR8fXA4XSPEVZqt0Pd6JJQxW4mWeledG+jVlK9H3loqts6/zgiVvyYChPvMrhGxHoe/gqMzuSyIP0cmeVF2WHHHlDH4sDzHdxxvqbSkD0EOAxA40xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907226; c=relaxed/simple;
	bh=vIZUmOhkctrpxNjE/bq31Se+xRGgI8VKyz9uNEv0GsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4Qldwg1fG6DLgZbU30UGAtnhMoBDwa1aMWGNW0+v+2YQuGI/wmo5PBWeV2jTPjVmOKx0yfaWLRG1aEnh9SzRp2ifCitmpU1aGZ0iCOq82LTDKBwhMWTWN1RIHCVW8H2h+FZcqTJE7PnmWUAfFNve4goPlhzfpd4UQlEqGnNp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJdHh1pD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJdHh1pD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so2074785e9.3;
        Wed, 02 Oct 2024 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907223; x=1728512023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=hJdHh1pDDc/wwQTw1aH+f3MPnAAzQk3DMfCYsLppvZPPYaGo78s+XDY2QXpl3ivF4r
         Eyz/AUgGwiC8x8WZRCy/FpG2MCcERU+gdpV7RG1U6rpDXr096E3wwTFr3hQ7LfqvTnPP
         36qyfooIgE6X3oSHR0sge39+pEkwBfo6D3MTj1AhEBbsLJLu5lWkbrvnTaZ8LXvtoYJ9
         M/wuQmundepYbRPFahGic1sD7nFKeeIo5z9YqJq1eFJP29TZRWmHTigs5j4J2bPT7rQJ
         f7080xDkLKLc7rm0wJthIK5p2UwIn/il7pZ5ylhwDJOewxDkvzjp71O54Jb/8PFV34Dx
         52fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907223; x=1728512023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T9c6jNuxQUPP/Rbzo55YkzEPcrdsPIICvkg9bn4/tM=;
        b=MVscUUG2gEGv9d6tUtSnasGfj9rBzAloA870R6IwFR1D9dy43OgL4+SjCiNZmDARTV
         NuoST+LQmcXqUd5KBNBqa3udHPnLSgITFcfaAUlPv2eYRkLw8OPsLRDtx8MrnkWn/EX9
         8MzwzGGSeBJ9/t8d/x95CTcOMvCLpvsm4BRbFR80k5rUyjnoOsY8nxwQoT54aCb1b4Rs
         ukXJYJh/HIEXLkLzu3R8wzm3YX4ZeSmQ5DLc3Tb2vQ/PzrQZ09QxcKcpCXslh9EMPXd1
         L/zHIH9Qc4C8s4tmE8/tRBvdXw1Zd8NOe3E6PTuLTUIUOu6nqnMIfz36i5cWIB+kRg8G
         oAXw==
X-Forwarded-Encrypted: i=1; AJvYcCU+2Dzzyz9xOSLWhnz9phH2zF2pQ36xtob8mKqTRRF/+kwM4/Yzu7inF+NwumN71iB1WKXYvR9B4mpl8FDp@vger.kernel.org, AJvYcCUpC9Kyml93hrrTza8hKvcNrGkTiAlyqZZCQG9wlEZh7fBlgIzifXckEtF3LuwqnkjLgLVku/4TZenw@vger.kernel.org, AJvYcCUzPqRGZNUYuXLjCt5TxUWIM/6DBBsb4/J/4T+b/cTtWxMrpmLW6B10ITJzgedDP1HYNw7myZIpkbyP8PU=@vger.kernel.org, AJvYcCWOTmP0JSUVj+R8PkkRCqi+mBH7iKJodNG8lnSipQ9SirY0h/QgEKhIaZPiDRJeKyddA1OJqA5ILi7X@vger.kernel.org, AJvYcCXANXhrP0uWNe+jQ+I5X22zZcFzAZGv0Zik9Sfw9hw0umMh0HdigEINv90M7oftYE5GSCG2CBl+bwCr@vger.kernel.org
X-Gm-Message-State: AOJu0YycjLqnYW3QWTPIecME6w3GIduK6RhOuN2kCK20XlxZaMauahmd
	vmSz0cyDS05IfD62P6QMonl2KmAtMbWdtZp4jDc/w83GPlnQXRqR
X-Google-Smtp-Source: AGHT+IHVMWSt0Q6Br7yza0Y32FBkOq5Dsl21VP0EwCtbgpPqez3dioXXC+VpAgoAGlxYRcWXNuPDcA==
X-Received: by 2002:a05:600c:500d:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42f778f435fmr36503995e9.31.1727907223052;
        Wed, 02 Oct 2024 15:13:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:42 -0700 (PDT)
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
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/6] block: add support for defining read-only partitions
Date: Thu,  3 Oct 2024 00:11:41 +0200
Message-ID: <20241002221306.4403-2-ansuelsmth@gmail.com>
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

