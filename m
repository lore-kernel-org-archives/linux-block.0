Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05618E74C;
	Mon, 30 Sep 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695889; cv=none; b=c9dsf+L40WIuwQi7pZuKud2yxAxRVMHWQakW83nbVe/wnbeMCVRTHJG0Rtwcd4s6bzYHieJKLWthHfVCSFXYGqOoOFYZ9txmr/mGt2QIw/qoCusoFQg+9TMrOAkJzG4X7v+w53lcmsoX/XN7/jLt01ugtyHxA81gxgr0FOYl++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695889; c=relaxed/simple;
	bh=Gz5KW5hALie3z9g2VJENb2IHqaJJS+XfH8IpYkcxYQY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bYNOX2LRhcBN0nXvBR9neK2c7iuxUKcWdJStRch2dLxRUjYUZZOPh5bSmKwFihrFWpdNzd7nYQxiuRj8pVr0uJNdMLu46uOmxjpVydrW3eGkMY+/tMSqxq8ozCfe9tad0HxQXU3VGEnVu5tSor08b8dSb68IbVQA4UbV3GtMk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWAt2evQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWAt2evQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so894668f8f.1;
        Mon, 30 Sep 2024 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695886; x=1728300686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YiIs3bHOwFCglJ1XZ2b3oRoZl2j5PvNMKUkUk+rZC0=;
        b=cWAt2evQBB3goeNESmR75n9KNr0dQ8Rm7DhK6O3oU9FgWULR8f3WYpq1YO6ZbbsqKn
         JEsk9u48hbq9rnVRG7H5No4E8DPVb8T+0JFneWqnDdxZvbXP2jQv5CadDy/wIKMPcNXu
         l389UeP/+gw//oF3g5HGXDwqPF8o22uFrmundkJGuWySFrxi8XKd6aT/DtwnB7Ehenrc
         h435MpMZLBZUiJOGGWKEbV6Z67IELWCcNp+mWwiWH6OQq5aN9bmCbKK5jLwzDDqi3JmI
         BaE1cSzFWaK5pkDbsnPZfaHqSuDJhXjwyWlB79sG46htibBWlxSu+NzW04dPclWnjqS/
         8EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695886; x=1728300686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YiIs3bHOwFCglJ1XZ2b3oRoZl2j5PvNMKUkUk+rZC0=;
        b=M1ZIXYIz3NgUcdTKPSH9v9TqVeS4elmwyXYmw22wn/YCxBnYj70uQ8+457G2H6ynBq
         BbXCAKF3glIlpU0dmM0EwYpE6yxwKdT/GRIvQ+k2Ku56UOvhC/0zDA5+ph2eGwcQaMEm
         o4Y1N3p0ec6c/Fey7lf4ePuLrnj+Vs46DDOw8j6hWmsyM7s86U6aDSvIf10NmbYJfUYL
         7v01OAWCACLLu/6wr1P3aJyJ5b9fL6/05YiWap4wOImwRCm+KllCjrnfnJsG1glxN5rV
         iXAPdjglu6NYWdMbqNwkmJ8Ixi0CrDTFy33ICAtVclgMELS4ohA8/qI+jCFZCJyuQXAC
         Ge5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDuem/bf7r6R/+CWNpynymmJjAbqdVbHb8wB4A/zW25sFfT07kJC86aV8H5/B01ewVos/NUDYidSQr@vger.kernel.org, AJvYcCUS1HDjggyRhvL5HCDxa20gl6Ql3ubQwzPynntXo5f1RGi2l7z9vD6ySgFxTbLW5Aywp/OeiE+w9arJb04=@vger.kernel.org, AJvYcCUfix8eqNATeOivlL395nnZ7Oy7Nov0hkibH/Uvai1mLkPdaC//WGsMB/YbrCyUCMXAj2G2Xo4M4iGP@vger.kernel.org, AJvYcCVD78MNkrJw9mbJSeTUkvvcllQ4Rf32h1Jxt5nYK2N69PMKxs8mzj2XTIU53uJS8bO8cPwSohkw8torIInQ@vger.kernel.org, AJvYcCVEigZmhzPGkcCEZxdXr2Xj2lg9IaJqD+SJsUjaK1dUeoI0DwY2Dv+MQSY1qpoZfW9K7VwkqGHSeuftwRHEINwS@vger.kernel.org, AJvYcCXPZfKJnYhFYyOoodMm2sU5U4qZlZkI/Hx8oRDet5k6qFkHc/n/2yGdAXEzB7I2g3RyAdokApv78arS@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGWf9BtJdQ1g2b6/PSNIYskTdEqfpCj7Dm6sxBCKzv5on5Fvb
	/HSNlCby+QyWAJmmxi/H8MpzqKo2D4uL9HK6JZLnzTF6AWw139Rx
