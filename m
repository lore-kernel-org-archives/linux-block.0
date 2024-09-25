Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C81534FB;
	Wed, 25 Sep 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300803; cv=none; b=aKkP9gUnF3uFaspMRK+FetUmj68rofdt5s1yMd1gxvw0TFUPlGCrbSNm33ou2DG6SesFXFdGc+NYwKhtMlWP8GjPS6WJLFcXBTngns+n2xjyqotf/N5RjTeUcFSt9alC7/MdVk4qNMLsyniQRd5iyclIfJeJcPBB8QSilTMlSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300803; c=relaxed/simple;
	bh=hKPqj54rfSZOJYhQlr4OrA/L/22OYdi+JxkaqQ4JVug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FI/haenZMUE84LnXBrD4j9FbGZ9+h8iDMD3d2FhBQ25WFAgI82d14t7pWmf4Y2F44S+U2KannmPkrcucgm4V2EfWE0E18rGVAaYcDuNqCzuML9yFkTMmNa41vOQAKPAj+kdZwseGIcYYNgZBQPiF7GTQkOAUcPeLmYw1tAneGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dii5f39l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dii5f39l"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so2334405e9.2;
        Wed, 25 Sep 2024 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300800; x=1727905600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVmVgaclLf08yTC2h5OjCOTI7DSU5jBV3Cn+WzQVxUs=;
        b=Dii5f39lmEUHDJoMMFW7d2zFhiH4bEGYeUw0AQ03txVdJgV/wZHsw8Eb1zdDZ671jK
         eEbYk3dvpgwfDsKPYNUgM4jMcsHvHqWFHYeH7bMaowIEWDXhAjlOxCjvCxNZ5ix3iT6u
         Xj9SG/rPpjIOGRFgzhO9wxkJMpDp7wmxHXL37FPVmjaQlkO0+D/6zEBSA/kU3nstbpjh
         jMsI07Dzcgee7ZLZXxSPev7okgUmvFU1j9JZUh4wvqeN7VFOZA+B5uy4/Bf5xqzM2Ucs
         xFkFh6Jxhx5OH6wK0MLnFroyEB8mbTrqIkTJbTzSCYCcVvPoZexjDgvXS5jS1VVmtLyS
         Yabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300800; x=1727905600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVmVgaclLf08yTC2h5OjCOTI7DSU5jBV3Cn+WzQVxUs=;
        b=WZlRRHvdm9JSsqQ3PeIggFHmiwlZrUs2m8MuVkKFz9DSP6M3db5WDy9gloEQeysz4q
         7ilNvLRHJ5QZXytyMxKq+19QXkMl2wa3DdGl5xRJPNj8gdpcI3hA6NeXTp04tLAJYQUY
         pXH5TcIFo/UpNkexRzApz4CA9prgNAPU2D7ZWLzXXz+mmBEF7oNl/WEGkO79DGKiYLg1
         LNV/zE64NbF16uoIU3Uk3p54a1lMcIbpTePoMdSxQQenWAVx9c7NR6FfIU1L1xZSR5z4
         lKr7RdvTNPxxrpkZfWK/YSYAGJ4TxdLpqFE6aVQXho7O+jQ/08hHfOR6kftjP/dC69c4
         NYSg==
X-Forwarded-Encrypted: i=1; AJvYcCUOupihU0UFPV36FS1lQbmY0azguJTkCSnHjWbekPaykEyZgWkoE0b7E5Q6DKVOKk05IzikxLd4oY++LLLY@vger.kernel.org, AJvYcCVeJecL9SS7e0WLUg/cemVAoUVQeOpEZ8r/qbXluA7Mw/PhFZub08b6jw1msoQ+S67nAT4zOdv1az3H@vger.kernel.org, AJvYcCW1dyNr0xH/p3/s3XhwmTyn170B/S0DV2AjaZHs7hilBFa3zqyLZZRQSKz5ds1bfEGH8oyZjZNm9+7p@vger.kernel.org, AJvYcCWhw7QnnJ+IeM0pzLN+abVSphra+5zMs3Xgk7Wc5qLfC53kJq0pvTlND2Bht7ZJe1cIXHHIFMN+eMelC3s=@vger.kernel.org, AJvYcCXjGleRSv/Ud9PiFJLWJOKh24VtPBCvzZN4/nqYuqD6MFRvlCn+gXFWQaW79e8agi6R0oCzy3kwg0VH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe60CHDYPBRUsvGMEn90r4HMsRngnC4hqOxsVFmGt/SO+Ogb8c
	JnfsOxH8OXbQCPfiT2XRi0jOmbnWLLa5KxlWjt9D2J9NCT58Jic9
X-Google-Smtp-Source: AGHT+IFLnDQbe1OOtOZOCODKOAoHYW+yOXDMI3pVNSMriwEKjgwO+0xQ1+cxh4UpT8hlWIhtMosbxQ==
X-Received: by 2002:a05:600c:3107:b0:42c:b995:20d9 with SMTP id 5b1f17b1804b1-42e9613634fmr31493025e9.28.1727300799582;
        Wed, 25 Sep 2024 14:46:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:39 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/5] block: partition table OF support
Date: Wed, 25 Sep 2024 23:45:20 +0200
Message-ID: <20240925214544.6114-1-ansuelsmth@gmail.com>
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
  block: add support for partition table defined in OF
  dt-bindings: block: Generalize and introduce property for partitions
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |   5 +-
 .../bindings/block/partitions/partition.yaml  |  33 ++++
 .../bindings/block/partitions/partitions.yaml |  27 ++++
 .../devicetree/bindings/mmc/mmc-card.yaml     |  57 +++++++
 .../bindings/mtd/partitions/partition.yaml    |  10 +-
 block/blk.h                                   |   1 +
 block/partitions/Kconfig                      |   8 +
 block/partitions/Makefile                     |   1 +
 block/partitions/check.h                      |   1 +
 block/partitions/cmdline.c                    |   3 +
 block/partitions/core.c                       |   6 +
 block/partitions/of.c                         | 144 ++++++++++++++++++
 12 files changed, 287 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/block/partitions/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions/partitions.yaml
 create mode 100644 block/partitions/of.c

-- 
2.45.2

