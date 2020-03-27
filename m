Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72235C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC6206F6
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0LVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:21:35 -0400
Received: from verein.lst.de ([213.95.11.211]:50874 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgC0LVf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 07:21:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00E7668C65; Fri, 27 Mar 2020 12:21:31 +0100 (CET)
Date:   Fri, 27 Mar 2020 12:21:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: simplify queue allocation
Message-ID: <20200327112131.GA1096@lst.de>
References: <20200327083012.1618778-1-hch@lst.de> <20200327083012.1618778-5-hch@lst.de> <SN4PR0401MB3598BF20E4DCF8F1B129625E9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598BF20E4DCF8F1B129625E9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 27, 2020 at 10:11:08AM +0000, Johannes Thumshirn wrote:
> On 27/03/2020 09:34, Christoph Hellwig wrote:
> > -struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
> > -{
> > -	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE);
> > -}
> > -EXPORT_SYMBOL(blk_alloc_queue);
> 
> Why are you removing the non _node() variant? The memory allocation 
> function for instance have this indirection as well and I don't think it 
> simplifies a lot passing NUMA_NO_NODE in each block driver.

Because the two variants are rather pointless.  And this might get
more people to actually pass a useful node ID instead of copy and
pasting some old example code.
