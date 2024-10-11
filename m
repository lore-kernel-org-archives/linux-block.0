Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426861F1309;
	Fri, 11 Oct 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634497; cv=none; b=IJsZSKyNAxIFHOH/hXDt1K+7w3C/+bSeG2oFWo8R+4e0bLdF6Vihr3L4r0b0dnjHcEeQM6+kq9+TXUOsyJ/xtg3GyJQoelop/CpKpYOgXuHIkxkMWe+b9RA4cU4ELhT0W+eioE1fDhr11pCecIAAwssYmee0ce6OvFHBa9TmNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634497; c=relaxed/simple;
	bh=dy3MV8+N6fy20BNYe4xwuMbKMUtMNnfgkD9SVol5fBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT/csZwquuXyppEVn3HVWefZQWTtETI3lKz0r1Aa8Pz1B89onpbhcsiWnIcJAKPNs2vxPhGIrPkhIvhlGUFq7m1qDZFkz3/NhVLBAlsh8UFzf/vGUoM7acVYbB0ksrfivIcY5SM5WBVoAQkMtedX3YAUL0g6P8XQvJXhLREo88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6310E227AB3; Fri, 11 Oct 2024 10:14:52 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:14:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <20241011081452.GA3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-2-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-2-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> The NVMe 2.0 specification adds an independent identify namespace
> data structure that contains generic attributes that apply to all
> namespace types. Some attributes carry over from the NVM command set
> identify namespace data structure, and others are new.
> 
> Currently, the data structure only considered when CRIMS is enabled or
> when the namespace type is key-value.
> 
> However, the independent namespace data structure
> is mandatory for devices that implement features from the 2.0+
> specification. Therefore, we can check this data structure first. If
> unavailable, retrieve the generic attributes from the NVM command set
> identify namespace data structure.

FYI, I still disagree with this for the same reason as before.
Assuming we're not really going to see hard drivers I'd be fine
with using it by default for 2.0 (or better even 2.1) by default.

