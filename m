Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D725F9CB;
	Sun, 29 Sep 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618897; cv=none; b=ZZr1+bHGfenhXr09mJFAj4t61vMGLK+bHg3zsM/Zw4BoyAVWOhV2fZDiK2op8XgCqlsQP7hPKvvGNfx5iuQpYPUlBZMZIqra4J7OzUv3y5gm/vxSUP+w8SKvnw+yFOEghkXkXnFXj+F0NmesHm6YPrx7/C8le/IT2TgRqqZI19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618897; c=relaxed/simple;
	bh=ftB5EISWBZiCT+QCmocovh6Hf2Gur5hrEprFTTKUDDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZQmzk8H3iktS2U69HL1tfsdkqTilx0HBcpezO/wgjhF5nrDNrnIzNVRF38kgFnnjDHxjApt+SWJhXLKwF3+AOKaGFUGj2ROLNsoFD9iApLjN0PxOVnyrHSEDhdDvkKby460R5cUZFauagVAv0PZEnDA8CPx/CpOG8kloEE3hkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRsmcoAV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRsmcoAV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so31398265e9.0;
        Sun, 29 Sep 2024 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727618894; x=1728223694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxiCM0bbtgYKLaDvgbQd9GQXp8QrE6bw3MQSKeJbJXY=;
        b=BRsmcoAVqaWTlGtWdspJG3Nf1lKN8uLnHhp1e+nxzIzo1M3SQJOCBsQN+7WMqZEKBc
         o85yuu1M+VBMYifXCoCzL2XeeNpfHpNZW+oz2iqSYHqoU7j/wZkq7dy+suCquIHMbXFc
         c2Vtd1xijB0DaJWqyxkZuziG/4f4Q2RzvH1OZfuCxIZS7pRCNl/USc1gNeZnPx2zq2De
         60e+sgSBtOvwZzykFK8ifcJz+lP5cmhDpFNy1rim/VBNlpt8oNagV2P8d8bEZij55VWv
         dnnPhI5y4juD5kH63EmN5Z3wvhUy7y4NmbB/BLGbAffkkZ4q+Xud3BDBoVB7rS8Amd8A
         2EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618894; x=1728223694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxiCM0bbtgYKLaDvgbQd9GQXp8QrE6bw3MQSKeJbJXY=;
        b=SE7hJoKmB+hc+KAU33LE8JhGCu9/3gqoew7HMBUPdm5K/0Gy/AiBLunZK/xhf7Y/Gm
         1M8oNPUf002DSLx2bbLku7ESIjO3dXQgoy5xLyLtmjN/AkRTpV2i15jxeYDDzyfB0sAa
         7vPoWg65AYKiesbTpx2BuswtJn2Jf4h9KuEkqNLajEdtBKrSty80LipeyYLk+5eGmgBj
         sDphH98xIqz7hsTtWH6t4CeOruytwgGeLhiiTdYlf9SA0TWRyH78nSP6LYdeAGjN7tew
         qUsHyGhg+MqZZKUW5sZBSy1qobLo6GuwAlykyQnIpSI4dijyIrfJ0B2zCWCUP1hT+Qvz
         +ktw==
X-Forwarded-Encrypted: i=1; AJvYcCUzksA9e3YsUndyvGLQ2SDZG1qUmO7Mc1GLIxAZb5zxqLNQumFOxv32O123Xctev0BdnhBzZ04ldSrbWxaI@vger.kernel.org, AJvYcCVbIZWkEpNcr/YEfYOq/PoPqUHx4E0OOge1iZilE3ctQeo4FKHGgOZPst7VOiKr1EDA6ywbIf2Hp1hh@vger.kernel.org, AJvYcCW4FULSj8MbdH2U4unDerYKQHATJv81SMUpGt7SFsoARjJHmIhIDv/SzllnklSquUqLPjZXozsQVmmK@vger.kernel.org, AJvYcCX7tz7ah/SBO9SncWnIY0i+snOJZl+iKmehHPH+CNDpV/x+KQxnE/zbTcuerp+F03L32fe6S8xDurlY@vger.kernel.org, AJvYcCXxYp8wgtgWnHoFmjlwwsVDW5KDoCQNQpbTOzlVfl+A4RJ8Zy7nX0t8za6ub9dXasXCAcQznRY9ShjQGjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDAEeLVgNgCFQrwIuPGXsIVH5s/LX82myluNVEYNe0bJINFqv
	BfxX5meEvywHacwL0e1oDDUehILXV/0+93tI1/N4fVLVYFq0JxJD
X-Google-Smtp-Source: AGHT+IE/JYgZQz1MkME+bh2fy1sSJl5BniRbrO4Qg7lwQZpjBnyGre/nNMwhzmyStG3YOmG/JYzKxQ==
X-Received: by 2002:a05:600c:1549:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42f58490e62mr75614675e9.31.1727618894119;
        Sun, 29 Sep 2024 07:08:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm77856005e9.7.2024.09.29.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:08:13 -0700 (PDT)
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
Subject: [PATCH v3 0/4] block: partition table OF support
Date: Sun, 29 Sep 2024 16:06:16 +0200
Message-ID: <20240929140713.6883-1-ansuelsmth@gmail.com>
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

Christian Marangi (4):
  block: add support for defining read-only partitions
  docs: block: Document support for read-only partition in cmdline part
  block: add support for partition table defined in OF
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |   5 +-
 .../devicetree/bindings/mmc/mmc-card.yaml     |  52 ++++++
 block/blk.h                                   |   1 +
 block/partitions/Kconfig                      |   8 +
 block/partitions/Makefile                     |   1 +
 block/partitions/check.h                      |   1 +
 block/partitions/cmdline.c                    |   3 +
 block/partitions/core.c                       |   6 +
 block/partitions/of.c                         | 151 ++++++++++++++++++
 9 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 block/partitions/of.c

-- 
2.45.2

