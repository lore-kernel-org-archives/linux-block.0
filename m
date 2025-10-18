Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF62868A9
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815112; cv=none; b=NNhZg80TcpvLvoCuqEynSkRZxOHyHCfwwanpDciOjh9zbCEbpDYeVO7eAwFDSCC/qOdb5tQKeQ/aaHByq4nbm9pk1Of6wVsfs08hRvkhYqV1lucYlkoJMeGVnKA+n3dHL6vSFklP7QDnLVV0NwX0ePUDTlLgb76tKZt9IkN8p3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815112; c=relaxed/simple;
	bh=w05CNOrXPy1aJSCpU/iFbw/ziBEh1x9+eqcFGCBigBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f1fcQPP3OvZYDd0j4P23X24qzYKX7wjgcc7LwLpNn4CgxGmY2eKjKCXYK8JDOjOeDu+Qd/IG+hg1uIVMFhlKQITZDQu69afXVrBCl0G/dCbhK7cyb+A+2FzFDJIV9t98sn+43b5GFmHdaXS4gjnokEEN1hMULb37yr5ti32JehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYD6ozFy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYD6ozFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760815111; x=1792351111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w05CNOrXPy1aJSCpU/iFbw/ziBEh1x9+eqcFGCBigBk=;
  b=FYD6ozFy4DnW2ASMiwU1D0sSTGpRP7PQeN+WP0ABhkAwXN/fvTegGub1
   4nVpEAeQE+hOmmj7pTdX9hjq0LJ0PeJFho69uML9SRVLhL7tMpYAloyIE
   8f3vCwTbTUM18ryto8U8XGKeSrUsrYJh99pMmRDuwi1zLGMXh5uSEGGD3
   XRFEZxLHkRNdjJzsiCqDG7GeZ3jJ+vIlJoOj2EQ5pGyqe39ckM0eHA1o8
   lpF/mmzZ+pWHWYUX0mArVU0sRVsJc/kdDJzP2mm1C7RfPTHaKUQAFZWay
   gZDo7VTL7odepejnZLcmIOM4hpgi6Ux63w6zSHta6kiCExg2WzgmQFlYZ
   Q==;
X-CSE-ConnectionGUID: bAxOVWoCRz+H6JVx0yrdSw==
X-CSE-MsgGUID: Ni8BxU1RRDWvE2Opu2trrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63041702"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63041702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:18:30 -0700
X-CSE-ConnectionGUID: slvOlB7qQNO3XNsQlwY9Jw==
X-CSE-MsgGUID: oMD52Br6QfSYbN5ISHSXqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="187250273"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:18:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACRd-00000000xOQ-1xfq;
	Sat, 18 Oct 2025 22:18:25 +0300
Date: Sat, 18 Oct 2025 22:18:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: axboe@kernel.dk, phasta@kernel.org, fourier.thomas@gmail.com,
	viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: mtip32xx: Fix typos in comments and log messages
Message-ID: <aPPoAYlgn0qry5R7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 12, 2025 at 11:40:03AM -0700, Alok Tiwari wrote:
> This patch corrects several minor typos and spelling errors in mtip32xx.c
> - Fixing "ge" -> "get" in a warning message.
> - Correcting "kernrel" -> "kernel", "progess" -> "progress"
>   "strucutre" -> "structure" in comments.
> 
> no functional impact.

I would go further and add another patch that fixes kernel-doc warnings
(Missing Return section). This one LGTM, though.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


