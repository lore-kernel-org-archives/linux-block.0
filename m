Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83862E6CC5;
	Tue, 18 Nov 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447376; cv=none; b=tt3wYO/K7fkdAtdhuPt3Tg4UhPA0v9qwXgEwknbbA9S1q03afOOmHlVSbZf0Hi/V1DXnKsRXw137x9c389216ajLFnC7XOi4t86+5KWyYDOfnI44Kv3iAKIzotCnFw4CfZMY74U7BdJDiCsG6xAlGvhHOYGEen5JbWfztNOt+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447376; c=relaxed/simple;
	bh=NMsOTA1DMJ5iERcAl/pml2D6iYbp4MdUF6qfsG/xYvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb7qojgwINpy8Ws/K1BZ3+nAJEddSApb/1RQ1Acm2rxRJB8AAoEsyTtNMRolqlR5JI86FP1uVf/Dg3A5s/bvGx/aSksALhxAAaNNnols5YdhyIs7eqCkxI9+i/EGhHDP5M3yBh1sAKmxo5eznsdWCLb7E7Ekvc5Wi8ptBNmNKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9jZ+UO9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9jZ+UO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763447375; x=1794983375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NMsOTA1DMJ5iERcAl/pml2D6iYbp4MdUF6qfsG/xYvM=;
  b=M9jZ+UO9mInVTh0Lkq22saZraecZhVAdd9DnkKz8iHonUaMRaludp3UA
   nc3BRx8RYacXraP2oZFdq+qrjaZA4i0YqQfsWoLNXHWxDwYz1+TyxavSB
   xAewxb+WTSoHCGD0jw0itv12zKbkwM0QKpwvcov+hzX9rkSE9y4zTUKK5
   1Cq5ZIbse7hwHBgq6KudV4Ru4dINWZbtPewFcIcgKrVc3SKAVOI2mh1/Q
   +5M6LfWIZn23uyV5pRuKztL90vzKXgFveVDlRpAQhuAP1Sn3yxLeVi7S/
   6xXuogoNGladtxQAyyXL4z3+Bmj2uNU8QVGpKsVXZIYkBmstMf60cK/f5
   Q==;
X-CSE-ConnectionGUID: OX+v4qq7SqCd3aUwP8Vc8Q==
X-CSE-MsgGUID: Zz4naFG+RJec7Xuf/5h11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69329990"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69329990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:29:34 -0800
X-CSE-ConnectionGUID: IV4Gw64wTteTnz/8Ll8CNg==
X-CSE-MsgGUID: EbEOfi6kSRy4agmjdcOZcw==
X-ExtLoop1: 1
Received: from guowangy-mobl.ccr.corp.intel.com (HELO [10.124.242.244]) ([10.124.242.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 22:29:31 -0800
Message-ID: <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
Date: Tue, 18 Nov 2025 14:29:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
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
 <aRU2sC5q5hCmS_eM@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRU2sC5q5hCmS_eM@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/2025 9:38 AM, Ming Lei wrote:
> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>> They still should share same L3 cache, and cpus_share_cache() should be
>>> true when the IO completes on the CPU which belong to different L2 with the
>>> submission CPU, and remote completion via IPI won't be triggered.
>> Yes, remote IPI not triggered.
> 
> OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
> remote IPI is triggered in case of crossing L3, which is understandable.
> 
> I will check if topo cluster can cover L3, if yes, the patch still can be
> simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
> and adding nr_sub_nodes.

Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two 
level NUMA-cluster spreading?

BR
Wangyang
