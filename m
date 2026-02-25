Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1133B8D4A;
	Wed, 25 Feb 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025772; cv=none; b=JSOHkc/VFdJ9odbtMUrv1cI02C6OIghimoWFEt05hmbiZcWNWJT5Wfb1EnM4O1PWVfWnOaSCeXsywzS3QmbD+Wo03Nd/qwzGr4kz7skpFizuo9hP2OjIy5UHQs1DhmLYDyvJ4akfOFjnCcPS3A1PoULz4ElqV8EPz/etpdGQsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025772; c=relaxed/simple;
	bh=RZBsUf0X02o3bPMs3VTOdahnvXKTjjrWfCtDKcZKalg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fi2MTjRA7HZlJ/8//kMs5GGB7uZ1hmMT+yyETKdYgb3KTpQW0KgfQBmVRq533kqnEJckOj7GVONDRWOxEe/BMYlINTl7oMS0tp4IeJ2J6eAtbRSCnVD8L5KCC3te6FzWN24VF+KS5otIZh6MmjxnoufJDhrHGuf7FMqs8PXRe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAOi4prY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAOi4prY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A45BC116D0;
	Wed, 25 Feb 2026 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025771;
	bh=RZBsUf0X02o3bPMs3VTOdahnvXKTjjrWfCtDKcZKalg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oAOi4prYTzY0Ql6MaV7exYfYmjbmobHpo3I+e4JwPKf3lrttu5b/es42Zie+xxfu6
	 1ekF39MXArTWtm2iyfk7U3LDuMSW2tO7qEWKnYHOCxH/ta1+faUl/V0ZjKZoKuQiTm
	 ThHyTyi6XE/wwfBlbtPQDv4Z7E1SoN0RHtq2B9hecciys5ZNxY293Q9NqCCzy/MAum
	 ZWaGTVbna6IlKmzcLYm+GmMPWLd+Z3njTvZHQA034x5skL5xhLFZsINLcICHvGKoFv
	 IDuP8WPhSRCp6xjb0tX41+BFoo8ehpYamIqejHkM4waigd/6geL3Ssucrzc9iheSab
	 xF7kEIr4W60ZA==
Message-ID: <f68663b4-3ff9-43dc-8a61-c2a36c8f4d14@kernel.org>
Date: Wed, 25 Feb 2026 14:22:48 +0100
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
 <f3a26a8a-a3db-4133-83c0-7a70faacee9c@kernel.org> <aZ7p9uF8H8u6RxrK@fedora>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <aZ7p9uF8H8u6RxrK@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 13:24, Ming Lei wrote:
> On Wed, Feb 25, 2026 at 12:29:26PM +0100, Vlastimil Babka (SUSE) wrote:
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
>> Hm that's weird, still the slowpath is prominent in your profile.
>> 
>> I followed your reproducer instructions, although only with a small
>> virtme-ng based setup. What's the output of "numactl -H" on yours, btw?
> 
> available: 8 nodes (0-7)
> node 0 cpus: 0 1 2 3 32 33 34 35
> node 0 size: 0 MB
> node 0 free: 0 MB
> node 1 cpus: 4 5 6 7 36 37 38 39
> node 1 size: 31906 MB
> node 1 free: 30572 MB
> node 2 cpus: 8 9 10 11 40 41 42 43
> node 2 size: 0 MB
> node 2 free: 0 MB
> node 3 cpus: 12 13 14 15 44 45 46 47
> node 3 size: 0 MB
> node 3 free: 0 MB
> node 4 cpus: 16 17 18 19 48 49 50 51
> node 4 size: 0 MB
> node 4 free: 0 MB
> node 5 cpus: 20 21 22 23 52 53 54 55
> node 5 size: 32135 MB
> node 5 free: 31086 MB
> node 6 cpus: 24 25 26 27 56 57 58 59
> node 6 size: 0 MB
> node 6 free: 0 MB
> node 7 cpus: 28 29 30 31 60 61 62 63
> node 7 size: 0 MB
> node 7 free: 0 MB
> node distances:
> node     0    1    2    3    4    5    6    7 
>    0:   10   12   12   12   32   32   32   32 
>    1:   12   10   12   12   32   32   32   32 
>    2:   12   12   10   12   32   32   32   32 
>    3:   12   12   12   10   32   32   32   32 
>    4:   32   32   32   32   10   12   12   12 
>    5:   32   32   32   32   12   10   12   12 
>    6:   32   32   32   32   12   12   10   12 
>    7:   32   32   32   32   12   12   12   10 

Oh right, memory-less nodes, of course. Always so much fun.

>> 
>> Anyway what I saw is my patch raised the IOPS substantially, and with
>> CONFIG_SLUB_STATS=y enabled I could see that
>> /sys/kernel/slab/bio-248/alloc_slowpath had substantial values before the
>> patch and zero afterwards.
>> 
>> Maybe if you could also enable CONFIG_SLUB_STATS=y and see in which cache(s)
>> there's significant alloc_slowpath even after the patch, it could help.
> 
> Patched:
> 
> /sys/kernel/slab/bio-264
> ./alloc_slowpath:83555260 C0=33 C1=6717992 C2=9 C3=6611030 C8=128 C9=6802316 C11=6934363 C13=6721479 C14=66 C15=6694472 C16=96 C17=7286868 C18=128 C19=7369091 C24=128 C25=7288673 C26=51 C27=6800502 C28=129 C29=7095073 C31=7232628 C43=4 C56=1

Yean, no slowpath allocations from cpus that are *not* on a memoryless node.
Thanks, that will help to focus what to look at.

> 
> Also config.tar.gz is attached.
> 
> Thanks, 
> Ming

