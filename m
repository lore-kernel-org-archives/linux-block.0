Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4395613A;
	Tue, 23 Jan 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987627; cv=none; b=PVsECuyqaLYm14JsOqZ97u/Y8cmqFc3CLyOMNpQI/3MzLBf8qfhryxGTJabossvMx+6YA/0wtsmbz8Elbr6fFdMWFyifppQkA5StkL0bR84OcAoTMN7w7zRXd6sQA+5Ecp7JL3TOLSHPboxRkHmxsq1DocLVyKNiQxYocQa3H3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987627; c=relaxed/simple;
	bh=cPpu6ryn6gkRkvgmx4NerAEJXJOWL4ErojxtTppxpQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB9Mw3SLOM4JdaLUh3i8g3UPmcq7TZmFsMneJxIEJXrZDPCpOwfXm69GSMDneIF5gtL8L+Yj6GSoh2rQrkgifONTpfn6Qojtke6WdPlre0ykPNskeNSKyHB9WuKXmpI+tihAfI0YWvtCih92GHkBJOsXAZ6t0uvhsfACmLjpewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+V5V36Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+V5V36Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CBCC433C7;
	Tue, 23 Jan 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987627;
	bh=cPpu6ryn6gkRkvgmx4NerAEJXJOWL4ErojxtTppxpQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M+V5V36ZwxIdQ8NpR4onAMDbaeC9+Rg48L4OWqwJG51BX9RMubDfuV8sjIh05WA2J
	 GpYgeCxXjJk8jFhXnrGYDtshunmpZLjdt7NKlE76dOwuIJp888x8RsuVgJxk03V6So
	 yi8MkobMZ4oZ1nWwGQKESKgY1gbD5jgohXPS1LZKOG1YOsQNQK5KDHs3C/q0FCte6O
	 8ZEe3S9IVUrQ1xM8r5aFclcW+QFL0tzfCiyKOXKkx1xAW+GTwAlytvEtbLbbxYHsc9
	 jnwXrLixQoKT9kNjOXdrvMBpyl3BuYPS2VdPrnEG2NOrL3jjGyprVZeWuu5ncV06cJ
	 E0TCPQK3VmsFg==
Message-ID: <0e8dacc9-0353-4e1c-a954-986426abdbf6@kernel.org>
Date: Tue, 23 Jan 2024 14:27:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
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
 <20240122173645.1686078-13-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Call virtblk_read_limits and most of virtblk_probe_zoned_device before
> allocating the gendisk and thus request_queue and make them read into
> a queue_limits structure instead.  Pass this initialized queue_limits
> to blk_mq_alloc_disk to set the queue up with the right parameters
> from the start and only leave a few final touches for zoned devices
> to be done just before adding the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

