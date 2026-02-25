Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9E19FA93;
	Wed, 25 Feb 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018970; cv=none; b=buntlCRSBf5kBG5hCCudSL95IdbZqDEm6jdqqZ/V0EQSKQa1ZDOlxpJMVDhtZwT/ZsaWIPvqqB4HCOmOkpR0STi5VrBRPByoD3f2lTZT44yTnG2maMrFuU9QKmIsq/4Cm/1EkHkXLmZZo8mRYOUXeB8Co16hY2dP/JIPJOUNSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018970; c=relaxed/simple;
	bh=ZoMjdr0T6OM95kTpTHlHC/FoYXWZ4T8BYxxD5K3H2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni0prRihUoTivoR0lgVdzSlxqtWEGdBKYm4ky/CSKASWO7Ppuvs6SVmJT8+/04Hcae1UkE3trCu8H/SDpJMZyksiII2UPoFb5z394e8RcQSv/YRGR9pV8QzCFG6MNSkm/RrgMaA64DE3/Jb1LPNuXbNM54QAjZD9AtIf1RW2zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWpiXD1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWpiXD1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DA3C116D0;
	Wed, 25 Feb 2026 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018970;
	bh=ZoMjdr0T6OM95kTpTHlHC/FoYXWZ4T8BYxxD5K3H2Qo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWpiXD1vPXYvxvOheOYqV1U5YoimDIoPoi+fFNBTpYbOOXaZz5UfXmpwYuZG158E8
	 40GGsVEDIH7wfNfv0tFBHRGOMHZBRK4elGleYsKFoaJMG5qjfuSYF0yzqkVV8/7zBt
	 2wTnop450r3CkoMM58GF+dcSJ3/+WHYWJw5tmKOubTtfrHoFuXZ2k1ttVqdYOMPSDi
	 oi7Tsn+TURZe/oRzDmMdFCVytlfba2ab6DDYgXZRbvYgRVPFyDKXRCzwF1Dg30+EGE
	 VFocWPZ7GYHPLjDZZB7d4Gm0IkS7klHUd2KkNL+eJiyiveZ0ChhDoq2Mbs7imb5mL/
	 JTad5V2+X7U5A==
Message-ID: <f3a26a8a-a3db-4133-83c0-7a70faacee9c@kernel.org>
Date: Wed, 25 Feb 2026 12:29:26 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org> <aZ7BbosIr2FvZFAe@fedora>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <aZ7BbosIr2FvZFAe@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 10:31, Ming Lei wrote:
> Hi Vlastimil,
> 
> On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
>> On 2/24/26 21:27, Vlastimil Babka wrote:
>> > 
>> > It made sense to me not to refill sheaves when we can't reclaim, but I
>> > didn't anticipate this interaction with mempools. We could change them
>> > but there might be others using a similar pattern. Maybe it would be for
>> > the best to just drop that heuristic from __pcs_replace_empty_main()
>> > (but carefully as some deadlock avoidance depends on it, we might need
>> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
>> > tomorrow to test this theory, unless someone beats me to it (feel free to).
>> Could you try this then, please? Thanks!
> 
> Thanks for working on this issue!
> 
> Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):

Hm that's weird, still the slowpath is prominent in your profile.

I followed your reproducer instructions, although only with a small
virtme-ng based setup. What's the output of "numactl -H" on yours, btw?

Anyway what I saw is my patch raised the IOPS substantially, and with
CONFIG_SLUB_STATS=y enabled I could see that
/sys/kernel/slab/bio-248/alloc_slowpath had substantial values before the
patch and zero afterwards.

Maybe if you could also enable CONFIG_SLUB_STATS=y and see in which cache(s)
there's significant alloc_slowpath even after the patch, it could help.

Thanks!


> ```
> 04cb971e2d28 (HEAD -> master) mm:slab/sheaves: severe performance regression in cross-CPU slab allocation
> a5a9cf3f020f mm: fix NULL NODE_DATA dereference for memoryless nodes on boot
> 7dff99b35460 (origin/master) Remove WARN_ALL_UNSEEDED_RANDOM kernel config option
> 551d44200152 default_gfp(): avoid using the "newfangled" __VA_OPT__ trick
> 6de23f81a5e0 (tag: v7.0-rc1) Linux 7.0-rc1
> ```
> 
> +   49.03%     2.00%  io_uring         [kernel.kallsyms]       [k] __blkdev_direct_IO_async
> -   38.66%     1.16%  io_uring         [kernel.kallsyms]       [k] bio_alloc_bioset
>    - 37.51% bio_alloc_bioset
>       - 34.98% mempool_alloc_noprof
>          - 34.87% kmem_cache_alloc_noprof
>             - 33.82% ___slab_alloc
>                - 30.25% get_from_any_partial
>                   - 29.59% get_from_partial_node
>                      - 28.42% __raw_spin_lock_irqsave
>                           native_queued_spin_lock_slowpath
>                + 2.16% allocate_slab
>                + 0.60% alloc_from_new_slab
>               0.51% __pcs_replace_empty_main
>         1.58% bio_associate_blkg
>    + 1.16% submitter_uring_fn
> +   35.16%     0.30%  io_uring         [kernel.kallsyms]       [k] kmem_cache_alloc_noprof
> +   35.13%     0.12%  io_uring         [kernel.kallsyms]       [k] mempool_alloc_noprof
> 
> 
> Thanks,
> Ming
> 

