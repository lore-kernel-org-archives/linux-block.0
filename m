Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdAQHup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2017 02:50:45 -0500
Date: Mon, 16 Jan 2017 23:50:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v1 00/54] block: support multipage bvec
Message-ID: <20170117075011.GA9732@infradead.org>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVM+DyiyyZJEGD0dtRtCFEd4OLV6k-bfLiz7-opsc5rkxw@mail.gmail.com>
 <20170116151813.GA28410@infradead.org>
 <CACVXFVPW4GFDy+vXfO+nksTYDoGAmedzP5cN88f_uC-TJp6MAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPW4GFDy+vXfO+nksTYDoGAmedzP5cN88f_uC-TJp6MAg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 10:40:36AM +0800, Ming Lei wrote:
> IMO, the only one left is raid(1/5/10) which can be dealt with by the
> "NO_MP" flag.

No, they can't in the long run.  They need to handle the bvecs just
like everyone else.
