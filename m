Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6121105;
	Mon, 30 Sep 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691707; cv=none; b=Ym6GUHJSFkQ5OEQyiB03ojPvPWDfZ/QTpynfs2R45Poz3oW/+wbypyEbqa8PHq+1SSfP8hGUcyqIdo3vWQAZpTKTTEghw8qan5IHxM+0ZsxOM//nRB9GIlyJhPwLlJdNMfIhHKaISZjtg3emiXmnxXlae481lxT4MIi3LXVkrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691707; c=relaxed/simple;
	bh=s1nABlC6VoIzuxImvl5KvjJPRPxfq/8aAumnJsCyWx4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxX0xcXv1GIy23hsw59kmR0Qgb0xeVF9fPUBKyq2j4whiKGq2JKF/Cq8GSCpRbQZM2Kel779f24YK8WIdOFYRngbjvxbjMssbtA5kkbQWdRpn4SqWVmN1Wc6qar6bakoIsDP6ELdaUEzphlO/StyttxWACBS43hJhfpetaLrVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsGq1bFY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsGq1bFY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cafda818aso40143895e9.2;
        Mon, 30 Sep 2024 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691703; x=1728296503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e1ty5pIk+oIg+yfM6En9ullK2BdDadhpV6rFAeaR270=;
        b=OsGq1bFYgqmTUOjb/C8fsNzvCqpOMCURbLZ8ffZMW9XDQbRLc5vkN18mtiiBfE5o4L
         qEmCecgyMMvs/nFgj/poV4oBhOGVsy7xXkSK6DXST7ji6pz94C3BMDPvDjXLH6MbwE69
         HwmlHb5sQzgN3aAfk3pVNDe4YnEhVKNa/6j8vlnC8BRu1/FailNwS0toa6VLRhEVj2HH
         dj1ifOv3eAct6JgcNKevtdjwGWI2a29v9aVsd66GnvVKEqv85Peiy7AAUlRomSzkHTIK
         dlRbQFeLioxFL6pFI1BnCORaP3ik5iSA9n4Ca7lsM3Esf4wMDBEbkyYHS+soT9eakwj0
         xNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691703; x=1728296503;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1ty5pIk+oIg+yfM6En9ullK2BdDadhpV6rFAeaR270=;
        b=r6XvnY49J53VKjlAX2fekiHaJtbvrBAYg/Wbo/qAxm1/6yg0ORJIWBnb9V38x5WKmU
         zXeg5tH9Gg0YDtM7ncYk2YIbn1sEJnmDDa6oR0iyFP7hvJfJFDfltK2TvjWnAIQ97Uzb
         mSrU69Asi2HY80SCnBTMu0eALNtQklaF0EfvhuyCKB1UynytWkMkFjE/eCBp5ncTjeJ5
         z8OW1o3eFTs9Z2F84lmJ/YmAaZD50MyRFcYlLOz6NjLTLShPotp+1ObAMzHr2nBQl+5V
         1xOOa8Y4LPABYmDLm50/ZpJZNz3ZllkNlkvbRx7gM3pQjG570/kLnA0umDYIX/mHcGed
         Fgbw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ye4K/4DpIWC+0RvFqQrAE9agUygxBQMNyxiCMxhzBZcDlMXyfjojRsXo+49TlJIAVqQZyHrIVhmJ@vger.kernel.org, AJvYcCU5gEGpjDSGeMs90YFOmEC+1Q8D4M2V3DjpwGV7hsAKqvYw0lTx6YffivPFmOSVkc2wOpFeaDENMcXE@vger.kernel.org, AJvYcCUh6esPCU6/yX0Kcd7t68GtPBIhoRtOcSqhaEN2TCBl6o9Xr6twpbgHePKS/bx4Zj8fW+auxhJ589WHQgXN@vger.kernel.org, AJvYcCUsb9G0M28GKrjLuEe9MmHl12IrzrDT9MaGEwgD6UQwocYE6YYvrJx++1iJdMcBdxxAZv0xsir38EM1@vger.kernel.org, AJvYcCWO2684CqQHvtXiZhI9fGxXPnxH6W6PdtAy7A01ge6YIspDI+XQH+qpEXqoKeDgJdeucxfVLH61d7a4/Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSfDHSUxYQm65pHBt8SPXxkJy6bZndCrdQbAz/fmXLIB1pXtr
	8RdqNfzp7DtcicGFoQJUsBKpokbQM9hb3iQstJG8m4bBHXZMiQ7J
X-Google-Smtp-Source: AGHT+IFcMNiBxoJLFefp3RHNAM+ysXKbWQ8pSr0I++Vxp8TOI03DlajGb6rdIvwmvCY7iesDvMNFZw==
X-Received: by 2002:a05:6000:10cd:b0:37c:cec2:23c6 with SMTP id ffacd0b85a97d-37cd5b2d54fmr5115987f8f.57.1727691703301;
        Mon, 30 Sep 2024 03:21:43 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e21dsm8684448f8f.33.2024.09.30.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:21:42 -0700 (PDT)
