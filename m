Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563461;
	b=tm7ux+Dc4nJxT4946S8JPjJDS1X2UNxb7ZHAyYAMW2kjkFcRGuAH4Fcqf0c/mRQyhyHV
	 fFK9ZxLBpKkSbwsKENogxtaBjvpRt0L0XkqYL9UvUKjGcIfs2z9JxVIvqI/NLMcRZ0twt
	 ENSDCeb/XQplCZEFi3yghZe/RY4YP3B+dgt++oALHgvP2YMEp0VXl0gT68aa3i0l5mOe4
	 unModxA0uC4qvcdBLqrAIIjarIJhA1/uQkLJPGrbZ7wzM0ZmIaIuDiRBNjYwLq6sx1CmA
	 vjVTlSKSHG/sGYla8ZKAww4YGFtc6SQlMIV19gk2Zd/WuEMO1oI622XQ2XPUC/VHHiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563461;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gRQOcYVLYl+C1cjG0ifST8FfIE974oDInNoO7fKrBgs=;
	b=vr1mPQn4VMMUvovdaOCPdOyj9K42/dDOsCBuvn0roZ8qMrtKW0SiwB7IgsUr3JPo8fg4
	 R1+zWFqdO7Ddsgf5qOZpC9FIqDX7BBToP8kzJjrnfnVAGiTyrgrbAqHIoaIuRdk1NoXfG
	 omDjG77TroCJfMg4WHdQ7WAEmibMSUGby0CYj760hjfIcwC6HrN8N83TB1tqnCwPwxUx8
	 6vtakDMXmxYmJ/5y9Q56U9Ez7QiMjh3NZd75KLgST8+oxcNurhNOzmGxP5hskPAFKJDu8
	 QQmnioY8T8+qSUP1L2izjlSgGPDaxliy+CdqvUFHc6QllgVAW9WmE4pV5RcqqmDYLxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBWGHeLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D2606A321;
	Fri, 13 Nov 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBWGHeLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932A81F000C4;
	Fri, 13 Nov 2026 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563461;
	bh=gRQOcYVLYl+C1cjG0ifST8FfIE974oDInNoO7fKrBgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OBWGHeLjiICUmUa+HiT1ssx+8Uqlo1phTos0ZuTHvWmR/8/Ch5AvBYfwMF3bzrp7F
	 aPo4ly43nFqtLorXsJCdMpVgEBYgPlSGOgmmx1dXHKBrb9rOCrdu/zgocxUmyjvYRV
	 tMrigyURtbFnaXyl1O4smlP5IhBqEi5GiLnZCgtYUhIOJpx90sJdqPNp7V8jonhk3t
	 3bAmeBciurMykgS41aAGm569izU3WBZQLrjeHhDvKcaHJW9Qt2M7o4MOwbL3aQ9fF6
	 McmRjbyDbZvugNbnszeXCS6/Xm2ZHT3+P2pY5yUaIhwvm+lsr2BXF5oSiOoaThzBDj
	 IVEnBsmW5nhKg==
Message-ID: <1707907e-2261-4d3b-87fb-3dfc662e0347@kernel.org>
Date: Fri, 13 Nov 2026 10:50:57 +0100
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
Subject: Re: [PATCH] zram: Avoid duplicate slots in batched writeback
To: Andrew Morton <akpm@linux-foundation.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, raoxu <raoxu@uniontech.com>,
 minchan@kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>
 <avK6Y1VmIYIBrorl@google.com>
 <20261112232621.6e8916a6e92bbb1afeb1e2a3@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261112232621.6e8916a6e92bbb1afeb1e2a3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 08:26, Andrew Morton wrote:
> On Tue, 10 Nov 2026 15:40:13 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
>> On (26/11/10 14:18), raoxu wrote:
>>> The writeback interface accepts multiple page_index and page_indexes
>>> parameters in one operation. Their ranges can overlap, but
>>> scan_slots_for_writeback() only excludes slots that are already being
>>> written back or marked as same-filled.
>>>
>>> A slot selected by an earlier range is placed on the post-processing list
>>> and marked with ZRAM_PP_SLOT. Without checking that flag, an overlapping
>>> range can enqueue the same slot again and submit it for writeback more
>>> than once.
>>>
>>> Skip slots already marked ZRAM_PP_SLOT while holding the slot lock. This
>>> keeps each slot in a writeback scan session represented by at most one
>>> post-processing entry and leaves the existing release and reuse paths
>>> unchanged.
>>>
>>> Signed-off-by: Xu Rao <raoxu@uniontech.com>
>>
>> LGTM.
>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>
>> Jens, do you want to pick it up and route via block tree or should
>> we route via "more traditional" tree (Andrew's tree)?
> 
> I grabbed it.
> 
> I did recently attempt to pull zram out of the mm project, by moving it
> from mm.git's mm-unstable branch and into mm.git's mm-nonmm-unstable
> branch.  Because "why does the mm project contain a block device
> driver".
> 
> I undid that change after about a week - it didn't work out because
> zram is joined at the hip with mm/zsmalloc.c.  zsmalloc is also used by
> mm/zswap.c.

Are there cleaner ways of isolating both things?

Like, many drivers use kmalloc() etc, and they are not part of core-mm :)

-- 
Cheers,

David
