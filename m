Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C229BC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A61218EA
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfAaQfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:35:00 -0500
Received: from 8bytes.org ([81.169.241.247]:36430 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388624AbfAaQfA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 11:35:00 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EE81B22D; Thu, 31 Jan 2019 17:34:58 +0100 (CET)
Date:   Thu, 31 Jan 2019 17:34:58 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH] dma: Uninline dma_max_mapping_size()
Message-ID: <20190131163458.GQ32526@8bytes.org>
References: <20190130164007.26497-1-joro@8bytes.org>
 <20190130164007.26497-4-joro@8bytes.org>
 <20190131104129.GA9241@lst.de>
 <20190131130127.GP32526@8bytes.org>
 <20190131143723.GA32329@lst.de>
 <20190131094319-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131094319-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 09:43:51AM -0500, Michael S. Tsirkin wrote:
> OK. Joerg can you repost the series with this squashed
> and all acks applied?

Sure, sent out now as v6.

Regards,

	Joerg
