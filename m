Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1B44C7C
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124187; cv=none; b=VYdbbU01Sx4HlyEvsOylFBmmSUckES4/f2RE5ffdowIf6PzAbmu91EE5ZG2+qoNyobgD6lDnmhQWnSTZ5UCbqXrY/Rh+nLWGI1ZS+VQ9J3XYOxavugM4NzZsQHTikxkM9HeniCf/+yvZBHXB/YmqOJi9HeDqh6ArhE3St/E0PxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124187; c=relaxed/simple;
	bh=RWo1Xjllp+oFZDJjpCJgNl7Y+4Znnw+WUps+DutqeLo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jd14t/49NLIh+BYarW0M47zth1LqsI5K4E6vh5t5kdcqcSJY2VAC4TEGRr1Zgn70jKS7+0atb9C6bE6oJy41K2IwNKwNDXTydvKiIkOdng+jH9txpufIV8Q7QQbmPH4IRg2RPJhDZvHnHVajDpa1he/m8z2WNmbjDhxizj9LHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esXmwKIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esXmwKIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A2FC4CEE3;
	Thu,  1 May 2025 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746124186;
	bh=RWo1Xjllp+oFZDJjpCJgNl7Y+4Znnw+WUps+DutqeLo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=esXmwKIKZHvoY52uCqudksor8esRl0sUJUVbp1K/gd4s+kxZOonwc+BY1jdZoEpN7
	 7ZrrxG+o90fcorxbcyfohFb6zn17hli5q0jaB0emGLkqmZ/F9QXGnC8aE71HADAUhQ
	 Uc/bhqkuyfrPyLEgj/oUDll2aPJotqeNZVzxO9t4D/7KWPH2APJxccqc/uHPboZC9R
	 7Wh28xNHHFj09T8QCRnxFhD60mO0YdIIqg66r3DlR3h1XAZVFU04RrGv1P8ABvV83g
	 gw25P0+NpEaLGK4LylgMxWJzKek19anpwBWGG5SujrTE8hY1fnWDos3CDUeWXNLaCz
	 ctpn1U+Sc0rkA==
Message-ID: <ba60ec9d-170f-4107-9f9a-4c4ffbbc5e63@kernel.org>
Date: Fri, 2 May 2025 03:29:45 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] New zoned loop block device driver
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20250407075222.170336-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250407075222.170336-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 16:52, Damien Le Moal wrote:
> This patch series implements the new "zloop" zoned block device driver
> which allows creating zoned block devices using one regular file per
> zone as backing storage. This driver is an alternative to the RUST
> rublk driver which provide a similar functionality using ublk
> (See https://github.com/ublk-org/rublk.git). However, zloop is far
> simpler to use (a single shell command to setup and teardown a device)
> and does not have any user space dependencies. These characteristics
> make zloop a better solution for integration in test environments (such
> as xfstests) using small VMs.

Jens,

Can we get this queued ?

> 
> zloop and rublk performance is generally comparable. zloop is a bit
> faster for large sequential write operations than rublk, while rublk is
> faster for small zone-random write IOs.
> 
> The first patch implements the "zloop" zoned block device driver under
> drivers/block. The second patch adds documentation for this driver
> (overview and usage examples).
> 
> About half of the code of the first patch is from Christoph Hellwig.
> 
> Damien Le Moal (2):
>   block: new zoned loop block device driver
>   Documentation: Document the new zoned loop block device driver
> 
> Changes from v2:
>  - Rebased on 6.15-rc1
>  - Some corrections of the documentation
> 
> Changes from v1:
>  - Corrected Kconfig description in patch 1 (outdated example was shown)
>  - Added missing request sector update on completion of zone append
>    request (I had not pushed that...)
>  - Added reference to the documentation in the kconfig entry in patch 2
> 
> Damien Le Moal (2):
>   block: new zoned loop block device driver
>   Documentation: Document the new zoned loop block device driver
> 
>  Documentation/admin-guide/blockdev/index.rst  |    1 +
>  .../admin-guide/blockdev/zoned_loop.rst       |  169 ++
>  MAINTAINERS                                   |    8 +
>  drivers/block/Kconfig                         |   19 +
>  drivers/block/Makefile                        |    1 +
>  drivers/block/zloop.c                         | 1385 +++++++++++++++++
>  6 files changed, 1583 insertions(+)
>  create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst
>  create mode 100644 drivers/block/zloop.c
> 


-- 
Damien Le Moal
Western Digital Research
