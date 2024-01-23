Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3535384;
	Tue, 23 Jan 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987051; cv=none; b=dr4MxqSnj8UxAXjWK7hdn1Ubokd3iuDptLekWRVlqfLoyXL9dNrTgZEqq6IkzbZckcJnCaXwy/VsZpkI6uiXhFtaHIx4iDOip5SFiO3wMALMr3c1wh8VDxUehbJaaZBy0+VmVVSbbD/1BaQLmGcQAUbRwVNJTxwV+3jiIxSfv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987051; c=relaxed/simple;
	bh=j2np+Yhw+N6TriCvLQQ/BYSPg2nziphCSgbEqkvZeEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6jV/kR0GGYcW+ugKlT2RrJwGuKZwjDc4YrdTZ/RXOHlylMHXkhRwrDcp4UEAt1ay+Q5Qv+UdVSY7DhuVS9M4fJNoYgjW4y/UdlZOWJacK71J1h2tQ0r53hnQv3RogSEn8PKAcC5ZZRiOVZGeOStGL1nSRPwzi8kvYEEO+FtmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWuEPDpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWuEPDpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A21C433C7;
	Tue, 23 Jan 2024 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987051;
	bh=j2np+Yhw+N6TriCvLQQ/BYSPg2nziphCSgbEqkvZeEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWuEPDpQ9d4e8/z1awq38zcsbpYA/KM9napcqmIaHC0/FaouTXYcIQPA6ue6sRO6A
	 imhCrtm3512yxIl6GRK2PDepQm/44fiifZqPRuYgwK2ngYv4LZGRpiO63V4jywUbDx
	 WjRONBJ/5qvAjcGTmQqXmPiG4scVkKNMOSU8rcPf8GnOb9T1Zt6he3ymLFOvZl/O53
	 KffwbRsgAK+Jbr3/ksp92zaVt+qBWPFlK9/kvOKnUGsL/dYCZ7kIpbGnqKX2bdYlFA
	 1lnfw8vhyKLXcQj3f5EQXkz1Df3QRYn1LKqu5gIimlyfYd3ws1k4dM6WqN926/PaXe
	 SZ+i6BHcdqegw==
Message-ID: <5336b36d-fc5d-4ed0-be2c-8f3e42de4b93@kernel.org>
Date: Tue, 23 Jan 2024 14:17:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

