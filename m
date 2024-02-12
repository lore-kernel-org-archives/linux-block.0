Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB67462;
	Mon, 12 Feb 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722809; cv=none; b=ds1RpsWrvlu+6zYkcabux7Wcyyd7JgyoLJRd3gDpJDcXpItDeb3CasJzpzlewMoLMWGl4fqi12bv3LfTDJPS+mwRSppcZV4/4WEegZUexP3KbeHzWXQ2O6wytIkqBD+S+MrOquhwrrontOThYStW9ODne2mJW3YYMWXRKASqrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722809; c=relaxed/simple;
	bh=KRvVpg0yMFiU7+mueEuTLVe7ZeaxAMokUzDN33ev9gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1atMJ5wR9Dh25W8HAwDMbAwux5GZFwboXo3hgkvrglBvEzHqr8v5rA1AkR6ORRQaozrjssLmiZk+N1l9YSM7pOkkAyXQ7RKZup+igrmBEWxDWTK+QRtmBiSDpnqenGLGbdyLQ7fdz24RoDFfkw4ES09/CSlwBTsfXPsFTCabw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW2X02JW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW2X02JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA07DC433F1;
	Mon, 12 Feb 2024 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722808;
	bh=KRvVpg0yMFiU7+mueEuTLVe7ZeaxAMokUzDN33ev9gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EW2X02JW4C8aHB4RDG6JtajETg9EHOSnmigtgMhPORXGXMn7aRP0Enp366l63JSqy
	 OJrU4Fznf5pGD6Cx9Un8qIxW3okUxb7yE1saj3s3siFrdqMnvMf9gDUuOvJ0fyw99r
	 lAw2Vb5NHn3O3ZyKy5D1WbUtv0OH1DrL3L9MrRj8fRTmOTMRz+MZBAwsD++SMY6OVF
	 y7C3JTfu3xXmXZHQFImyGtbwH4K80tyM99k4OUa0eYm6lXmINrpWmR+hMzOzdzOCNJ
	 oWaOqpCGQ2GA3gTYrU7CBYZzxpD+bnAT0C/vAl2x/cMVPZI9QexoJSkyq9EZT5+tlR
	 5dFJDm+DPwDVw==
Message-ID: <2705379d-7fdb-4061-aae1-4c37f74e1801@kernel.org>
Date: Mon, 12 Feb 2024 16:26:45 +0900
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
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-9-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 15:46, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it after validating and
> capping the values using blk_validate_limits.  This will allow allocating
> queues with valid queue limits instead of setting the values one at a
> time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

