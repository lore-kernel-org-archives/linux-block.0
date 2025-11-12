Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2131494DB;
	Wed, 12 Nov 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916574; cv=none; b=OAeSWXOWrjcVsDZ7as5bKd6rpNkdGOlafatKmGIPv9kYGfaCIiJC5L/Bhsfa9W10CUppcgxptGEmh6+OWqFOe6k6g0rTeePXa/r57lfCnSHfcfJo+RzKwUnWEvF2/MC5rNtwy/tBIi4HwVt+psJ0Tg9Tpix07Q6wPXTEaDcfdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916574; c=relaxed/simple;
	bh=0CzASL4FQtni4BE+5yAo9I0TqTLhNXvwqY61AaPkOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3JCglCb35fIe/3Dj0lnE9mwUocxVDAiYWK0T3yc/Tj/QqMT3vkQmlA1y4ac1uK6xc5VlFCEqGcyLG7lTa3s+zDmVsYDlkbEH7GZKlTCe0ZNGqFU1GgGLPzy0N8GGExEMn5lK0uCoxEwBCyXES4zbktcIiLVc1yCdZeKlC6Xy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHyFydut; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHyFydut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762916573; x=1794452573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CzASL4FQtni4BE+5yAo9I0TqTLhNXvwqY61AaPkOZs=;
  b=UHyFydutvHb/NWKQpfxT+biV/hu/PC3aATklzjyjzAPv8wOvlYzIHGtl
   pIp1eCKs3BRJVSIAT3lzHT9DtVdomUXmwWSBnoe5OIh8q8zEfSoNml3li
   FETz4dbzIbkmTvsR/SyeTmHdl2BvcPyfSy1nTBWKmcZS/nN99Ng3aHSl3
   6YJoEzYBQxfBPEMg610M0JJwkYUQOT1B9SFIw8olE2B6zAD3qr46hULOB
   O25Z3BqQqQeCzviAcPUnNFbzQUbhmAND44sAgQmLoznGobMl51Y1dmeji
   ZrAXPrDvZmag/zia3OLFT0G8SsoeTgVWVgulmBFxGxtsVkmO/oXXV8Vyp
   w==;
X-CSE-ConnectionGUID: P8LTB1xXS4ecAFQYawj+UQ==
X-CSE-MsgGUID: AxeW4Y2dSFqRmcz4ug12yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="63981337"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="63981337"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:53 -0800
X-CSE-ConnectionGUID: vPPwIXwoShCC59bAM+JeaQ==
X-CSE-MsgGUID: mJrBIcSfTDGkGIwwzBS3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189531161"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:02:49 -0800
Message-ID: <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
Date: Wed, 12 Nov 2025 11:02:47 +0800
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
 <aRMnR5DRdsU8lGtU@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRMnR5DRdsU8lGtU@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 8:08 PM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
>> On 11/11/2025 11:25 AM, Ming Lei wrote:
>>> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>>>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>>>> the total number of CPUs. This forces multiple CPUs to share the same
>>>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>>>> performance penalty can be observed on some platforms.
>>>
>>> Can you add details why/how CPU cluster isn't aligned with IRQ
>>> affinity? And how performance penalty is caused?
>>
>> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
>> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
>> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
>> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
>> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
>> CPU31, it will have cross L2 memory access.
> 
> 
> CPUs sharing L2 usually have small number, and it is common to see one queue
> mapping includes CPUs from different L2.
> 
> So how much does crossing L2 hurt IO perf?
We see 15%+ performance difference in FIO libaio/randread/bs=8k.

> They still should share same L3 cache, and cpus_share_cache() should be
> true when the IO completes on the CPU which belong to different L2 with the
> submission CPU, and remote completion via IPI won't be triggered.
Yes, remote IPI not triggered.


BR
Wangyang
