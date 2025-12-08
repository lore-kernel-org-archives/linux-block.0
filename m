Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C92765D3;
	Mon,  8 Dec 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162062; cv=none; b=qAflI460Mc3dExWvTixAoi3vusW5VDenhyEnYg8o+/lizYRlcwii9orm95Qr9EB714cvutkqZsIvn/xUiFZQMrBqBKcgPxX4LufsfRfGy65yMZgMh7JsDpk69WQA+Infwi9tWRdj7V7rROsUUwUxMu29JAXg4b11wAtj/4xgnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162062; c=relaxed/simple;
	bh=6TwHcb5iUovQX1XFCXHnFY38ZruK56VM+5PnT7qnu20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R87asRDMDgU/w92rimCZ0MEFBD7N+mP/CrXTIS0uz5iWvUne/LdZ1x/bW8KwullgkOCWLMj0SoMABOJvUL5mLwR6sM6vWWugJQp6YGD5OrB6fu634byZvodA4p60D9HzovGAb2RtrFqAkAkcIAiES0FEz36zVieGNz0MUeWN5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQo1ghuE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQo1ghuE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765162060; x=1796698060;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6TwHcb5iUovQX1XFCXHnFY38ZruK56VM+5PnT7qnu20=;
  b=EQo1ghuEZkYfPqapMCHcto1Si6Rx6E87RMheZ+BUv0DGJYskr+rqEVK6
   C+4cqv8dcaqeL3uenvmaUgJzQAVgk3PwcijmFE4naBNZ9otsLXqVKCpP1
   IpFFXrwi8mfuMVeMyeqd6Nc8XU5rypF4J+vVeWGL/Mxp6c2Z7NBNyS0X2
   +Vyej/FMr7ISeABvJ05YRevtGyksS5A3m/DWM0UxfHWZDc4zNYyWVjDxu
   KkkpZuWVMiwTyZxBAjfatV4FSTTj0rUb95vgVM58aGerzZ5m9ThMpd1vX
   Xd0kOV9V33ws0ofT+3AXMNfeQ9BhabyY67NrvHotJxZCdhknunxTMEKsB
   Q==;
X-CSE-ConnectionGUID: eu8Ipz+5RJup/2Fh5hMBfg==
X-CSE-MsgGUID: 5h9uk55qQ1S1KXSYqgATfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="70957761"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="70957761"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:40 -0800
X-CSE-ConnectionGUID: uJPi9MaPTbeYe7fO5XbNjw==
X-CSE-MsgGUID: aPr5tsLvTxWcHxRb5YKL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="195848648"
Received: from unknown (HELO [10.238.3.27]) ([10.238.3.27])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 18:47:36 -0800
Message-ID: <585538f9-10b8-4da9-8566-179fa789f4ab@intel.com>
Date: Mon, 8 Dec 2025 10:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Dan Liang <dan.liang@intel.com>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora> <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora> <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
 <aRU2sC5q5hCmS_eM@fedora> <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
 <aR0i2f91VGv47swo@fedora> <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Language: en-US
In-Reply-To: <7ec85f26-25fa-4c77-9e46-347261723d95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/2025 3:58 PM, Guo, Wangyang wrote:
> On 11/19/2025 9:52 AM, Ming Lei wrote:
>> On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
>>> On 11/13/2025 9:38 AM, Ming Lei wrote:
>>>> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>>>>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>>>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>>>> They still should share same L3 cache, and cpus_share_cache() 
>>>>>> should be
>>>>>> true when the IO completes on the CPU which belong to different L2 
>>>>>> with the
>>>>>> submission CPU, and remote completion via IPI won't be triggered.
>>>>> Yes, remote IPI not triggered.
>>>>
>>>> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 
>>>> 1/3 if
>>>> remote IPI is triggered in case of crossing L3, which is 
>>>> understandable.
>>>>
>>>> I will check if topo cluster can cover L3, if yes, the patch still 
>>>> can be
>>>> simplified a lot by introducing sub-node spread by changing 
>>>> build_node_to_cpumask()
>>>> and adding nr_sub_nodes.
>>>
>>> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
>>> level NUMA-cluster spreading?
>>
>> Yes, I think the change may be minimized by introducing sub-numa-node for
>> covering it, what do you think of this approach?
>>
>> However, it is bad to use cluster as sub-numa-node at default, because 
>> cluster
>> is aligned with CPUs sharing L2 cache, so there could be too many 
>> clusters
>> for many systems in which one cluster just includes two CPUs, then the 
>> finally
>> calculated mapping crosses clusters inevitably because nr_queues is
>> less than nr_clusters.
>>
>> I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.
>>
>> For your case, either adding one kernel parameter, or adding 
>> group_cpus_cluster()
>> API for the unusual case by sharing single code path.
> 
> Yes, it will make the change simpler, but no matter using cluster or L3 
> cache as sub-numa-node, as CPU core count increase, there is potential 
> risk that nr_queues < nr_sub_numa_node, which will make CPU spreading no 
> affinity at all.
> 
> I think we need to keep two level NUMA/sub-NUMA spreading to avoid such 
> regression.
> 
> For most platforms, there is no need for 2nd level spreading since L2 is 
> not shared between physical cores and L3 mapping is the same as NUMA. I 
> think we can add a platform specified configuration: by default, only 
> NUMA spreading is used; if platform like Intel Xeon E or some AMD 
> platform need second level spreading, we can config it to use L3 or 
> cluster as sub-numa-node for 2nd level spreading.
> 
> How does that sound to you?

Hi Ming,

Hope you're doing well.

Just wanted to kindly follow up on my previous email. Please let me know 
if you have any further feedback/guidance on the proposed changes or if 
there’s anything I can do to help move this forward.

Thanks for your time and guidance!

BR
Wangyang

