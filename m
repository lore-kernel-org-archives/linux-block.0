Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B95220;
	Tue, 23 Jan 2024 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987902; cv=none; b=rMY4Q/2LcS2bwlhJgbvUDbTBFEd5rABrVrLDfR+pkwDTl57mPqqAdsSq8J/vfm2d43cj9vNElB2niw2vS3nBwJsA6zdh4Y5rmky45MdFB2Kd8SehLt1c6URrBlndsJOITRZejRKIyKG1pT5M99wqXKHOerVPxKgfwzbBLqmpkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987902; c=relaxed/simple;
	bh=wjCgQi0roIhtkMBplPGFNKHRjVkQdZDEwQLchHAoQ00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkUPF8M+gpMHlyhddDNbkN0zJ1a9uGCuD7x1lHifUMIPRNvSndCod2e/X+oZrqzThHv9zGDmVZ74WOCw1heEqQBz+PJRjfdD3Ltn0yavo2d3ZSoQyQZL6dqXLDRIvunTTepL1HTDCptDDdzvILg4IAsy6ftjOCJYBgj3k6WUaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsZnIFwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsZnIFwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66620C433F1;
	Tue, 23 Jan 2024 05:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987902;
	bh=wjCgQi0roIhtkMBplPGFNKHRjVkQdZDEwQLchHAoQ00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WsZnIFwFc2lm76nogoU9tTQWNwQqxr5K5fYrvmaPN4zqSYAPNTKMeB+OZMTWI2KBg
	 Aksbw52ZN3KYfociTiqWM0uTApVmo+JiV7vkVKeeqaruny6RDmDSFrPUXJNrgCE6Fy
	 JvL7p3CjvuZy5NUTxHzrCZ5ZDMtojJr5JJd+TAgxMCoUU6K3zuG+umT3+cMrUljQT9
	 GUj23txdfuirYvkWM9s6qZ1slKUCsfTcMUvK8d+7PlX4ETI6uMSMSPLxqBcHzkipjr
	 TdA2VnWoVL8Y5rK+Iy+qmKA8V/uE4PpoXG9pRp9lveXEAI9q6k6iYyKVMw1NtxdlN6
	 pBLJwgQBiyH2Q==
Message-ID: <ccedfd42-7bcd-409b-af37-e16cd5e4fabb@kernel.org>
Date: Tue, 23 Jan 2024 14:31:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] loop: use the atomic queue limits update API
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
 <20240122173645.1686078-16-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass the default limits to blk_mq_alloc_disk and then use the
> queue_limits_{start,commit}_update API to change the limits in an
> atomic way on existing loop gendisks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

