Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C6EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 05:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F185610A3
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 05:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJSF7R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 01:59:17 -0400
Received: from verein.lst.de ([213.95.11.211]:36681 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhJSF7Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 01:59:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 343BF68BFE; Tue, 19 Oct 2021 07:57:02 +0200 (CEST)
Date:   Tue, 19 Oct 2021 07:57:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 4/6] block: change plugging to use a singly linked list
Message-ID: <20211019055701.GB20805@lst.de>
References: <20211018175109.401292-1-axboe@kernel.dk> <20211018175109.401292-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018175109.401292-5-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 11:51:07AM -0600, Jens Axboe wrote:
> Use a singly linked list for the blk_plug. This saves 8 bytes in the
> blk_plug struct, and makes for faster list manipulations than doubly
> linked lists. As we don't use the doubly linked lists for anything,
> singly linked is just fine.
> 
> This yields a bump in default (merging enabled) performance from 7.0
> to 7.1M IOPS, and ~7.5M IOPS with merging disabled.

I still find this very hard to review.  It doesn't just switch the
list implementation but also does change how this code works.  Especially
in blk_mq_flush_plug_list, but also in blk_mq_submit_bio.  I think
this needs to be further split up.
