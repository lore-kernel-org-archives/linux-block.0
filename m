Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44885EBE;
	Fri, 11 Oct 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634535; cv=none; b=GQEO60Y76gcbGZmEJZbskDPHWf9JmBwfxr+u3vgus7DL3V+Issd5nNa4KimIoFBMWQ8oHN8DnAJacJ5pCHkFEFWqa0rOXG6aWkWz2jI3w/aZ0Nx/CGUUnQiQoOmRld3q00plHA1ZYaKtz+N2+55D0mrUS5GBHA4tPc2xRCu9cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634535; c=relaxed/simple;
	bh=4wPvZGGoLtunxLdPboh4ypFVrat8Vll8sYtYJqkbbXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWAG9beKCADiz2DfBJFHyHDW1n5oFSSJza3b4Eg86yCoXvxyFExiu14XpBi9zlHyXa3pu7qNMYVXn+vgiLFT8GTgNDed1htNkBz1iVSYbuviVXMzVZ/OUy52cqNuOhmWMZTETKr/aKU0RqggWg0WaIx7KSUl2WhZpzKdSBifokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F084227AB3; Fri, 11 Oct 2024 10:15:30 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:15:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 2/3 v2] nvme: add rotational support
Message-ID: <20241011081530.GB3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-3-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-3-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 10, 2024 at 02:39:50PM +0200, Matias Bjørling wrote:
> From: Wang Yugui <wangyugui@e16-tech.com>
> 
> Rotational devices, such as hard-drives, can be detected using
> the rotational bit in the namespace independent identify namespace
> data structure. Make the bit visible to the block layer through the
> rotational queue setting.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>

If you pass this on, this should be a Signed-off-by.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> larlar

?

