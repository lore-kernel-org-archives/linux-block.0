Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758F2F22;
	Wed,  2 Oct 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907225; cv=none; b=Q9mL19TMlH7X4dL6uRv03TfLCCcvSmLz3ii29+65xCuz825p8by/c55hn8qt4cZ+2HqgiiVVoRFYjcUN0O+2zmckry+7TGD2GswjFKV1mDAyc3uknhCNSQbU9kxm5sHqKBxLidNiD3zdaGSsALYgUTaJMK+vxh6kUYRiGiI74+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907225; c=relaxed/simple;
	bh=/vSxzzdnxtM0HOi6z5vD6IUAh4pVhAXIgMFytU3+dMM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bH58qCid/0rYQlWynzXdjcRly9Ug6eDNHDXl43u6gqgrOBCSVH7wLV7bXSRka1bwMKt+8zxqLH1ofHBDFm5Z1KKsU6z2gdfHPb55LQl9XHaRQPET5ZBa+eNIW/H4TvlJ65XvHG228H8HbRg4XiYHnz+m+wEftCvbCUuIyXbHQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK2c/sZ7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK2c/sZ7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso2798215e9.2;
        Wed, 02 Oct 2024 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907221; x=1728512021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0S2HFaO2ayyfhdvTGH+PY+VatOA3lIK5x/wfc5GpFA=;
        b=PK2c/sZ7bVrg6CHZy1EVX+DDQUAWllGb9l5rYkZDuzYeim41vMsQTg9iUOyuB811ow
         5K+cAANeyll+tyb4D6sVuBDXxvgFPozneQmvm2FVNR/U+2+lGVwT/YSatn9LuW/7jxqp
         80QtfL2awFiBg+B+9t6qwbe9N0dKtrk1Pw7pKb1SABLuDiYLMtRQk+etPhXR7mE371LF
         u0ptAgzti3oFe+0v0j+hAkuh+agGsPVz2YbVcRNqtsdRTtSHS1mDQKiXg691YDSoApdn
         KyhNylJ+VrPDblYS51ZwXjA/+i2GIPeIfHZXw6/aCjMhb5D0LPEZk96BbtJJDPB0/Jo2
         iwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907221; x=1728512021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0S2HFaO2ayyfhdvTGH+PY+VatOA3lIK5x/wfc5GpFA=;
        b=Ek0tFWmTKrEGomg2VLY6A/X3724E3bBDPSFSyqwszbGjVSVM0EhybdIsi/ULYVf93B
         edlkUxjQ7E5SDWbP5c7zn+Bgtq/eDTYSQ2rsATpWQnA9J9HFx6lWwAYUNCfrJIMLeFH5
         2l7na3ex7jeeVQyA6iYEyzeDI3T9uo2166iTi9sththqqe2l+jJw0D8RVW8txMdhtcDh
         mfV0KTtU5YGA3KcoG2SzXxj5Q1sNrNV8m5AFMkAju0RGNvqZYzDMjpC/RhvXj0SdPacR
         gmvh8IN9ireBXZM6VArKN1Xo0Gjt5YyxymRKX8myZt3FSZIn+X9vha1xCbESqqmoaDzN
         dvYw==
X-Forwarded-Encrypted: i=1; AJvYcCVhCqsaTT70MxW6SQYUDM6lq71UHaKdCIglQwLzq8zx1KChvtNGX0OehI6gGcoDjIzFgHAjlaDLVa1E@vger.kernel.org, AJvYcCVt17GHGxKfDhiyo/m2fZteQhiKPKQ76eXU8iUbNRBpGC3RevCcbBtuL3efCXkZZstaYqJa7TUkHbzY@vger.kernel.org, AJvYcCWUhBpzR/nowH1s9s4J+YFXqZT8e0TIIZnmB/RHh7Ci/jS9z8UzkMKxmOB7cpwsEmEsb/kQ1Jljn/Xg@vger.kernel.org, AJvYcCWVJDNb2az9Wb9jYaDyt3uAMdxjtlO55CyQCE0Rr03I+ExMuWUBgrfDhMGeyRGkqj19onE3h0Mh/gWpm14k@vger.kernel.org, AJvYcCXOFVHy3KOUCwywYkurz68LyHOCjUdwUsBvhA3rMnGc2kE+hqcHgvSZyxpMrOAz7MNeOGsC0283InXspOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrk8GZnqGgm5XEsGgm/f9oVNaWoM/nMSQts55iZHlHiVCece4W
	RdgmcnIbSfzSjLND11m2eD35KDxM2Iv3Wh3HWMjyXWdweYTOSj18
X-Google-Smtp-Source: AGHT+IGnm4XY5ZYU87xjpGoupm9OuMzZZrmfG2JaiUPs9J7pC5TIWa2/V5qZHM8+eoZ8IoUMiX/nAQ==
X-Received: by 2002:a05:600c:1c1e:b0:42c:bd5a:9455 with SMTP id 5b1f17b1804b1-42f777c3654mr42745285e9.18.1727907221100;
        Wed, 02 Oct 2024 15:13:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:39 -0700 (PDT)
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
Subject: [PATCH v6 0/6] block: partition table OF support
Date: Thu,  3 Oct 2024 00:11:40 +0200
Message-ID: <20241002221306.4403-1-ansuelsmth@gmail.com>
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

Changes v6:
- Rename device_add_of_disk() to add_disk_fwnode()
- Add kdocs for add_disk_fwnode()
- Improve variables order in OF block partition code
- Add Reviewed-by tag
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
  block: introduce add_disk_fwnode()
  mmc: block: attach partitions fwnode if found in mmc-card
  block: add support for partition table defined in OF
  dt-bindings: mmc: Document support for partition table in mmc-card

 Documentation/block/cmdline-partition.rst     |   5 +-
 .../devicetree/bindings/mmc/mmc-card.yaml     |  52 +++++++++
 block/blk.h                                   |   1 +
 block/genhd.c                                 |  28 ++++-
 block/partitions/Kconfig                      |   9 ++
 block/partitions/Makefile                     |   1 +
 block/partitions/check.h                      |   1 +
 block/partitions/cmdline.c                    |   3 +
 block/partitions/core.c                       |   6 +
 block/partitions/of.c                         | 110 ++++++++++++++++++
 drivers/mmc/core/block.c                      |  55 ++++++++-
 include/linux/blkdev.h                        |   3 +
 12 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100644 block/partitions/of.c

-- 
2.45.2

