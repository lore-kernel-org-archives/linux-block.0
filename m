Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534513D0C8
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507813; cv=none; b=po7WcMI+12fOS6+mwfvx/uQkVApKCm5PdPKHMojLajEofhkHEjCb/s631Jj9aIXwrRXCiasydCCge0dJSwgMOu+9vcb1qFVbR3F1JUyZH6tuQ4bdlQOg8qGrHlZH+ecAKseZCyRblpA05L1Hh0QyLii08Lq+eJa+Q4HNVFrsiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507813; c=relaxed/simple;
	bh=nJDvNRnCHO0W6kka+FAavHGHLfb0qEsB5Cywd7hyRYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTjvd+W/RfXrHqmSc9wXWVzlqbU0Tsrt1Z44rsObTz+fQZlQgGVgW9kTvvtGLmdb8YWwBOlmRgDaTtAl7gRDxkDjQhcXO8cYKDvjte+nlHVsL0bL3do/EFxUDzARdvTQUs6ytmkM7nVyJzspH5KPJKzWzmv39sI5MIwbEFaKtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMhK5LfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMhK5LfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE537C433F1;
	Wed, 21 Feb 2024 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708507812;
	bh=nJDvNRnCHO0W6kka+FAavHGHLfb0qEsB5Cywd7hyRYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMhK5LfZEWKt5b29Lv2PN1zIzxTetEpwbyg4YP/287Doxc7muAIxS1bDC15kdqtsb
	 Qb5rDFQRTd1A3nOhbZYsaOQZvGpNeMZyLd9wEblZDzPFrn7GmkVJnthqy9Jqt7fWVS
	 8hSWzQTj/zm/b+drtISAFWN8bqPYKnYgYoePAvqjMyPky5RBlkH2KKzROcKctPtMuO
	 Jkt5BJPxl+QJcKEN1YbzF2R/VlPToT1ivJdSKPlz+evf8umMUQzvX/7KFf4Fh5EBrf
	 RXMdiCjo0tqTazSx5bk49zwyWy4TdiYwem0DTNuthc0pu4BCRkrFaaZYGnVT857VlN
	 p+W7yZyrhcHfA==
Message-ID: <99bba6e6-1ae3-49d2-842b-680257cedbad@kernel.org>
Date: Wed, 21 Feb 2024 18:30:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20240220081327.2678-1-dwagner@suse.de>
 <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
 <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 16:37, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 06:22:29AM +0000, Shinichiro Kawasaki wrote:
>> I found this changes makes the test case fail when the kernel does not have
>> CONFIG_HUGETLBFS. Without the config, /proc/sys/vm/nr_hugepages does not
>> exist.
>>
>> When CONFIG_HUGETLBFS is not defined, should we skip this test case?
> 
> Obviously, we should aim for really solid test cases. Though it is not
> guaranteed that the test will pass even with CONFIG_HUGETLBS enabled. I
> suspect we would need to make some more preparation steps that the
> allocation has a high change to pass. Though I haven't really looked
> into what the necessary steps would be. The sysfs exposes a few more
> knobs to play with.

"echo 3 > /proc/sys/vm/drop_caches" before mounting hugetlbfs should allow for
the big pages to fit... Still no guarantees but likely that will lower setup
failure frequency.

> 
>> If this is
>> the case, we can add "_have_kernel_option HUGETLBFS" in requires(). If not, we
>> should check existence of /proc/sys/vm/nr_hugepages before touching it, like:
>>
>>        if [[ -r /proc/sys/vm/nr_hugepages &&
>>                      "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
> 
> Sure, I'll add this and also fix the typos in the commit message.
> 
>>
>> Also I suggest to add in-line comment to help understanding why nr_hugepages
>> sysfs needs change. Something like,
>>
>> # nvme-cli may fail to allocate linear memory for rather large IO buffers.
>> # Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
>> # from HugeTLB pool.
> 
> Ok.
> 

-- 
Damien Le Moal
Western Digital Research

