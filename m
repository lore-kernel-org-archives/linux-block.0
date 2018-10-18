Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: don't deal with discard limit in
 blkdev_issue_discard()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, stable@vger.kernel.org,
 Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
 Ming Lin <ming.l@ssi.samsung.com>, Mike Snitzer <snitzer@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>
References: <20181012075310.4587-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f025344a-3ecf-afe0-4bcf-439d0b3051cf@kernel.dk>
Date: Thu, 18 Oct 2018 07:23:56 -0600
MIME-Version: 1.0
In-Reply-To: <20181012075310.4587-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 1:53 AM, Ming Lei wrote:
> blk_queue_split() does respect this limit via bio splitting, so no
> need to do that in blkdev_issue_discard(), then we can align to
> normal bio submit(bio_add_page() & submit_bio()).
> 
> More importantly, this patch fixes one issue introduced in a22c4d7e34402cc
> ("block: re-add discard_granularity and alignment checks"), in which
> zero discard bio may be generated in case of zero alignment.

Thanks Ming, applied.

-- 
Jens Axboe
