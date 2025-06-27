Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD52DF3ED;
	Fri, 27 Jun 2025 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033321; cv=none; b=KP7GBoc61aUlOQe3kzhdS/BG39mBsiJgrI1KaSEn0+1rB9bc2QS0cYa0SUegmDbOCHQ8G28TzIT5v0ZOnOYZo/sU8mcX6ohrJZO9vUvi0MoG7ENzUSEaQ6ixOnkPJ+52XR8Uf0z9s86SDZ2BrL1BxUQcxxu5ck514Z+zatUdjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033321; c=relaxed/simple;
	bh=P4Ol1+LiFEtLPD59kS9hjo80t0gjmAurYnjvAZxSUvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dnefm9ls4xHbA+8304nDeVKI9ibPSCFuFxqiT/lOpdrbU9/laZTJOadf/YflZ/bGMxnERO8RyVi0OxWAL5Zk9P3XbljARP/nGWyLZ73s2v5Oh2WTzj3eyOI4xBWpAKccZ5dzFm0U1EetvXHS/P1IQ4W9vNRFzRpbACVgY0THhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQYw+8X8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQYw+8X8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751033320; x=1782569320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P4Ol1+LiFEtLPD59kS9hjo80t0gjmAurYnjvAZxSUvU=;
  b=AQYw+8X86oaXcnHCJhtjttATackNpdOBkgW5Y9QD8HtsE2cXGlWfhBmS
   /UkwLLY3eA5CLtVnuM9f3Ut09n73mCrqmHyzbEf2ujPPqzvWtkRRhAMMl
   qslQWFi6RkFH3BSPWm+wL3l2NUn3iW74qmFFmkpTu+xM2c5YCK0P0ooCZ
   Nro05JVqhD9s1nKCWK1caSf2rKHMMUeb3LpzoixHKd7ltk5GcWomeHtwX
   bEG69OMcNwspoeR3RBd6KXertgsPnj3JBAU7bfEpkKAdVbdjzZuZI8yo8
   Nu88Y2irRvULyc612AyHcxBnqFb2fRLOz1pB4FCSzWlCJYSDtFHCbTV2n
   Q==;
X-CSE-ConnectionGUID: wDai7AFgSFSO8aVh77B0lg==
X-CSE-MsgGUID: pg6TqBaDTOONK+pTjDjWvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53497237"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53497237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 07:08:39 -0700
X-CSE-ConnectionGUID: ePkKxERqRxuRUcHgyz0bpQ==
X-CSE-MsgGUID: JOPKpQoAQt6ILiQWdl2ndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="153528904"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 07:08:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uV9kn-0000000AV32-2hqm;
	Fri, 27 Jun 2025 17:08:33 +0300
Date: Fri, 27 Jun 2025 17:08:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Philipp Stanner <phasta@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	Asai Thambi S P <asamymuthupa@micron.com>,
	Sam Bradshaw <sbradshaw@micron.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: mtip32xx: Fix usage of dma_map_sg()
Message-ID: <aF6l4STJBU7nXYS1@smile.fi.intel.com>
References: <20250627121123.203731-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627121123.203731-2-fourier.thomas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 02:11:19PM +0200, Thomas Fourier wrote:
> The dma_map_sg() can fail and, in case of failure, returns 0.  If it
> fails, mtip_hw_submit_io() returns an error.
> 
> The dma_unmap_sg() requires the nents parameter to be the same as the
> one passed to dma_map_sg(). This patch saves the nents in
> command->scatter_ents.

I don't know why I'm in Cc list here, but FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
with a caveat that I am not an expert at all in these areas. Code
just look okay and doing sane things.

-- 
With Best Regards,
Andy Shevchenko


