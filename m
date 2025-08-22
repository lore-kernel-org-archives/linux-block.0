Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717F2F068E;
	Fri, 22 Aug 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855375; cv=none; b=DO28k+e9FLmBLKB/BL06yKCVRmcqNXLo1w0cCOqqy922HZN8QryCRCgUda16+HhmW3kly8J09DbjTxVsnItSo79mmzqT/POU/LdwiB1dIPKOGDsM95X2+XUWPdMNSz/VtGaVrIyKqnOkxMfg2snS6eifELb7nLCGLNHe76P4qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855375; c=relaxed/simple;
	bh=rXY2Zyhv7wbJPlQxeHTH9gfaadUzm0ipeM5O7Zztx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5pstm/TU2SkfG6fIjAeJIdWhWqGACuEpqutWqbjoKEjvcogaj/jrU2r0TnKPI8QMon4J7AJ8UeHgAgOmytACDtrkehPfMZKsIb37gmIg+9YenyJlONSTVBv57yIc4JclPJqhY7Y9NqfxIqibvwwbTjV/KdEHJKOpOMGICPUzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDsaz9+3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDsaz9+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855374; x=1787391374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rXY2Zyhv7wbJPlQxeHTH9gfaadUzm0ipeM5O7Zztx3c=;
  b=cDsaz9+38CR+W+cU/BWs7iUabjS76FOzWhBtHnNK+5Ysh3AENq9DmU0B
   Npfiw73xfSSbYq52DhxIjUzSSRCF1lKH5zzTNKZ3Xx47Ro/99mf05AD1j
   UF0E2TYNLy8Z/frEXLFPncGupJ3AmslYlz/B5an65u6Eq3HID4jM4+KtZ
   fKbO0tg/Ck+IDIM9JchyzXmBZq7q8yvoQqtKF7iO6URttWmGyqntSMjBj
   V6oQHyMr9nzrUu9OzdBfJiQt0gRZilaJK15zgyNB77hLDi0Y4LBg9vpal
   Tv810+qDyvoDXYZmN6lIcK1xCTXAmkT44vI1fp4tjPT4RPynu0ve4Yz1G
   g==;
X-CSE-ConnectionGUID: 5uxeXMT/TJ+/vUfboV/JPA==
X-CSE-MsgGUID: SE2niaHPTFixfSWHsSW6bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68433201"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68433201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:36:13 -0700
X-CSE-ConnectionGUID: lqVp1h1xS0SKP4Yjt2TPlg==
X-CSE-MsgGUID: GAC3aRMdRwuebj5vMQkgWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169029493"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:36:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1upOBr-00000007Tk3-3IyP;
	Fri, 22 Aug 2025 12:36:07 +0300
Date: Fri, 22 Aug 2025 12:36:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: axboe@kernel.dk, phasta@kernel.org, broonie@kernel.org,
	lizetao1@huawei.com, viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: mtip32xx: Remove the redundant return
Message-ID: <aKg6B6buH5xYlnxL@smile.fi.intel.com>
References: <20250822024100.991144-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822024100.991144-1-zhangheng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 22, 2025 at 10:41:00AM +0800, Zhang Heng wrote:
> Remove the redundant return

Missing period.

...

>  iomap_err:
>  	kfree(dd);

>  	pci_set_drvdata(pdev, NULL);

I'm wondering if this also being redundant. I know about some corner cases, so
is this one of them, or can it be removed as well?

> -	return rv;
>  done:
>  	return rv;

-- 
With Best Regards,
Andy Shevchenko


