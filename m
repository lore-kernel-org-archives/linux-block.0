Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644197;
	b=ApT120zjYwVMD1aETxcUq7goFQ2md0IUiYILM9RSZJoaNpQEZPaTKuT1J+W+WPXDhymN
	 1yf+TOrxOsNkakCBo2y2dOJ7yYCX6glcfiN0LJkIu9/psb2uZ2JT2/WXZf9uErhXVAQZk
	 qcMpvKS6SHeH26D4BFy3wgQLEarbgzhmuvEOx6wg7iTqIXZOcEA9TVFAUuQ7zXyETnI9+
	 18r+CvC+5/IO4dDalFRpSCz6Bg/k+SgpOZK6W5VNWJQvWz9l3fU63V+oSo6kdxJZhPQI9
	 j8rCFpl0fDoFZXvtUB+MdpjSdB/5bJ5J4Bx4w2W2ePVBYGgXEgjBmAw8pz/EBrNdQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644197;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vUeq5LteBRvwR4Wuc6WX9RogAMz5eXkXkWOEBxiQ1EM=;
	b=2I5+KBBhKyRji3S+ZSw309i/zmtw4KW03aUIyG1/6vF2eAPZOO3RMYk67Ig0vJg5M17l
	 l/RAOPHQHXc3k8oYGOuUEk7iRqBA64IyXwZO/MzFjhQ+SKsUYeuNbHssEOKwGZZA8Xzuy
	 PdtooThnswACIKSQxhsSn0gkmXn7iKeE6o/f2t0YwBUeG/pqA5gNa7X/MKj3ScpRV7Dcg
	 RcOQH8bBK9deJZ7dsC3UeKq3H1+58eb8kGLV8pQG6U/GYNZggRUp0IGReB267PclD7Gwm
	 fcxuOvtZ5qKIoCXh9/dpOaLA7enVrKvM29egbidOg1AnbePRglp1AVDp0RlFAfqqc5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UB+RbUBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F01606A31E;
	Wed, 25 Nov 2026 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UB+RbUBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94D71F000C6;
	Wed, 25 Nov 2026 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795644197;
	bh=vUeq5LteBRvwR4Wuc6WX9RogAMz5eXkXkWOEBxiQ1EM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UB+RbUBBtKIA30H5GdjQc20xPbyAQorjOzKDIRLOwGZ6IYuTYgvNXdJTWrt/Pu0GL
	 JTjQGLR2nSvl9s9buKqgU7DSOrLRn6BzE6syepE5VXJCu2PFBp5zcKQi9HfvnXchXq
	 5KH3xQnvNDSrHu9EglqE+CFB8o6vwf2Y+G8mDT4zW7JBmT6WbFt1FJePH0fTmdRlkQ
	 U07atZlDbuwA2gzLppS+360UUjKlsjNuoDyKu5j3hTx5nmMXfdxku7jk1YPqwjAPBC
	 I773QPAZ2QQatrzp7awp3NE+udNyHwQcPCDhuEXoY4SVegsGplYw38wNXFd8XpoU88
	 VLYnJCzbADKiQ==
Message-ID: <6c33dae1-2f63-4583-b322-bc4c4139e25c@kernel.org>
Date: Thu, 26 Nov 2026 07:03:14 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
To: Alberto Faria <afaria@redhat.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowangio@gmail.com>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-2-afaria@redhat.com>
 <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
 <CAELaAXwH8-gn+nuD96gDSeKZMgKZjX22Q-hVywXbQL8si6S1Pw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAELaAXwH8-gn+nuD96gDSeKZMgKZjX22Q-hVywXbQL8si6S1Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/26 18:16, Alberto Faria wrote:
> On Wed, Nov 25, 2026 at 9:07 AM Johannes Thumshirn
> <johannes.thumshirn@wdc.com> wrote:
>> On 11/25/26 9:39 AM, Alberto Faria wrote:
>>> +     /*
>>> +      * Do not advertise FUA when the device is zoned, since we
>>> +      * would not be able to handle it on REQ_OP_ZONE_APPEND.
>>> +      */
>>> +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
>>> +         virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
>>> +         !(lim.features & BLK_FEAT_ZONED))
>>> +             lim.features |= BLK_FEAT_FUA;
>>> +
>>
>> Can you elaborate why?
> 
> The virtio spec currently only defines FUA for OUT requests, so there
> would be no way to pass on the REQ_FUA to the device on a zone append.

Still very confused. What does OUT requests mean ? Is it the data transfer
direction (device to host)? If yes and an OUT request indicates a "read", then
why single out zone append? Why not all write commands?

If on the other hand this flags indicates that the command cdb is one way only
and cannot return data (e.g. the written location that zone append returns),
then OK, I understand. But the comment should clarify that.

-- 
Damien Le Moal
Western Digital Research
