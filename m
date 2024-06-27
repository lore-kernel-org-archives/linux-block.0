Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D64EB37;
	Thu, 27 Jun 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521429; cv=none; b=Iqs+ShZJWOU9NvMQfiq+KHA4RHwJD4mueQBmqZd2rHUXvf8lUWdOw6utg/uSlgtK45ptngSnx+ac4tRMDEqtcCGYpswRSM9LOwBTU5Ffs2lAFflecldSIwqYrQrCZjBybQfK9R7gOD0QiiKPLG2Rb6pi1j+T4wfTIjlp7P44KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521429; c=relaxed/simple;
	bh=QO4mqrMGBNCou1YAOdGtl/B4FJn9dLGZV/WpWr0/f7Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elQYTl9nNB8F3bnGs0ypfOdmKRHtdFktYqK91Kv0L88xoWcRXa9GxBcVPya+8r04IgS+DjvomRekcp7jjJ/Y/MjBkX2XwpAT2ipsOtyryDKwiltQZc09FrUl8UMaZ0YOPEc+QZ7SOqe/8HlVCxS5C7KIV+R0zN7IPOd3pOlC2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMw3u-000000007kJ-0D2F;
	Thu, 27 Jun 2024 20:49:46 +0000
Date: Thu, 27 Jun 2024 21:49:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
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
Subject: [PATCH v4 0/4] block: preparations for NVMEM provider
Message-ID: <cover.1719520771.git.daniel@makrotopia.org>
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

Typically the NVMEM framework is used to have kernel drivers read and
use binary data from EEPROMs, efuses, flash memory (MTD), ...

Using references to NVMEM bits in Device Tree allows the kernel to
access and apply e.g. the Ethernet MAC address, which can be a requirement
for userland to come up (e.g. for nfsroot).

The goal of this series is to prepare the block subsystem to allow for
the implementation of an NVMEM provider similar to other types of
non-volatile storage, so the same approach already used for EEPROMs, MTD
(raw flashes) and UBI-managed NAND can also be used for devices storing
those bits on an eMMC.

Define a device tree schema for block devices and partitions on them,
which (similar to how it now works also for UBI volumes) can be matched
by one or more properties.

Also add a simple notification API for other subsystems to be notified
about additions and removals of block devices, which is going to be used
by the block-backed NVMEM provider.

Overall, this enables uniform handling across practially all flash
storage types used for this purpose (MTD, UBI, and soon also MMC or and
in future maybe also other block devices).
---
Changes since v3 sent on Jun 26th, addressing comments from Jens Axboe:
 - improve readability and error-handling in fwnode-matching code
 - remove forgotten code from earlier development accessing ddev->parent
 - use '#if defined' instead of '#ifdef' in header
 - provide inline dummies in case of CONFIG_BLOCK_NOTIFIERS not being set

Changes since v2 sent on May 30th 2024 [1] addressing comments from
Hauke Mehrtens (https://patchwork.kernel.org/comment/25892133/)
 - Check length of UUID and PARTNAME.
 - Remove forgotten fallback to get 'partitions' subnode from parent.
   It is no longer needed and was a left over from earlier development.
 - Split series into 3 parts, one for each affected subsystem. This is
   the first part covering only the changes needed in the block
   subsystem. The second part adds the actual nvmem provider to
   drivers/nvmem/, the third part is going to make use of it for MMC
   block devices and cover changes in drivers/mmc.

Changes since v1 sent on March 21st 2024 [2]:
 - introduce notifications for block device addition and removal for
   in-kernel users. This allows the nvmem driver to be built as a module
   and avoids using class_interface and block subsystem internals as
   suggested in https://patchwork.kernel.org/comment/25771998/ and
   https://patchwork.kernel.org/comment/25770441/

This series has previously been submitted as RFC on July 19th 2023[3]
and most of the basic idea did not change since. Another round of RFC
was submitted on March 5th 2024[4].

[1]: https://patchwork.kernel.org/project/linux-block/list/?series=857192
[2]: https://patchwork.kernel.org/project/linux-block/list/?series=837150&archive=both
[3]: https://patchwork.kernel.org/project/linux-block/list/?series=767565
[4]: https://patchwork.kernel.org/project/linux-block/list/?series=832705


Daniel Golle (4):
  dt-bindings: block: add basic bindings for block devices
  block: partitions: populate fwnode
  block: add support for notifications
  block: add new genhd flag GENHD_FL_NVMEM

 .../bindings/block/block-device.yaml          | 22 +++++
 .../devicetree/bindings/block/partition.yaml  | 51 +++++++++++
 .../devicetree/bindings/block/partitions.yaml | 20 +++++
 block/Kconfig                                 |  6 ++
 block/Makefile                                |  1 +
 block/blk-notify.c                            | 87 +++++++++++++++++++
 block/partitions/core.c                       | 70 +++++++++++++++
 include/linux/blkdev.h                        | 13 +++
 8 files changed, 270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml
 create mode 100644 block/blk-notify.c

-- 
2.45.2
