Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906CC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BD320656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANV7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:59:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26033 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfANV7a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 16:59:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A48CC0BEAB8;
        Mon, 14 Jan 2019 21:59:30 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id D28AD5D76A;
        Mon, 14 Jan 2019 21:59:27 +0000 (UTC)
Date:   Mon, 14 Jan 2019 16:59:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Message-ID: <20190114165800-mutt-send-email-mst@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110134433.15672-2-joro@8bytes.org>
 <20190110170205.GB27546@char.us.oracle.com>
 <20190111091231.GB5825@8bytes.org>
 <20190114204907.GH32038@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114204907.GH32038@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 14 Jan 2019 21:59:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 03:49:07PM -0500, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 11, 2019 at 10:12:31AM +0100, Joerg Roedel wrote:
> > On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> > > Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> > > need to limit the size of pages.
> > 
> > That function just exports the overall size of the swiotlb aperture, no?
> > What I need here is the maximum size for a single mapping.
> 
> Yes. The other drivers just assumed that if there is SWIOTLB they would use
> the smaller size by default (as in they knew the limitation).
> 
> But I agree it would be better to have something smarter - and also convert the
> DRM drivers to piggy back on this.
> 
> Or alternatively we could make SWIOTLB handle bigger sizes..


Just a thought: is it a good idea to teach blk_queue_max_segment_size
to get the dma size? This will help us find other devices
possibly missing this check.


> > 
> > Regards,
> > 
> > 	Joerg
