Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdHJLQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2017 07:16:22 -0400
Date: Thu, 10 Aug 2017 04:16:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 05/49] fs/buffer: comment on direct access to bvec
 table
Message-ID: <20170810111616.GC20308@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-6-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +	/*
> +	 * It is safe to truncate the last bvec in the following way
> +	 * even though multipage bvec is supported, but we need to
> +	 * fix the parameters passed to zero_user().
> +	 */
> +	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];

A 'we need to fix XXX' comment isn't very useful.  Just fix it in the
series (which I suspect you're going to do anyway).

Also a bio_last_vec helper might be nice for something like this and
documents properly converted places much better than these comments.