X-Google-Smtp-Source: AGHT+IEIsdcRgsyK864MeREGM2feJVQach96Q/sGvKiTG2PTKeFbkb9eida+L8WPLH+9ZNFVIrSS3Q==
X-Received: by 2002:a5d:5447:0:b0:378:8b84:4de9 with SMTP id ffacd0b85a97d-37cd5a69798mr10450453f8f.12.1727695885496;
        Mon, 30 Sep 2024 04:31:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:24 -0700 (PDT)
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
Subject: [PATCH v4 0/5] block: partition table OF support
Date: Mon, 30 Sep 2024 13:30:07 +0200
Message-ID: <20240930113045.28616-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
this is an initial proposal to complete support for manually defining
partition table.

Some background on this. Many OEM on embedded device (modem, router...)
are starting to migrate from NOR/NAND flash to eMMC. The reason for this
is that OEM are starting to require more and more space for the firmware
and price difference is becoming so little that using eMMC is only benefits
and no cons.

Given these reason, OEM are also using very custom way to provide a
partition table and doesn't relay on common method like writing a table
on the eMMC.

One way that is commonly used is to hardcode the partition table and
pass it to the system via various way (cmdline, special glue driver,
block2mtd...)
This way is also used on Android where the partition table
is passed from the bootloader via cmdline.

One reason to use this method is to save space on the device and to
permit more flexibility on partition handling.

What this series does is complete support for this feature.
It's possible to use the cmdline to define a partition table similar
to how it's done for MTD but this is problematic for a number of device
where tweaking the cmdline is not possible. This series adds OF support
to make it possible to define a partition table in the Device Tree.

We implement a similar schema to the MTD fixed-partition, where we define
a "label" and a "reg" with "offset" and "size".

A new block partition parser is introduced that check if the block device
have an OF node attached and check if a fixed-partition table is defined.

If a correct node is found, then partition table is filled. cmdline will
still have priority to this new parser.

Some block device also implement boot1 and boot2 additional disk. Similar
to the cmdline parser, these disk can have OF support using the
"partitions-boot0" and "partitions-boot1" additional node.

It's also completed support for declaring partition as read-only as this
feature was introduced but never finished in the cmdline parser.

Posting as RFC for any comments or additional checks on OF parser code.

I hope this solution is better accepted as downstream this is becoming
a real problem with a growing number of strange solution for the simple
task of providing a fixed partition table.

Changes v4:
- Fix wrong description and title in Kconfig
- Validate reg len with addr and size cells
- Drop offset 0 constraint (not needed)
- Rework bytes to sector conversion
- Follow common logic with ignore partitions after state->limit
- Better handle device_node put
- Add suggested strends string helper
Changes v3:
- Out of RFC
- Drop partition schema generalization and simplify it
- Require fixed-partitions compatible to adapt to MTD schema
- Make label property optional and fallback to node name
Changes v2:
- Reference bytes in DT instead of Sector Size
- Validate offset and size after Sector Size conversion
- Limit boot0 and boot1 to eMMC and add comments about JEDEC spec
- Generalize MTD partition schema and introduce block partitions schema
- Add missing code to actually attach the OF parser to block partition core
- Add reviewed by tag for read-only patch

Christian Marangi (5):
  block: add support for defining read-only partitions
  docs: block: Document support for read-only partition in cmdline part
  string: add strends() helper to check if a string ends with a suffix
  block: add support for partition table defined in OF
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |   5 +-
 .../devicetree/bindings/mmc/mmc-card.yaml     |  52 ++++++
 block/blk.h                                   |   1 +
 block/partitions/Kconfig                      |   9 ++
 block/partitions/Makefile                     |   1 +
 block/partitions/check.h                      |   1 +
 block/partitions/cmdline.c                    |   3 +
 block/partitions/core.c                       |   6 +
 block/partitions/of.c                         | 151 ++++++++++++++++++
 include/linux/string.h                        |  13 ++
 10 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 block/partitions/of.c

-- 
2.45.2

