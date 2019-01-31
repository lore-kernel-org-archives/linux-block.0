Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67314C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A18A2086C
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 14:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfAaOnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfAaOnz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 09:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 078EB804F2;
        Thu, 31 Jan 2019 14:43:55 +0000 (UTC)
Received: from redhat.com (ovpn-124-197.rdu2.redhat.com [10.10.124.197])
        by smtp.corp.redhat.com (Postfix) with SMTP id CFD855FCA6;
        Thu, 31 Jan 2019 14:43:51 +0000 (UTC)
Date:   Thu, 31 Jan 2019 09:43:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH] dma: Uninline dma_max_mapping_size()
Message-ID: <20190131094319-mutt-send-email-mst@kernel.org>
References: <20190130164007.26497-1-joro@8bytes.org>
 <20190130164007.26497-4-joro@8bytes.org>
 <20190131104129.GA9241@lst.de>
 <20190131130127.GP32526@8bytes.org>
 <20190131143723.GA32329@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131143723.GA32329@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 31 Jan 2019 14:43:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 03:37:23PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 31, 2019 at 02:01:27PM +0100, Joerg Roedel wrote:
> > On Thu, Jan 31, 2019 at 11:41:29AM +0100, Christoph Hellwig wrote:
> > > Sorry for not noticing last time, but since 5.0 we keep all non-fast
> > > path DMA mapping interfaces out of line, so this should move to
> > > kernel/dma/mapping.c.
> > 
> > Okay, attached patch does that. It applies on-top of this patch-set.
> > 
> > Michael, feel free to either apply this on-top of the patch-set or merge
> > the diff into patch 3, whatever you prefer.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I'd prefer it to be squashed if possible.

OK. Joerg can you repost the series with this squashed
and all acks applied?

