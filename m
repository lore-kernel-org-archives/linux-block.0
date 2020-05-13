Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00368CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2B523126
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgEMMYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:24:00 -0400
Received: from verein.lst.de ([213.95.11.211]:46204 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMMYA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:24:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F072968BEB; Wed, 13 May 2020 14:23:57 +0200 (CEST)
Date:   Wed, 13 May 2020 14:23:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: remove a pointless queue enter pair in
 blk_mq_alloc_request_hctx
Message-ID: <20200513122357.GA8336@lst.de>
References: <20200513110419.2362556-1-hch@lst.de> <20200513110419.2362556-4-hch@lst.de> <SN4PR0401MB35981F543497561896B564469BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35981F543497561896B564469BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 12:02:10PM +0000, Johannes Thumshirn wrote:
> I know success handling is discouraged in the kernel, but I think 
> 
> 	rq = blk_mq_get_request(q, NULL, &alloc_data);
> 	if (rq)
> 		return rq;
> 
> out_queue_exit:
> 	blk_queue_exit(q);
> 	return ERR_PTR(ret);
> 
> looks nicer, doesn't it?	

Not at all.  A flow of most common case stays in line, everything else
jumps out really helps with reading.
