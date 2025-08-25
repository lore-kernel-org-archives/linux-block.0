Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F82DCF50;
	Mon, 25 Aug 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119506; cv=none; b=Jzwur6xEJqTa5CCfmAwflp6aYIHoOjqe7w2yqjPWgwOsE0iZvKtmwQzJ2KjC3W36N6uMpENDHenMMHPYivfPQRM/CXrxhAkl7n2d77MZFPsTNzSI0Xc4JnZBZyANwlceHW2dlbOt44dGEZf+d4OC1P3ayfhridMzQjAdt4sFetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119506; c=relaxed/simple;
	bh=/nWAv21uUwIg6I+Yt9bRMTJHK+0bLZc8dmTqYN1EitI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtlrDYqsMkfvPIl25zXwGH5Rmyduau3bg3ZpFCGWfoa10gIZ9Gs42oWxqddNZZEGlO9FTurAW5OJo1lVkEPYvlqxVghzpMdz6bQnTQAvyMw3QSk3eL+7PqpNcEp+SOyvq178TIedXtvMQc9QKLoZtYmb9ngtxeWwfF08luUfBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOIpUl4N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOIpUl4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756119505; x=1787655505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nWAv21uUwIg6I+Yt9bRMTJHK+0bLZc8dmTqYN1EitI=;
  b=iOIpUl4N28b5mM0GDmT+UWJ22CDkGS/CXSPweI37clxWYFh1VdlGUYsU
   A+xLGgiCwWz43VHnbi1S0NOoPw/X/82etTR+W4iIipf/6LG+cuksZe+ET
   oAri9yAt2ElkvD88Nr6tieUWw/SAERh320J+jihUZesm13AI/tsOwqvLg
   2PLglmE16ihfm1qraYquzQ4eBGedx6N44mpHKqAMzvMWG7zEbcyxcmO3C
   kqLLMk4yYpfXQmZxs2PL7komQyg8vohqFYZYtQleQTdTkARmYTWrub2+r
   92mXv+UpPdC1hvPn6uDT+3V2rsfVjBppkZGKVCl3S67m4VabB4cmxzhkl
   A==;
X-CSE-ConnectionGUID: cB2RwpRcSRytGvpfdaCCCA==
X-CSE-MsgGUID: H1cuzTfHSXy/MWDjDzSusw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58398632"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58398632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:58:24 -0700
X-CSE-ConnectionGUID: K3S/DeXlTSyNZC63BVA/Jw==
X-CSE-MsgGUID: dtKb/MJJSWaE0WolSmIOOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168510744"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 03:58:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqUu2-00000008TXx-0PSP;
	Mon, 25 Aug 2025 13:58:18 +0300
Date: Mon, 25 Aug 2025 13:58:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: axboe@kernel.dk, phasta@kernel.org, broonie@kernel.org,
	lizetao1@huawei.com, viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: mtip32xx: Prioritize state cleanup over memory
 freeing in the mtip_pci_probe error path.
Message-ID: <aKxByRMFizjnhgn4@smile.fi.intel.com>
References: <20250823083222.3137817-1-zhangheng@kylinos.cn>
 <aKxBd1uFldjopX3T@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxBd1uFldjopX3T@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 01:56:55PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 23, 2025 at 04:32:22PM +0800, Zhang Heng wrote:
> > The original sequence kfree(dd); pci_set_drvdata(pdev, NULL); creates a
> > theoretical race condition window. Between these two calls, the pci_dev
> > structure retains a dangling pointer to the already-freed device private
> > data (dd). Any concurrent access to the drvdata (e.g., from an interrupt
> > handler or an unexpected call to remove) would lead to a use-after-free
> > kernel oops.
> > 
> > Changes made:
> > 1. `pci_set_drvdata(pdev, NULL);` - First, atomically sever the link
> > from the pci_dev.
> > 2. `kfree(dd);` - Then, safely free the private memory.
> > 
> > This ensures the kernel state is always consistent before resources
> > are released, adhering to defensive programming principles.

...

> >  iomap_err:
> > -	kfree(dd);
> >  	pci_set_drvdata(pdev, NULL);
> > -	return rv;
> > +	kfree(dd);
> 
> These two seems to me unrelated. How do you possible have a race? What's racy
> there? (Yes, I have read the commit message, but I fail to see how it may lead
> to anything here. My question in one of the previous patches was about needless
> pci_set_drvdata() call. Do we even need that one?
> 
> >  done:
> >  	return rv;

Also note, 99.99% of the drivers do that cleanup in the driver core whenever it
considers the best to do a such. So if you see an issue in this driver, the commit
message should really explain much more.

-- 
With Best Regards,
Andy Shevchenko


