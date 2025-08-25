Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E641DBB2E;
	Mon, 25 Aug 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129247; cv=none; b=pFJwMExcMsF5zEaBllQHawqXCry7crSJdJDgSY3cfIN/oSaBzO4i6RJpQqEqp6sXY36U793uYEup1olnHrJVzgoxZRRCO7LikNOln9NR7RsF8SmnwSMvHQ7ofWB+NufnlOmijukvufyIDsOHiXiiTczrqvjmMfgIFXlpTEbzorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129247; c=relaxed/simple;
	bh=ehcwVAugwnXapfzvSqRnt3H6zF/o6KfmzCVWgaLs8pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+w8D9kBgFqnUZ0F240ouZ+rjxpbEGeeQSM8YAm+jXqKpRMvVI6tLzqrLNhAesZKh0xmRcaHB88pPloiVKPNRtFbTPRVBwMXC/q66MuvuX/0jLVtYHTrlZphlV9RajQGFQzAgpFucwmBnitBEqmpyVQrn5XxAxX8g2+UGE+AWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n75xSces; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n75xSces"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756129246; x=1787665246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ehcwVAugwnXapfzvSqRnt3H6zF/o6KfmzCVWgaLs8pI=;
  b=n75xScesyyWCUMOl2yStS7jwHI1EBxRWDNlUK4O0QHTmDOhGresGp9dl
   z0unM7t15JB2l3ePrsh74ObR/Cot+kDkpMaPyzTkEPnOPKGlzJ6mDSCvt
   kYOncMYCuwlKppd83LLnfvkxZX24v0P62rOqKGicqgaRSbux1mxqVm4Rx
   ygdYGD4H9iRVICyADWAFsZSZA1xPMWS5Vhgb4Pl2rrhWV4qVRvxQ8466w
   6qjuUXWvwC4wJyMVM9FQqloU8Q1xC1wOF5qfh5qE5bkf+eWDVK2eR6KdY
   TEmpIwQzyu4YQ3zITkEuEQ6fq8SL9dZej8s0bgFYJg3J1VE1axIYpUkn6
   w==;
X-CSE-ConnectionGUID: B0b00MLRQoWHuzXuAfMIug==
X-CSE-MsgGUID: /a0/KvdxRfySfNyT7T2IjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58266108"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="58266108"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:40:44 -0700
X-CSE-ConnectionGUID: EAZubjnLRd+1ZQG+NKWcYw==
X-CSE-MsgGUID: D6so7cl+Romhrg/S1oSacw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173704853"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:40:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uqXR8-00000008WNa-0Hib;
	Mon, 25 Aug 2025 16:40:38 +0300
Date: Mon, 25 Aug 2025 16:40:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: phasta@kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>, axboe@kernel.dk, broonie@kernel.org,
	lizetao1@huawei.com, viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: mtip32xx: Prioritize state cleanup over memory
 freeing in the mtip_pci_probe error path.
Message-ID: <aKxn1bnFhFVSw3r7@smile.fi.intel.com>
References: <20250823083222.3137817-1-zhangheng@kylinos.cn>
 <ab3196a1e0ccb8f94eafb83de589c0ae8f82d598.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab3196a1e0ccb8f94eafb83de589c0ae8f82d598.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 01:33:17PM +0200, Philipp Stanner wrote:
> On Sat, 2025-08-23 at 16:32 +0800, Zhang Heng wrote:

...

> So I think that the pci_set_drvdata(… NULL) can be removed
> alltogether. 
> 
> When working on the probe() / remove() paths last and this year, I came
> to believe that calls like that were often used because of a
> misunderstanding of how the driver core APIs work.

I think there are other aspects that makes this happen (any combination of them
possible):

1) old books for Linux kernel development with outdated examples (these calls
   used to be required ca. 2010);

2) initial driver development based on (quite) old examples;

3) (as you said) misunderstanding of the device enumeration process in Linux
device model;

4) ...anything else I forgot...

-- 
With Best Regards,
Andy Shevchenko


