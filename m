Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09557376E6;
	Tue, 23 Jan 2024 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987329; cv=none; b=ZCQSvIS3Y0G7fcXQ8ismWgBXU4M5DX42vHwxQV5IJjDtEBLC4y1Hf0s8aksARcvNB5xnxPab7bD0wTPZ/8VwoeB3JuqIccV7L7sYJwVIKRVnfCv3KqWd34BAIUKUonRd3FGylGvG9GSXfoCvLcFqW1pl7f8px858kYc6QQBq7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987329; c=relaxed/simple;
	bh=sUwtSxOaabAe1k5Flqo7FosuUxAAdIvjaNGZ0lwzaKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+m4B2hHySwOl7dv0pkiGCRH6AwCGcaSMPTGqZ+7ojMbwoQh2AIisTZGBTLjCiUq6wEpY1AUGikn44DDrA5ES/F0UH3p7C5xmRmenvRsnuPX48g3AI/bkQrhxO0gs6j9pK9UUQX3Tu0phXfCwovQNCgf0LjzLSJt7va7UpDwgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI5bJoOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI5bJoOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4967C433C7;
	Tue, 23 Jan 2024 05:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987328;
	bh=sUwtSxOaabAe1k5Flqo7FosuUxAAdIvjaNGZ0lwzaKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tI5bJoOJJNt+2Dme93P03LHvWU8iigbJCqLjfXNMfB/aRPWmiRqiwBWPste+NFugK
	 AwTy6sV2UXkqxnQDIXCiR8AN9swEee8RqyCTfUd/1Aq3SoVncdBokYFiFpetsA059h
	 pjdBGkIDsLUqyoBuLNtKFh/rBUqzgI59IlJE76BvELpr0GvL7B0ZgTuEOSSsTSk2DR
	 AJ4+5WvdQgd6KZe5Rp5SQ0AlXsA18YM3vPnqJKcnhsnZ1GCTKD+vbsWa+n7zuYzZy/
	 mH+F2ULAy4vlY/JE6b87sFrWAK4wWGAN4MR9lrDMFEjW8p9NisEUmQsDNPIX6oC04T
	 BcSy5Jl4UFLvw==
Message-ID: <ba58f732-e36d-4109-9938-1926371aa19e@kernel.org>
Date: Tue, 23 Jan 2024 14:22:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] block: pass a queue_limits argument to
 blk_mq_alloc_disk
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
 <20240122173645.1686078-11-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_alloc_disk and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

