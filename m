Return-Path: <axboe@kernel.dk>
Subject: Re: resend: zeroout fixes
To: Christoph Hellwig <hch@lst.de>
References: <1468920214-32400-1-git-send-email-hch@lst.de>
Cc: shli@fb.com, martin.petersen@oracle.com, snitzer@redhat.com,
 sitsofe@yahoo.com, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5c685f2e-59e5-18e6-5205-7bf9193fbac3@kernel.dk>
Date: Wed, 20 Jul 2016 17:36:32 -0600
MIME-Version: 1.0
In-Reply-To: <1468920214-32400-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/19/2016 03:23 AM, Christoph Hellwig wrote:
> The first one is a repost of my BLKDEV_DISCARD_ZERO with the spelling
> fixes suggest from Martin, the second one just drops the -EOPNOTSUPP
> special casing in blkdev_issue_write_same.
>
> Note that the patches are against the block for-next tree, and
> unfortunately we have diverged significantly from 4.7 in this area:
> 4.7 has the missing bio_put for the sumbmit_bio_wait callers, and
> 4.8 has the various req_op changes, including a new calling
> convention for __blkdev_issue_zeroout.  I'm not sure how to best
> sort this mess out, but I really think we need the bio_put in the
> for-4.8 tree as well, and we should probably bring the changed
> __blkdev_issue_discard calling convention into 4.7 as well.
> Suggestion for how to best handle this?

I think we should leave 4.7 as-is. The put issue being fixed is the most 
important one, so just roll a separate 4.8 patch for that.

-- 
Jens Axboe
