Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6231ED7C;
	Fri, 10 Apr 2026 03:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792311; cv=none; b=OO2gs8HjF7u1RHGRoFkytx3+BiyE9OOwgKnBkcRbhdp6YnXp/0533ydrUdQcmu7JcRTgzycLvwaBi5jrSLOB+GFFqIczhVJacYjVbNkGqnWWrAtqdiIwOvzgEuqD6QVIiRa5jKGIDgF/2CjOJ0z6MEQAU8Dph3JAhkWhkUDHTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792311; c=relaxed/simple;
	bh=5d6dhpV31KvNc4bStrc9O5kfWsbNNzg3rN1k3m7kvgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMCPb0TKl3hbF6TtkSbotvLZXf/0U+2evLBITZJCH/BY3v5LuQ49b7d4kiwkMYPbWbCOQSmGePxoglYlWebhzO2YpoKF9Cakz0yCIy/9j9t+HOy7zW15bsjDC6qgypTTSy0CLV45jn/M4QTXIMCh/1mTW8T6Ru4phYy/Kn2BeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QC8ul+Ab; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QC8ul+Ab"
Received: from [100.67.208.126] (unknown [52.163.222.1])
	by linux.microsoft.com (Postfix) with ESMTPSA id 656A520B710C;
	Thu,  9 Apr 2026 20:38:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 656A520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775792309;
	bh=/PFBHBQZRsG6lAj3Mf2YsSQjznw4IhcHi7euPbD1izc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QC8ul+Ab1e5vh5oY5IOu3ia7YiN+/K5TZUkR+1phZI3I1Y8WyA3Io9mZTXRVMTp3+
	 q43FH6hJ0IKkLABuj/PdoJ2Vnw78xalbLeU8YfzS3ih2l6/LNJhzO1b9QwaS1aRQXC
	 C3He1+uuqQIQb/ICFB84Lne3/RcmQ6r3JKogx/4E=
Message-ID: <2dd7926b-6bcb-4828-9a89-de429a5efd93@linux.microsoft.com>
Date: Fri, 10 Apr 2026 09:08:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: allow different-pgmap pages as separate bvecs
 in bio_add_page
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>, Long Li
 <longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com>
 <20260401082329.1602328-3-namjain@linux.microsoft.com>
 <20260401140850.GC21703@lst.de>
 <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com>
 <20260402053057.GA11783@lst.de>
 <d48427c2-9aa3-42a2-a8d7-43a7a3b3b685@linux.microsoft.com>
 <20260407055247.GA6405@lst.de>
 <6106a655-2d4b-4ebf-b269-459e3bd3efd4@linux.microsoft.com>
 <20260408060825.GA24532@lst.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260408060825.GA24532@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/2026 11:38 AM, Christoph Hellwig wrote:
> Hi Naman,
> 
> On Tue, Apr 07, 2026 at 12:38:30PM +0530, Naman Jain wrote:
>>> So the zone_device_pages_have_same_pgmap check should go into
>>> zone_device_pages_compatible and we need to stop building the bio
>>> as well in that case.
>>
>> Ok, so rest all things same, from my last email, but my previous compatible
>> function would look like this:
>>
>> static inline bool zone_device_pages_compatible(const struct page *a,
>>                          const struct page *b)
>> {
>>      if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
>>          return zone_device_pages_have_same_pgmap(a, b);
>>      return true;
>> }
>>
>> This would prevent two P2PDMA pages from different pgmaps (different PCI
>> devices) passing the compatible check and both get added to the bio.
>> Please correct me if that is not what you meant. I'll wait for a couple
>> more days and send the next version with this, and we can review this
>> again.
> 
> This looks good modulo the tabs vs spaces in the indentation.

Hi,
Thanks.

Regards,
Naman

