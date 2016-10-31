Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53335 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943729AbcJaPZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 11:25:52 -0400
Date: Mon, 31 Oct 2016 08:25:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        "open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>
Subject: Re: [PATCH 03/60] block: drbd: remove impossible failure handling
Message-ID: <20161031152549.GA30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Oct 29, 2016 at 04:08:02PM +0800, Ming Lei wrote:
> For a non-cloned bio, bio_add_page() only returns failure when
> the io vec table is full, but in that case, bio->bi_vcnt can't
> be zero at all.
> 
> So remove the impossible failure handling.
> 
> Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
