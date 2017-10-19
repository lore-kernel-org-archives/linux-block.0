Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdJSW4W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 18:56:22 -0400
Date: Fri, 20 Oct 2017 06:55:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 09/49] block: comment on bio_iov_iter_get_pages()
Message-ID: <20171019225555.GB27130@ming.t460p>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-10-ming.lei@redhat.com>
 <20170810112805.GE20308@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810112805.GE20308@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 10, 2017 at 04:28:05AM -0700, Christoph Hellwig wrote:
> > + * The hacking way of using bvec table as page pointer array is safe
> > + * even after multipage bvec is introduced because that space can be
> > + * thought as unused by bio_add_page().
> 
> I'm not sure what value this comment adds.
> 
> Note that once we have multi-page biovecs this could should change
> to take advantage of multipage biovecs, so adding a comment before
> that doesn't seem too helpful.

As mentioned in comment on patch 8, bio_alloc_pages() should be move
to bcache.

-- 
Ming
