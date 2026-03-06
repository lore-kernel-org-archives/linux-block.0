Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2823D7FF;
	Fri,  6 Mar 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786851; cv=none; b=igcHCWYT2PXoYMG0HNfBwfxXC+dLLtJxF1KNEI/nHDu3DdUcOrcnyLynhrWw3lJzMYmlOp+luwe58biVr5ueU6U8qapFnqn1eHgxqvqlV7JWZe1FHdhQ0NqqD/DQFg6xO3qCohqGJ/W/zh41+j7PqRCkrNVTUztys/xJ/zTK9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786851; c=relaxed/simple;
	bh=P8nU/WJbN/Jf3BgOGTYFKVnRv0oHKTBEQGlPM2nnzoU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S8oo4tsgPNjJgporhJ40OljRjTpP/7vIoMf+444wTFEAWy0aOQwAT9ywN0WiLuN++NDZa8pkm+4W9Dy5cwjHimwkEioZpSSqqzkMSvQDscTGIraDXG7xN35b4SFQuyX3nc5X9XPw2VzfVKp4q/cKNGYebLW0UwqVjsLpNgOpr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD+3ATVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD+3ATVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76698C4CEF7;
	Fri,  6 Mar 2026 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772786851;
	bh=P8nU/WJbN/Jf3BgOGTYFKVnRv0oHKTBEQGlPM2nnzoU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZD+3ATVl1pJ3uEdzvM15SIpkrqOOzYDO11TTEpC2BsmycrnP7BoaxN21uLxAzuUZR
	 7u4QgDMN2AODukfOS7d2POc9a9xwrj4abCw1OJOWuHVXyeuWq8mcvS0G8QqhvLI3dO
	 IP2XVOHerZGabKg7BdnItPk5PMzWPNx9cKSvPQ2H+y04TxOUj9pOKP/aBal2ZObVLz
	 Wb7cIMC7DCSUt+LCVI3O/kDWh0qtVtf8xRGrxpa7Q0aUiIrmZNTh588Z2sVlZY1kG8
	 9tEGIb4yKmF/j4ImmaFeawM4YTPgJr9YrUwR6jRDo1dfdx+nYwuPzEp6KnoeQVci0B
	 +jH7x9zOTlaBQ==
Message-ID: <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org>
Date: Fri, 6 Mar 2026 09:47:27 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org> <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org> <aapeVb_L5zohWRRe@hyeyoo>
In-Reply-To: <aapeVb_L5zohWRRe@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 05:55, Harry Yoo wrote:
> On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
>> On 2/25/26 10:31, Ming Lei wrote:
>> > Hi Vlastimil,
>> > 
>> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
>> >> On 2/24/26 21:27, Vlastimil Babka wrote:
>> >> > 
>> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
>> >> > didn't anticipate this interaction with mempools. We could change them
>> >> > but there might be others using a similar pattern. Maybe it would be for
>> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
>> >> > (but carefully as some deadlock avoidance depends on it, we might need
>> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
>> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
>> >> Could you try this then, please? Thanks!
>> > 
>> > Thanks for working on this issue!
>> > 
>> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
>> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
>> 
>> what about this patch in addition to the previous one? Thanks.
>> 
>> ----8<----
>> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
>> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
>> Date: Thu, 26 Feb 2026 18:59:56 +0100
>> Subject: [PATCH] mm/slab: put barn on every online node
>> 
>> Including memoryless nodes.
>> 
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> ---
> 
> Just taking a quick grasp...
> 
>> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
>>  		return;
>>  
>> -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
>> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
>> +			|| !node_isset(slab_nid(slab), slab_nodes))
> 
> I think you intended !node_isset(numa_mem_id(), slab_nodes)?
> 
> "Skip freeing to pcs if it's remote free, but memoryless nodes is
>  an exception".

Indeed, thanks! Ming, could you retry with that fixed up please?

>>  	    && likely(!slab_test_pfmemalloc(slab))) {
>>  		if (likely(free_to_pcs(s, object, true)))
>>  			return;
> 

