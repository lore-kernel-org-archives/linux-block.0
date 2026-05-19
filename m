Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5D3DD87C
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177340; cv=none; b=Qfi+8Vur/tRi13eKDZX7oEUg30AkM6EkIq0gjIlzK1AX/d9LDKxn4Pwlo0+M/1uU6jng7e37Mpg8ztt/x5rHN+r4shvh1oGjT9ymtEMwlKMJOSDgYXWzrYj+i5leAF5pw2E4Pv+kbn6HQo+MnD+ZL/upcUhPI/aflnSIlzRNmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177340; c=relaxed/simple;
	bh=MXBiZ/wthBntpSi+XVh/5KZUGWD1ymfLzKpiLi2B+50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLg30YnlUDs7dqC1ap1cTf3oYLaXSJemme9wD1Hzs65tAp3xNi3/azvXJpKPFujZKIzA6XIoOI+EOWKAyWk1SAK21ZJEnSOwqkpmnTMIvl6PC23jL5lLN1h3tWeD+IKC2uwSZTlpASw3XfVuaYFZoDD6UeE5B/cJmlPA9N1pNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks1aaa+s; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks1aaa+s"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso1649766f8f.0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177335; x=1779782135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=ks1aaa+sOp1IU4Gt4nMoXDYLCXD3Mx+MGbDkxgF8grRjAcwSob1Qq/k4toYk6mwLeV
         qoEL9iT9F7oFpcFmcO+ka12sKKyWyymSGfBm47llOR7KuUZ4EyRJBO0cGW9IQunqoYtw
         D2U5DyBoASaN5/xXTiSQMwJjMBgh+drWKglYcIJ7eHQ0mBqVANk+svcqRzgmxR87zZs+
         VgzkEyi7wlvf+Pe7YnQnM6SMSw6nPlH6O1esy7/oTVXftAKeiccmv49bvoyPTYfW8u89
         c6rT6f2ScKw48a6OOo73lL9scxd4NYF8QO8lTGKzXhKvvHF1KGy1qtd8ESF65fOoDbuI
         KGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177335; x=1779782135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=mlC0dXx3RvNnuWxlmMmiMMcTSEuAqEGeqnscaIat0XMOZshE6Gy5mbzGZiyRiL8myW
         QSSRzQpmKRw67cAT/CkdlCgvntzbJnH5pkeHE0bUzm75jNLNA5nroL5A4xq2Ir7nlC0M
         tpCM5FAaNWBU1OlB2f0AdutUT+x524Z/zjJEqwzJeuxWaY77U4xvDIZQPR5s7eL0HzS2
         YuUI9Y2tImZdeMS1TstLalDjPO9Ts6W0jqXJ5AF6nK16dnhC313y9mu48yfTBpRRiPjH
         VcgJ6G1sXE5z6M11VPgEg715R1ov8Qlnv47ho0nGdBVQxbp0+ewZYamcqYBAT6W9Mg6e
         kYwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ca063rn3GB5e7dlVmuv/FOiATnEIKWjn13L5cIJQeyZXHJVql9n19PurPT7VxdPdn0ANDICzWdTgvyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jgBZCNTtTD13oKZTZ+38d2YeFKTqk/DA0mKOxf6bKIVwnmLR
	GvMfTlJkcrTBG9fYqXORH3ruLKbwojPaWqXdHYcK9MZRhScLGUbT8aH/
X-Gm-Gg: Acq92OFbGxTV9GLy4PlVz+tGvpe4EqZWVz9fLdk0Upa+WutaOoERpmlpz1E2DXSERxK
	BqEEfIBUxzC6kogE6katMdljBWDASiPGU28GC1DC7zz0uRnRlpf5rzzTPcg2wJr8AhPrLmZ+t+t
	6ICc7PFK1M5wVBBBc8vs6RD2c439akxpgu+q9srzkxX5WXTKcSKVSHeMuSFMU82ZMH9EnJh2sP7
	JmjHLbG1zq1XuEOYvc1W0rJSY1EoV2DpvqH0dmxPuignR1cIyikn+6YUehhjm8B0Mrh2zslWMyM
	R8jCM5P65tJUcmoFpXYmgNQQ6X1xDrhfRsI7HxFFCGM4q3joEhGSrdIwtP3hKx3rB8zLmmB65y9
	+/nz/2y7V0hwGy22NFcCB4ss8T3cV1Wd0Mnn7N2QWJv7iZTbOJxqsGbcmUZWIdrWjrn/9mVfcLc
	Fmuidh7+OTYwYj3ISXq4n5FW8ytf7dkcXRg3HbjOmnxPWIrcrbXDGZNk6FWIIVYdFnvelsGN5uX
	laH+/K44z9uLzDESIyVisAWhlPU4r0ETGAYP6mQot6Wy4Ps/G2p85KI6W1wetZUh0KT/PiN8lmo
	KQ==
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fe60ea590mr265981195e9.12.1779177335066;
        Tue, 19 May 2026 00:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm329088665e9.6.2026.05.19.00.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:55:34 -0700 (PDT)
Message-ID: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
Date: Tue, 19 May 2026 08:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
 <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
 <20260519065653.GB8173@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260519065653.GB8173@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 07:56, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>> To be fair, it's not that dma-buf specific. This lib/ code only
>> does some resv locking, fence waiting and queuing fences,
> 
> But all the dma resv/fence stuff is pretty tied into the dma-buf
> ecosystem.  I don't think it would really apply to something not
> doing DMA at all.

The point is that those can be separated to reuse the rest.
  >> otherwise
>> all the attaching is done by the driver behind callbacks. Switching
>> it to some memfd could be pretty simple. But The main thing it'd
>> need to share is iterator handling like forwarding in the block
>> layer, and it should be fine as it's already passed as a completely
>> opaque object with no knowledge about pages / dma / etc. for the
>> middle layers.
> 
> But none of that really sits in the current lib/ code anyway?

It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
dma-buf would be confusing, and then it'll need renaming at all
layers to support the use case.

>>> lib/ is most certainly the wrong place for something that absolutely
>>> is not library functionality but directly interacts with a few
>>> subsystems.
>>
>> It only interacts with dma-buf, and even for dma-buf attachments
>> are created by the driver. Block, nvme, io_uring are users, either
>> using the helpers or implementing callbacks.
>>
>> Ok. Let's assume for the argument's sake it's not dma-buf
>> specific, if not lib/, where would you put it? I was also
>> assuming that dma-buf being under drivers/ is rather a relic
>> of the past rather than the desired location, hmm?
> 
> drivers/dma-buf is a pretty natural place for it, I could not thing

_If_ there is no dma mappings, drivers/dma-buf would definitely
be an awkward spot. Just trying to understand your criteria for
placement, let's say of a generic buffer registration code assuming
there is no dma-buf involved at all. Again, just a hypothetical.

> where else you'd place dma-buffers.  I'm not sure how hmm has anything
> to do with it.

Looks there is some confusion. It's was meant as an interjection
with an open question, I didn't mention the HMM subsystem.

-- 
Pavel Begunkov

