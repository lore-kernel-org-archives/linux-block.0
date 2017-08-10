Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdHJL2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2017 07:28:08 -0400
Date: Thu, 10 Aug 2017 04:28:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 09/49] block: comment on bio_iov_iter_get_pages()
Message-ID: <20170810112805.GE20308@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-10-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> + * The hacking way of using bvec table as page pointer array is safe
> + * even after multipage bvec is introduced because that space can be
> + * thought as unused by bio_add_page().

I'm not sure what value this comment adds.

Note that once we have multi-page biovecs this could should change
to take advantage of multipage biovecs, so adding a comment before
that doesn't seem too helpful.
