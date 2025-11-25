Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9B239562
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078745; cv=none; b=XrwUPNYpCXpOB1RuNkkkNKRdpbvyAhYu2z5MkBbTa+U4sD3jKP+RCkuf8z8jshj87+QX7OudlKpNrh6Jllp8/9KLMBYTfCW/pOJzaiEbAiVy3Wrm6is5vbm1nBMlnO5Vwy1i14frIh8kSkURviJ1smx2jcm5lkfSZKOGsZxUlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078745; c=relaxed/simple;
	bh=f14XKdRLbAIaCqZKzl7GBicWGlFYtiJZvAmLderW2+o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JmZCXT0FZAaF8/u4htti8coiP0OCyuj60DpzlFFPdkE/NRjEdINv+LrVAyun19moc33ZPBlztBB0XvcE8bXE7FSpCIzeWYAW2PFtZGd9VrYMzIIGNTyhitlII+gBZpwveX+6yHMwg6JWCBHq0YwR7efyzADoFgVF+OeX+Q8tldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn23i8i/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn23i8i/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c4c65485so4457100f8f.0
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764078741; x=1764683541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=Tn23i8i/gAj7vqH1s1cK5d5zQm7b7yhVGSi/AE/Ivf2m+vkkXTZSCrGKTRHLTuQTa7
         +KvNFkU/QqK+sEYwmwE2Yb0UignIKpNtSGsqpMHs/CPGxcYMG/N8qiBawIMySNh8OD9L
         5CFkyX3nscW9U/c0Ixc1EDHO06SCrhsAKXgyg9EeZTPGrTiWs68K46R3tkvVE17xIQlY
         0Zwxtkt7V4Jn7BDMVmlugZm3dJgJc/uiAABbZzW2rEcSjTHEnOrqyDjv+jCOU9L7FiMM
         HA/ARVms1OdAi49sm7BTSYV6aRV0jfm40tamlOr9bgiYxozsxBCGcTL6bgfe+VIuWtOO
         M3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078741; x=1764683541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHOesweq24KF358s0vEumPsOYuhj+3ibk2FmOjZUv+4=;
        b=v1q2RYLjhd6pMt8IWpxynR5OWgk7EQkOUeiUjBt0aVRNIWXKRx2HQQzdGpGJZWso1H
         vy5nmWtuFv0klGf1ImuVv6BFDU5BAcKsol74xnbUitoqruGpElXQnZJtnj8fYiX2jcNr
         xR2/cwUe7/PdBFrZ0QtbRbs0PwitcBHl/e8dernGLF04jYt7qQoGwApXQuBZ/KX9EaYx
         Pj12gE//eilPz1FVL23ibeFzGCQPsqkYcBYnWb5P+1OJHNAJ45P5ICb8ac9nsUarOUc4
         sftLaHEC37aeGa9P4DIubHw/rT85EeuiQOIM2Sj4mj9BiBX7vNQsW3Kn8iIsYX3TGZWz
         ev9w==
X-Forwarded-Encrypted: i=1; AJvYcCXj8pWLhpt+2QBletLRy4RpoRgshqbX3brUtccZIBczB3lsGVBezyPDaZvPSaFiTKecKUntahODwks6YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIel5kVGw6W9jq8TmPKB1gTyEbRYTVQMnuzCevujJ1aX4OasDA
	mDgV1Eyr79+VRsaoIBLCae2/EqNsBkbDLE0PPF8cE4ZGR/K9sup8HjZY
X-Gm-Gg: ASbGncsgkTW0v/F19KaVU8MAqoL8/aW9Oj1NdnJWpxOBjA6lnO+Ywnh0g8zhEfndMCh
	lK47bjs46Am7CLMUxSmvPSkm6Y0oSem1xz4IcGYXnelzgsQDHMOEA9HhFNStncY3G2qRTTDxXMN
	kwAI4QNN4PNYlauosUekms3G1ZXE2ExBC/dVkvHY1wdc/4l7bI5o2QfsBA+PNkQg/8tbMCGtaf9
	21rqkAWLr25XBMoxxwxpHoKBN5/05Mh6QKM9JmtZ5+EPDIpwPl/Dcf9SOtvM1vukFnryW9fdOKU
	gaTV44lEYfCE2fYgpiPsCBjHSHoME0Z9eXpjELxXmKFsvFtESJLpwwfZnyILvJbyETk8ND2YqnO
	W6ZAwzwst/IobIukyvoO6U6KQHjFArDwHtV3U40/+dj6TJBK5UFoZS9oKnIQi8aHMXx0XHeQEf7
	865Jj12h9pQzraewfqWFN9MKYFTyVh3UIaqAlvfBuEdQMnKKkrzJ/4GDepFPILN2fihSkU+FZN
