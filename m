Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A9CC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD9E20663
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfANJmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfANJmJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3000D80F81;
        Mon, 14 Jan 2019 09:42:08 +0000 (UTC)
Received: from [10.72.12.169] (ovpn-12-169.pek2.redhat.com [10.72.12.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A064608DC;
        Mon, 14 Jan 2019 09:41:59 +0000 (UTC)
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
Date:   Mon, 14 Jan 2019 17:41:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111091502.GC5825@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 14 Jan 2019 09:42:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/1/11 下午5:15, Joerg Roedel wrote:
> On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
>> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
>> all virtio devices under AMD-SEV guests?
> Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
> aperture, because that memory is not encrypted. The guest bounces the
> data then to its encrypted memory.
>
> Regards,
>
> 	Joerg


Thanks, have you tested vhost-net in this case. I suspect it may not work



