Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143C1714A0
	for <linux-block@vger.kernel.org>; Mon, 30 Sep 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684088; cv=none; b=PXbtgpStsfPDO4fcPBtHdgLLyLgZqobZ9Omi7zj9q+SRppiqlhI6HlexMlFgCtR5MN4W6l5r2flO4Ic0DxJS0rxL/K5f927JrhXzGt+6L6Izxu9cNtdCQyTYEsu5w6x8wgNB4upAuNpO4TeKW0DHZketLPlGlF0luqKf3I1pxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684088; c=relaxed/simple;
	bh=Ceu/nVD+ZRhjdNGaopzqvLqPyVf9Z+iuNWVvvy/ZI78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJtE5LcMHOveA4Fy2kzHtbIUu5NEqYjTs7+G8GW7f+VueM7Q4xcl/bwLEqae39XB2gCsFRC0Io4fiu1f3P9HgRkfcBXV5msGP4ofsdZS7n99fo+qHxX4plfEyRxqq8YTVAu9rXByEM790W7nwQhlbIGQ8Fb1mf6FCLwlqawZ1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1svBY9-0007aq-P2; Mon, 30 Sep 2024 10:14:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1svBY3-002aWI-LV; Mon, 30 Sep 2024 10:14:27 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1svBY3-0030yV-1k;
	Mon, 30 Sep 2024 10:14:27 +0200
Date: Mon, 30 Sep 2024 10:14:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v3 3/4] block: add support for partition table defined in
 OF
Message-ID: <Zvpd48oOYletv7Ko@pengutronix.de>
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
 <20240929140713.6883-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929140713.6883-4-ansuelsmth@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

Hi Christian,

Thanks for working on this, it will be useful for me as well.
Some comments inside.

On Sun, Sep 29, 2024 at 04:06:19PM +0200, Christian Marangi wrote:
> Add support for partition table defined in Device Tree. Similar to how
> it's done with MTD, add support for defining a fixed partition table in
> device tree.
> 
> A common scenario for this is fixed block (eMMC) embedded devices that
> have no MBR or GPT partition table to save storage space. Bootloader
> access the block device with absolute address of data.
> 
> This is to complete the functionality with an equivalent implementation
> with providing partition table with bootargs, for case where the booargs
> can't be modified and tweaking the Device Tree is the only solution to
> have an usabe partition table.
> 
> The implementation follow the fixed-partitions parser used on MTD
> devices where a "partitions" node is expected to be declared with
> "fixed-partitions" compatible in the OF node of the disk device
> (mmc-card for eMMC for example) and each child node declare a label
> and a reg with offset and size. If label is not declared, the node name
> is used as fallback. Eventually is also possible to declare the read-only
> property to flag the partition as read-only.
> 
> For eMMC block, driver scan the disk name and check if it's suffixed with
> "boot0" or "boot1".
> This is to handle the additional disk provided by eMMC as supported in
> JEDEC 4.4+. If this suffix is detected, "partitions-boot0" or
> "partitions-boot1" are used instead of the generic "partitions" for the
> relevant disk.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  block/partitions/Kconfig  |   8 ++
>  block/partitions/Makefile |   1 +
>  block/partitions/check.h  |   1 +
>  block/partitions/core.c   |   3 +
>  block/partitions/of.c     | 151 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 164 insertions(+)
>  create mode 100644 block/partitions/of.c
> 
> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index 7aff4eb81c60..8534f7544f26 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -270,4 +270,12 @@ config CMDLINE_PARTITION
>  	  Say Y here if you want to read the partition table from bootargs.
>  	  The format for the command line is just like mtdparts.
>  
> +config OF_PARTITION
> +	bool "Command line partition support" if PARTITION_ADVANCED

Should be "device tree partition support".

> +	depends on OF
> +	help
> +	  Say Y here if you want to enable support for partition table
> +	  defined in Device Tree. (mainly for eMMC)
> +	  The format for the command line is just like MTD fixed-partition schema.
> +
>  endmenu

[...]

