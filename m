Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA314D456
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562505; cv=none; b=BSC/MKuuWVd+hSUpaJjet4OVaRQEpjq+N24tHX68FlRieFVPqG7FfBQHhZlT13iUcSloV5OXO/7jneB5IDWV3MXzJ7CYWNYEVxXZVibGmqsn2mWbHMLOgILF1Xwm4fqLmeHyv3AJpSTGXh5FXFVtYrQRa+HF1aaKfU5BcOHsDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562505; c=relaxed/simple;
	bh=HduPs94q+QhQQ2NCQNepM6fIX356TE0KHJzgIrpMCt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCQPY+HEgdRa8B0vp6PM5UcvlYlwudhwhmVSFPvFcV7HEohmwkjivEX1mOLUR5zyt24zIGi52iFcF4o/uCLj5xqQ7DZa0LON2bjNfGxbZXN2XMf9sRbDjVX2w666v2ML6z+RFQBE5u5xyTRRpggaWdEo9TYsxqg0IjhYotbvDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbtYiscd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbtYiscd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9E9C433F1;
	Wed, 27 Mar 2024 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562504;
	bh=HduPs94q+QhQQ2NCQNepM6fIX356TE0KHJzgIrpMCt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbtYiscdFaK0nnBITplEVWR2ukuhlk4smChuTGuLPBDmz3A9YWyJkM7KUP2MU4Bxk
	 CU1RkK5bUJ5Ed+5w8n+oMlKn6GFtcPIzidATF/+mqlID3/0X4zrYonATNvTUh6r1ia
	 nLkHGJm+xmYiahpgEDveiQL2DRO1GpoFMu25cbI5nHeTxL8LhjUVfHreKAOgfZ1uE1
	 kctJfXrWU+VtBSmB3TYbqF7q2ay+R98iOqZ9JFL1Nkw0Q3NGiEJhCHGxk41ws89eA6
	 xORTc/DYESZLUwJbepN+2ghF40sD7Mltg5J6T0kRe1XDDH/LIhOxyIxaY0cloqQfiS
	 b7h6rsHwpXvbQ==
Date: Wed, 27 Mar 2024 11:01:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: cancel the queue limit update when
 nvme_update_zone_info fails
Message-ID: <ZgRfBqorU5ejb1lt@kbusch-mbp.dhcp.thefacebook.com>
References: <20240327172145.2844065-1-hch@lst.de>
 <20240327172145.2844065-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327172145.2844065-2-hch@lst.de>

On Wed, Mar 27, 2024 at 06:21:45PM +0100, Christoph Hellwig wrote:
> @@ -2115,6 +2115,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	    ns->head->ids.csi == NVME_CSI_ZNS) {
>  		ret = nvme_update_zone_info(ns, lbaf, &lim);
>  		if (ret) {
> +			queue_limits_cancel_update(ns->disk->queue);

Could you instead move nvme_update_zone_info() outside the
queue_limits_start_update()? That way we wouldn't need to "cancel" the
update. You'd just need to save a copy of "mor" and "mar" in the ns
instead of writing these directly to the queue_limits.
