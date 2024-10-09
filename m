Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA213AD39;
	Wed,  9 Oct 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460092; cv=none; b=qh5Q4qkwmyO2wGdoDZEaoLOJB6wx4V1iwOSVD6P2d53gL4v9oM+MGmQsy5AlZ03zDu7EJALJoB/3ux16IfI5YnbLnkuiWReht2yw0P1h1J/5XLahT8OXl8qUrXmQuNAjkCnZ6yH7hXnvmQExVnkAq6buzOS8Aj6rfOAPQOGNl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460092; c=relaxed/simple;
	bh=LNxiatCqwg9/DlcqG8QKHqaYhKxmzOGa5j8+rHqy+Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erJ3ey83TVo6W/Zgomyo5FhsgWxBe2Vpy40EZWUQICys9BXtPNLlIrSuTH65oMbL9+zlgebo0nsWT4IR9WR1qepNxRqTU+C9VVTjNouDnlTpd+FxVt9naItrfdhw5XFd7rZ9AyyXSTZdGQscyjVCUvaHfgLpgQz1XfKOZ69OrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C8AC227A8E; Wed,  9 Oct 2024 09:48:06 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:48:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 2/2] nvme: add rotational support
Message-ID: <20241009074805.GC16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-3-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-3-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 08, 2024 at 04:55:03PM +0200, Matias Bjørling wrote:
> +	if (info->is_rotational)
> +		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;

Entropy from block devices is pretty useless.  The only reason we still
keep it for SCSI is because of retro-computing platforms without a proper
platform hardware RNG.  NVMe HDDs reall should not show up in those kinds
of environments.  Also without a add_disk_randomness in the nvme I/O
completion handler this won't actually do anything.

