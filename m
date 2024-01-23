Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512481FA5;
	Tue, 23 Jan 2024 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987185; cv=none; b=cXET7XMYi7OnXNSbiTbqvbn76Ezb3eM/70H+nWewuJrzBaC1bDaIPLXAUU4MqjGk/o8O6D/QF1NBwCakUrExnGsCGt91Ozi8HVVKYFs8ZcSHcyvRnLJ/gj9loL1FALzfrX44m5Cy7Kw/gjVgTq9B8ykdbNAWXBujphz4K1HjwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987185; c=relaxed/simple;
	bh=fTwXC5a+GyvoKvS4HGH/GTBafoY2st06hVenMAUFCO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOp+IvDjr/EOiMchvVMfFaVpc+CB4fPEGJHuz1c8RTfnDHr/Prz2fI5wsP/U6lOoMp7zpEcHBYq6X4kOlPnpcxLkcuNhyxrHRAbARx6TBSNxYV3H/f9VwoCLMzrX8jUc4urVbklb7ZUFTeyroeLVJPJxJBPK3nbJ7GM7QTJDWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbNGrW+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbNGrW+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6498C433C7;
	Tue, 23 Jan 2024 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987184;
	bh=fTwXC5a+GyvoKvS4HGH/GTBafoY2st06hVenMAUFCO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbNGrW+LcTZcEwmz7X80teBShRjqua6PYHO1i5X7e1jf3cyTe5cG8eBy7wFfMgv3z
	 2oULZZQB2fTqWaxi/f6s6+OF6oplZPU6an37oaZg6qOluva54lgSlSpwe6n5hdrY+X
	 r8ff4OX7JoobbN9lGc8JwmHc76UT8zxUDJfSmUNXnehgV+oQNq+nZpnJob5ln77PgC
	 F468C5wBz5GmAgVWzNH2fE8YH9kx0IYJmgZmK6MVzjpeSG+0GKzFb+LYkY4QMce9tN
	 QunJKXEFexkep90UJNBD8iKtte9s+AcqxWqSUL/homPDTiao+cqVazEwrK7Df+zXde
	 VzLLRlcBHyFqQ==
Message-ID: <d8e0f81e-b269-49b3-92bb-c039a2dfbfaf@kernel.org>
Date: Tue, 23 Jan 2024 14:19:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] block: pass a queue_limits argument to
 blk_mq_init_queue
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
 <20240122173645.1686078-10-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_init_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Also rename the function to blk_mq_alloc_queue as that is a much better
> name for a function that allocates a queue and always pass the queuedata
> argument instead of having a separate version for the extra argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

