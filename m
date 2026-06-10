Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB9408639;
	Wed, 10 Jun 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103771; cv=none; b=m0omgFemG9MtLt2cORSpumBAwW/De2niLLrs9jqjENLHbjjG1GLLPzKLUE3n6QokcGC4PEAwEYNtrXbsYgNCwuZ4Jz1PdMMD/G1VDOEoouBKPO49izL/m2fcIlUPIyLYHnJwX9vT6dlfcj+YPFu0wUCzu4vekKPB85NFD+3XRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103771; c=relaxed/simple;
	bh=wdD+yxiW9aVoMld4LMPC1DWLru4HtTsU9EmgfMnk6eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTMIJZzNC5XVeHD9t4n2Hk5OqXo9uWeu3DgNd9nYDEcQdEGb1ov1QZnxLqtyeFxoma4XgerrTBcbvKnrwpiT0ixjsun2zi0klCjXpep4p0YNLQLPV3R5ALqEfetyZts1gpGbRVeYJlWgUW++fKoSp5g0VvyKmoOd9KC7xlIkSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYWIndeY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYWIndeY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781103770; x=1812639770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wdD+yxiW9aVoMld4LMPC1DWLru4HtTsU9EmgfMnk6eg=;
  b=IYWIndeY6xvcOvSzUD3YJRYWYC8lX4SZ+0P/TXyAB1A5m8V2lk6Ienaz
   1XrZPVFZJkQZEhRQDVjjYmB6WJs3LyTOkJ/fDXgPvml5G8ObipCP/hm2Q
   b4hrB31D09MtFizWt7LC9koJi6546dcbRgL1DgZh8/56oylxOVSZ4nmNO
   Vz7FJRd88Ku9xNe7/jiUrlGEXK+6j7hfCByby9uFlNKXtVh/+ssTGbdSf
   gnlUOHQWDDhkK6s8VgkZKvfeEsynJueDjeIGA7IVyRYbvec8/pdM7NCnC
   wq6YE60gwbkmqjWbvBHzDmUizGbGatUBrr+eZBGNmI/qbi+yKg/ZUM5yU
   Q==;
X-CSE-ConnectionGUID: KcgU0FGrQx+nl55jRFys7A==
X-CSE-MsgGUID: IY8JNEakTTaKROC01+vL7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="107334580"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="107334580"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 08:02:48 -0700
X-CSE-ConnectionGUID: vFiAK4i9TuuPvjj1ruVuyA==
X-CSE-MsgGUID: yPzj5/7BTy26oZg8/7CqtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251275772"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 08:02:35 -0700
Date: Wed, 10 Jun 2026 18:02:32 +0300
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
Message-ID: <ail8iNvPrJnE7p58@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <bd0b7393-8ccb-4d67-8bfc-18c68347122c@amd.com>
 <5152089a-2808-4fe9-b633-b03018105dd2@linux.dev>
 <6b2efdee-95b0-4306-a682-0d0466497ddb@amd.com>
 <2399841f-d834-4652-8285-4a15c7d9a9b9@linux.dev>
 <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d974a2ea-6102-45ff-bf36-3b25a2404e40@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 11:11:34AM +0200, Christian König wrote:
> On 6/10/26 10:18, Kaitao Cheng wrote:
> > 在 2026/6/10 16:07, Christian König 写道:

...

> > Should we revert to v1, or keep list_for_each_entry() and
> > list_for_each_entry_safe() as they are, close this thread, and make no
> > changes?
> > 
> > Link to v1:
> > https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/
> > 
> > Or do you have any better suggestions?
> 
> v1 looks perfectly reasonable to me.

But why not just hiding that once for all (in case they don't use the temporary
iterator)? Easy to automate, robust — everyone is happy?

> You should just include some patches in the same patch set to actually use
> the new macros.
> 
> If you modify the files under drivers/dma-buf or drivers/gpu/drm/amd to use
> the new macro I'm happy to review that.

-- 
With Best Regards,
Andy Shevchenko


