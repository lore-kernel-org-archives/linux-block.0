Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B754481CD
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369456; cv=none; b=n/Sjh8bm2aqsLzMk4EsyhhAmO7AxGT5voPKTPfGHcaRGk9q2UN3PzlFwQcaecqUVhBq7EFNxlc2mclxSbMQt4j9j2RBVahBuv79KWKYUpCRUTEbDrj5Rxb7G6BP2InjVpnYHpCi0yWOf+sx/T4jn8f8QbiP+qOl604YPi5jYZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369456; c=relaxed/simple;
	bh=AKyAow3/wzc/Ot9e9YRui5V8hO3If9LCvP1JmKecbqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7wMOUucLSlZv43oylSTYR4CFAQCMpUH5mxiVL41zbWwL2t4sO18Yq8HkcVjsrDH8tD3gZHVbI7gLknu0J+eUmeRkQ1kvXcGyzSU5r/C/3t9bXP2GimTi0wl7GUFl/FwvbgsfdlNAVcJFBFrsvq1y9pTxUhIacfl+KvSPkXaHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFOM5LHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFOM5LHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CB2C113CC;
	Fri, 10 May 2024 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715369456;
	bh=AKyAow3/wzc/Ot9e9YRui5V8hO3If9LCvP1JmKecbqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFOM5LHhmbuaAigFGy+V9f7hNlxpo2QRMDHP0k7iwOUmLiC4nkLlRuxfqOClxhTw7
	 E6ZWtRHUZKdDBDQPODd7sSS43xdOtj36Fw8vuIOj0aTasipX+nIyDvdTRxIeuBAaPI
	 /4Usus/Hj8MUE6LSfCj1FEjBMhRoONHSdallPWO13veJQwCcynIK+eupp44cfUcYC4
	 8A7UHZ3mHddl8VMoSVUWiqy/6c4ugIdH3oeLGCtX+RUR2LYk/da6OcGFQdlpecyA2z
	 Tm2we9K2wCF1E0D9nCtxmzRd+ZG6dtwZHH/k/Iuh512vWQP96nWvtqTRdFxv3NTREk
	 DfNOZIgy88qNg==
Date: Fri, 10 May 2024 13:30:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, javier.gonz@samsung.com,
	bvanassche@acm.org, david@fromorbit.com, slava@dubeyko.com,
	gost.dev@samsung.com, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH] nvme: enable FDP support
Message-ID: <Zj517BwMrCn7nfxC@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510134015.29717-1-joshi.k@samsung.com>

On Fri, May 10, 2024 at 07:10:15PM +0530, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data lifetime information using the write hints.
> The SCSI driver (sd) can already pass this information to the SCSI
> devices. This patch does the same for NVMe.
> 
> Fetches the placement-identifiers (plids) if the device supports FDP.
> And map the incoming write-hints to plids.

Just some additional background since this looks similiar to when the
driver supported "streams".

Supporting streams in the driver was pretty a non-issue. The feature was
removed because devices didn't work with streams as expected, and
supporting it carried more maintenance overhead for the upper layers.

Since the block layer re-introduced write hints anyway outside of this
use case, this looks fine to me to re-introduce support for those hints.

So why not re-add stream support back? As far as I know, devices never
implemented that feature as expected, the driver had to enable it on
start up, and there's no required feedback mechanism to see if it's even
working or hurting.

For FDP, the user had to have configured the namespace that way in order
to get this, so it's still an optional, opt-in feature. It's also
mandatory for FDP capable drives to report WAF through the endurance
log, so users can see the effects of using it.

It would be nice to compare endurance logs with and without the FDP
configuration enabled for your various workloads. This will be great to
discuss at LSFMM next week.

> +static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
> +{
> +	struct nvme_command c = {};
> +	struct nvme_fdp_ruh_status *ruhs;
> +	struct nvme_fdp_ruh_status_desc *ruhsd;
> +	int size, ret, i;
> +
> +	size = sizeof(*ruhs) + NVME_MAX_PLIDS * sizeof(*ruhsd);

	size = struct_size(ruhs, ruhsd, MAX_PLIDS);

> +#define NVME_MAX_PLIDS   (128)
> +
>  /*
>   * Anchor structure for namespaces.  There is one for each namespace in a
>   * NVMe subsystem that any of our controllers can see, and the namespace
> @@ -457,6 +459,8 @@ struct nvme_ns_head {
>  	bool			shared;
>  	bool			passthru_err_log_enabled;
>  	int			instance;
> +	u16			nr_plids;
> +	u16			plids[NVME_MAX_PLIDS];

The largest index needed is WRITE_LIFE_EXTREME, which is "5", so I think
NVME_MAX_PLIDS should be the same value. And it will save space in the
struct.
