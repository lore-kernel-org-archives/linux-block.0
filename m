Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02C3161BA;
	Tue,  9 Jun 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988422; cv=none; b=ChLrn1cu9VDFuoPcXtzF8nMK3zgUTxAN8c4NtBmDggYnLM5y5zK5ulwB4pV0CqzqevUeYWPR9T7rMffKTpw3QzxMw1TgkwgZ2qOp+CZx4S+FqGcupTcjtmf2RFbtTV7NhscllkO0mZ8IR65gz5CSxPUXfPgnkJH2YAJ4GM1cUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988422; c=relaxed/simple;
	bh=2uFU5Nc5neHcjkdpq8khI2EoQ4OEWJdTXCqvSWCGdV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3CfC3+ywYr62dbEF90tu7CTQRZEt9TLXocMS00UuhH5DBa00bYnbz3JmZ7KJ3Gwb2GovZ31N6QvsXKJCNBYc/6qBwrxe1BQee0hWRjDc1APkLSWeYQ7cRapUsiKym5TnqkN9pst9nvgWT4RBdEC8ESTJ5RLBDs73ZnFhL0SoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge8WQRR4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge8WQRR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780988422; x=1812524422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uFU5Nc5neHcjkdpq8khI2EoQ4OEWJdTXCqvSWCGdV4=;
  b=ge8WQRR4VcrmPbPq+fsDeE7duJPhV9EeKrOr6TXurjOrptdb1yPsT4K1
   l+icar9RusaYYkEc6ojAxzVZj+mdrDZLFMyLrZy/k2xvWDkssb4efHKNE
   tArYOZUxH+Bwtnb9fi1q3Mf3ULfaC/HDTy1XabA9ahu7DyNNQlndo7j7O
   gNnN669/wLAoiP9J8hu9GslQNdU+XSHblcbktR7BQ9ZYpdxbDpZk3j5Oh
   VzypZUVFhTSLVEIoKUaAInhH6cCbAPKDfOw5yQyqLxw7oOw1EKd0LxNar
   uOIUyzKFQz2KMdSjpFreu3DSXnfqN/qnY0pcx0bda8zazALgKf8vxjy6v
   g==;
X-CSE-ConnectionGUID: Ev081xT3SHabmdaEgE1BAQ==
X-CSE-MsgGUID: zUwp9MauRnmSRNZ9d9ZcFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85364707"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="85364707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:00:21 -0700
X-CSE-ConnectionGUID: pCChZ3wCTI+GwpURGgDxKg==
X-CSE-MsgGUID: Ei1KwtbHTi20oALanPWYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="249699387"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:00:05 -0700
Date: Tue, 9 Jun 2026 10:00:03 +0300
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
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v2 04/14] drm/i915/gt: Open-code active timeline walk
Message-ID: <aie580RAM3vCunbh@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-2-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609062526.94907-2-kaitao.cheng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 02:25:16PM +0800, Kaitao Cheng wrote:
> 
> A later change will make list_for_each_entry() cache the next element
> before entering the loop body. __intel_gt_unset_wedged() drops
> timelines->lock while waiting on a fence and then restarts the walk from
> the list head after the lock is reacquired.
> 
> Keep the loop open-coded so the next timeline is selected after that
> restart logic has run. This preserves the existing lock-drop traversal
> semantics and prepares the code for the list iterator update.

...

>  	spin_lock(&timelines->lock);
> -	list_for_each_entry(tl, &timelines->active_list, link) {
> +	for (tl = list_first_entry(&timelines->active_list, typeof(*tl), link);
> +	     !list_entry_is_head(tl, &timelines->active_list, link);
> +	     tl = list_next_entry(tl, link)) {

Yeah, these cases should rather be converted to do {} while or while-loop.
This will make the intention clearer and reduces the possibility that someone
mistakenly changes these back to use list_for_each_entry().

See, for example, deferred_probe_work_func() implementation.

-- 
With Best Regards,
Andy Shevchenko


