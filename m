Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055830E85D;
	Tue,  9 Jun 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988776; cv=none; b=MSDH5Lf9HFBFe51O05+cqWlj1dEXrKYonrZia5uN0IoafQKFaTTBl0JVxZmXlOqF6OxdksxeRp94AyHJCJGo2EaEdWMfJgmGmbXvwTRQKu033S2AGMWDrFaGNTzRYCem0yQDVChuYaAEbTDUeDzHadZ6lSQrgChWBpjsPGw3nBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988776; c=relaxed/simple;
	bh=wPNxaq+MxK/SZuHOphqim3jNSNXgk7q+4ZcK8M927Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbXn9fu1PUK+Fwn6Gio+k8+RYt/R5vqzJn2V2ESa+af5LJBHtgkn1F9LBWFETpVMppQp7QVaFTyntUXzQKkiWw7FVBNcHeNIrH6yol+ojcEtWffjktlj5fGVMlJS9OngSCp/vfhIxC6/G+EWey1y8tL25UndxmM268p3TNtUcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1Q/svxB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1Q/svxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780988775; x=1812524775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPNxaq+MxK/SZuHOphqim3jNSNXgk7q+4ZcK8M927Ho=;
  b=V1Q/svxBQIKze/UXIJSjOVKgrHKSgASIHCOspehkIKVQv2bX/4KShqag
   d/zBQ8UonmmfCj23Qs6t014+PRFWP64qdiRXDWUO2OGNx4EEGAO2w7sCU
   LzHdXSmmXEbVpF2R8KUvg9khSMXFrJq7Vl7L5BPkpGUIiiD5fiYxw3W59
   4FQh6ok8g54u9bkh5DW/Blm+yyV0i7ZfxxRM0zm2LuMO17UyyOq9quxWQ
   m9u+KlPrFKZMmipRXS8dPL0QcSU9emqYxGViqZqE8at93dpxdLxORPsZ3
   1zs8+uHOBOMxAuYOXU3Mg0bhso5WN1KqbjVHLVl3SqfMuxV7UvOnW0AtV
   w==;
X-CSE-ConnectionGUID: WXYisqjbQZyrA+fWFTk52w==
X-CSE-MsgGUID: 2Gv7+2jvTKSkNfbTwfVq+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69275340"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="69275340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:06:13 -0700
X-CSE-ConnectionGUID: 0Fv2wpZjRBeJ47Uck52CjA==
X-CSE-MsgGUID: onLxLx0PQVGxZ3J/XwQjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="242837949"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:06:01 -0700
Date: Tue, 9 Jun 2026 10:05:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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
	Kaito Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor
 state
Message-ID: <aie7Vlcg76naApoC@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <aie299WveL1utNya@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aie299WveL1utNya@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 09:47:34AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 09, 2026 at 02:13:33PM +0800, Kaitao Cheng wrote:
> > 
> > This series prepares for, and then updates, the list_for_each_entry()
> > family so the common entry iterators cache their next or previous cursor
> > before the loop body runs.

While code looks okay, this doesn't explain "why?" aspects.

> > The first 13 patches open-code loops that intentionally depend on the
> > old "derive the next entry from the current cursor at the end of the
> > iteration" behaviour.  These loops append work to the list being walked,
> > restart traversal after dropping a lock, skip an entry consumed by the
> > current iteration, or otherwise adjust the cursor in the loop body.
> > 
> > The final patch changes include/linux/list.h to keep a private cursor in
> > the common entry iterators while preserving the public macro interface.
> > The safe variants remain available when callers need the temporary
> > cursor explicitly or have stronger mutation requirements.
> 
> Something is really wrong with the patch series email chaining.
> Patches 3, 10, and 13 start the subthreads. Please, check your
> tools and fix them accordingly.
> 
> Note, `git format-patch ...` should not have this "side-effect"
> when used correctly.

-- 
With Best Regards,
Andy Shevchenko


