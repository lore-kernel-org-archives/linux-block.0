Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53539 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966280AbcKAOSS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Nov 2016 10:18:18 -0400
Date: Tue, 1 Nov 2016 15:18:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fast-path for small and simple direct I/O
        requests
Message-ID: <20161101141816.GA17142@lst.de>
References: <1477936765-8828-1-git-send-email-hch@lst.de> <1477936765-8828-3-git-send-email-hch@lst.de> <20161031231911.GA20713@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161031231911.GA20713@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 04:19:11PM -0700, Omar Sandoval wrote:
> > +	if (unlikely(ret))
> > +		return ret;
> > +	ret = bio.bi_iter.bi_size;
> > +
> > +	if (iov_iter_rw(iter) == READ) {
> > +		bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> > +		if (iter->type == ITER_IOVEC)
> 
> Nit: iter_is_iovec()?

Fixed.

