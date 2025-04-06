Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E8CA6B;
	Sun,  6 Apr 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969975; cv=none; b=HJCAwTFqMIuL29lPxGYSX5+wXkaKiVZfAwNsVn4NN1Ab4YIkXnw+Mv7rJ11i6QCQ7UTSvdW4Yy1C6bSoNXH2EN9OgjmDT+I0zIOyOm/jX4ypWQbsK9OtcdoGgRvbloWjIOjqC3InEHqPM4mPLz/r0TqkL4rlf3gAWAqAtl/4hGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969975; c=relaxed/simple;
	bh=kqXpkAZobw0z/QtawS9MtkY6Uld0bwSNru6iFQNPH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCrghP+VNzLoyHhnmxbv6M9KB9fKxeWNkpvflvVQV3ZlazWulo45S56QCirGHV+pYGDFqZwHSlkVko7PLONLfrlN3gY/8GMqSm+RrFtAV0CX7RpDKu82TdxHHW8Du4+xOHLHzCKjmKdicpnBKOG+g+VSswJFGaFA0JkhUS0uwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKqcwRS8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKqcwRS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743969973; x=1775505973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kqXpkAZobw0z/QtawS9MtkY6Uld0bwSNru6iFQNPH2w=;
  b=QKqcwRS8ztAzS4jWh6thV0XTtwUn30nvrP9pWfQ/XLPEqgXk/sLZXCjJ
   ZcmaIJAkbQatnPgGDFqQMG1yF2siPbusfCdqFtBFR44n4YJZkzUuNuB0u
   /sSE3P8Zf5MI37ht/HfX9so/3SsQaX/1R5M3G+s+DyNVZp50awHp7Lpt2
   XfiQ4FOWe3z206iVFhF/WCW7W8HubDLBzv7AvsYLx03wiGejNXNMpSpxs
   Rcy4a2E+pXGcX4ZwJwJqyHcKbAGDbIDvWVb20baWajsjDSC71CNGIdmmI
   1E+0mpZ68haxF4KK8PSw96M+K1EJvIkk/rIyHmRfNn0qZQdkI9PY9yntQ
   g==;
X-CSE-ConnectionGUID: z04YZDcNQ7qd5o7dILvv7w==
X-CSE-MsgGUID: HNl4tYJbQVKP5UqgjkJ6HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45363115"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45363115"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 13:06:12 -0700
X-CSE-ConnectionGUID: LJOtVJ0oQNGznx11Hc0yAQ==
X-CSE-MsgGUID: 5j4nyi6LTGmCAgWCMBGe+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="132981261"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 13:06:12 -0700
Date: Sun, 6 Apr 2025 13:06:11 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: lockdep warnings from upstream build
Message-ID: <Z_Les3Izgqkg85_x@agluck-desk3>
References: <Z_HArDcN1zdd9wdt@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_HArDcN1zdd9wdt@agluck-desk3>

On Sat, Apr 05, 2025 at 04:45:50PM -0700, Luck, Tony wrote:
> Several email threads on this over the past few days, but none
> seem to be getting much attention:
> 
> https://lore.kernel.org/all/?q=%22%28%26q-%3Eelevator_lock%29%7B%2B.%2B.%7D-%7B4%3A4%7D%2C+at%3A+elv_iosched_store%22
> 
> Since tomorrow is "-rc1" day I thought I'd add my lockdep splat to the
> mix.
> 
> System is a 2-socket Icelake. Kernel built from:
> 
> f4d2ef48250a ("Merge tag 'kbuild-v6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")
> 
> Though I saw the same thing a few days ago, so the problem was
> introduced much earlier in the merge window.

Bisecting leads to this:

ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")

Which may be doing what it says on the tin. But, I don't think I've
ever seen the "type 1 splats" on this machine even though every kernel
I build has lockdep enabled.

So it this showing up a real problem that happens to be very difficult
to hit? Or has it introduced a false positive?

-Tony
