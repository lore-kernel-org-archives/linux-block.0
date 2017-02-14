Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdBNQBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 11:01:12 -0500
Date: Tue, 14 Feb 2017 08:01:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 5/5] md: fast clone bio in bio_clone_mddev()
Message-ID: <20170214160109.GA32705@infradead.org>
References: <1487086143-10255-1-git-send-email-tom.leiming@gmail.com>
 <1487086143-10255-6-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487086143-10255-6-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 14, 2017 at 11:29:03PM +0800, Ming Lei wrote:
> Firstly bio_clone_mddev() is used in raid normal I/O and isn't
> in resync I/O path.
> 
> Secondly all the direct access to bvec table in raid happens on
> resync I/O except for write behind of raid1, in which we still
> use bio_clone() for allocating new bvec table.
> 
> So this patch replaces bio_clone() with bio_clone_fast()
> in bio_clone_mddev().
> 
> Also kill bio_clone_mddev() and call bio_clone_fast() directly, as
> suggested by Christoph Hellwig.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, can you also tack on another patch to kill bio_alloc_mddev
to be consistent?
