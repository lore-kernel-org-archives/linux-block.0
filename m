Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A70C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A820656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfANJuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:50:04 -0500
Received: from verein.lst.de ([213.95.11.211]:45648 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfANJuE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 04:50:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 46DA567358; Mon, 14 Jan 2019 10:50:02 +0100 (CET)
Date:   Mon, 14 Jan 2019 10:50:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114095002.GA29874@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com> <20190111091502.GC5825@8bytes.org> <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
>
> On 2019/1/11 下午5:15, Joerg Roedel wrote:
>> On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
>>> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
>>> all virtio devices under AMD-SEV guests?
>> Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
>> aperture, because that memory is not encrypted. The guest bounces the
>> data then to its encrypted memory.
>>
>> Regards,
>>
>> 	Joerg
>
>
> Thanks, have you tested vhost-net in this case. I suspect it may not work

Which brings me back to my pet pevee that we need to take actions
that virtio uses the proper dma mapping API by default with quirks
for legacy cases.  The magic bypass it uses is just causing problems
over problems.