Message-ID: <66fa7bb6.5d0a0220.2dcbde.bf69@mx.google.com>
X-Google-Original-Message-ID: <Zvp7r_Mml0zcmkcH@Ansuel-XPS.>
Date: Mon, 30 Sep 2024 12:21:35 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
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
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
 <20240929140713.6883-4-ansuelsmth@gmail.com>
 <Zvpd48oOYletv7Ko@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvpd48oOYletv7Ko@pengutronix.de>

On Mon, Sep 30, 2024 at 10:14:27AM +0200, Sascha Hauer wrote:
> Hi Christian,
> 
> Thanks for working on this, it will be useful for me as well.
> Some comments inside.
> 
> On Sun, Sep 29, 2024 at 04:06:19PM +0200, Christian Marangi wrote:
> > Add support for partition table defined in Device Tree. Similar to how
> > it's done with MTD, add support for defining a fixed partition table in
> > device tree.
> > 
> > A common scenario for this is fixed block (eMMC) embedded devices that
> > have no MBR or GPT partition table to save storage space. Bootloader
> > access the block device with absolute address of data.
> > 
> > This is to complete the functionality with an equivalent implementation
> > with providing partition table with bootargs, for case where the booargs
> > can't be modified and tweaking the Device Tree is the only solution to
> > have an usabe partition table.
> > 
> > The implementation follow the fixed-partitions parser used on MTD
> > devices where a "partitions" node is expected to be declared with
> > "fixed-partitions" compatible in the OF node of the disk device
> > (mmc-card for eMMC for example) and each child node declare a label
> > and a reg with offset and size. If label is not declared, the node name
> > is used as fallback. Eventually is also possible to declare the read-only
> > property to flag the partition as read-only.
> > 
> > For eMMC block, driver scan the disk name and check if it's suffixed with
> > "boot0" or "boot1".
> > This is to handle the additional disk provided by eMMC as supported in
> > JEDEC 4.4+. If this suffix is detected, "partitions-boot0" or
> > "partitions-boot1" are used instead of the generic "partitions" for the
> > relevant disk.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  block/partitions/Kconfig  |   8 ++
> >  block/partitions/Makefile |   1 +
> >  block/partitions/check.h  |   1 +
> >  block/partitions/core.c   |   3 +
> >  block/partitions/of.c     | 151 ++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 164 insertions(+)
> >  create mode 100644 block/partitions/of.c
> > 
> > diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> > index 7aff4eb81c60..8534f7544f26 100644
> > --- a/block/partitions/Kconfig
> > +++ b/block/partitions/Kconfig
> > @@ -270,4 +270,12 @@ config CMDLINE_PARTITION
> >  	  Say Y here if you want to read the partition table from bootargs.
> >  	  The format for the command line is just like mtdparts.
> >  
> > +config OF_PARTITION
> > +	bool "Command line partition support" if PARTITION_ADVANCED
> 
> Should be "device tree partition support".
> 
> > +	depends on OF
> > +	help
> > +	  Say Y here if you want to enable support for partition table
> > +	  defined in Device Tree. (mainly for eMMC)
> > +	  The format for the command line is just like MTD fixed-partition schema.
> > +
> >  endmenu
> 
> [...]
> 
> > diff --git a/block/partitions/of.c b/block/partitions/of.c
> > new file mode 100644
> > index 000000000000..bc6200eb86b3
> > --- /dev/null
> > +++ b/block/partitions/of.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/blkdev.h>
> > +#include <linux/major.h>
> > +#include <linux/of.h>
> > +#include "check.h"
> > +
> > +#define BOOT0_STR	"boot0"
> > +#define BOOT1_STR	"boot1"
> > +
> > +static struct device_node *get_partitions_node(struct device_node *disk_np,
> > +					       struct gendisk *disk)
> > +{
> > +	const char *node_name = "partitions";
> > +
> > +	/*
> > +	 * JEDEC specification 4.4 for eMMC introduced 3 additional partition
> > +	 * present on every eMMC. These additional partition are always hardcoded
> > +	 * from the eMMC driver as boot0, boot1 and rpmb. While rpmb is used to
> > +	 * store keys and exposed as a char device, the other 2 are exposed as
> > +	 * real separate disk with the boot0/1 appended to the disk name.
> > +	 *
> > +	 * Here we parse the disk_name in search for such suffix and select
> > +	 * the correct partition node.
> > +	 */
> > +	if (disk->major == MMC_BLOCK_MAJOR) {
> > +		const char *disk_name = disk->disk_name;
> > +
> > +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
> > +			    BOOT0_STR, sizeof(BOOT0_STR)))
> > +			node_name = "partitions-boot0";
> > +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT1_STR),
> > +			    BOOT1_STR, sizeof(BOOT1_STR)))
> > +			node_name = "partitions-boot1";
> > +	}
> > +
> > +	return of_get_child_by_name(disk_np, node_name);
> > +}
> > +
> > +static int validate_of_partition(struct device_node *np, int slot)
> > +{
> > +	int a_cells, s_cells;
> > +	const __be32 *reg;
> > +	u64 offset, size;
> > +	int len;
> > +
> > +	reg = of_get_property(np, "reg", &len);
> > +
> > +	a_cells = of_n_addr_cells(np);
> > +	s_cells = of_n_size_cells(np);
> > +
> 
> The corresponding mtd ofpart parser validates a_cells + s_cells against
> len, like this:
> 
> 	if (len / 4 != a_cells + s_cells) {
> 		pr_debug("%s: ofpart partition %pOF (%pOF) error parsing reg property.\n",
> 			 master->name, pp,
> 			 mtd_node);
> 		goto ofpart_fail;
> 	}
> 
> I think you should do it here as well.
> 
> > +	/*
> > +	 * Validate offset conversion from bytes to sectors.
> > +	 * Only the first partition is allowed to have offset 0.
> > +	 */
> 
> Where is this constraint coming from? I would put the partitions in
> order into the device tree as well, but the binding doesn't enforce it
> and I see no reason to do so.
>

It's to handle case where offset is 0. But I think I can just check the
value on validation.

> > +	offset = of_read_number(reg, a_cells);
> > +	if (do_div(offset, SECTOR_SIZE) ||
> 
> How about (offset % SECTOR_SIZE) or (offset & (SECTOR_SIZE - 1))? Might
> be a bit more intuitive to read.
> 

do_div was useful to check the result of the division at the same time
but now that I think about it, it's not really needed. Checking the % of
the devision is enough to validate the value are alligned to 512bytes.

> > +	    (slot > 1 && !offset))
> > +		return -EINVAL;
> > +
> > +	/* Validate size conversion from bytes to sectors */
> > +	size = of_read_number(reg + a_cells, s_cells);
> > +	if (do_div(size, SECTOR_SIZE) || !size)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static void add_of_partition(struct parsed_partitions *state, int slot,
> > +			     struct device_node *np)
> > +{
> > +	struct partition_meta_info *info;
> > +	char tmp[sizeof(info->volname) + 4];
> > +	int a_cells, s_cells;
> > +	const char *partname;
> > +	const __be32 *reg;
> > +	u64 offset, size;
> > +	int len;
> > +
> > +	reg = of_get_property(np, "reg", &len);
> > +
> > +	a_cells = of_n_addr_cells(np);
> > +	s_cells = of_n_size_cells(np);
> > +
> > +	/* Convert bytes to sector size */
> > +	offset = of_read_number(reg, a_cells) / SECTOR_SIZE;
> > +	size = of_read_number(reg + a_cells, s_cells) / SECTOR_SIZE;
> > +
> > +	put_partition(state, slot, offset, size);
> > +
> > +	if (of_property_read_bool(np, "read-only"))
> > +		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
> > +
> > +	/*
> > +	 * Follow MTD label logic, search for label property,
> > +	 * fallback to node name if not found.
> > +	 */
> > +	info = &state->parts[slot].info;
> > +	partname = of_get_property(np, "label", &len);
> > +	if (!partname)
> > +		partname = of_get_property(np, "name", &len);
> > +	strscpy(info->volname, partname, sizeof(info->volname));
> > +
> > +	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
> > +	strlcat(state->pp_buf, tmp, PAGE_SIZE);
> > +}
> > +
> > +int of_partition(struct parsed_partitions *state)
> > +{
> > +	struct device_node *disk_np, *partitions_np, *np;
> > +	struct device *ddev = disk_to_dev(state->disk);
> > +	int slot;
> > +
> > +	disk_np = of_node_get(ddev->parent->of_node);
> > +	if (!disk_np)
> > +		return 0;
> > +
> > +	partitions_np = get_partitions_node(disk_np, state->disk);
> > +	if (!partitions_np ||
> > +	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
> > +		return 0;
> 
> of_node_put(disk_np) missing here before return.
> 

Thjanks forgot about it when I added the compatible check.

> > +
> > +	/* Check if child are over the limit */
> > +	slot = of_get_child_count(partitions_np);
> > +	if (slot >= state->limit)
> > +		goto err;
> 
> Other partition parsers just silently ignore the partitions
> exceeding state->limit instead of throwing an error. Maybe do the same
> here?
> 

Ehhh I didn't understand if this is correct or not. Ok I will follow how
it's done by the other.

> > +
> > +	slot = 1;
> > +	/* Validate parition offset and size */
> > +	for_each_child_of_node(partitions_np, np) {
> > +		if (validate_of_partition(np, slot))
> > +			goto err;
> > +
> > +		slot++;
> > +	}
> > +
> > +	slot = 1;
> > +	for_each_child_of_node(partitions_np, np) {
> > +		add_of_partition(state, slot, np);
> > +
> > +		slot++;
> > +	}
> > +
> > +	strlcat(state->pp_buf, "\n", PAGE_SIZE);
> > +
> > +	return 1;
> > +err:
> > +	of_node_put(partitions_np);
> > +	of_node_put(disk_np);
> 
> You should put the nodes for the non error case as well.
> 

ack.

-- 
	Ansuel
