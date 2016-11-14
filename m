Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52259 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbcKNSAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 13:00:54 -0500
Date: Mon, 14 Nov 2016 10:00:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161114180052.GA24476@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 14, 2016 at 10:47:46AM -0700, Jens Axboe wrote:
> This seems less clean in basically all ways, not sure I agree with you.
> We already have 4 vecs inlined in a generic bio, and we might as well
> use the fs bioset instead of creating our own. You also add a smallish
> dio to track things, I don't think we need that.

We need it unless we want unbounded allocations for the biovec.  With a
1GB I/O we're at a page size allocation, and with 64MB I/Os that aren't
unheard of we'd be up to a 64 pages or an order 6 allocation which will
take down the VM.  We also need to pin down all the user memory while
doing the I/O instead of having throttling on the bio mempool before
doing the get_user_pages.