> diff --git a/block/partitions/of.c b/block/partitions/of.c
> new file mode 100644
> index 000000000000..bc6200eb86b3
> --- /dev/null
> +++ b/block/partitions/of.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/blkdev.h>
> +#include <linux/major.h>
> +#include <linux/of.h>
> +#include "check.h"
> +
> +#define BOOT0_STR	"boot0"
> +#define BOOT1_STR	"boot1"
> +
> +static struct device_node *get_partitions_node(struct device_node *disk_np,
> +					       struct gendisk *disk)
> +{
> +	const char *node_name = "partitions";
> +
> +	/*
> +	 * JEDEC specification 4.4 for eMMC introduced 3 additional partition
> +	 * present on every eMMC. These additional partition are always hardcoded
> +	 * from the eMMC driver as boot0, boot1 and rpmb. While rpmb is used to
> +	 * store keys and exposed as a char device, the other 2 are exposed as
> +	 * real separate disk with the boot0/1 appended to the disk name.
> +	 *
> +	 * Here we parse the disk_name in search for such suffix and select
> +	 * the correct partition node.
> +	 */
> +	if (disk->major == MMC_BLOCK_MAJOR) {
> +		const char *disk_name = disk->disk_name;
> +
> +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
> +			    BOOT0_STR, sizeof(BOOT0_STR)))
> +			node_name = "partitions-boot0";
> +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT1_STR),
> +			    BOOT1_STR, sizeof(BOOT1_STR)))
> +			node_name = "partitions-boot1";
> +	}
> +
> +	return of_get_child_by_name(disk_np, node_name);
> +}
> +
> +static int validate_of_partition(struct device_node *np, int slot)
> +{
> +	int a_cells, s_cells;
> +	const __be32 *reg;
> +	u64 offset, size;
> +	int len;
> +
> +	reg = of_get_property(np, "reg", &len);
> +
> +	a_cells = of_n_addr_cells(np);
> +	s_cells = of_n_size_cells(np);
> +

The corresponding mtd ofpart parser validates a_cells + s_cells against
len, like this:

	if (len / 4 != a_cells + s_cells) {
		pr_debug("%s: ofpart partition %pOF (%pOF) error parsing reg property.\n",
			 master->name, pp,
			 mtd_node);
		goto ofpart_fail;
	}

I think you should do it here as well.

> +	/*
> +	 * Validate offset conversion from bytes to sectors.
> +	 * Only the first partition is allowed to have offset 0.
> +	 */

Where is this constraint coming from? I would put the partitions in
order into the device tree as well, but the binding doesn't enforce it
and I see no reason to do so.

> +	offset = of_read_number(reg, a_cells);
> +	if (do_div(offset, SECTOR_SIZE) ||

How about (offset % SECTOR_SIZE) or (offset & (SECTOR_SIZE - 1))? Might
be a bit more intuitive to read.

> +	    (slot > 1 && !offset))
> +		return -EINVAL;
> +
> +	/* Validate size conversion from bytes to sectors */
> +	size = of_read_number(reg + a_cells, s_cells);
> +	if (do_div(size, SECTOR_SIZE) || !size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void add_of_partition(struct parsed_partitions *state, int slot,
> +			     struct device_node *np)
> +{
> +	struct partition_meta_info *info;
> +	char tmp[sizeof(info->volname) + 4];
> +	int a_cells, s_cells;
> +	const char *partname;
> +	const __be32 *reg;
> +	u64 offset, size;
> +	int len;
> +
> +	reg = of_get_property(np, "reg", &len);
> +
> +	a_cells = of_n_addr_cells(np);
> +	s_cells = of_n_size_cells(np);
> +
> +	/* Convert bytes to sector size */
> +	offset = of_read_number(reg, a_cells) / SECTOR_SIZE;
> +	size = of_read_number(reg + a_cells, s_cells) / SECTOR_SIZE;
> +
> +	put_partition(state, slot, offset, size);
> +
> +	if (of_property_read_bool(np, "read-only"))
> +		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
> +
> +	/*
> +	 * Follow MTD label logic, search for label property,
> +	 * fallback to node name if not found.
> +	 */
> +	info = &state->parts[slot].info;
> +	partname = of_get_property(np, "label", &len);
> +	if (!partname)
> +		partname = of_get_property(np, "name", &len);
> +	strscpy(info->volname, partname, sizeof(info->volname));
> +
> +	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
> +	strlcat(state->pp_buf, tmp, PAGE_SIZE);
> +}
> +
> +int of_partition(struct parsed_partitions *state)
> +{
> +	struct device_node *disk_np, *partitions_np, *np;
> +	struct device *ddev = disk_to_dev(state->disk);
> +	int slot;
> +
> +	disk_np = of_node_get(ddev->parent->of_node);
> +	if (!disk_np)
> +		return 0;
> +
> +	partitions_np = get_partitions_node(disk_np, state->disk);
> +	if (!partitions_np ||
> +	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
> +		return 0;

of_node_put(disk_np) missing here before return.

> +
> +	/* Check if child are over the limit */
> +	slot = of_get_child_count(partitions_np);
> +	if (slot >= state->limit)
> +		goto err;

Other partition parsers just silently ignore the partitions
exceeding state->limit instead of throwing an error. Maybe do the same
here?

> +
> +	slot = 1;
> +	/* Validate parition offset and size */
> +	for_each_child_of_node(partitions_np, np) {
> +		if (validate_of_partition(np, slot))
> +			goto err;
> +
> +		slot++;
> +	}
> +
> +	slot = 1;
> +	for_each_child_of_node(partitions_np, np) {
> +		add_of_partition(state, slot, np);
> +
> +		slot++;
> +	}
> +
> +	strlcat(state->pp_buf, "\n", PAGE_SIZE);
> +
> +	return 1;
> +err:
> +	of_node_put(partitions_np);
> +	of_node_put(disk_np);

You should put the nodes for the non error case as well.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
