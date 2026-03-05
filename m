Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A9336888;
	Thu,  5 Mar 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715924; cv=none; b=sizZPY0eS8aTfCVBWknxBsPBc9aCeuTFNXWMa0pnBdnpN108pwJQqXqDz26pAUqv6GsoXbO2e/9u1oTNweoMfPHMVFocWa6QLidsHcMM/5BO/uexTA+w2fqHj1qIJVAhsO+5g8vXWfQvUHLISOVUd7y9E4Rqvwxo6rhqKjgg0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715924; c=relaxed/simple;
	bh=5O3pdPqVxVHBOmTlIeryC54JgtIMpNS1g0GSO96c1I0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DmZJhpxhhaxRf476Sh2vFHBcc3xYvVBrCuR12xdk1BqX5+rWl3CLie+EVBESjuO/jXzFgE4afg7KNz9e+aM5P6lBQPmd9ZTXVnB1wYv6FdbgiRWwSDMsk060+lS0G1UqZBU7R0SaJfnJGV47VWW6yjBd9B1yVMFzRDxtARcQ0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHFYoctb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHFYoctb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6469BC116C6;
	Thu,  5 Mar 2026 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715924;
	bh=5O3pdPqVxVHBOmTlIeryC54JgtIMpNS1g0GSO96c1I0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=oHFYoctbU3ceTdExzWvMnxM3IXzij87OYgmV9QRWbf2fJ9tV98hJ+6o02dB3GtACB
	 uuLeNXfVUHAxkyoEZ69EGo1ltkkgDA4Gz41ZOHFg1lAHqZVdH3MC+M/iPPs2beREMa
	 CI/kbDG4DTR72H0+ySIyBry/YSJxsL0vXDJCK+/iC5NKGt0EBgr0S3ik/9g44apBv4
	 WJXU+8h9aJIx4AERVSz5TaF7pXqbv8NIdxHO5ozlLjbi73QfX5TH/92T8dfsTMXQeb
	 qloLxiQ31Za+1poigJz91Okk4P4FX+H+uG55dz9PSISA5BX+BlcApaDIfhmtk2O+Ub
	 3M4pMQwhtHC2Q==
Message-ID: <08db9e93-3d29-42e0-ae57-79c295d75753@kernel.org>
Date: Thu, 5 Mar 2026 14:05:20 +0100
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
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org> <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org> <aaFinIsCmitHSP_c@fedora>
Content-Language: en-US
In-Reply-To: <aaFinIsCmitHSP_c@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 10:23, Ming Lei wrote:
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
> 
> With the two patches, IOPS increases to 22M from 13M, but still much less than
> 36M which is obtained in v6.19-rc5, and slab-sheave PR follows v6.19-rc5.

OK thanks! Maybe now we're approching the original theories about effective
caching capacity etc...

> Also alloc_slowpath can't be observed any more.
> 
> Follows perf profile with the two patches:

What's the full perf profile of v6.19-rc5 and full profile of the patched
7.0-rc2 then? Thanks.

Also contents of all the files under /sys/kernel/slab/$cache (forgot which
particular one it was) with CONFIG_SLUB_STATS=y would be great, thanks.

> 
> 
> -    8.30%     0.19%  io_uring         [kernel.kallsyms]               [k] mempool_alloc_noprof
>    - 8.11% mempool_alloc_noprof
>       - 7.64% kmem_cache_alloc_noprof
>          - 6.15% __pcs_replace_empty_main
>             - 5.96% refill_sheaf
>                + 5.95% refill_objects
> +    8.06%     0.44%  io_uring         [kernel.kallsyms]               [k] kmem_cache_alloc_noprof
> +    7.44%     0.00%  kublk            [ublk_drv]                      [k] 0xffffffffc140c71b
> +    6.63%     0.03%  kublk            [kernel.kallsyms]               [k] __io_run_local_work
> +    6.19%     0.05%  io_uring         [kernel.kallsyms]               [k] __pcs_replace_empty_main
> -    5.97%     0.01%  io_uring         [kernel.kallsyms]               [k] refill_sheaf
>    - 5.96% refill_sheaf
>       - 5.95% refill_objects
>          - 4.87% __refill_objects_any
>             - 4.76% __refill_objects_node
>                  0.72% __slab_free
>          - 1.00% allocate_slab
>             - 0.80% __alloc_frozen_pages_noprof
>                - 0.79% get_page_from_freelist
>                   + 0.72% post_alloc_hook
> +    5.96%     0.02%  io_uring         [kernel.kallsyms]               [k] refill_objects
> 
> 
> thanks,
> Ming
> 

