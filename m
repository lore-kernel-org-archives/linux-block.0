Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A58C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 08:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D76920818
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 08:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfBGIqQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:46:16 -0500
Received: from 8bytes.org ([81.169.241.247]:38722 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfBGIqQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 03:46:16 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 11C223A2; Thu,  7 Feb 2019 09:46:13 +0100 (CET)
Date:   Thu, 7 Feb 2019 09:46:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190207084613.GW32526@8bytes.org>
References: <20190131163403.11363-1-joro@8bytes.org>
 <20190205155133-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205155133-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

On Tue, Feb 05, 2019 at 03:52:38PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2019 at 05:33:58PM +0100, Joerg Roedel wrote:
> > Changes to v5 are:
> > 
> > 	- Changed patch 3 to uninline dma_max_mapping_size()
> 
> And this lead to problems reported by kbuild :(

Hmm, I didn't get any kbuild emails for this series. Can you please
forward it me so that I can look into it?

> BTW when you repost, can I ask you to pls include
> the version in all patches? Both --subject-prefix
> and -v flags to git format-patch will do this for you.

Will do, thanks.


Regards,

	Joerg
