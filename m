Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5142253EB;
	Tue, 11 Nov 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839079; cv=none; b=OJfqhN97FriNTof+0b+bPAAjq00qGIR32rvO4bZfnfiQFD3vEn+yghge+z56eUjEuOUdTVoPV6ARuP265RfrUeis1l5rVdzZ6HZfd+GM7qUueukaC7s30hKBMSYULuie6b6u0TCsBFAZxLRMes+B+uN04zibz6MsMOsoB2YtR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839079; c=relaxed/simple;
	bh=qmB23KBZam3+BYAe/TpOP+kDi8RzRSN2DKhHCUO1HcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ME0SwODMOtaoNgXWx2tcIMtMRHgExcBZGNVC425wZEI7T7v1hGIcpP6bz+os+Cwke3tB78LL0gHSq+LEjv3KCll3+Mia/GFsdBtRlQSl3jVWmJpZyfAuEc9AbKQcoWSoXPJSBya1S+IADpc03dMmJubAihSEdMdO43GBjDVPS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgKTmlKs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgKTmlKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762839078; x=1794375078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmB23KBZam3+BYAe/TpOP+kDi8RzRSN2DKhHCUO1HcE=;
  b=GgKTmlKs6qchoyuhw9f9pj/0FqC77lCpWDLqKyJpxK0KZEVy37oiGxMs
   JOApuKoVBmU2X2SUZ+kWlTKLOQY4Ftfl/3WNATOwh/mGAt7R9USlX0CsB
   oeUJMWgaqncBCFWbE5liO/j6oet8IJo9Fehodz0byi9oV2q3aoKdQ26Ms
   xhRKv82U2pNdnt1YsKu0ln+GMxNKR/8YtBHDqW+b3nxBB1fa5s5FSLnJP
   26JWk44KEygck+C3+fPX61sE4lM/pnYa+LSKRo79/ZjEUGN4kjmdc0zGc
   HJ0tZRSeRUhxd4ZhmdOFt/TAzMXYBsEs2F5x4Qt02MbBwNaonMqSiFJYL
   g==;
X-CSE-ConnectionGUID: cOAF+a4cS7yEz8TnMunxJw==
X-CSE-MsgGUID: 5eBtObsJTJy02avXxe9rmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76000630"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="76000630"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:17 -0800
X-CSE-ConnectionGUID: GpuEIhUYSumZNIgV9aF2cQ==
X-CSE-MsgGUID: W+UFF+FATv+zwiSXibzg0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193870829"
Received: from unknown (HELO [10.238.2.7]) ([10.238.2.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 21:31:14 -0800
Message-ID: <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
Date: Tue, 11 Nov 2025 13:31:04 +0800
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
 <aRKssW96lHFrT2ZN@fedora>
Content-Language: en-US
From: "Guo, Wangyang" <wangyang.guo@intel.com>
In-Reply-To: <aRKssW96lHFrT2ZN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2025 11:25 AM, Ming Lei wrote:
> On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
>> As CPU core counts increase, the number of NVMe IRQs may be smaller than
>> the total number of CPUs. This forces multiple CPUs to share the same
>> IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
>> performance penalty can be observed on some platforms.
> 
> Can you add details why/how CPU cluster isn't aligned with IRQ
> affinity? And how performance penalty is caused?

Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share 
the L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 
IRQs to dispatch. The existing algorithm will map first 7 IRQs each with 
4 CPUs and remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may 
have cross cluster issue. For example, the 9th IRQ which pinned to 
CPU32, then for CPU31, it will have cross L2 memory access.

CPU |28 29 30 31|32 33 34 35|36 ...
      -------- -------- --------
IRQ      8        9       10

If this patch applied, then first 2 IRQs each mapped with 2 CPUs and 
rest 9 IRQs each mapped with 4 CPUs, which avoids the cross cluster 
memory access.

CPU |00 01 02 03|04 05 06 07|08 09 10 11| ...
      ----- ----- ----------- -----------
IRQ  1      2        3           4


BR
Wangyang
