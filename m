Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6C8389107;
	Thu,  2 Apr 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120122; cv=none; b=g2zy2DGbo3lD1kaisvp36oZn0n2Ckryu+fubO0WmXj/F5/IVkGcClZFUZkB/LdAlRd9/FCNzaAROnSA7KqhKF1gYI4vnkI3gnIm2BF7nRIpe1YpLRy4pboKRp7iIgF9bSxFutx88VNiqr81n2yHXYEWvSzfTcOWKB1upRQtsEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120122; c=relaxed/simple;
	bh=kSvtlNaRoVgEEMy9B6r0SFRKhOwkFbYxwEGnVLK5e9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls+c0IIBTz+j/YucQXU3Y+S4mLFs4zQDfuKhzPKB8FlbVm64yGGYGaeyvQbrazltp0ALpB99uLQS29NhOwMASP2iAbp32qnXY3Aj+YO/ZvbAI/QcmeyNEz3Lmn1KV+MgPI4ZUP3keLTIQKgWyx2fajcuhsYFOInbQP8QjPAR/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f9C8bAAB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f9C8bAAB"
Received: from [100.67.0.96] (unknown [52.163.71.154])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2220120B712B;
	Thu,  2 Apr 2026 01:55:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2220120B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775120120;
	bh=xvsf/97p1qJTJFVkIYsXigSds5Qygwdf3LJkXuEJ/j8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f9C8bAABY4rsRnEzQTSe0795BVNMo7XLcUOwS1X8kivNjpw1CpBhF8VtcXISdbhhn
	 2q+z54Wqoq85HAZvP4He0zq92eXI0Zy975bEevYhYE9DX6jA06s/jcgLo+wIWBImGn
	 V93pacb6Ac7Ac9vda9KDe8DjFLSTwFOk7DVyGISQ=
Message-ID: <d48427c2-9aa3-42a2-a8d7-43a7a3b3b685@linux.microsoft.com>
Date: Thu, 2 Apr 2026 14:25:14 +0530
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
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260402053057.GA11783@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/2026 11:00 AM, Christoph Hellwig wrote:
> On Thu, Apr 02, 2026 at 10:51:05AM +0530, Naman Jain wrote:
>> When a direct I/O request spans pages from different chunks (different
>> pgmaps), the current code rejected the second page entirely:
>>
>>      if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
>>          return 0;  // Rejection - forces bio split or I/O error
>>
>> Both chunks are regular RAM from the DMA perspective
>> (MEMORY_DEVICE_GENERIC, not P2PDMA). The only requirement is that they not
>> be merged into the same bvec segment, which patch 1/2 enforces by adding
>> the pgmap check to biovec_phys_mergeable().
>>
>> This patch allows pages from different pgmaps to be added as separate bvec
>> entries in the same bio, eliminating bio splits and I/O failures
>> when buffers span pgmap boundaries.
> 
> Which as I said we can't do in general, as different pgmaps cna have
> different DMA mapping requirements.  We might be able to relax this
> if we know multiple pgmaps can be mapped in the same way.  I.e.
> replace zone_device_pages_have_same_pgmap with
> zone_device_pages_compatible and add additional conditions to it.
> 
>> --- a/block/bio-integrity.c
>> +++ b/block/bio-integrity.c
>> @@ -231,6 +231,9 @@ int bio_integrity_add_page(struct bio *bio, struct page
>> *page,
>>          if (bip->bip_vcnt > 0) {
>>                  struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
>>
>> +               if (is_pci_p2pdma_page(bv->bv_page) !=
>> +                   is_pci_p2pdma_page(page))
>> +                       return 0;
>>                  if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
> 
> The above is implied by not having the same pgmap.

Thanks. If I understand correctly, here is how this would look like.
Please let me know if this is what you suggested.


diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf0477943..e54c6e06e1cbb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -231,10 +231,10 @@ int bio_integrity_add_page(struct bio *bio, struct 
page *page,
         if (bip->bip_vcnt > 0) {
                 struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];

-               if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+               if (!zone_device_pages_compatible(bv->bv_page, page))
                         return 0;
-
-               if (bvec_try_merge_hw_page(q, bv, page, len, offset)) {
+               if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+                   bvec_try_merge_hw_page(q, bv, page, len, offset)) {
                         bip->bip_iter.bi_size += len;
                         return len;
                 }
diff --git a/block/bio.c b/block/bio.c
index 77067fa346d35..0e70bb912338c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1034,10 +1034,10 @@ int bio_add_page(struct bio *bio, struct page *page,
         if (bio->bi_vcnt > 0) {
                 struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];

-               if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
+               if (!zone_device_pages_compatible(bv->bv_page, page))
                         return 0;
-
-               if (bvec_try_merge_page(bv, page, len, offset)) {
+               if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&
+                   bvec_try_merge_page(bv, page, len, offset)) {
                         bio->bi_iter.bi_size += len;
                         return len;
                 }
diff --git a/block/blk.h b/block/blk.h
index 0cb3441638284..c5710ba4c81b9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -136,6 +136,23 @@ static inline bool biovec_phys_mergeable(struct 
request_queue *q,
         return true;
  }

+/*
+ * Check if two pages from potentially different zone device pgmaps can
+ * coexist as separate bvec entries in the same bio.
+ *
+ * The block DMA iterator (blk_dma_map_iter_start) caches the P2PDMA 
mapping
+ * state from the first segment and applies it to all subsequent 
segments, so
+ * P2PDMA and non-P2PDMA pages must never be mixed in the same bio.
+ *
+ * Other zone device types (FS_DAX, GENERIC) use the same 
dma_map_phys() path
+ * as normal RAM.  PRIVATE and COHERENT pages never appear in bios.
+ */
+static inline bool zone_device_pages_compatible(const struct page *a,
+                                               const struct page *b)
+{
+       return is_pci_p2pdma_page(a) == is_pci_p2pdma_page(b);
+}
+
  static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
                 struct bio_vec *bprv, unsigned int offset)
  {
