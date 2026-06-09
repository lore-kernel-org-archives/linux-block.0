Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFF352012;
	Tue,  9 Jun 2026 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988576; cv=none; b=bN9Y3WZpg60M3ErJT38gmveGgp1U+di9wSjMfd8idzZzFL0jVzZxIqIbKFn/Vt0KSG/VBHPV2ZqNab95TvygTTKjCBxLkRgIW5Vu2SVTJ9vB28vCR3A+mv1BLjezRnVgpXGJSzzK5rShEG6F2rMPoxIB2OjDWBk+2hvTXtJ61ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988576; c=relaxed/simple;
	bh=yzH6uJSi6Qy/tGngU0UZEQlj4llniF58GR8UVGOo5h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce32TEEnR2RhkoDFL8pEh5elt/NxLW5J0Oxfq61CXgMGpTdRZpOHq7rahu/PbomRGLqRnZfE7cT4SbM5fjkT1S7ltagz8kE1qhrU5S0EL/8kJtxC1+CXwyFix/Jyg/oSLuEwAY5Y/bYow0VC+5IeqH+7EGQTxAn221RpL8mKWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhxtLC+3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhxtLC+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780988576; x=1812524576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzH6uJSi6Qy/tGngU0UZEQlj4llniF58GR8UVGOo5h0=;
  b=HhxtLC+3DtIZry9DaHdwPlRDQhjNmMMLt4qt68nqfIvlC0bs3jG+oU9+
   k9oysQLfrFyHiBvblQuXJIO6AaNUA/Dx9Y79zwhp6+uYfS3BzyIbcpbYN
   jOGKz1NFJIxJEcCHllojj5xHeVBzxuM3wIgkO71CXuJHQTDv1ntkIgg2m
   uBwkUAQPVPKWorwLIUx6E7VHJFzRGN+bAW8a6o93A7caO7cfs9UKAhZHC
   NePGdh4BCjt/fiPORIUk9N4HsYVypBzOvzPg86RWMRXjDv4pbHG6qtdR0
   BI7jFB1dhlRczhthMRcEI1akzOwjEesME6IOCHHbNbRgs+gJm+aYj+E1t
   Q==;
X-CSE-ConnectionGUID: iFcaIGufQhK75wQQgE5s7w==
X-CSE-MsgGUID: tAjcXyARSPSw/OT39UYIKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85364915"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="85364915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:02:55 -0700
X-CSE-ConnectionGUID: NtMsANXzRtq8/DTsdCsIOw==
X-CSE-MsgGUID: Qc9xZ1QCR5ObTHR46qYy4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="243342065"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:02:42 -0700
Date: Tue, 9 Jun 2026 10:02:40 +0300
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
Subject: Re: [PATCH v2 07/14] spi: fsi: Open-code message transfer walk
Message-ID: <aie6kH06I6mMeoED@ashevche-desk.local>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-5-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609062526.94907-5-kaitao.cheng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 02:25:19PM +0800, Kaitao Cheng wrote:
>
> A later change will make list_for_each_entry() cache the next element
> before entering the loop body. fsi_spi_transfer_one_message() can combine
> the current transfer with the following transfer and then advance the
> cursor to that consumed entry.
> 
> Keep the transfer walk open-coded so the loop step observes that cursor
> update and skips the consumed transfer. This preserves the existing
> message sequencing semantics and prepares the code for the list iterator
> update.

...

> -	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
> +	for (transfer = list_first_entry(&mesg->transfers,
> +					 typeof(*transfer), transfer_list);

You can keep this on a single line for more logical split.

	for (transfer = list_first_entry(&mesg->transfers, typeof(*transfer), transfer_list);

it's under relaxed limits for the line length.

> +	     !list_entry_is_head(transfer, &mesg->transfers, transfer_list);
> +	     transfer = list_next_entry(transfer, transfer_list)) {

-- 
With Best Regards,
Andy Shevchenko