X-Google-Smtp-Source: AGHT+IFKl0FSWbmMlOH9ZWfAZWRSmX8BD6ohJLnDHz1PIktPZZElxLDCt4b4SkoYMkjbJJn+KqrIYg==
X-Received: by 2002:a5d:5d81:0:b0:42b:3ded:298d with SMTP id ffacd0b85a97d-42cc1d2d5ebmr16251211f8f.32.1764078741365;
        Tue, 25 Nov 2025 05:52:21 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm35280457f8f.26.2025.11.25.05.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:52:20 -0800 (PST)
Message-ID: <a80a1e7d-e387-448f-8095-0aa22a07af17@gmail.com>
Date: Tue, 25 Nov 2025 13:52:18 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <fd10fe48-f278-4ed0-b96b-c4f5a91b7f95@amd.com>
 <905ff009-0e02-4a5b-aa8d-236bfc1a404e@gmail.com>
 <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Language: en-US
In-Reply-To: <53be1078-4d67-470f-b1af-1d9ac985fbe2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 14:17, Christian König wrote:
> On 11/24/25 12:30, Pavel Begunkov wrote:
>> On 11/24/25 10:33, Christian König wrote:
>>> On 11/23/25 23:51, Pavel Begunkov wrote:
>>>> Picking up the work on supporting dmabuf in the read/write path.
>>>
>>> IIRC that work was completely stopped because it violated core dma_fence and DMA-buf rules and after some private discussion was considered not doable in general.
>>>
>>> Or am I mixing something up here?
>>
>> The time gap is purely due to me being busy. I wasn't CC'ed to those private
>> discussions you mentioned, but the v1 feedback was to use dynamic attachments
>> and avoid passing dma address arrays directly.
>>
>> https://lore.kernel.org/all/cover.1751035820.git.asml.silence@gmail.com/
>>
>> I'm lost on what part is not doable. Can you elaborate on the core
>> dma-fence dma-buf rules?
> 
> I most likely mixed that up, in other words that was a different discussion.
> 
> When you use dma_fences to indicate async completion of events you need to be super duper careful that you only do this for in flight events, have the fence creation in the right order etc...

I'm curious, what can happen if there is new IO using a
move_notify()ed mapping, but let's say it's guaranteed to complete
strictly before dma_buf_unmap_attachment() and the fence is signaled?
Is there some loss of data or corruption that can happen?

sg_table = map_attach()         |
move_notify()                   |
   -> add_fence(fence)           |
                                 | issue_IO(sg_table)
                                 | // IO completed
unmap_attachment(sg_table)      |
signal_fence(fence)             |

> For example once the fence is created you can't make any memory allocations any more, that's why we have this dance of reserving fence slots, creating the fence and then adding it.

Looks I have some terminology gap here. By "memory allocations" you
don't mean kmalloc, right? I assume it's about new users of the
mapping.

>>> Since I don't see any dma_fence implementation at all that might actually be the case.
>>
>> See Patch 5, struct blk_mq_dma_fence. It's used in the move_notify
>> callback and is signaled when all inflight IO using the current
>> mapping are complete. All new IO requests will try to recreate the
>> mapping, and hence potentially wait with dma_resv_wait_timeout().
> 
> Without looking at the code that approach sounds more or less correct to me.
> 
>>> On the other hand we have direct I/O from DMA-buf working for quite a while, just not upstream and without io_uring support.
>>
>> Have any reference?
> 
> There is a WIP feature in AMDs GPU driver package for ROCm.
> 
> But that can't be used as general purpose DMA-buf approach, because it makes use of internal knowledge about how the GPU driver is using the backing store.

Got it

> BTW when you use DMA addresses from DMA-buf always keep in mind that this memory can be written by others at the same time, e.g. you can't do things like compute a CRC first, then write to backing store and finally compare CRC.

Right. The direct IO path also works with user pages, so the
constraints are similar in this regard.

-- 
Pavel Begunkov

