Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763436D
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918497; cv=none; b=MKnqzSrnR7xpPfmNOipMk/Nww/TJaeBBRv4+hUCBfUt98jQIeH99t/iF3cSi2rJ6oKF93nZFsVfOlE3xFOWINn8bRpeAfGNNxgYSHgcEtFpwEgB55P7tyYvciigkvLAWPna9XYcWqHFmy5t7XqefzsyeC7HvC4W/nmUCf3PhVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918497; c=relaxed/simple;
	bh=q7sxD0h5sNBrbaEgmzUwvS0OwTu/1CWdVpn37xS4yI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY+s/zk3OfWxXDih3WE54Zvt8nTHnj5EvoH6OpWUPEkeRpZRHkjW0SPOfSqGBJ6WmaeeG19r2YZ6PbAYOEPcazpqMVEYfr8j9qTw7KQyNH6jLpoLR+a/lS3qAQwTzKMx8vMOO8SeQe48oCPbeKEUAL/ep2cLuv/o9nd9ye32LrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKlVDzah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKlVDzah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8708EC4CEC6;
	Wed,  6 Nov 2024 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918496;
	bh=q7sxD0h5sNBrbaEgmzUwvS0OwTu/1CWdVpn37xS4yI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKlVDzahtjJYybEsZjbxHjMCbi7xp0KA7NCSIXl3Uk3MBSQZUtkYiq03aFF74V5XN
	 swPwsLJJx/pvi8JGLWf1lfno9ECd1fWwdNbmIR94JFEuLyZai409i7hr0YihbKyy6D
	 VWR9Ewq9lY7xU6Pvytupf30Len2BgOExHrJ4dEqtJUtCeZIl4nUjv3yqu5fZ34eWd1
	 0iWG3c1gkfzfzwgp5IYF8hSs5JxQopgb4GTnQNt+hqdByC97D19GsxPTHS0WigLzuB
	 ExXEK0aQZMmUuk88AfX4vUXWAfDTB8sF7mPb2qH4soKxa+dT185VoVaWW47vlzIICU
	 nstOV59VHi8Cw==
Date: Wed, 6 Nov 2024 11:41:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: pre-calculate max_zone_append_sectors
Message-ID: <Zyu4XuKxAoVEHKp1@kbusch-mbp>
References: <20241104073955.112324-1-hch@lst.de>
 <20241104073955.112324-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104073955.112324-3-hch@lst.de>

On Mon, Nov 04, 2024 at 08:39:32AM +0100, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6a15873055b9..c26cb7d3a2e5 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -636,7 +636,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	if (head->ids.csi == NVME_CSI_ZNS)
>  		lim.features |= BLK_FEAT_ZONED;
>  	else
> -		lim.max_zone_append_sectors = 0;
> +		lim.max_hw_zone_append_sectors = 0;

I think you need to continue clearing max_zone_append_sectors here. The
initial stack limits sets max_zone_append_sectors to UINT_MAX, and
blk_validate_zoned_limits() wants it to be zero.
