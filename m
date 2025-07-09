Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE0283153
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051885; cv=none; b=PMKj02J8KQqhcwNmWfThx//2F4b0qPHssvy958ppjBc2oYPryF8QXrQxQ3t0qKMMG9jW/uNjaUPCWOpuVXGG/3be/oeruIBduSKadI/rlkxnrt1WQbdhyLnYHGCXi87KsYsmRcPsl0B32+F8l/8T28On/vCwp4/jHzMWM2pMExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051885; c=relaxed/simple;
	bh=YkiSIros1J4wxzjDae83XDFtPS6hGqYUw+KwTlnP0Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnrciLRtGeTM0K8CkU2vIOiB522owPskXjiDYm+0NYFXSZCktoSGm1SM6E3Pch0DnVXxh7ybcsMWIy3C1ra16Nc5c4I8gXy5c7dclrBK4IC+aSDIHGH3BSIaDm3apBELg7PMZOKnOQcDMWq+vaPnG/jT3r1bZJgDnQ9yf5u1pyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeDfwXxP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeDfwXxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051884; x=1783587884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YkiSIros1J4wxzjDae83XDFtPS6hGqYUw+KwTlnP0Ts=;
  b=DeDfwXxPpgJF2UcJklKCZbUXZTG4Yg0fpY++mGHw40kyac/nEuzJSSbU
   2hK0I6VKwYe0M8/Lo88IGCxH370czJi312r0DPQcmc5OA3LY/tBDFmP0K
   8ylV5ckxYUPMG6UyJ9Z1a+oIq0YC2YocpR1RDYpc3ay+rocMiXxLUz6i/
   pPCBcBu3K2WTx2voIofEdRxSjt7uLL3wbZrXz7ceIy79MGecANdRCKLkB
   fOzR/1tB6Z06r2MKy/FkDX6TAl2+Ro/3mn8Rrx5f3OrDa+LYHZUHyEK8M
   idGRP8BvaE75/3sQeS9TWVNmgMH/p94KRhjB2XdSPZ2efcT1+9sf9AK03
   g==;
X-CSE-ConnectionGUID: BQMZAOqQTo+RtzgjCQiwgA==
X-CSE-MsgGUID: 0V3/tZUbSIy2KQYctIfJIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54188720"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54188720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:04:43 -0700
X-CSE-ConnectionGUID: tVNzeBpGSauK5mukHnWm3Q==
X-CSE-MsgGUID: sb+msiXuSayBBhYjd8aBww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156301378"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:04:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZQjF-0000000Dojd-3Efe;
	Wed, 09 Jul 2025 12:04:37 +0300
Date: Wed, 9 Jul 2025 12:04:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <benh@debian.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	1107479@bugs.debian.org, Roland Sommer <r.sommer@gmx.de>,
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <aG4wpd_afBxEXjjA@smile.fi.intel.com>
References: <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
 <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
 <aG0CmhnEHGtUEkWz@black.fi.intel.com>
 <ce06bf7b-d916-4ee8-af4c-3af5f7959b42@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce06bf7b-d916-4ee8-af4c-3af5f7959b42@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 08, 2025 at 09:32:19AM -0600, Jens Axboe wrote:
> On 7/8/25 5:35 AM, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 05:13:45PM -0600, Jens Axboe wrote:
> >> On 7/2/25 5:08 PM, Ben Hutchings wrote:
> >>> On Sun, 2025-06-29 at 12:26 +0200, Uwe Kleine-K?nig wrote:
> >>>> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
> >>>>
> >>>> Huh, how did I manage that (rhetorical question)? Thanks
> >>>>
> >>>>>> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
> >>>>>> explicitly, the blacklist entry doesn't help for that. Without the
> >>>>>> kernel module renamed, does the 2nd DVD-RAM result in the blocking
> >>>>>> behaviour?
> >>>>>
> >>>>> Yes.
> >>>>
> >>>> OK, that makes sense. So udev does in this order:
> >>>>
> >>>>  - auto-load the module (which is suppressed with the backlist entry)
> >>>>  - call blkid (which blocks if the module is loaded)
> >>>>  - call pktsetup (which loads the module even in presence of the
> >>>>    blacklist entry).
> >>> [...]
> >>>
> >>> I tested with a CD-RW, and the behaviour was slightly different:
> >>>
> >>> - Nothing automtically created a pktcdvd device, so blkid initially
> >>> worked with a CD-RW inserted and the pktcdvd modules loaded.
> >>> - After running pktsetup to create the block device /dev/pktcdvd/0,
> >>> blkid and any other program attempting to open that device hung.
> >>>
> >>> My conslusion is that pktcdvd is eqaully broken for CD-RWs.
> >>
> >> Not surprising. Maybe we should take another stab at killing it
> >> from the kernel.
> > 
> > In the commit 4b83e99ee709 ("Revert "pktcdvd: remove driver."") you
> > wrote that we would wait for better user space solution is developed.
> > Any news there?
> > 
> > Just asking (I'm in favour to kill the old fart) as you haven't
> > mentioned that in a new attempt.
> 
> No work has been done there, to my knowledge. But as the current driver
> is totally broken and people aren't even complaining about that (outside
> of running into that for unrelated reasons), I don't think there's any
> reason for keeping the driver in-tree.

Sure, thanks for clarifications!

-- 
With Best Regards,
Andy Shevchenko


