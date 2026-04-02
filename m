Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE0311973;
	Thu,  2 Apr 2026 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107276; cv=none; b=OvyXiVubCpPgSIc3iHYM8u3CkCGoLzG/aTCLcvN/O+e92J4P6nSms8sk5xQbspyH1tcVCrFyDPP2gSq5IqyT7KDNKZkSQMBKel78j2YAqyD4ecY7HRSxdnKxV7Z1YBF7hGPTpYWj5LBNO8egZOzT1ld1HYUa+Y3EaiIh3o/I8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107276; c=relaxed/simple;
	bh=6Wq5ylcnas8plmo61fDOIFyIDUfUQYXBFb0Uch11QCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW+JZm9k3oQ2u1yP54izSoeUsL2UYiJdIgOkt0oveOu6iSlGLMHUpyIxsIRRUIiBT9ZUlC5F4fncOSAqct/apcj6L6Zgtq9UqHQ9reUB1Jad0m2I7bSyFySGJeGqUjUOVUIrdGoj4brSyezVhgz3f9QsTqaCXzBPW7MRPA2+oZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jVql0lni; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jVql0lni"
Received: from [10.18.134.75] (unknown [167.220.238.75])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D12620B710C;
	Wed,  1 Apr 2026 22:21:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D12620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775107270;
	bh=2WotgcLtRNYc54Ika67F5aWli8hoJbAFYArqHHErJA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVql0lnijb610j0AxwrYDYtUTwC3ikDvHCl8WKIY1JBFEBHoQG+cLLQVfNO7zowZ7
	 3A0wvBE4zEFBLTcVps/yg2Erxqcn4yIBKzuLybOCwm8NDfYKi8Bbv53jOwJOnzr8YA
	 rI3CfIlvEZbA6rrwjm7x52Q3nFC7LvKAvllE1x4E=
Message-ID: <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com>
Date: Thu, 2 Apr 2026 10:51:05 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260401140850.GC21703@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/2026 7:38 PM, Christoph Hellwig wrote:
> On Wed, Apr 01, 2026 at 08:23:29AM +0000, Naman Jain wrote:
>> bio_add_page() and bio_integrity_add_page() reject pages from a
>> different dev_pagemap entirely, returning 0 even when the page could
>> be added as a new bvec entry. The pgmap check was intended only to
>> prevent merging into the same bvec segment, not to block the page
>> from being added at all.
>>
>> This causes callers to unnecessarily start a new bio when a buffer
>> spans pages from two different pgmaps, even though the bio has room
>> for another bvec.
> 
> This is not unnecessary.  A single dma mapping operation can only
> map a single target pgmap.  The old SG API works around this by
> doing multiple mapping operation underneath, but compared to that
> just having multiple bios is much easier and more efficient.
> 
> What is your use case here?

Hello Christoph,

Thanks for reviewing these patches.

The use case driving this patch is the MSHV VTL driver 
(drivers/hv/mshv_vtl_main.c) for VMs with paravisor architecture 
(OpenHCL/OpenVMM: https://openvmm.dev/guide/index.html).

In this setup, the guest runs at two Virtual Trust Levels:
- VTL2 (higher privilege): runs a Linux kernel acting as "paravisor" 
that handles device I/O on behalf of the guest
- VTL0 (lower privilege): runs the actual guest OS (Windows/Linux)

VTL2 Linux performs block I/O (NVMe, SCSI, etc.) using VTL0's memory as 
DMA buffers. To enable this, VTL0 memory is registered into the VTL2 
kernel via the MSHV_ADD_VTL0_MEMORY ioctl, which calls 
devm_memremap_pages() to create MEMORY_DEVICE_GENERIC zone device pages.

The ioctl is called multiple times, by the Virtual Machine Manager 
(VMM), registering VTL0's physical address space in chunks. Each call 
creates a separate dev_pagemap. This chunking is necessary because:

1. Firmware/UEFI fragments the guest physical address space (MMIO holes,
    reserved regions)
2. Alignment constraints: vmemmap_shift is computed from the range 
alignment, and highly aligned large ranges can exceed MAX_FOLIO_ORDER, 
causing devm_memremap_pages() to fail

When a direct I/O request spans pages from different chunks (different 
pgmaps), the current code rejected the second page entirely:

     if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
         return 0;  // Rejection - forces bio split or I/O error

Both chunks are regular RAM from the DMA perspective 
(MEMORY_DEVICE_GENERIC, not P2PDMA). The only requirement is that they 
not be merged into the same bvec segment, which patch 1/2 enforces by 
adding the pgmap check to biovec_phys_mergeable().

This patch allows pages from different pgmaps to be added as separate 
bvec entries in the same bio, eliminating bio splits and I/O failures
when buffers span pgmap boundaries.

I noticed this while doing kernel upgrade from 6.12 to 6.18 for OpenHCL 
kernel.



There's this another concern flagged from Sashiko code review:
https://sashiko.dev/#/patchset/20260401082329.1602328-1-namjain%40linux.microsoft.com

 From my code analysis, this issue would not happening as of now, so 
this is future proofing the APIs after change 2/2. I would need to add a 
check like this to fix this:

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3462697331890..6f2f30a814560 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -231,6 +231,9 @@ int bio_integrity_add_page(struct bio *bio, struct 
page *page,
         if (bip->bip_vcnt > 0) {
                 struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];

+               if (is_pci_p2pdma_page(bv->bv_page) !=
+                   is_pci_p2pdma_page(page))
+                       return 0;
                 if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
                     bvec_try_merge_hw_page(q, bv, page, len, offset)) {
                         bip->bip_iter.bi_size += len;
diff --git a/block/bio.c b/block/bio.c
index 7715e59e68613..6216a554de68b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1034,6 +1034,9 @@ int bio_add_page(struct bio *bio, struct page *page,
         if (bio->bi_vcnt > 0) {
                 struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];

+               if (is_pci_p2pdma_page(bv->bv_page) !=
+                   is_pci_p2pdma_page(page))
+                       return 0;
                 if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
                     bvec_try_merge_page(bv, page, len, offset)) {
                         bio->bi_iter.bi_size += len;


Please let me know what you think about this.

Thanks,
Naman
