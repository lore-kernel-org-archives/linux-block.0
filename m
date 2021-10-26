Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5706C610CB
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 07:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhJZHkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 03:40:21 -0400
Received: from verein.lst.de ([213.95.11.211]:60777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhJZHkV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47AAF6732D; Tue, 26 Oct 2021 09:37:56 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:37:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] loop: relax loop dio use condition
Message-ID: <20211026073756.GE31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 05:44:35PM +0800, Ming Lei wrote:
> So far loop dio requires the following conditions:
> 
> 1) lo->lo_offset is aligned with backing queue's logical block size
> 
> 2) loop queue's logical block size is <= backing queue's logical block
>    size

And both these checks absolutely do make sense.  We should not drop
them and gets us into the messy state of mixed direct and buffered
I/O.
