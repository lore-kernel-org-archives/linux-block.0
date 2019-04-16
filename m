Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F823C10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7F92064B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD2XTIp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfDPOJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:09:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfDPOJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 10:09:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so10417047plb.5
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tnaTfgPaukK1KpyQO1Tw6QcseZlhO6AD3y1FwvFlqoc=;
        b=mD2XTIp8ItVgO9IvfsYkeKvYtJw+wNlGNUbgKRurX2PL3Q8MOfOhqPyKIzK6w6WdCn
         +s461Gidjtu6cIlXc+n5InQqC56OO3QUVlohbOajpCf4hCWYnQsPOvdMX9uN2Ku33o6C
         q+MnXUq/HCg9ehkA3S68BpEft58xSmU1rI0Fxdxd7/On4SunRxwdoOsrnNgNgVkStOuS
         1gOBAhiuK6h+QPfy0XWufLlLCcTGbDHcKEX2/p07bI/6x+eQ7CCr7lBax2D94aRMBvQb
         hrS1j+wBVcMMJXl1D/2GP6FZRR5xBC7TsgrNf1PUM+jGVgAez5kwam7oCuTWk7l0R0ue
         7Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tnaTfgPaukK1KpyQO1Tw6QcseZlhO6AD3y1FwvFlqoc=;
        b=GSZ4Yo01q/OrqQR+VW6acA7xZw5Vmsd7KbhQbeMNEoz6JOo5ficcZLnRefD9NEVLBg
         8g53aLQw7VZXdKV8rOK2nKbtrifTtadf/TJ94/GO3xheDGW/m3gKfN/zH00VtfGUfB33
         0/4+OR2R+5RHEFpfKLRQVqV2GvM829mogeltGOx4YscWAQ8NxgA4E+LAOSrgW9WZ3QoV
         Qliib69/LCLgY3DaUroK/BGzViQMvxx9Qn+JQ8kan12M3cYr91OB4OgDXAZYJyYPK9TD
         ZcGRr1ndnlXSfpVHp+KM9XCpSkfZq2jAK1wp2TDWFhx/537ap7OjcNCD2UpVFh+kbLlt
         wFSw==
X-Gm-Message-State: APjAAAVw/AoAO3Rwrrg9y7AICAfswruvXvMVIzomFu1e0fui+6ED7xQP
        RRyrB5JuD+5Q6675fzR0lX+8kddO
X-Google-Smtp-Source: APXvYqwC6Iv38YndpRNUHa4BYHv9W+L3LBGkEDML3+AbcyZgGgVbsxicENEQngfWV4qpoSqIuMVnSQ==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr34613713plb.109.1555423757404;
        Tue, 16 Apr 2019 07:09:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v188sm78222086pgb.7.2019.04.16.07.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:09:16 -0700 (PDT)
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de> <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de> <20190415210731.GA32723@roeck-us.net>
 <20190416063356.GA25763@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed1a624c-a7c4-5f88-e5d9-6f77a3e70e3b@roeck-us.net>
Date:   Tue, 16 Apr 2019 07:09:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416063356.GA25763@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/19 11:33 PM, Christoph Hellwig wrote:
> On Mon, Apr 15, 2019 at 02:07:31PM -0700, Guenter Roeck wrote:
>> On Mon, Apr 15, 2019 at 10:52:42PM +0200, Christoph Hellwig wrote:
>>> On Mon, Apr 15, 2019 at 12:44:35PM -0700, Guenter Roeck wrote:
>>>> This patch causes crashes with various boot tests. Most sparc tests crash, as
>>>> well as several arm tests. Bisect results in both cases point to this patch.
>>>
>>> That just means we trigger an existing bug more easily now.  I'll see
>>> if I can help with the issues.
>>
>> Code which previously worked reliably no longer does. I would be quite
>> hesitant to call this "trigger an existing bug more easily". "Regression"
>> seems to be a more appropriate term - even more so as it seems to cause
>> 'init' crashes, at least on arm.
> 
> Well, we have these sgls in the wild already, it just is that they
> are fairly rare.  For a related fix on a mainstream platform see
> here for example:
> 
> 	https://lore.kernel.org/patchwork/patch/1050367/
> 
> Below is a rework of the sparc32 iommu code that should avoid your
> reported problem.  Please send any other reports to me as well.
> 

The code below on top of next-20190415 results in

