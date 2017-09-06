Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdIFNrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 09:47:32 -0400
Date: Wed, 6 Sep 2017 06:47:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 10/18] lightnvm: pblk: use bio_copy_kern when possible
Message-ID: <20170906134731.GD3960@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504695071-25928-11-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 12:51:03PM +0200, Javier Gonz�lez wrote:
> In pblk, buffers forming bios can be allocated on physically contiguous
> or virtually contiguous memory. For physically contiguous memory, we
> already use the bio_map_kern helper funciton, however, for virtually
> contiguous memory, we from the bio manually. This makes the code more
> complex, specially on the completion path, where mapped pages need to be
> freed.
> 
> Instead, use bio_copy_kern, which does the same and at the same time
> simplifies the completion path.

Nope.  You want to loop over vmalloc_to_page and call bio_add_page
for each page, after taking care of virtually tagged caches instead
of this bounce buffering.

And you really want to allocate the request first and only then map
the data to the request, as said before.
