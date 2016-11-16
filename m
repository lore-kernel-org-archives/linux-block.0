Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:25742 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcKPRtC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 12:49:02 -0500
Date: Wed, 16 Nov 2016 12:59:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@fb.com, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
Message-ID: <20161116175906.GA10050@localhost.localdomain>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 15, 2016 at 10:50:36PM -0800, Chaitanya Kulkarni wrote:
> This adds a new block layer operation to zero out a range of
> LBAs. This allows to implement zeroing for devices that don't use
> either discard with a predictable zero pattern or WRITE SAME of zeroes.
> The prominent example of that is NVMe with the Write Zeroes command,
> but in the future this should also help with improving the way
> zeroing discards work.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
> ---

> +static int __blkdev_issue_write_zeroes(struct block_device *bdev,
> +		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> +		struct bio **biop)
> +{
> +	struct bio *bio = *biop;
> +	unsigned int max_write_zeroes_sectors;
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!blk_queue_write_zeroes(q))
> +		return -EOPNOTSUPP;
> +
> +	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
> +	max_write_zeroes_sectors = UINT_MAX >> 9;
> +
> +	while (nr_sects) {
> +		bio = next_bio(bio, 0, gfp_mask);
> +		bio->bi_iter.bi_sector = sector;
> +		bio->bi_bdev = bdev;
> +		bio_set_op_attrs(bio, REQ_OP_WRITE_ZEROES, 0);
> +
> +		if (nr_sects > max_write_zeroes_sectors) {
> +			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;

Your maximum bi_size exceeds the 2-bytes an NVMe Write Zeroes command
provides for the block count. Instead of having a simple queue flag
for write zeroes support, have it take a max sectors value instead. I
proposed this here a couple years ago (though I goof'ed registering the
nvme part...):

  http://lists.infradead.org/pipermail/linux-nvme/2014-July/001054.html
