Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA0C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29E20651
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfANTMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:12:13 -0500
Received: from foss.arm.com ([217.140.101.70]:39164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfANTMM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 14:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3893F80D;
        Mon, 14 Jan 2019 11:12:12 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FDAF3F5BD;
        Mon, 14 Jan 2019 11:12:10 -0800 (PST)
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
 <20190114131114-mutt-send-email-mst@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
Date:   Mon, 14 Jan 2019 19:12:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/01/2019 18:20, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 08:41:37PM +0800, Jason Wang wrote:
>>
>> On 2019/1/14 下午5:50, Christoph Hellwig wrote:
>>> On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
>>>> On 2019/1/11 下午5:15, Joerg Roedel wrote:
>>>>> On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
>>>>>> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
>>>>>> all virtio devices under AMD-SEV guests?
>>>>> Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
>>>>> aperture, because that memory is not encrypted. The guest bounces the
>>>>> data then to its encrypted memory.
>>>>>
>>>>> Regards,
>>>>>
>>>>> 	Joerg
>>>>
>>>> Thanks, have you tested vhost-net in this case. I suspect it may not work
>>> Which brings me back to my pet pevee that we need to take actions
>>> that virtio uses the proper dma mapping API by default with quirks
>>> for legacy cases.  The magic bypass it uses is just causing problems
>>> over problems.
>>
>>
>> Yes, I fully agree with you. This is probably an exact example of such
>> problem.
>>
>> Thanks
> 
> I don't think so - the issue is really that DMA API does not yet handle
> the SEV case 100% correctly. I suspect passthrough devices would have
> the same issue.

Huh? Regardless of which virtio devices use it or not, the DMA API is 
handling the SEV case as correctly as it possibly can, by forcing 
everything through the unencrypted bounce buffer. If the segments being 
mapped are too big for that bounce buffer in the first place, there's 
nothing it can possibly do except fail, gracefully or otherwise.

Now, in theory, yes, the real issue at hand is not unique to virtio-blk 
nor SEV - any driver whose device has a sufficiently large DMA segment 
size and who manages to get sufficient physically-contiguous memory 
could technically generate a scatterlist segment longer than SWIOTLB can 
handle. However, in practice that basically never happens, not least 
because very few drivers ever override the default 64K DMA segment 
limit. AFAICS nothing in drivers/virtio is calling 
dma_set_max_seg_size() or otherwise assigning any dma_parms to replace 
the defaults either, so the really interesting question here is how are 
these apparently-out-of-spec 256K segments getting generated at all?

Robin.
