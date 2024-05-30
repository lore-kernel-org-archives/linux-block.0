Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED018040;
	Thu, 30 May 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035227; cv=none; b=DbRQYTRr9g/zNaiY7M+emlf0+RWCTockkgY73taENR48wbeol/nX9g+RJvlWdbXfdyy+82GLiV2z9wxc4vje1gILOb6OVfkRLraQXvhxIgdEngl6MfIhgVb/OV2bprR5KI6D762/h4s/FM3B9G1fNdX4nDWk1xWq0RCNvp7Iiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035227; c=relaxed/simple;
	bh=i6vBjYMdFnnLJpM5QWR1zTf8u6cNKoHy8dOt9MG9lIA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PhG3xWXxNvwOB8y71AklSUge3nJBqFj6zCNyeos8haJ6QLgNMlX0XhnhtGsSyG5uP0EvvefoVJQwuxyks8PQQ5sOct4qJuxu0oxc0346IxFpth3nGAw/5IIa1qH6HW1xWN7ncGPU0L44pEW7qMEDzK2kRPpPcokab8ztvv2Eris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVHr-000000004cn-1BZJ;
	Thu, 30 May 2024 02:13:03 +0000
Date: Thu, 30 May 2024 03:12:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2 0/9] nvmem: implement block NVMEM provider
Message-ID: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On embedded devices using an eMMC it is common that one or more (hw/sw)
partitions on the eMMC are used to store MAC addresses and Wi-Fi
calibration EEPROM data.

Implement an NVMEM provider backed by a block device as typically the
NVMEM framework is used to have kernel drivers read and use binary data
from EEPROMs, efuses, flash memory (MTD), ...

In order to be able to reference hardware partitions on an eMMC, add code
to bind each hardware partition to a specific firmware subnode.

Overall, this enables uniform handling across practially all flash
storage types used for this purpose (MTD, UBI, and now also MMC or and in
future may also other block devices).

As part of this series it was necessary to define a device tree schema
for block devices and partitions on them, which (similar to how it now
works also for UBI volumes) can be matched by one or more properties.

---
This series has previously been submitted as RFC on July 19th 2023[1]
and most of the basic idea did not change since. Another round of RFC
was submitted on March 5th 2024[2].

Changes since v1 sent on March 21st 2024 [3]:
 - introduce notifications for block device addition and removal for
   in-kernel users. This allows the nvmem driver to be built as a module
   and avoids using class_interface and block subsystem internals as
   suggested in https://patchwork.kernel.org/comment/25771998/ and
   https://patchwork.kernel.org/comment/25770441/

[1]: https://patchwork.kernel.org/project/linux-block/list/?series=767565
[2]: https://patchwork.kernel.org/project/linux-block/list/?series=832705
[3]: https://patchwork.kernel.org/project/linux-block/list/?series=837150&archive=both

Daniel Golle (9):
  dt-bindings: block: add basic bindings for block devices
  block: partitions: populate fwnode
  block: add support for notifications
  block: add new genhd flag GENHD_FL_NVMEM
  nvmem: implement block NVMEM provider
  dt-bindings: mmc: mmc-card: add block device nodes
  mmc: core: set card fwnode_handle
  mmc: block: set fwnode of disk devices
  mmc: block: set GENHD_FL_NVMEM

 .../bindings/block/block-device.yaml          |  22 ++
 .../devicetree/bindings/block/partition.yaml  |  51 +++++
 .../devicetree/bindings/block/partitions.yaml |  20 ++
 .../devicetree/bindings/mmc/mmc-card.yaml     |  45 ++++
 block/Kconfig                                 |   6 +
 block/Makefile                                |   1 +
 block/blk-notify.c                            |  88 ++++++++
 block/partitions/core.c                       |  41 ++++
 drivers/mmc/core/block.c                      |   8 +
 drivers/mmc/core/bus.c                        |   2 +
 drivers/nvmem/Kconfig                         |  11 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/block.c                         | 198 ++++++++++++++++++
 include/linux/blkdev.h                        |  10 +
 14 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml
 create mode 100644 block/blk-notify.c
 create mode 100644 drivers/nvmem/block.c

-- 
2.45.1
