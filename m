Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215B1F4276
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397733; cv=none; b=NNt4kP7tX+Lcpr3Eu8zEL669jAEJNrVSwIyXFPjhfqfDi/WsK7OZ5lCNSWbR+Snk18WnS13o4zk9xXwBfefSJf7+PXO0syyLT3j/U+uLpS1duPdq11pyUJihQnrMBW/icVmm31EE5HVYfQjTZiJXOEf8PWupJHIw1GM9if/aTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397733; c=relaxed/simple;
	bh=z7QzahvsUpDUq/hh1dmI3rNNlgN7khulvlUbO6WYo3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oinqQONvI0r5d/l0AVij4/7nOoZ0yIqGKUB+89ITBLup4IzI9x198xI9Dj4TvQKns9LG9FDu++aHLCRQujdPxot49/nK1Ykj94G/juDoHlxvGuYT3Pq59UukTyBrtUi4AMgRtGLN1SQeYr8L8zB6TCSgadfNOmO35pncAAxB+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tJ9vK-0008Qw-3k; Thu, 05 Dec 2024 12:21:34 +0100
Message-ID: <5e9a80d6-6c89-478e-99c9-584647661f5e@pengutronix.de>
Date: Thu, 5 Dec 2024 12:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Co-existence of GPT and fixed partitions (Was: Re: [PATCH v6 5/6]
 block: add support for partition table defined in OF)
To: Christian Marangi <ansuelsmth@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 INAGAKI Hiroshi <musashino.open@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Riyan Dhiman <riyandhiman14@gmail.com>,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian
 <lizhijian@fujitsu.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com,
 Christoph Hellwig <hch@infradead.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <20241002221306.4403-6-ansuelsmth@gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241002221306.4403-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

Hi,

sorry for not writing sooner. I only noticed this now.

On 03.10.24 00:11, Christian Marangi wrote:
> Add support for partition table defined in Device Tree. Similar to how
> it's done with MTD, add support for defining a fixed partition table in
> device tree.
> 
> A common scenario for this is fixed block (eMMC) embedded devices that
> have no MBR or GPT partition table to save storage space. Bootloader
> access the block device with absolute address of data.

How common are these? I never worked with a system that didn't use MBR
or GPT for the user partition.

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

barebox has for many years supported defining fixed partitions on SD/MMC
nodes and it's used heavily to define e.g. the location of the barebox
environment. Many who do so, do this either before the first partition
of the MBR/GPT or overlay the fixed partition to be identical to
an existing MBR/GPT partition.

barebox also by default copies all fixed partitions it is aware of
into the kernel DT, so if the kernel now stops parsing GPT/MBR when
a fixed partition node is defined, this would break compatibility of
existing barebox-booting systems with new kernels.

> +config OF_PARTITION
> +	bool "Device Tree partition support" if PARTITION_ADVANCED
> +	depends on OF
> +	help
> +	  Say Y here if you want to enable support for partition table
> +	  defined in Device Tree. (mainly for eMMC)
> +	  The format for the device tree node is just like MTD fixed-partition
> +	  schema.

Thanks for making this configurable and disabled by default, so users
won't experience breakage if they just do a make olddefconfig.

> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index abad6c83db8f..dc21734b00ec 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -43,6 +43,9 @@ static int (*const check_part[])(struct parsed_partitions *) = {
>  #ifdef CONFIG_CMDLINE_PARTITION
>  	cmdline_partition,
>  #endif
> +#ifdef CONFIG_OF_PARTITION
> +	of_partition,		/* cmdline have priority to OF */
> +#endif
>  #ifdef CONFIG_EFI_PARTITION
>  	efi_partition,		/* this must come before msdos */
>  #endif

If I understand correctly, it's possible to have both partitions-boot1 and
a GPT on the user area with your patch, right?

So this only leaves the matter of dealing with both fixed-partitions and
GPT for the same device node.

What are the thoughts on this? An easy way out would be to make of_partition
come later than efi_partition/mbr_partition, but I think it would be
nice if the kernel could consume partition info out of both of_partition
and efi_partition as long they don't collide.

Thanks,
Ahmad



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
