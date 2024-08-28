Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7760156872
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829463; cv=none; b=YT66dVQI1WG35xF+bM9Z9aKdCyg3+eR9b3dgSXWDo/Ng3e3j4IApg5STFcVnPNVw5ZN/K+VP26n2i/Bh1TMzj6ZapHyqNST1qNVGoBwJSBQ6zUspHiDrklZu0wPsONGxWB6qqF4NqlfwsUDZLXJaWVc8N9lDPix1Awm5Pu6o9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829463; c=relaxed/simple;
	bh=yAmxD2apeAdddPp6XGfvkthfGKBNe0KhvOJy4iN+qsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrKCcoQS7Oe6aG7FykZtHojwDVCntNdV+mlPUb6G7BDe6v1j2QeqjPBKH1r2zD7Ozu1ZrQWPk0y7Dc5ND8tSh2Y+Au/vcxTGvX95KfQNu2M6VmAJ9Ku60m4bC0QAAZvVwGm6V34NYeXQKlzgxJPU+SHJtn62zVF4i2rZHIjm7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1B6567373; Wed, 28 Aug 2024 09:17:30 +0200 (CEST)
Date: Wed, 28 Aug 2024 09:17:29 +0200
From: hch <hch@lst.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: John Garry <john.g.garry@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Message-ID: <20240828071729.GA1653@lst.de>
References: <20240815163228.216051-1-john.g.garry@oracle.com> <20240815163228.216051-2-john.g.garry@oracle.com> <jxozlplk5fforzhc5hgmanqszw7pb7kuxbo2f23e5xtu3yozdy@tneiyvantisq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jxozlplk5fforzhc5hgmanqszw7pb7kuxbo2f23e5xtu3yozdy@tneiyvantisq>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 07:15:55AM +0000, Shinichiro Kawasaki wrote:
> I ran may test set for the kernel v6.11-rc5 and found that this commit triggers
> an error. When I set up xfs with a dm-zoned device on a TCMU zoned device and
> filled the filesystem, the kernel reported this error message:
> 
>   device-mapper: zoned reclaim: (sdg): Align zone 19 wp 0 to 32736 (wp+32736) blocks failed -121
> 
> When dm-zoned calls blkdev_issue_zeorout(), EREMOTEIO 121 was returned, then
> the error was reported. I think a change in this commit is the cause. Please
> find my comment below.

This patch should fix it:

https://lore.kernel.org/linux-block/20240827175340.GB1977952@frogsfrogsfrogs/

