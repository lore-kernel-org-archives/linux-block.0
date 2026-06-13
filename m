Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF563A2543;
	Sat, 13 Jun 2026 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781316697; cv=none; b=i2EvVH3U7sGXvplX/Ia9m49FvR7P8Ma58G6IOGw2LwFi36AKIxr4WEdYJAM+wxBDGwGZ43KWIseH4HNycdfWLyqHVzlhAqe2My8jDHPDYOJFU63lTVrsw2+zx9M0dmid96dI/vbFDe+ybOv6qeHQeu8o/F5vsPF1aydjWVNQcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781316697; c=relaxed/simple;
	bh=ecnkEaaCS8+DWqCNDsS+RP9RroP8df0sQbWKP5wlgus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYC7OLwbo0NzfPSxuBeuiDZuJz6Vv3oWx9lCWgiFmp2AxnvBUWHxr/yLMCk6cR4IbatJPkpx6IZe+IZZNEGsF4UFJdvY5qHPAjdoSri7c+L3XuGpPWQ8X43W3wFraFiScuzbSkWT0z4wyuoip9YKJZNkRmSHt+nF4W9Xmy59aTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=m/B1Wk7p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/MO738r; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="m/B1Wk7p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/MO738r"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id F3E41130005A;
	Fri, 12 Jun 2026 22:11:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 22:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781316691; x=
	1781323891; bh=fh1bnzRZkfgjl9/+6Z2PA5Kxn4ZV0HU2wTlYFBWNiQ4=; b=m
	/B1Wk7purilBiKkMRVuC3Flfti1lZpKfwlt77AZHkSZhKAS8ia2z8R1CfOFuJXF6
	jqWuwBOSRldHgJLpHFlWbohi+/JgUUnflgC3sz67VmbHnHyV/qKZ4L9+/cZXwBar
	pZn5nQLmSLaeUika7jXQ35MDD5xqJYMJ+XFW0A6h82xxae3b35f+ak0pm9sP0j3o
	Rn6Oms26Dq5JaxYcd+LhJ5gGkGzHljkvR3PWQpdcFDZcrutUQ5Gw4MM7C09x5GvX
	Rm44QXSJLT+PBjHrSfnnGBG8BhkzE2o2bhAyK2kr+YrDji7XqZrfOW/mHwWthgS8
	Q8mLA82aenzF3UH78IFeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781316691; x=1781323891; bh=fh1bnzRZkfgjl9/+6Z2PA5Kxn4ZV0HU2wTl
	YFBWNiQ4=; b=B/MO738r25kBC5W1FZEi/jo6InpT95G+oNzeSTFxbs6dD4/bHOo
	eohWxUFnm/DfWRpK+E9TtLDOCX/uuLyULx8m11eswEvzdxMrqTKhaL6Z02wKBqNd
	CwUcrPKAd4Siff0BNUrNKfyxMQnnlhIFTpMxLRKZ8xZjD0t2cTZE+U4PZ4f1VLum
	eUck3wo68eBHMIfH++HVVwfv7ri3oT2EnqWmMJLbVCz7Bgqys21n/vANfaMKmzA5
	KTcEAvxk1SZlFD9lLcLv/WXuzYzr6P0pxCDuHnQsrl+DKeZ8fmfPZHEY9ZY0Se5J
	q0LnaDPLjJpMRMgOPg+6e3HR5iqlooX1wzg==
X-ME-Sender: <xms:ULwsaqJSU3ZGUfYTfTfHvUkDGrkZoAz6knspkLRN72dkmhaAlWGU0w>
    <xme:ULwsahfpOAjeeQFoOqDeZonzxOth5iwOqocTQN665ujKaw5W4kvXENFHiPc-NQxhw
    bYtvUQNmu3jDY73PL51YmoAI2sjikN827tQNcmget20GbLVOMoBysI>
