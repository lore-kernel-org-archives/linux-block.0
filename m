Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237B15C14F;
	Wed, 10 Jun 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102612; cv=none; b=o4fphUl6PeXOgsJWQtxVS7qXgoKbZg6tWQiAKCEGysHjQ8zJOpFXx9FJ6AH5sjqZByM4X4xdfz5a5S3Is4CAzAeBZ2f+4m9VAKsoVwGTT74URXz6+I6bUedwZ8cj5XZFVs5ELQvek7RzoEulE3fbwru3cMgPcdXvbxKs4OKnRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102612; c=relaxed/simple;
	bh=DPrzoI0Cic4lctVW9xW26ap2kbgPfsaWv6mpsae+kMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EarYmbdRF5vKGtm3ZXBS4R/7g27LPIzt1HzMWv0Tagr0rNl7uOPkOrDtH2goVYoTXs5y3BEZsp7yq9CCprQHoZ/raYM+1jG4SJVJwrNF7RgaAhvpSd+gK2NYCIwPimaL2b1zu6U6eqpr4tAItkZtlA4NQjvv/wq2ZN3VUq3zVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na+2ujzO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na+2ujzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781102611; x=1812638611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DPrzoI0Cic4lctVW9xW26ap2kbgPfsaWv6mpsae+kMQ=;
  b=na+2ujzOI/QIK0hxH5SmVq1OXSr79K7m/H8isj9MQ5AmNt4nlE1DxXup
   fPZ7F9YdTnOBBxSPzOnBbKXlJF5Br8qmL1gV0OuqpbLLnwen2c/pDHV88
   WWNolPd0zbKNXp1YioXUxrea6e8337OOgT6CBDS6upRxVlzK1RuJRLKSW
   2F48BTWvOORjkFqlmDzLwfH+rOlRC8xbOehdLaQCWv90whbVrLUvwUd8d
   Iwp2MulVgI7UWcmRn2Pml5FhEeCjynitbdmEu+2+04tysfUi8Mu+nEnIb
   r0we5NcGUpXxx59lbyuJrfR5fCgkVXe5/tP8rYdYBhTmcQ5k4VWcL76UW
   w==;
X-CSE-ConnectionGUID: hmGqtfgORD6gGQuC8j5eCw==
X-CSE-MsgGUID: T8q1HyzvTraFe67iTMRHhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93384023"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93384023"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:43:30 -0700
X-CSE-ConnectionGUID: 9i25flRDSViVTbAIRpyEPA==
X-CSE-MsgGUID: qyMNFvgnTEePAxuMiNBn1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251104880"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:43:17 -0700
Date: Wed, 10 Jun 2026 17:43:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <ail4AvzqAOXNaU6N@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 02:14:06PM +0800, Kaitao Cheng wrote:
> 在 2026/6/9 18:33, Christian König 写道:
> > On 6/9/26 08:13, Kaitao Cheng wrote:
> >>
> >> This series prepares for, and then updates, the list_for_each_entry()
> >> family so the common entry iterators cache their next or previous cursor
> >> before the loop body runs.
> > 
> > Why in the world would we want to do that?
> > 
> > The safe and non-safe variants have very distinct use cases and that is completely intentional.
> > 
> > What we could improve maybe is the documentation, from my experience an astonishing large amount of people have misconceptions about the safe variants.
> > 
> >> The first 13 patches open-code loops that intentionally depend on the
> >> old "derive the next entry from the current cursor at the end of the
> >> iteration" behaviour.  These loops append work to the list being walked,
> >> restart traversal after dropping a lock, skip an entry consumed by the
> >> current iteration, or otherwise adjust the cursor in the loop body.
> > 
> > Well I have to clearly reject the changes for subsystems/components I'm maintaining, that just looks horrible to me and I clearly don't see a good reason for that.
> 
> Hi Christian and Andy Shevchenko,
> 
> Thanks for taking a look. I would like to clarify the point you raised.
> 
> The reason I started looking at this is the original motivation behind
> the _safe() variants.  They exist because some users need to remove, move
> or otherwise consume the current entry while walking the list.  In that
> case the next cursor has to be preserved before the loop body can modify
> the current entry.
> 
> The unfortunate part is that this could not be expressed with the
> existing list_for_each_entry() interface without changing its calling
> convention.  The _safe() variants had to grow an extra argument for the
> temporary cursor, and that is why we ended up with a separate family of
> macros.
> 
> But conceptually, the distinction does not have to be exposed as two
> different iterator families forever.  The difference is an implementation
> detail: whether the iterator keeps the next/previous cursor before the
> body runs.  This series makes the common list_for_each_entry() iterators
> do that internally, so the safe and non-safe forms can effectively be
> folded together, or at least the need for a separate public _safe()
> interface becomes much weaker.
> 
> There is also a usability issue with the current _safe() interface.  The
> caller is forced to define a temporary cursor outside the macro and pass
> it in, even though almost all users never use that cursor directly.  It is
> just boilerplate required by the macro implementation.  I find that
> redundant and awkward: the temporary cursor is an internal detail of the
> iteration, but every caller has to spell it out.

Ah, I think the distinct macro families is that what we want.
But the hiding of the parameter can be done inside list_for_each_*_safe().
You can do a treewide change with coccinelle.

Sorry if I didn't get the whole idea from your previous contributions.

Note, even cases that would need a temporary cursor may be switched to
new list_for_each_*_safe(), see how PCI macros for iterating over resources
are implemented (include/linux/pci.h).

> With the updated list_for_each_entry() implementation, that extra cursor
> can be kept inside the iterator itself.  Callers that only want to walk
> the list, including callers that delete or consume the current entry, no
> longer need to carry an otherwise-unused temporary variable just to make
> the macro work.
> 
> >> The final patch changes include/linux/list.h to keep a private cursor in
> >> the common entry iterators while preserving the public macro interface.
> >> The safe variants remain available when callers need the temporary
> >> cursor explicitly or have stronger mutation requirements.


-- 
With Best Regards,
Andy Shevchenko


