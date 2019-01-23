Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF8C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC321872
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAWV3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:29:22 -0500
Received: from verein.lst.de ([213.95.11.211]:45006 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfAWV3W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 16:29:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6916168CEC; Wed, 23 Jan 2019 22:29:21 +0100 (CET)
Date:   Wed, 23 Jan 2019 22:29:21 +0100
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
Subject: Re: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Message-ID: <20190123212921.GC9032@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-4-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


This looks ok, but could really use some documentation in
Documentation/DMA-API.txt.
