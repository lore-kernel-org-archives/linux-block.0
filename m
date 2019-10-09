Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED5DC47404
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253612190F
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570659229;
	bh=RyPgVqyj3PPw8zKgkDtZVoZJBEN/mwASsfZ3X8viFlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oimw+9TM6kby0a91LK+Fha+sBEDa9R2WJ326TKFUdH9l/dGrTW9EUg/yGhfefDGdp
	 VK/JyiS7G5O7wrN5NDJwHBwM1SGZ7G1caXbm5+z4ddnIu9RF2Xcc77UkkLUwN4v7ap
	 dZQVAs7VUmjUm9Q4CDuPLzdSbY3ELabEdKghc1Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfJIWNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbfJIWNs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 18:13:48 -0400
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08B120B7C;
        Wed,  9 Oct 2019 22:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570659227;
        bh=RyPgVqyj3PPw8zKgkDtZVoZJBEN/mwASsfZ3X8viFlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ob9rAGSf4kNkBMpSCe4SQ3shpy8EKIrmDLXF707Cgz9PzHJA6+ZVX3wqfOwpy3c94
         4KqzrRhJaQyB3mDz9J4jyRqBVSABi8NN3laK0c/71U1sIEzkZjJGvGLqWrDmNtIGke
         PqJspaioXzcDujS0cyNGMv6SjJM66iv/A0BGWCEg=
Date:   Thu, 10 Oct 2019 07:13:44 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 01/12] nvme-core: introduce nvme_ctrl_get_by_path()
Message-ID: <20191009221344.GB3009@washi1.fujisawa.hgst.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:18PM -0600, Logan Gunthorpe wrote:
> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> It makes use of filp_open() to open the file and uses the private
> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
> file do not match, -EINVAL is returned.
> 
> The purpose of this function is to support NVMe-OF target passthru.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>
