Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373028370;
	Thu,  3 Oct 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949570; cv=none; b=p54EO0vxA5S8eX/VRzydiiZ5iVUEQefs973PZFlKPap27WLk6QdS4HMXt7WmjhsHSSfBhnijukV1L/vaXkE+USZOTWjQ4QzL3Qe587D/VYbRtv5zt4W0SGFtYnDwAO4zNLEFq+o70CLKB4RrEDVnvtXv7t5WjX8HSkTkdDc8YQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949570; c=relaxed/simple;
	bh=GAvgnDYbIpJ8EztU1XXyYsFYyamS+ZKbGL4mJyafhNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJDYcOZ5EjZbcUEe0sA92Isitsa9llCIrISLVGDO77gJOjgKUV46ZLD5cvdFGnLatbNBphWkONR4AVKnGaQtmBLXUy+GSoH0BOgzu9snRzJJUPhCtCwMFManvAYo9P0fGAIlmSHl7StSZIC7S5gD8aJo4U+6bvBpXpKBM8ejqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JSxS/CNDQjaeoEm8LJ3OHQ==
X-CSE-MsgGUID: RCGoF4pKTaSIuJvgiL+dqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44604905"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44604905"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:59:28 -0700
X-CSE-ConnectionGUID: sAT+PtLZQ5icH7Km736sXg==
X-CSE-MsgGUID: 2r+uLvUiSDOn+6O7WPYLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74155166"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:59:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1swIcB-0000000G4lR-3KKf;
	Thu, 03 Oct 2024 12:59:19 +0300
Date: Thu, 3 Oct 2024 12:59:19 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <Zv5q90Dc_VzA4xs3@smile.fi.intel.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
 <ZvqfbNDfI2QWZEBg@smile.fi.intel.com>
 <87setej1y2.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87setej1y2.fsf@prevas.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 11:20:37AM +0200, Rasmus Villemoes wrote:
> Andy Shevchenko <andy@kernel.org> writes:
> > On Mon, Sep 30, 2024 at 01:30:07PM +0200, Christian Marangi wrote:

...

> >> this is an initial proposal to complete support for manually defining
> >> partition table.
> >> 
> >> Some block device also implement boot1 and boot2 additional disk. Similar
> >> to the cmdline parser, these disk can have OF support using the
> >> "partitions-boot0" and "partitions-boot1" additional node.
> >> 
> >> It's also completed support for declaring partition as read-only as this
> >> feature was introduced but never finished in the cmdline parser.
> >
> > I'm not sure I fully understood the problem you are trying to solve.
> > I have a device at hand that uses eMMC (and was produced almost ten years ago).
> > This device has a regular GPT on eMMC and no kernel needs to be patched for that.
> > So, why is it a problem for the mentioned OEMs to use standard GPT approach?
> 
> For the user area (main block device), yes, a GPT can often be used, but
> not always. For the boot partitions, the particular SOC/cpu/bootrom may
> make it impossible to use a standard partition table, because the
> bootrom expects to find a bootloader at offset 0 on the active boot
> partition. In such a case, there's no way you can write a regular MBR or
> GPT, but it is nevertheless nice to have a machine-readable definition
> of which data goes where in the boot partitions. With these patches, one
> can do
> 
>   partitions-boot0 {
>     partition@0 {
>       label = "bootloader";
>       reg = <0 0x...>; // 2 MB
>     }
>     partition@... {
>       label = "device-data";
>       reg = <...> // 4 MB
>     }
>   }
> 
> and describe that layout.

I see now, on the device I mentioned the firmware is located on a boot
partition, so the user ones are being used for bootloader and the OS.

-- 
With Best Regards,
Andy Shevchenko


