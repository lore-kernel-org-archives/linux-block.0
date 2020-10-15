Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E39C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 07:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1912224A
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 07:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgJOHni (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 03:43:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59447 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgJOHnh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 03:43:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 083C468AFE; Thu, 15 Oct 2020 09:43:36 +0200 (CEST)
Date:   Thu, 15 Oct 2020 09:43:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: set NOWAIT for sync polling
Message-ID: <20201015074335.GB14082@lst.de>
References: <20201013084051.27255-1-jefflexu@linux.alibaba.com> <20201013120913.GA614668@T590> <17357ee1-7662-f20b-0a49-2fb3fdf01ebc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17357ee1-7662-f20b-0a49-2fb3fdf01ebc@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 04:31:49PM +0800, JeffleXu wrote:
> What about just disabling HIPRI in preadv2(2)/pwritev2(2)? Christoph 
> Hellwig disabled HIPRI for libaio in
>
> commit 154989e45fd8de9bfb52bbd6e5ea763e437e54c5 ("aio: clear IOCB_HIPRI"). 
> What do you think, @Christoph?
>
> (cc Christoph Hellwig)

aio clears the flag because it can't work.  For preadv2/pwritev2 it
works perfectly fine.
