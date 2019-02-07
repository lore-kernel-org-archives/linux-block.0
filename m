Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A627C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41860218FE
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfBGIti (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:49:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:53988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfBGIti (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 03:49:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0A42AEB7;
        Thu,  7 Feb 2019 08:49:36 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:49:33 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190207084933.GA22272@suse.de>
References: <20190131163403.11363-1-joro@8bytes.org>
 <20190205155133-mutt-send-email-mst@kernel.org>
 <20190207084613.GW32526@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207084613.GW32526@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 07, 2019 at 09:46:13AM +0100, Joerg Roedel wrote:
> Hmm, I didn't get any kbuild emails for this series. Can you please
> forward it me so that I can look into it?

Nevermind, just found them in another inbox.


	Joerg
