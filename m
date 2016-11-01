Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53547 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966318AbcKAOTK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Nov 2016 10:19:10 -0400
Date: Tue, 1 Nov 2016 15:19:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 1/2] block: add bio_iov_iter_get_pages()
Message-ID: <20161101141908.GB17142@lst.de>
References: <1477936765-8828-1-git-send-email-hch@lst.de> <1477936765-8828-2-git-send-email-hch@lst.de> <CACVXFVP_ybet0cYdt4voOoGGgXDj50qTajJD4hCmMci0W4juOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVP_ybet0cYdt4voOoGGgXDj50qTajJD4hCmMci0W4juOQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 01, 2016 at 09:05:00AM +0800, Ming Lei wrote:
> > +       size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> 
> BTW, if there is one multi-page version of get_user_pages_fast() and
> iov_iter_get_pages(), size of page array can be reduced too.

There isn't at the moment.  I have some plans for it, but it will require
lots of mm and arch changes, so I'd like to keep it separate.

