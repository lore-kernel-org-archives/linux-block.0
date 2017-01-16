Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdAPPSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 10:18:15 -0500
Date: Mon, 16 Jan 2017 07:18:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v1 00/54] block: support multipage bvec
Message-ID: <20170116151813.GA28410@infradead.org>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVM+DyiyyZJEGD0dtRtCFEd4OLV6k-bfLiz7-opsc5rkxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVM+DyiyyZJEGD0dtRtCFEd4OLV6k-bfLiz7-opsc5rkxw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 16, 2017 at 11:19:19AM +0800, Ming Lei wrote:
> Any comments on this version?

We'll need to make sure all drivers can handle multi-page bvecs
before continuing any other work.  Without that the series is a no-go.
Note that in general making a drivers capable of handling multipage
bvecs will clean it up by using new helpers and be worthwhile on it's
own.
