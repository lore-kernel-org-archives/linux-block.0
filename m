Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB219F48D;
	Tue,  1 Oct 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821236; cv=none; b=hNfcJryLTai1LF6JBgokXxjzqZauD2/CEcb3fVQiMg52AcKGVkiylBESWVicA48lOjmHCgR9TitmgTP/0jew6T1nvYxowrGzzvAMMQCeQPmOcZBCImOaw1fmiKlVeWA1BApa2NC9Ga4cx8O9OLuTET9+jQxfgYjHtVyCmewCFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821236; c=relaxed/simple;
	bh=9mDEkDQMiItxZeF67HTJeeJTc5Y0bzgkU+u9tXl/roE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YCEXl9csR/ES5QMUhV7dogZR7zwNoSyQCyw6XdjDBZzqg0+WvuLBI2VKMue/z4kroq7S49bu8qjdAML6aKyIsVy4L3mPP9qYH7ADsd73AcwRvBCKEcvpQ5WDIQcvrKCKBvhgETlrQw3tDont3zXM0wUJt5bo8kT/KI1Y3DNuX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHr3nYjI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHr3nYjI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce6a5b785so135663f8f.1;
        Tue, 01 Oct 2024 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821233; x=1728426033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYrJq6c3Q3rKtUWpY38GPX2O1z4HkjkZcpDgBdSCRsc=;
        b=kHr3nYjIG0DOetRq4ugjdB/T28Y/ir0w1mTmlXXpw1vX+X3VWexyHAyVOwEjFuZq4z
         lcsiPFUY8yo3meqF/+7ve7N3s0dQkzQG1jmoGRYkDoefm0ml6LLt49dyn37DRsxnxJmK
         SV6K1gaPtxhk2D8gj1BC+9BdJgIB3JUbExeJWYkL7DOnX9gBTpmr6l4TrOWhWQKHkzrC
         +igjmFqKjum8pMUb8KlY11CPams3Z2puLma9pa97op6H8lUVRt3JG+UjskBhnMGbkLs1
         PrWib7hDuyxPXaH3uFbvlKMOQv8kqEeXQLpeuWPlhbr9nqVidPb746Z5S/hD9IIVtD9u
         DFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821233; x=1728426033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYrJq6c3Q3rKtUWpY38GPX2O1z4HkjkZcpDgBdSCRsc=;
        b=KCLVDwZavLJmorlxbbMTH6d6DzEt47smUE/pldmz5fJgFIqv5e+NOdIOYC7I6xhHah
         GPX4yGD3Wi1dsuCkHAv8ejU8+ewP0qBs1dS0lcunOdRX0XEkYHGu8vCH5rhULOyrAUcX
         XZy4LA155YRPdf+qyIBBikGLl2oYUUr3HGbNISmAYdbk5W+Yt1wAhXkdQBtjVdskvyo+
         PhZ+1nPv3kqd94uX9ZvRd28hjbJO2OvhKkCSVoJPSYgeUDorkWrPLGzaTRqfK8iA0VaC
         7o+jeIz5A3TvrfKF06wBeb9NSBft43SgRy5r70TSLJaMG8Hy7XWJ+JWghYsg6CZzxug7
         LMBw==
X-Forwarded-Encrypted: i=1; AJvYcCWUgaA/NT6mWs2sU6EUQrpeIf6EsOn8Lp9xRwZ2Abv8lzrXaHfKQIv27aQE7HYtQimroPcLGswLb0Pl@vger.kernel.org, AJvYcCWXIE3ipk7ebdsMty7qVOH13UCGE1dB2/muXaTLswbf5KzwmQZipXxyr24PzVqSg+vWTtF71P2jIB4q@vger.kernel.org, AJvYcCWqBZntRU5tu3TeC6wBfqJUFW2/7Jf20bqDQurlnEYXDIazy6sjAWaym+i6TkFHxlQspfIIojqEvC4eC98N@vger.kernel.org, AJvYcCWxWDpvS+Te12Sci7eLmgL6vSgUPn9m3sO0F9xOD9cMMyYCKsdCcl9c+IQSz8p11NMVOZ9qAtDFQuv3@vger.kernel.org, AJvYcCXyrRzyngS64lCOxZN+AchtzdYApSXIsWJGJR/Ug4vzBIkiC7AMKsBEXXVR0eXc3Ptz47sU/P51qjh9glk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUrMF2dLMxe5zYX1ZvbkeVlSH6ovTFarG63sEaRbd2Qi1u/Fa
	hFOV0eKvIJFyK0fn0A+4tGm3rPdFUzz75L9Ph7fPWguwCs7HQYkW
X-Google-Smtp-Source: AGHT+IEaZ5G0o2VurvFRqoM2fooqueJnAeKF/bnUDzmqZRCJooDD6XsknN8KOL+KYpnVny1PHoUrEA==
X-Received: by 2002:a5d:47ad:0:b0:374:c692:42e2 with SMTP id ffacd0b85a97d-37cf28a4902mr3724307f8f.9.1727821232769;
        Tue, 01 Oct 2024 15:20:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:31 -0700 (PDT)
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
Subject: [PATCH v5 0/6] block: partition table OF support
Date: Wed,  2 Oct 2024 00:18:52 +0200
Message-ID: <20241001221931.9309-1-ansuelsmth@gmail.com>
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

A new block partition parser is introduced that check if the disk device
have an OF node attached and check if a fixed-partition table is defined.

block driver can use the device_add_of_disk() function to register a new
disk and attach a fwnode to it for usage with the OF parser.

This permits flexibility from the driver side to implement the partitions
node in different nodes across different block devices.

If a correct node is found, then partition table is filled. cmdline will
still have priority to this new parser.

Some block device also implement boot1 and boot2 additional disk. Similar
to the cmdline parser, these disk can have OF support using the
"partitions-boot1" and "partitions-boot2" additional node. Also eMMC
gp 1/2/3/4 disk are supported.

It's also completed support for declaring partition as read-only as this
feature was introduced but never finished in the cmdline parser.

I hope this solution is better accepted as downstream this is becoming
a real problem with a growing number of strange solution for the simple
task of providing a fixed partition table.

Changes v5:
- Introduce device_add_of_disk() function
- Detach eMMC special disk from OF block partition code and move
  parsing to eMMC block driver (as requested by Christoph)
- Rework OF block partition to use the device disk device_node
- Extend support for eMMC GP1/2/3/4
- Rename boot0/1 to boot1/2
- Drop strends patch (unused now)
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

Christian Marangi (6):
  block: add support for defining read-only partitions
  docs: block: Document support for read-only partition in cmdline part
  block: introduce device_add_of_disk()
  mmc: block: attach partitions fwnode if found in mmc-card
  block: add support for partition table defined in OF
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |   5 +-
 .../devicetree/bindings/mmc/mmc-card.yaml     |  52 ++++++++
 block/blk.h                                   |   1 +
 block/genhd.c                                 |  21 +++-
 block/partitions/Kconfig                      |   9 ++
 block/partitions/Makefile                     |   1 +
 block/partitions/check.h                      |   1 +
 block/partitions/cmdline.c                    |   3 +
 block/partitions/core.c                       |   6 +
 block/partitions/of.c                         | 116 ++++++++++++++++++
 drivers/mmc/core/block.c                      |  55 ++++++++-
 include/linux/blkdev.h                        |   3 +
 12 files changed, 269 insertions(+), 4 deletions(-)
 create mode 100644 block/partitions/of.c

-- 
2.45.2

