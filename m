Return-Path: <BATV+efe86d5870596b20d79e+5139+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 18 Sep 2017 16:51:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: move sanity checking ahead of
 bi_front/back_seg_size updating
Message-ID: <20170918235110.GB8600@infradead.org>
References: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 16, 2017 at 07:10:30AM +0800, Jianchao Wang wrote:
> If the bio_integrity_merge_rq() return false or nr_phys_segments exceeds
> the max_segments, the merging fails, but the bi_front/back_seg_size may
> have been modified. To avoid it, move the sanity checking ahead.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can you elaborate a little more on how this found and if there
is a way to easily reproduce it, say for a blktests test case?
