Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5D41A84;
	Mon, 30 Sep 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700855; cv=none; b=soh33BE2WzbbvxLVajoKHs9WyS0F8dqlKyNP1hWohzEDIH8RSmQTpWHUSY6H6Zvwffjg8/1a9eiSWoLkBp8R8uOIDGHOwH7BTnYXD9unEPhcUf2ZYUJPVzIzXwqZVVLjXHl5Oheq1mDB1Rln9Tmq85nLI7UjDQ80t1d7n9ylJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700855; c=relaxed/simple;
	bh=JbymPE1wAX7oLNeBnVW/EsUQEOcGrDy36SdgxsVK40U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJg0RCzLbt8ejyp2Isv2EILjX1upHDM6rQy2X930aRjzIQfuW4rHwOp83dP/hpUC/HUB+9Oe+0cQty5ibd7EeHybM4mohUhcxJCxHKw8RfYliWFIQkXmlOcExwPQaCWhwwY/xzmbMTwpstxCbkwlF/RZnvBB8kMGRn56z2nJw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4Cl5IOWHSYOx9akl6V4CHA==
X-CSE-MsgGUID: hwDgEIaLTJqGqWNTZ8J5EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26946175"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26946175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:54:13 -0700
X-CSE-ConnectionGUID: UFrOowHtT9C1RadabsDP0w==
X-CSE-MsgGUID: YC01WcDRQtugj8jMJbQ4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72963878"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:54:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1svFue-0000000EfCj-3mlL;
	Mon, 30 Sep 2024 15:54:04 +0300
Date: Mon, 30 Sep 2024 15:54:04 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v4 0/5] block: partition table OF support
Message-ID: <ZvqfbNDfI2QWZEBg@smile.fi.intel.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 30, 2024 at 01:30:07PM +0200, Christian Marangi wrote:
> Hi,
> this is an initial proposal to complete support for manually defining
> partition table.
> 
> Some background on this. Many OEM on embedded device (modem, router...)
> are starting to migrate from NOR/NAND flash to eMMC. The reason for this
> is that OEM are starting to require more and more space for the firmware
> and price difference is becoming so little that using eMMC is only benefits
> and no cons.
> 
> Given these reason, OEM are also using very custom way to provide a
> partition table and doesn't relay on common method like writing a table
> on the eMMC.
> 
> One way that is commonly used is to hardcode the partition table and
> pass it to the system via various way (cmdline, special glue driver,
> block2mtd...)
> This way is also used on Android where the partition table
> is passed from the bootloader via cmdline.
> 
> One reason to use this method is to save space on the device and to
> permit more flexibility on partition handling.
> 
> What this series does is complete support for this feature.
> It's possible to use the cmdline to define a partition table similar
> to how it's done for MTD but this is problematic for a number of device
> where tweaking the cmdline is not possible. This series adds OF support
> to make it possible to define a partition table in the Device Tree.
> 
> We implement a similar schema to the MTD fixed-partition, where we define
> a "label" and a "reg" with "offset" and "size".
> 
> A new block partition parser is introduced that check if the block device
> have an OF node attached and check if a fixed-partition table is defined.
> 
> If a correct node is found, then partition table is filled. cmdline will
> still have priority to this new parser.
> 
> Some block device also implement boot1 and boot2 additional disk. Similar
> to the cmdline parser, these disk can have OF support using the
> "partitions-boot0" and "partitions-boot1" additional node.
> 
> It's also completed support for declaring partition as read-only as this
> feature was introduced but never finished in the cmdline parser.


I'm not sure I fully understood the problem you are trying to solve.
I have a device at hand that uses eMMC (and was produced almost ten years ago).
This device has a regular GPT on eMMC and no kernel needs to be patched for that.
So, why is it a problem for the mentioned OEMs to use standard GPT approach?

-- 
With Best Regards,
Andy Shevchenko


