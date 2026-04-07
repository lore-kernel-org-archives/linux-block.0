Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A753921C8;
	Tue,  7 Apr 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545724; cv=none; b=SKkV0FB8V5Q4hA6p1dNury/0SdAQSBG5mwUDb8o+7YxnkqvkpGNWyyEChKxT1cwx9D41Do1PTauTEF1QW5PZomzv9GaofPttccDk9HKs9aMAJVlCBHRTfw8sSN9E1wTAC6B6d9kWhf46wTBUL6LWNTkQ37lcyMN6hG2pYBS3fgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545724; c=relaxed/simple;
	bh=4sqm7Pn/xr0KkPhoKfgyitU/HZmehDF9Tw0iV0sxJHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVk5aZ3W7joD98Xwo5OogyJxbxxc1hol5aW29TpBSzCkNcXI1uadNSLX2pYyWmOEoFSLPab+3BIEBv9CwZOhK/jFrSLYPERs3xBjWwGOj8MKtipi4BTpIPAnS0czCm1MPETPEpaG3jP8YCaZP4AIGmg8NvYcMhb33HH3NMAxOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rsLADGmw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rsLADGmw"
Received: from [100.67.193.68] (unknown [20.24.150.112])
	by linux.microsoft.com (Postfix) with ESMTPSA id 415AC20B710C;
	Tue,  7 Apr 2026 00:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 415AC20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775545716;
	bh=1LELfpWDHDTz0Ew3LeY58d1PH/L5Bye8+55q3QqPoFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rsLADGmwlBQARRbfVRJ/Dy3IpnrciOveksHB4iYt07mHhYis+wuy7wUJun6VnKdYt
	 fh/Sln4Gc0aQRwCENnUfY/8UHKGIms2Kc7Lu8g+Vse9rSLcwOfR9tuRMYjwVAqaQMa
	 LEyH9+loZAw9bFDKqMbVQtynrImIvxlprP7twJLs=
Message-ID: <6106a655-2d4b-4ebf-b269-459e3bd3efd4@linux.microsoft.com>
Date: Tue, 7 Apr 2026 12:38:30 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260407055247.GA6405@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/7/2026 11:22 AM, Christoph Hellwig wrote:
>> -               if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
>> +               if (!zone_device_pages_compatible(bv->bv_page, page))
>>                          return 0;
>> -
>> -               if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
>> +               if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
>> +                   bvec_try_merge_hw_page(q, bv, page, len, offset)) {
> 
> We still can't merge merge pages with different P2P pgmaps into the
> same request.
> 
> So the zone_device_pages_have_same_pgmap check should go into
> zone_device_pages_compatible and we need to stop building the bio
> as well in that case.

Ok, so rest all things same, from my last email, but my previous 
compatible function would look like this:

static inline bool zone_device_pages_compatible(const struct page *a,
                         const struct page *b)
{
     if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
         return zone_device_pages_have_same_pgmap(a, b);
     return true;
}

This would prevent two P2PDMA pages from different pgmaps (different PCI 
devices) passing the compatible check and both get added to the bio.
Please correct me if that is not what you meant. I'll wait for a couple 
more days and send the next version with this, and we can review this again.

Thanks for your inputs.

Regards,
Naman
