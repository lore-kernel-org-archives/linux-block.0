Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D41D9A66;
	Thu, 16 Apr 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316547; cv=none; b=C3ja3k6NSgRC8AfPiuNOFFRHYgAZeIQyNU1d127B+qGzQRu0e1zk12co7eTLYgAZ7Ra7/iKRxc2Y1c99lrgpDQlR1ufG7X5Pw6dnx1fiwct9XEpaFt6TdmeIeqs2p9SDjuEhE1sTY23SQ8h0QQEhEfoqzo2xRP1st+Oate6VZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316547; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es5SiHbBx6CiAm7qYI3egFj/LDf0m25llzojjtsObguixoMkvIwxtWJo3TteRI7ih+EdsUMCOP/N5dQIiBrrqAGT50eyNhi3M1psVqAdO8akempgO12rYUbcEfIpKt+hQ+2yvGXhEYEvz35jzjL0Uaj3y7CK9EZYGigKM5JnBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BFE768C7B; Thu, 16 Apr 2026 07:15:34 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:15:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com,
	mlombard@arkamax.eu, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing
 new ones
Message-ID: <20260416051533.GB14802@lst.de>
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415230250.2783414-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

