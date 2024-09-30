Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F218DF76;
	Mon, 30 Sep 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700563; cv=none; b=Gz+xUnvAWtHKLDQfeLVh7SBHjIdZmzCk9wEGvNeZanDD1hfsKRJrfAKox6XCEHnOkjvOJBuKl6LWIUKsJGnUtSFQJFcC1ozeQ5ESXHjNy3TakY28kx/GYv9thIjlwJcqWO6LiYmiPFrhw600ClE/Gkw+qCkjvAGZuo2ZDkREWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700563; c=relaxed/simple;
	bh=F/U0sRoJdr4E2hz881oUVHvIf/z2huLNVCZMePykZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gArUFO0QSRqxkg0HN4+VEAzkkx1Q5UlZI48YvMchghsFQMVMuY7ROmllp7cvMOzk13mRnSE1e2DEkCpea34YvgeegfqardH3KgidAW876qobzkctvemCCPoh5DqhAoE8+6Ck3lNbkBbmpw/kiP3bqE8IOpR3HlpztWJwHUhRuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: X8ogNJCaSBmrAMSRJn/oCQ==
X-CSE-MsgGUID: YxEr24y/Qmya4EIelEMJyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37927560"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37927560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:49:22 -0700
X-CSE-ConnectionGUID: I3zFfxIOTm28Yq4645XqPw==
X-CSE-MsgGUID: ALUzUGNKTcm94Z5KTfvQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73601077"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:49:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1svFpw-0000000Ef7L-3G1q;
	Mon, 30 Sep 2024 15:49:12 +0300
Date: Mon, 30 Sep 2024 15:49:12 +0300
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
Subject: Re: [PATCH v4 4/5] block: add support for partition table defined in
 OF
Message-ID: <ZvqeSC3ZsRU0uEaB@smile.fi.intel.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
 <20240930113045.28616-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930113045.28616-5-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 30, 2024 at 01:30:11PM +0200, Christian Marangi wrote:
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

...

> +	strscpy(info->volname, partname, sizeof(info->volname));

We have 2-arguments strscpy(), please use that.

> +	strlcat(state->pp_buf, tmp, PAGE_SIZE);

In new code we should not use strl*(). They are subject to remove.
And actually why? You have used strscpy() a few lines above...

...

> +	for_each_child_of_node(partitions_np, np) {

Use _scoped() variant.

> +		if (validate_of_partition(np, slot)) {
> +			of_node_put(np);
> +			ret = -1;
> +			goto exit;
> +		}
> +
> +		slot++;
> +	}

...

> +	for_each_child_of_node(partitions_np, np) {

Ditto.

> +		if (slot >= state->limit) {
> +			of_node_put(np);
> +			break;
> +		}
> +
> +		add_of_partition(state, slot, np);
> +
> +		slot++;
> +	}

...

> +	strlcat(state->pp_buf, "\n", PAGE_SIZE);

Why strl*()?

-- 
With Best Regards,
Andy Shevchenko


