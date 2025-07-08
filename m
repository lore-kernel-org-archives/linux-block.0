Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD072820A5
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974561; cv=none; b=q7RYcjA56QeQyYAMXeK86WTFm5tHdrMoze2DZJA9qQKfICoEgAfPDyWQdEv+cLuLPNhxl2OIQemf3LO654AqqeJ7d3aIESyA32blB/zak1Nn72HGf392wpT/m9j7A3quhtBp5ZC9s/HiDcIvg0Bzj5tzIOPij8R3Qy6KXb0hjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974561; c=relaxed/simple;
	bh=PymnTLj/9dm6myphiop2iybLTuB/RpnLRp9LXVXUgyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Gv/ofOzx6j2W4YcCu8AkXHPcSdgwAQEH2NKefR4PYuyuDZpj5buDNr2XHKED10tccr/dRQJnL+trGxugpfXORI+ruxz0k/O9U3HR9PJ3AtTt2OWOUFAmZ/kFvcaGg/6JwijAuUFC5ShWrhu/WELSb7jKRG+/KsFK9PENEBfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWxOAB+o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWxOAB+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751974559; x=1783510559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PymnTLj/9dm6myphiop2iybLTuB/RpnLRp9LXVXUgyw=;
  b=lWxOAB+oRcmL5dXFAr0S4Yn7z9HvPoAHjJBf4JQIdH9eaFTY3lEyCU6v
   BSJphVJrB092smKKbAPY2bNOyRm9G/Ry689owPsS96eFcMk5kWR+OTDd3
   REbUt2Q4K/UfyeQuhg4pCWPx13iH72ymUKr64rrWY+II96WzA+tg78ORs
   a8k2AtfPlfCq1wo0XA8ssAb32fa0uTeud4P6p5JlDomj0cfzgH/v8W6/4
   A/DnRkdl11YVbAeM7wjKeJg3gouTHeuQ9tM8Bvj3gOtQCYtCyVjhasM0B
   KE42SPN1jg+KsbN0GTiTKtNz8djTkNSowLZ5TUJDVba1EtT6Sh9kIlqpe
   w==;
X-CSE-ConnectionGUID: OQH5rHKDR1Sgx+AE6aEjxg==
X-CSE-MsgGUID: JgOy2h2yTku0JB0ZhhVrzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57976365"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="57976365"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 04:35:58 -0700
X-CSE-ConnectionGUID: 7fPOVUuqRuOqsjNsyytr7g==
X-CSE-MsgGUID: aydsI5GdQNG2KfHoaskX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155970455"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 08 Jul 2025 04:35:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 70356157; Tue, 08 Jul 2025 14:35:54 +0300 (EEST)
Date: Tue, 8 Jul 2025 14:35:54 +0300
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
Message-ID: <aG0CmhnEHGtUEkWz@black.fi.intel.com>
References: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
 <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jul 02, 2025 at 05:13:45PM -0600, Jens Axboe wrote:
> On 7/2/25 5:08 PM, Ben Hutchings wrote:
> > On Sun, 2025-06-29 at 12:26 +0200, Uwe Kleine-König wrote:
> >> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
> >>
> >> Huh, how did I manage that (rhetorical question)? Thanks
> >>
> >>>> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
> >>>> explicitly, the blacklist entry doesn't help for that. Without the
> >>>> kernel module renamed, does the 2nd DVD-RAM result in the blocking
> >>>> behaviour?
> >>>
> >>> Yes.
> >>
> >> OK, that makes sense. So udev does in this order:
> >>
> >>  - auto-load the module (which is suppressed with the backlist entry)
> >>  - call blkid (which blocks if the module is loaded)
> >>  - call pktsetup (which loads the module even in presence of the
> >>    blacklist entry).
> > [...]
> > 
> > I tested with a CD-RW, and the behaviour was slightly different:
> > 
> > - Nothing automtically created a pktcdvd device, so blkid initially
> > worked with a CD-RW inserted and the pktcdvd modules loaded.
> > - After running pktsetup to create the block device /dev/pktcdvd/0,
> > blkid and any other program attempting to open that device hung.
> > 
> > My conslusion is that pktcdvd is eqaully broken for CD-RWs.
> 
> Not surprising. Maybe we should take another stab at killing it
> from the kernel.

In the commit 4b83e99ee709 ("Revert "pktcdvd: remove driver."") you wrote
that we would wait for better user space solution is developed. Any news there?

Just asking (I'm in favour to kill the old fart) as you haven't mentioned that
in a new attempt.

-- 
With Best Regards,
Andy Shevchenko


