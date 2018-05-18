Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/34] block: add a lower-level bio_add_page interface
To: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org
References: <20180518164830.1552-1-hch@lst.de>
 <20180518164830.1552-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <febbcb2b-b3de-4e43-242e-0eb43f681bd0@kernel.dk>
Date: Fri, 18 May 2018 10:56:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180518164830.1552-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 10:47 AM, Christoph Hellwig wrote:
> For the upcoming removal of buffer heads in XFS we need to keep track of
> the number of outstanding writeback requests per page.  For this we need
> to know if bio_add_page merged a region with the previous bvec or not.
> Instead of adding additional arguments this refactors bio_add_page to
> be implemented using three lower level helpers which users like XFS can
> use directly if they care about the merge decisions.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
