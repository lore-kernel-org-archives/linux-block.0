Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE1C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0220870
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 09:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfAKJMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:12:34 -0500
Received: from 8bytes.org ([81.169.241.247]:56724 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJMd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 04:12:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0F1B53A2; Fri, 11 Jan 2019 10:12:31 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:12:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Message-ID: <20190111091231.GB5825@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110134433.15672-2-joro@8bytes.org>
 <20190110170205.GB27546@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110170205.GB27546@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> need to limit the size of pages.

That function just exports the overall size of the swiotlb aperture, no?
What I need here is the maximum size for a single mapping.

Regards,

	Joerg
