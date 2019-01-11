Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E40C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387D20870
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 09:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfAKJPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:15:04 -0500
Received: from 8bytes.org ([81.169.241.247]:56744 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJPE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 04:15:04 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id ABABC3A2; Fri, 11 Jan 2019 10:15:02 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:15:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190111091502.GC5825@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
> all virtio devices under AMD-SEV guests?

Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
aperture, because that memory is not encrypted. The guest bounces the
data then to its encrypted memory.

Regards,

	Joerg
