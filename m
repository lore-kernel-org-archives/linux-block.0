Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C71277CA5;
	Thu, 11 Jun 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202684; cv=none; b=fjlJY6QhfYzWSD5AxroDz6rk5/O0enTuLnGY+U+drOemoSdYpjM5q2hA+AFbNfYTN9L4zkQuLiuJjF0ebwRKFjQ2OCq0Xl0962jIWpe4XTC8fiesNHWI43XOf3zTZq2AFQQK/I2v5GRO0/hChsJyLfT7H9+2dMuVxYSwbtgmoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202684; c=relaxed/simple;
	bh=7hFbgC9HnPzMr6oxo3wnpqIPpU8GHodGdbMFTy6e1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ2bPu1UUVxH45Omn7BpNlHM2K7DsONhDMIgv4Dx+r37WgV53V8OR6MXGrOD+1vSPwuiPOyc4ujklv0+O58hFcKKyadnTIkY3iDnR5fMU4CryUuZAGlNuriGu70ARokpArUNqCRLQEDNAD9gJi39rZk0VQoz236MJlS8y/qBxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/Jrxrou; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/Jrxrou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781202683; x=1812738683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7hFbgC9HnPzMr6oxo3wnpqIPpU8GHodGdbMFTy6e1TU=;
  b=n/JrxrouDCCmwKE//EE67sldzNYWRJqKgAFI9VAzShLyg9bRm6BdjeU3
   KXTZUXW+Iu3zwQh5zi2c2BWLzDTcdCh1a4zC0LGZJQkeEH4ObDJ7KrPG2
   2ebR0ceb1HtTsQa/XvS/bTX59qANMG4cfCWt30aBqrp6JlgzPOBjKr/vG
   eh5f2Htruma9N6dDfpcGy6wszmAuLxh6I/h9cpFk5M6iCOflUrBq0x69a
   36+OEbt/7sVpqIRzvIY7FbidUhZCIRB87a5VcBLA/rh4JnbwK3NsEQsiS
   0TLikE4QADTavHdnRHHtkLGRFKtS7aW179dFCVXmwqgNvOWZYodYO8Fx3
   Q==;
X-CSE-ConnectionGUID: Jj81FjmbQMuib/UTgOSwkw==
X-CSE-MsgGUID: 7iDgGRZaTX+p30aRdF5oYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93136346"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93136346"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:31:21 -0700
X-CSE-ConnectionGUID: 5eTY9mfpReuvZAQcDYRSJg==
X-CSE-MsgGUID: MEeJ9TMTQhGOHh6SBSHMRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="276756938"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:31:08 -0700
Date: Thu, 11 Jun 2026 21:31:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Huang Rui <ray.huang@amd.com>, Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Waiman Long <longman@redhat.com>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kaito Cheng <chengkaitao@kylinos.cn>,
	Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
Message-ID: <air-6P9ZGBbCWtGs@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
 <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
 <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
 <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
 <ail8iNvPrJnE7p58@ashevche-desk.local>
 <92683537-8404-47fe-a4ba-160e54870f0b@amd.com>
 <aipx1goKIsk40vrF@ashevche-desk.local>
 <96f9390b-a547-442f-b0a9-99a5ba52c0e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f9390b-a547-442f-b0a9-99a5ba52c0e1@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 10:39:14AM +0200, Christian König wrote:
> On 6/11/26 10:29, Andy Shevchenko wrote:
> > On Thu, Jun 11, 2026 at 10:01:25AM +0200, Christian König wrote:
> >> On 6/10/26 17:02, Andy Shevchenko wrote:
> >>> On Wed, Jun 10, 2026 at 11:11:34AM +0200, Christian König wrote:
> >>>> On 6/10/26 10:18, Kaitao Cheng wrote:
> >>>>> 在 2026/6/10 16:07, Christian König 写道:

...

> >>>>> Should we revert to v1, or keep list_for_each_entry() and
> >>>>> list_for_each_entry_safe() as they are, close this thread, and make no
> >>>>> changes?
> >>>>>
> >>>>> Link to v1:
> >>>>> https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
> >>>>>
> >>>>> Or do you have any better suggestions?
> >>>>
> >>>> v1 looks perfectly reasonable to me.
> >>>
> >>> But why not just hiding that once for all (in case they don't use the temporary
> >>> iterator)? Easy to automate, robust — everyone is happy?
> >>
> >> As far as I can see that is an extremely bad idea.
> >>
> >> The distinction between the use cases of 'iterating the list' and 'iterating
> >> the list while you modify it' is completely intentional.
> > 
> > What I meant is to keep the name, just drop the parameter (make it hidden and
> > being defined inside list_for_each_*_safe() cases).
> 
> Ah, sorry I was still thinking the suggestion is to merge
> list_for_each_entry() and list_for_each_entry_safe().
> 
> If the modification is done all at once or in steps doesn't really matter for
> me as long as the patch can be re-created reproducible.
> 
> But I'm wondering if we couldn't improve the name at the same time. The
> _safe() postfix has caused tons of confusion where especially beginners
> thought that it is a thread-safe variant, which it clearly isn't.
> 
> The _mutable() postfix sounds like a much better description to what happens here.

I see, no objections from my side, but with the new name we don't need to have
treewide change, the downside that one should undertake this to finish the job,
otherwise we will have _safe() and _mutable() for a long time.

> >> See the bool type can be implemented by int as well, but it is just a
> >> different use case.
> > 
> >>>> You should just include some patches in the same patch set to actually use
> >>>> the new macros.
> >>>>
> >>>> If you modify the files under drivers/dma-buf or drivers/gpu/drm/amd to use
> >>>> the new macro I'm happy to review that.

-- 
With Best Regards,
Andy Shevchenko


