Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28631233704
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598319; cv=none; b=B18Kq8B39wV5aHwkrdsc6v/l2YXTrjZb3C0fA2OSp45kJpQB21/RiRrBtGLg8y1CfB7cgAlRPoUzWO5Q6adRDrrm7RnOBtZ9MCtWonrVANo5MamF4e5X0wjDDln9n7q8RfdWLCWNYIxW0QBX1ZJ0EX2p2lcONmqkJ4ZArABMAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598319; c=relaxed/simple;
	bh=OOW6Oa67YboqbqdsYF1VnxZMxAruEn+Tzzb5FOCwbnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am7O1ANzLB3WgtSbEssVBtTdgZDKAO4Z8EyrJLw6WPochH4KbB3RBywUWDDGJ2FiKBDakMqQvHytsHjPCYyI9p3Xz97vvZRH21V8zJ6wjXByaA9fYNzLV83G0QWNBC7y1pa9de8L0bOSRlSgkMmWKhls3Wauk1xuhCuepdjfBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVvpP3Hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVvpP3Hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68457C4CEE3;
	Tue, 15 Jul 2025 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752598318;
	bh=OOW6Oa67YboqbqdsYF1VnxZMxAruEn+Tzzb5FOCwbnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVvpP3HuGkBjogbuFUIJwW4OK16+ZWx5xVCItnFBMPy/gLwtqTSWXALid3STB9/NC
	 CR7c6i9zZ0Q1TtZstmvHjv2A0UNoYz/FY3J/Os+hD0ITieIw4Xa+9Sfrt/ne1Jo/Fv
	 IpoxV/IXYPWcz0TEwEdXTxh8X6zXrk0FGyUVt3QX3ZVpEiRDOmqnzrHFfLt3fvLs3k
	 NHihD0wkItFb90jOzofVzeik2jPE1pfFg2Q8CblsTHKpdFipA2NDotkfGgpmHGzyP5
	 A+tye7MePAw15LGXaxjcw8m9n6r/DVRwdUjp2FsI/7rqBSNfBfG89f7r7k9I4upF6y
	 DRFoxY+LDvjkw==
Date: Tue, 15 Jul 2025 10:51:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Coly Li <colyli@kernel.org>
Cc: hch@lst.de, linux-block@vger.kernel.org
Subject: Re: Improper io_opt setting for md raid5
Message-ID: <aHaHLKp7-RrYUeJW@kbusch-mbp>
References: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>

On Tue, Jul 15, 2025 at 11:56:57PM +0800, Coly Li wrote:
> 240         if (dma_dev->dma_mask) {
> 241                 shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> 242                                 dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> 243         }

Just comparing how NVMe uses dma_opt_mapping_size(), that return is used
to limit its "max_sectors" rather than opt_sectors, so this different
usages seems odd to me. But there doesn't appear to be anything else
setting shost->opt_sectors either.
 
> Then in drivers/scsi/sd.c, inside sd_revalidate_disk() from the following coce,
> 3785         /*
> 3786          * Limit default to SCSI host optimal sector limit if set. There may be
> 3787          * an impact on performance for when the size of a request exceeds this
> 3788          * host limit.
> 3789          */
> 3790         lim.io_opt = sdp->host->opt_sectors << SECTOR_SHIFT;

Checking where "opt_sectors" was introduced, 608128d391fa5c9 says it was
to provide the host optimal sectors, but the io_opt limit is supposed to
be the device's. Seems to be a mistmatch in usage here, as "opt_sectors"
should only be the upper limit for "io_opt" rather than the starting
value.
