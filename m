Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DA360F59
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhJRSDr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 14:03:47 -0400
Received: from verein.lst.de ([213.95.11.211]:35391 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRSDr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 14:03:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4872368AFE; Mon, 18 Oct 2021 20:01:34 +0200 (CEST)
Date:   Mon, 18 Oct 2021 20:01:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 5/6] block: move blk_mq_tag_to_rq() inline
Message-ID: <20211018180133.GD4232@lst.de>
References: <20211018175109.401292-1-axboe@kernel.dk> <20211018175109.401292-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018175109.401292-6-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 11:51:08AM -0600, Jens Axboe wrote:
> This is in the fast path of driver issue or completion, and it's a single
> array index operation. Move it inline to avoid a function call for it.
> 
> This does mean making struct blk_mq_tags block layer public, but there's
> not really much in there.

I don't really like exposing more data structures if we can avoid it,
but if this makes a big enough difference:

Reviewed-by: Christoph Hellwig <hch@lst.de>