esp ffd398e4: esp0: regs[(ptrval):(ptrval)] irq[2]
esp ffd398e4: esp0: is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi host0: esp
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
scsi target0:0:0: Beginning Domain Validation
scsi target0:0:0: Domain Validation Initial Inquiry Failed
scsi target0:0:0: Ending Domain Validation
scsi host0: scsi scan: INQUIRY result too short (5), using 36
scsi 0:0:2:0: Direct-Access                                    PQ: 0 ANSI: 0
scsi target0:0:2: Beginning Domain Validation
scsi target0:0:2: Domain Validation Initial Inquiry Failed
scsi target0:0:2: Ending Domain Validation
...
sd 0:0:2:0: Device offlined - not ready after error recovery
sd 0:0:2:0: rejecting I/O to offline device

and sometimes:

...
sd 0:0:0:4: [sde] Asking for cache data failed
sd 0:0:0:4: [sde] Assuming drive cache: write through
sd 0:0:0:4: rejecting I/O to offline device
sd 0:0:0:5: Device offlined - not ready after error recovery
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
kworker/u2:6(90): Oops [#1]
CPU: 0 PID: 90 Comm: kworker/u2:6 Not tainted 5.1.0-rc4-next-20190415-00001-g328cdb292761 #1
Workqueue: events_unbound async_run_entry_fn
PSR: 409010c5 PC: f02d2904 NPC: f02d2908 Y: 0000000c    Not tainted
PC: <__scsi_execute+0xc/0x18c>
%G: f5334608 00000000  00000000 00000002  00041200 00000008  f5386000 00000002
%O: f5334608 00000000  f5387c90 f50d3fb0  0000000b f5334a4c  f5387b98 f02d2a38
RPC: <__scsi_execute+0x140/0x18c>
%L: 00000000 00000000  f51b1800 00000001  00000002 00000000  f5386000 f05f9070
%I: 00000200 f5387ca0  00000002 00000000  00000000 00000000  f5387bf8 f02e92a4
Disabling lock debugging due to kernel taint
Caller[f02e92a4]: sd_revalidate_disk+0xe8/0x1f5c
Caller[f02eb418]: sd_probe+0x2b0/0x3f0
Caller[f02bbc98]: really_probe+0x1bc/0x2e8
Caller[f02bc10c]: __driver_attach_async_helper+0x48/0x58
Caller[f003f534]: async_run_entry_fn+0x38/0x124
Caller[f00373bc]: process_one_work+0x168/0x390
Caller[f0037728]: worker_thread+0x144/0x504
Caller[f003c90c]: kthread+0xd8/0x110
Caller[f00082f0]: ret_from_kernel_thread+0xc/0x38
Caller[00000000]:   (null)
Instruction DUMP:
  9de3bfa0
  b41ea001
  80a0001a
<d0062004>
  92603fff
  a4100018
  e207a06c
  e007a074
  94102008

Guenter

> diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
> index e8d5d73ca40d..93c2fc440cb0 100644
> --- a/arch/sparc/mm/iommu.c
> +++ b/arch/sparc/mm/iommu.c
> @@ -175,16 +175,38 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
>   	}
>   }
>   
> -static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
> +static u32 __sbus_iommu_map_page(struct device *dev, struct page *page, unsigned offset,
> +		unsigned len, bool need_flush)
>   {
>   	struct iommu_struct *iommu = dev->archdata.iommu;
> +	phys_addr_t paddr = page_to_phys(page) + offset, p;
> +	unsigned long pfn = __phys_to_pfn(paddr);
> +	unsigned long off = (unsigned long)paddr & ~PAGE_MASK;
> +	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>   	int ioptex;
>   	iopte_t *iopte, *iopte0;
>   	unsigned int busa, busa0;
>   	int i;
>   
> +	/* XXX So what is maxphys for us and how do drivers know it? */
> +	if (!len || len > 256 * 1024)
> +		return DMA_MAPPING_ERROR;
> +
> +	/*
> +	 * We expect unmapped highmem pages to be not in the cache.
> +	 * XXX Is this a good assumption?
> +	 * XXX What if someone else unmaps it here and races us?
> +	 */
> +	if (need_flush && !PageHighMem(page)) {
> +		for (p = paddr & PAGE_MASK; p < paddr + len; p += PAGE_SIZE) {
> +			unsigned long vaddr = (unsigned long)phys_to_virt(p);
> +
> +			flush_page_for_dma(vaddr);
> +		}
> +	}
> +
>   	/* page color = pfn of page */
> -	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
> +	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
>   	if (ioptex < 0)
>   		panic("iommu out");
>   	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
> @@ -193,11 +215,11 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
>   	busa = busa0;
>   	iopte = iopte0;
>   	for (i = 0; i < npages; i++) {
> -		iopte_val(*iopte) = MKIOPTE(page_to_pfn(page), IOPERM);
> +		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
>   		iommu_invalidate_page(iommu->regs, busa);
>   		busa += PAGE_SIZE;
>   		iopte++;
> -		page++;
> +		pfn++;
>   	}
>   
>   	iommu_flush_iotlb(iopte0, npages);
> @@ -205,99 +227,62 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
>   	return busa0;
>   }
>   
> -static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t len)
> -{
> -	void *vaddr = page_address(page) + offset;
> -	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
> -	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	
> -	/* XXX So what is maxphys for us and how do drivers know it? */
> -	if (!len || len > 256 * 1024)
> -		return DMA_MAPPING_ERROR;
> -	return iommu_get_one(dev, virt_to_page(vaddr), npages) + off;
> -}
> -
>   static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
>   		struct page *page, unsigned long offset, size_t len,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	flush_page_for_dma(0);
> -	return __sbus_iommu_map_page(dev, page, offset, len);
> +	return __sbus_iommu_map_page(dev, page, offset, len, false);
>   }
>   
>   static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
>   		struct page *page, unsigned long offset, size_t len,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	void *vaddr = page_address(page) + offset;
> -	unsigned long p = ((unsigned long)vaddr) & PAGE_MASK;
> -
> -	while (p < (unsigned long)vaddr + len) {
> -		flush_page_for_dma(p);
> -		p += PAGE_SIZE;
> -	}
> -
> -	return __sbus_iommu_map_page(dev, page, offset, len);
> +	return __sbus_iommu_map_page(dev, page, offset, len, true);
>   }
>   
> -static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs,
> +		bool need_flush)
>   {
>   	struct scatterlist *sg;
> -	int i, n;
> -
> -	flush_page_for_dma(0);
> +	int i;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> -		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
> -		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
> +		sg->dma_address = __sbus_iommu_map_page(dev, sg_page(sg),
> +				sg->offset, sg->length, need_flush);
> +		if (sg->dma_address == DMA_MAPPING_ERROR)
> +			return 0;
>   		sg->dma_length = sg->length;
>   	}
>   
>   	return nents;
>   }
>   
> -static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
> +static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	unsigned long page, oldpage = 0;
> -	struct scatterlist *sg;
> -	int i, j, n;
> -
> -	for_each_sg(sgl, sg, nents, j) {
> -		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
> -
> -		/*
> -		 * We expect unmapped highmem pages to be not in the cache.
> -		 * XXX Is this a good assumption?
> -		 * XXX What if someone else unmaps it here and races us?
> -		 */
> -		if ((page = (unsigned long) page_address(sg_page(sg))) != 0) {
> -			for (i = 0; i < n; i++) {
> -				if (page != oldpage) {	/* Already flushed? */
> -					flush_page_for_dma(page);
> -					oldpage = page;
> -				}
> -				page += PAGE_SIZE;
> -			}
> -		}
> -
> -		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
> -		sg->dma_length = sg->length;
> -	}
> +	flush_page_for_dma(0);
> +	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, false);
> +}
>   
> -	return nents;
> +static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, true);
>   }
>   
> -static void iommu_release_one(struct device *dev, u32 busa, int npages)
> +static void __sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
> +		size_t len)
>   {
>   	struct iommu_struct *iommu = dev->archdata.iommu;
> -	int ioptex;
> -	int i;
> +	unsigned busa, npages, ioptex, i;
>   
> +	busa = dma_addr & PAGE_MASK;
>   	BUG_ON(busa < iommu->start);
>   	ioptex = (busa - iommu->start) >> PAGE_SHIFT;
> +	npages = ((dma_addr & ~PAGE_MASK) + len + PAGE_SIZE-1) >> PAGE_SHIFT;
>   	for (i = 0; i < npages; i++) {
>   		iopte_val(iommu->page_table[ioptex + i]) = 0;
>   		iommu_invalidate_page(iommu->regs, busa);
> @@ -309,22 +294,17 @@ static void iommu_release_one(struct device *dev, u32 busa, int npages)
>   static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
>   		size_t len, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	unsigned long off = dma_addr & ~PAGE_MASK;
> -	int npages;
> -
> -	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
> -	iommu_release_one(dev, dma_addr & PAGE_MASK, npages);
> +	__sbus_iommu_unmap_page(dev, dma_addr, len);
>   }
>   
>   static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct scatterlist *sg;
> -	int i, n;
> +	int i;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> -		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
> -		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
> +		__sbus_iommu_unmap_page(dev, sg->dma_address, sg->length);
>   		sg->dma_address = 0x21212121;
>   	}
>   }
> 

