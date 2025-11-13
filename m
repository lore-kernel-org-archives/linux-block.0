Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CE2F9DBB;
	Thu, 13 Nov 2025 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004765; cv=none; b=mGn+A8a6mc2FqiX/Rje7Opm68NKSe7GxchAnpSJAPamdUdI3He4UatAV25AyIqT7YtAvR0xnaX38ifKJXWRef3o9W1n1iTdh+fCcAgGdJHaToRrgpOUacOir21gIZARzeVyCwQ8b42bSCJnw2yVye20FOAVcIq3nXz564fMI5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004765; c=relaxed/simple;
	bh=nW8dYWJRACfO9SxIG8/7eN3wi1ZlRG3WcV3UoKJDPTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHxAOuys1mqeeGDuiI42KVSJAEIIWu1iOXfnbTXTs9wfacuc9mtUI0x2AqE+oI1U3nRsrBUcdSUtgDvUPuIBplYNozBtiuxDkXQOI3b7Mm3L2BX4EpPWoztcZ9oKUXpU+XZCr9zkbETM5DtTvvQE122IKlc0GhiMhzu8LG/23xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPjChoR+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPjChoR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763004762; x=1794540762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nW8dYWJRACfO9SxIG8/7eN3wi1ZlRG3WcV3UoKJDPTM=;
  b=hPjChoR+bB1cTwcgZkkxGQkeTDkEg7xrGO5hE50J+dUkPusF/ftqHYhK
   Gnk86Rc9PU3Ivj0iyiReNcz79P/SeRdz10bawA10xgA8jZqo7npI0FymA
   G6Sa6doCen5Y0Aym81MfsWhiPqLUGmbSG/n8krpIVoC125SbzlMxsPWJJ
   JX2xBbNpCikEZWzfxzpjF67RYkTA0ViwUubauaieNOD+aMiqcBe8k2vZz
   AnED/shpSNysLOxNuVWdhleKDi1jt+ENM574PytC4PM+s9pNmajuq9gq+
   y23SQGBLFm+gVepjKT3xKfxH8TqnxJHWKRmty4WttsjvX1UWcmtB/gFX4
   Q==;
X-CSE-ConnectionGUID: Z+vkHmRzRCaCX0UH8XQ1dw==
X-CSE-MsgGUID: fXev3YbCTHa+0MUBETB3Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68943556"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="68943556"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 19:32:41 -0800
X-CSE-ConnectionGUID: O1uxeBX2Sa+cL9lsKqBhsA==
X-CSE-MsgGUID: s7OouAHqR/OR+ATVTBdb+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="193512952"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 19:32:38 -0800
Message-ID: <2ca29d50-88c4-4f4a-afc6-4b79700004e3@intel.com>
Date: Thu, 13 Nov 2025 11:32:34 +0800
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
Content-Transfer-Encoding: 8bit

On 11/13/2025 9:38 AM, Ming Lei wrote:
> On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 8:08 PM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>>>> On 11/11/2025 11:25 AM, Ming Lei wrote:
>>>>> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>>>>>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>>>>>> the total number of CPUs. This forces multiple CPUs to share the same
>>>>>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>>>>>> performance penalty can be observed on some platforms.
>>>>>
>>>>> Can you add details why/how CPU cluster isn't aligned with IRQ
>>>>> affinity? And how performance penalty is caused?
>>>>
>>>> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
>>>> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
>>>> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
>>>> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
>>>> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
>>>> CPU31, it will have cross L2 memory access.
>>>
>>>
>>> CPUs sharing L2 usually have small number, and it is common to see one queue
>>> mapping includes CPUs from different L2.
>>>
>>> So how much does crossing L2 hurt IO perf?
>> We see 15%+ performance difference in FIO libaio/randread/bs=8k.
> 
> As I mentioned, it is common to see CPUs crossing L2 in same group, but why
> does it make a difference here? You mentioned just some platforms are
> affected.

We observed the performance difference in Intel Xeon E platform which 
has 4 physical CPU cores as 1 module (cluster) sharing the same L2 
cache. For other platforms like Intel P-core or AMD, I think it's hard 
to show performance benefit with L2 locality, because:
1. L2 cache is only shared within 2 logic core when HT enabled
2. If IRQ pinned to corresponding HT core, the L2 cache locality is 
good, but other aspects like retiring maybe affected since they are 
sharing the same physical CPU resources.

BR
Wangyang
