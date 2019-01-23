Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7310C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5FC21872
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAWV2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:28:15 -0500
Received: from verein.lst.de ([213.95.11.211]:44993 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfAWV2P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 16:28:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B5AC968DCF; Wed, 23 Jan 2019 22:28:13 +0100 (CET)
Date:   Wed, 23 Jan 2019 22:28:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Message-ID: <20190123212813.GB9032@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-2-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 05:30:45PM +0100, Joerg Roedel wrote:
> +extern size_t swiotlb_max_mapping_size(struct device *dev);

No need for the extern keyword on function declarations in headers.
