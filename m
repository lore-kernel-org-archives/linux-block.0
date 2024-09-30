Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D818E77D;
	Mon, 30 Sep 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695892; cv=none; b=LT/P1iwcxEmZ6DVod1iuld+1ni1rQUY+epJws4r4TIHlME6GhWdxQIujMaIKSdelo4nJdWDrst7Xe01y+DhhnJRIQRAYw9/mOt0DBA0HceJPJYdGHbidcb0pabbzF7mffxEl+lVdBjY+xSowiRwVXc2QkACHITBxDlX9lBteFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695892; c=relaxed/simple;
	bh=AvSpeRPjeVRXz5j8dQKUo3Zt1JFIF3gH9S62HhEmPeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beRXDE1Ymxf7diyDC6ff7lOWw4JzU1v8pCnN1EX+aO8BFjVxvx7iCtqUya/cnVHKjGzQobZfkL9C12KGFRSUNiNvwb+YB3Ooo6UCx9uaHZLhEPd7OA8OXQvadoTDV9eQ52wRmsJCawaqLYeYppEfv7Rsn63/tD/tvPkLAws1lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/a0EnKb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/a0EnKb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso37399445e9.2;
        Mon, 30 Sep 2024 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695889; x=1728300689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=c/a0EnKbZdvxSjmrJRA/ls80fCwWXFnKgCIRLYUGrCI7Y48B58wn5s+fqFDEbTpy1+
         4r9bn5RLkf0vVntfGvW1fIVDwvTLFG0G5F0DtSLSy+EsvP0tYq6MB016hSKYSYyxV6PG
         /0XHkhUvhLha9AU9Jrc7CYvKEGxYjQ2FQ8oQGgxSfZr7JRbOXlur3YenTpA6GIFbF0bz
         AUpJltRDLiIWHPEj/D8oYkm4GsRlzfztaCIXRi9FXeOi73yFkWLskwNnbRvMMj20wQT2
         FQ2mbB45FKzByG7aA0Jvjy0mgPz7ERw5PgkgBdIUHSvgIw1+oFCIYrc5xEdmYn/lcMpW
         IkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695889; x=1728300689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36HmyHvoEEpKMI8/Stc+TIqGBije17bfud9rEk2jFTM=;
        b=v9fTOmMUeqyX2d2fwVZbvC26cxCnHlf/3q/wrLsx5dYmzAFPA0x9Q9dBr0scwgs275
         EarGWtvSQodJ9MYMpEk3xrPg4SHxS7qfnXHl56z4WglCFVDXiITi9sUiaGpCb5BXoEnb
         X5l7ygqART7dw5pPHdpo9COdQi4QsYGxgoULQKMaa7+5Nrwm4VZsAEJOuX+1bWPmxo9V
         kLmIINf6RCjH5MTE/nIjiOmSiLI+D7NPxCug6f4B7GkNpqQACC8N67ZrJ8tis/SLNi7j
         z2Pxk+OxDSi+76Rz6LQb/A4TcL4+Wb52xz8nXPV6MOG78H8DSi8Ji+U3sNFNKrfhQChC
         7Lzw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZUnQ00YdUaPN5Nhak7/UVMULlt8CVzjOf2RQspugN0iPNQ+lvDoxNwAFnAK69D31UVLqa9AABLppL1LtJvug@vger.kernel.org, AJvYcCW3BZXp3DQO6fmJj76D/vCeZErAP5hZH/k9GrQfpnk3SDGyxRsXfeMDRzClNQlP4dlXCWga3wCJHPbz@vger.kernel.org, AJvYcCWALLQV7E0p81aSIEtyTowknou/oeCsEOvJbzkQmh3jdQpcpqWXyI9ez5PWN+miR9cLJCoetUo8wvccx7ZR@vger.kernel.org, AJvYcCWmPWEI44w+5qFIShqyqML1X7zv9F4a+1D4qo9+5x8ptUt/JokbuHLRu3QNUDHvNDrPNskAhEBpMdpW@vger.kernel.org, AJvYcCXKU4rTog3pLqoy8nPj0bZSXSjdGy1zAkS5iFAKTo64LLv75vpczJXZUxpWif34Wksvs/YaDirIPSqI0AA=@vger.kernel.org, AJvYcCXm7dOBAfOQYSDqxIJVwTB7Z0WRaGuUVWbhej19UaBQe9mXxst124x4K8As8Jayxz9vL6u5rxrrAqN7@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnZf2A4fuNn9aC6u+BP6h4mf+Nj0NWTYaOkgZGxHhQEaxn5NX
	9hx/ExWTmxxYOz7Xglp/0n2AxkiXYwdlkgn/7zkqMUeYC9d8pJLV
X-Google-Smtp-Source: AGHT+IFdddYiC+jr5F0voSOw4j5kJnXv13mz7EIb2rZwLR4PRKIEIhzvRYwcw5tQ+Q66sYaMUFoqCQ==
X-Received: by 2002:a05:600c:1f91:b0:42c:bc04:58a5 with SMTP id 5b1f17b1804b1-42f58491434mr93746695e9.33.1727695889210;
        Mon, 30 Sep 2024 04:31:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v4 2/5] docs: block: Document support for read-only partition in cmdline part
Date: Mon, 30 Sep 2024 13:30:09 +0200
Message-ID: <20240930113045.28616-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for read-only partition in cmdline partition for block
devices by appending "ro" after the (partition name).

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/block/cmdline-partition.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/block/cmdline-partition.rst b/Documentation/block/cmdline-partition.rst
index 530bedff548a..526ba201dddc 100644
--- a/Documentation/block/cmdline-partition.rst
+++ b/Documentation/block/cmdline-partition.rst
@@ -39,13 +39,16 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
     create a link to block device partition with the name "PARTNAME".
     User space application can access partition by partition name.
 
+ro
+    read-only. Flag the partition as read-only.
+
 Example:
 
     eMMC disk names are "mmcblk0" and "mmcblk0boot0".
 
   bootargs::
 
-    'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot),-(kernel)'
+    'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot)ro,-(kernel)'
 
   dmesg::
 
-- 
2.45.2

