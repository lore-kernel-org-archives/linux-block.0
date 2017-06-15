Return-Path: <prvs=733925e927=clm@fb.com>
Date: Wed, 14 Jun 2017 18:31:19 -0700
From: Chris Mason <clm@fb.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <adilger@dilger.ca>, <hch@infradead.org>, <martin.petersen@oracle.com>
Subject: Re: [PATCH 10/11] btrfs: add support for passing in stream
 information for buffered writes
Message-ID: <20170615013117.GA32465@clm-mbp.thefacebook.com>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-11-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
In-Reply-To: <1497467134-6323-11-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 14, 2017 at 01:05:33PM -0600, Jens Axboe wrote:
>Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>Signed-off-by: Jens Axboe <axboe@kernel.dk>

Thanks Jens!

Signed-off-by: Chris Mason <clm@fb.com>

>---
> fs/btrfs/extent_io.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>index d3619e010005..b245085e8f10 100644
>--- a/fs/btrfs/extent_io.c
>+++ b/fs/btrfs/extent_io.c
>@@ -2827,6 +2827,7 @@ static int submit_extent_page(int op, int op_flags, struct extent_io_tree *tree,
> 	bio->bi_end_io = end_io_func;
> 	bio->bi_private = tree;
> 	bio_set_op_attrs(bio, op, op_flags);
>+	bio_set_streamid(bio, inode_streamid(page->mapping->host));
> 	if (wbc) {
> 		wbc_init_bio(wbc, bio);
> 		wbc_account_io(wbc, page, page_size);
>-- 
>2.7.4
>
