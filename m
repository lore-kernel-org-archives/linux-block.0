Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56391 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944236AbcJaPkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 11:40:25 -0400
Date: Mon, 31 Oct 2016 08:40:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 46/60] block: deal with dirtying pages for multipage bvec
Message-ID: <20161031154021.GM30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-47-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-47-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Oct 29, 2016 at 04:08:45PM +0800, Ming Lei wrote:
> In bio_check_pages_dirty(), bvec->bv_page is used as flag
> for marking if the page has been dirtied & released, and if
> no, it will be dirtied in deferred workqueue.
> 
> With multipage bvec, we can't do that any more, so change
> the logic into checking all pages in one mp bvec, and only
> release all these pages if all are dirtied, otherwise dirty
> them all in deferred wrokqueue.

Just defer the whole bio to the workqueue if we need to redirty any,
that avoids having all these complex iteratations.
