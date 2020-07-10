Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEBBC433E1
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 15:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C6D2078B
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 15:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJPm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:42:29 -0400
Received: from verein.lst.de ([213.95.11.211]:43774 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJPm2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 11:42:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF39968AEF; Fri, 10 Jul 2020 17:42:26 +0200 (CEST)
Date:   Fri, 10 Jul 2020 17:42:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: Re: simplify block device claiming
Message-ID: <20200710154226.GA20144@lst.de>
References: <20200702084919.3720275-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702084919.3720275-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments?

On Thu, Jul 02, 2020 at 10:49:15AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series simplifies how we claim block devices for exclusive opens.
> 
> Diffstat:
>  drivers/block/loop.c   |    7 -
>  fs/block_dev.c         |  231 ++++++++++++++++---------------------------------
>  include/linux/blkdev.h |    3 
>  3 files changed, 81 insertions(+), 160 deletions(-)
---end quoted text---
