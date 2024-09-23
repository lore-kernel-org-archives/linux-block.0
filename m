Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95B197A88;
	Mon, 23 Sep 2024 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089212; cv=none; b=cPfBOBNYQr5v+YbAE35EpemGk8u1YKRZnLmrW6KKjn7p1moaZSQML7YRwZ0liehQYS0Of0lCsgi+/P+Xb9WAaBYOPiorWh1f0ofsZc4k6Vc3XFUKlgpbYtKVnXYm6bASzHiDsPsK2wCh85Qbsdkb/ayuluJSSFdmI+qYMzvYo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089212; c=relaxed/simple;
	bh=rEJOd8Ag634czjmTBSKTu+5heBAHV6i2Bwts/0hgliw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mSEux2RjopV/kOucIJiHrq3IgPi+MJHoZBKmA5j+Lw0qWLdNYH5/VXceGxfNWryRGDMvvwM6AW9xQiHaL43C740iVxAnqjGwMWUxG7eX+iqZPl7gg6OCagJ8GPA/oIIqtz1SDO6tXSwE0Z4ZwjNmqGdSAmkMAYMt2w4qYbSM/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+JwolTB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+JwolTB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so37867095e9.3;
        Mon, 23 Sep 2024 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089208; x=1727694008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxRWLiboh7HytSmhqGBPtDBEZbsko5+ohtUjH0Pgnac=;
        b=L+JwolTBeMW4IwVuDAEb5gVBoCK7PbeHPo78AAh19ln3fXZZBbWxVJ4U3l0gnyKxmH
         Md5HqDkpAMd5eHv+1btFs8HZ7bzLcGrf+7ptp3p0YXKJnOgwMvCsqJBK0trCqvPe27Bt
         3SY7JmVT07H+1+1xOfP0mqq1kuMip5cpLce4XKl+Qju3jOT4zzRdYy67UkKIYSCuZX7a
         4+BAFWi/RPnGa3sJo4j92eoAA8iRRGUHY9v2bIrArNIrVnFHkhHs4UJKTiXg3pbe37vA
         6lX6O/hsreav+loFl2NjQRL2LJ6KMhFZN3I0L6lval7uTrRUPmbMPK+WwVctBmzO1CsK
         R8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089208; x=1727694008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxRWLiboh7HytSmhqGBPtDBEZbsko5+ohtUjH0Pgnac=;
        b=B1AyDdL+0PCUiOWu7PPODvATwA6tm7imPnxOp4nJ1o/TPwgurHpu3P1Z/inC8CoIXb
         LHe7qiaKGzKdfr8+C/VoaVf0O2qlLNSEnTeLfB1ADFhn8edDpHs0VWaCKY94RIGAXBJ7
         gWortHlbpAm/1FBObPzFRPIKyVPiMY4s33X8R4J6Rjm6AugxYAu0atIQvcskSHgxWE8p
         WTwGRb3rq1/bE+W1D+8ERsh1ED3vdGddKo0rwbhhyNxtz7hLfuo52gQ6ZXyEw/bJnP0O
         D5nzrryHQwKulxKJtR6aRp9151a1r5KxyPRoOW+26lshoLRwaMwC6cn7YXt3RRIznPSE
         VuBw==
X-Forwarded-Encrypted: i=1; AJvYcCVAWsfmFOTgozPBNkHVF1qCA9DPHF5CvBp706GNfvx5TfTR+v9iLqbibA+GAoiszRuPP3x2kf8IeKy/r8Kl@vger.kernel.org, AJvYcCVBJAHyK4/OxC1XY6Fdogdj+HTB3Kf7mSq0T54faXErmfP42LdUoZWCJJ11DT8pT7N52INVCoW/NECc@vger.kernel.org, AJvYcCWUXztGl6j5Pk8v9SzEUifDNRjdT/xH1fRccJ9tQ/RuS0F8PZCf5Si9HPdc7X2nUBDgE5bVaqG9gzWR@vger.kernel.org, AJvYcCX/TOzVb50OZliNSkHRbxF0wkSoK+oEN5NhVSDw7j44SUkvVujAQMGLiehVZFQ682GSED/ZD/uQlNyq@vger.kernel.org, AJvYcCXZ4UVSK9+huxnJhz5YAu1ClzUmVhClJzVsFFf892cKsbMiQByGlFGArpgE0kim4Cnte/GHzwYsPnnQDnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRri9sX0VLzdNzK/6fSm6g7O7IoPy7Q8QEvxBuoJKZG1h8rDrA
	gbY+au8nAFFNaLOTeCukVjBkr3+4O2M+CY99WJrzPa6AERa8qatW
X-Google-Smtp-Source: AGHT+IErWvFQEf2jiK9SRXlOED5yG6nPGlIzASYigX17RzzHW049azXXIEUSdWnJ+MCGtT3N32fXmA==
X-Received: by 2002:a05:600c:4ecb:b0:42c:ae76:6cea with SMTP id 5b1f17b1804b1-42e7abe8455mr72712825e9.9.1727089207462;
        Mon, 23 Sep 2024 04:00:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e7afd7490sm97856615e9.28.2024.09.23.04.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:00:06 -0700 (PDT)
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
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH 0/4] block: partition table OF support
Date: Mon, 23 Sep 2024 12:59:29 +0200
Message-ID: <20240923105937.4374-1-ansuelsmth@gmail.com>
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

Christian Marangi (4):
  block: add support for defining read-only partitions
  docs: block: Document support for read-only partition in cmdline part
  block: add support for partition table defined in OF
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |  5 +-
 .../devicetree/bindings/mmc/mmc-card.yaml     | 75 ++++++++++++++++
 block/blk.h                                   |  1 +
 block/partitions/Kconfig                      |  8 ++
 block/partitions/Makefile                     |  1 +
 block/partitions/cmdline.c                    |  3 +
 block/partitions/core.c                       |  3 +
 block/partitions/of.c                         | 85 +++++++++++++++++++
 8 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 block/partitions/of.c

-- 
2.45.2