X-ME-Received: <xmr:ULwsahqjIqnco2Z3DcLoZTyMFsoOrP0wNMni9j0HG90Y9TI7BFN_QaV06BuMmbh11eW2LBxgLuuRksM5bGGMSNYbNYgx36I>
X-ME-Proxy-Cause: dmFkZTF4d5otJNSy4E5+TBrm5t4/oKNW6ZUmoxVyat81cKms57U/uBMehGj0z5o/f8U0/o
    PK70IhoMQDHia1i8CUjqCHYptK3rsgOvh6V75aLzG/qgZR8GOCrcy2g63bYzQQOxQqQZj/
    9oT1UuiKnf5HDSuvjSqxoI4qcJJc8bRoOgMhp5UWdtRrRuetAFIP6Aax0o1UXRC5743AIG
    ohTJB6VzPihRmorA3Lx8YAKhiMlL0+yMkZd8nQebbDlRgY6+OEVjhF6TdMsRENVLgOl/oT
    e9kd0DiCM7hKkG8v6/VJyviGyBIdYP/hdF4S7lGeNUOAI6uqYDfailcqU2g8IxWFbY33Iz
    +ACooa7G5aLCHNydDMqgIw/A9YbG1rRl+rnyg/YIAD4D6JdEdoAgr2XQjPH8mcmJlRbD3J
    L4/zbRcQgfwyBPi98PR4JOKtv58W0qZNGq2bo6mWTGKoyLqrpZmzB453regdcvZ8yWpZmu
    5lZqhVxLEQEMILodTD6zK1GHSSrZm7GNYXniwmQFVTJUC06+nPk5jOzXfJFTMkjFQnsTua
    s5EZutrLFiC0SlXAMx3G8OW0t7HhwPROcWEkdP0Sg/cm0K2m7YFRY8ECn2xh73b8iO9AwB
    tCQHO9fSd6RcJ4FMQt07rf5E93yDlosmA0AAxIdfE3fyuvVFOzAgwLaVB37Q
X-ME-Proxy: <xmx:ULwsaquT5SmR-xrOGgQFjoa6EFFSjj_YmJFkzvlVLH6-bw1wIgxJcA>
    <xmx:ULwsaiczRhSGXgdtKE6k3bFZWKF6E3kwyRiRHotFTZvhVr9iHcwmsg>
    <xmx:ULwsavqtUT6DHcdKXT_TCM513fG-OiPCsLUvufUASvNxvwu79-mjtQ>
    <xmx:ULwsagTJKGVgV3JEZ3ffGTuu0di_sdwXaiZGwS3tmV3GAsHXbdzfUw>
    <xmx:U7wsaqO7MfduZe3aBiVNiGj0DHVe0CuJke1_63F3DF10oo3uJ_cbzvXT>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 22:11:17 -0400 (EDT)
Date: Sat, 13 Jun 2026 11:11:15 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?=
 <christoph.boehmwalder@linbit.com>,	Jens Axboe <axboe@kernel.dk>,
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
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
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
Subject: Re: [PATCH v2 02/14] firewire: core: Open-code topology list walk
Message-ID: <20260613021115.GA130812@sakamocchi.jp>
Mail-Followup-To: Kaitao Cheng <kaitao.cheng@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?=
 <christoph.boehmwalder@linbit.com>,	Jens Axboe <axboe@kernel.dk>,
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
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Boqun Feng <boqun@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
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
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609061347.93688-3-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609061347.93688-3-kaitao.cheng@linux.dev>

Hi,

On Tue, Jun 09, 2026 at 02:13:35PM +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> A later change will make list_for_each_entry() cache the next element
> before entering the loop body. for_each_fw_node() intentionally appends
> newly discovered child nodes to the temporary walk list while the list is
> being traversed.
> 
> Keep the loop open-coded so the next node is looked up only after
> children have been appended. This preserves the current breadth-first
> traversal semantics and prepares the code for the list iterator update.
> 
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  drivers/firewire/core-topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the patch.

Last September I've realized the issue but not solved yet[1]. A pointer
array would be another candidate to store the found nodes, since IEEE 1394
bus a restriction about the maximum number of nodes up to 256. But It is
too large if put in kernel stack, while it is slightly difficult to keep
it in heap dynamically since the function is called under holding
spinning lock.

Anyway, there is no objection to your change. Let me apply it to
for-next branch so that your further work goes well with no blocks
locating in this subsystem.

[1] https://social.kernel.org/notice/AyDqvLkpwUvI5eyokK


Thanks

Takashi Sakamoto
