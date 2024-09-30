Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017118EFEB;
	Mon, 30 Sep 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700339; cv=none; b=enGG3vD4hOKS9QUENctEYfWrVuQAUE0E5441b1DSP7O5rhz1iYnCx5aTJCnz69b51Vpw/EfT6+YkXoWA5zU1M1gb2B9wbpIj+Fjqi7P1EcLtMPQ7+IbfgO29CspWVagjEaDPHQSoj3ABNcR1woSVo5TX+4/+7lbDjU9yYhMUuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700339; c=relaxed/simple;
	bh=Ut0lQ2g9exrMix45yy0WQ7t9mzUrHTgaYqmEtChH8t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu9JcruUt5Hc8uB6eOe2JT0p7dyJdROqZLmxQRbnU2k/pDdxuC6/fsYTSbC5JzSbhWV0X6eL66/d3/LfAXsWnnOkbWYJZ2N0mmLtBCWhKbQdyCdMpCjmFo0j42QfBl15y2R2L9jnIdOjYkhv8VrFNo15zGHGiHldpEgWRHy44Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: KD10S7boS7mTEbF15noccg==
X-CSE-MsgGUID: KbXWujLhQ1Kud92A2UV0Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26908858"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26908858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:45:37 -0700
X-CSE-ConnectionGUID: LpizH6AiS6S8a9x6XhV00Q==
X-CSE-MsgGUID: /nBZg+QPSQucfIQtGeE3mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73262705"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:45:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1svFmK-0000000Ef39-3uEe;
	Mon, 30 Sep 2024 15:45:28 +0300
Date: Mon, 30 Sep 2024 15:45:28 +0300
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
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 3/5] string: add strends() helper to check if a string
 ends with a suffix
Message-ID: <ZvqdaLAVbUF0i1Zi@smile.fi.intel.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
 <20240930113045.28616-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930113045.28616-4-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 30, 2024 at 01:30:10PM +0200, Christian Marangi wrote:
> Add strends() helper to check if a string ends with a suffix. The
> unreadable strends is chosen to keep consistency with the parallel
> strstarts helper used to check if a string starts with a prefix.

strstarts()

> To prevent out-of-bounds read, len of string is checked against the
> prefix length before comparing the 2 string at the offset.

...

> +/**
> + * strends - does @str end with @suffix?
> + * @str: string to examine
> + * @suffix: suffix to look for.

Please, run kernel doc validator

	scripts/kernel-doc -Wall -none ...

and fix the warning.

> + */

-- 
With Best Regards,
Andy Shevchenko


