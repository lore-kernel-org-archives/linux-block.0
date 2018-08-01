Return-Path: <yanaijie@huawei.com>
Subject: Re: [PATCH] block: only rewind to last split
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <20180801093357.18417-1-yanaijie@huawei.com>
CC: <miaoxie@huawei.com>, <zhaohongjiang@huawei.com>, Kent Overstreet
	<kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <5B617E16.9040908@huawei.com>
Date: Wed, 1 Aug 2018 17:32:06 +0800
MIME-Version: 1.0
In-Reply-To: <20180801093357.18417-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-block@vger.kernel.org>

Sorry, please ignore this because I saw Greg Edwards's patch ("block: 
reset bi_iter.bi_done after splitting bio") already fixed this.

On 2018/8/1 17:33, Jason Yan wrote:
> Commit 63573e359d05 ("bio-integrity: Restore original iterator on verify
> stage") made the bio-integrity verify function works fine when the bio
> is smaller than the queue limit.
>
> But since commit 54efd50bfd87 ("block: make generic_make_request handle
> arbitrarily sized bios") the bio will split in block layer if the size
> of bio is larger than the max length of the queue limit. This will make
> the bio-integrity verify function do not work. We will see such error
> log with splited bios:
>
> [69163.386065] sda: ref tag error at location 0 (rcvd 1024)
>
> Suppose we have a bio of size 1024k submitted and the driver can only
> accept bio of max size 512k.
>
> The original bio:
>
>            bi_sector         1024k
>       bio      +-------------------------------+
>
> After the split we have two bios:
>
>            bi_sector  512k
>       split    +---------------+
>                             bi_sector  512k
>       bio      +---------------+---------------+
>
> The new split bio is cloned from the first 512k of the original bio. And
> the original bio is advanced to the next 512k(that is 512k~1024k). The
> we submit these two requests to the driver.
>
> After the these two bios are complete and we rewind the original bio in
> bio_integrity_verify_fn(), the bio restored to the beginnig, but it does
> not match the data we submitted to the driver:
>
>            bi_sector         1024k
>       bio      +-------------------------------+
>
> When the split bio is complete the verify works fine. But when the whole
> original bio is complete we just rewind the whole bio, which makes the
> seed does not match the ref tag at all. So we see the above error log.
>
> Fix this by clear the bi_iter.bi_done after split, so that we will only
> rewind to the last sector we last start to split.
>
> Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reported-by: Zhang Liao <zhangliao2@huawei.com>
> Tested-by: Li Chunjiang <lichunjiang2@huawei.com>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Kent Overstreet <kent.overstreet@gmail.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Martin K. Petersen <martin.petersen@oracle.com>
> CC: Miao Xie <miaoxie@huawei.com>
> CC: Zhaohongjiang <zhaohongjiang@huawei.com>
> ---
>   block/bio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 67eff5eddc49..afa4f408b9dc 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1867,6 +1867,14 @@ struct bio *bio_split(struct bio *bio, int sectors,
>
>   	bio_advance(bio, split->bi_iter.bi_size);
>
> +	/*
> +	 * Now bi_iter.bi_done is only used for bio-integrity to verify
> +	 * the data come up from the driver. If we don't clear bi_done
> +	 * here, the original bio will rewind to the beginning and the
> +	 * seed is error. Please check bio_integrity_verify_fn().
> +	 */
> +	bio->bi_iter.bi_done = 0;
> +
>   	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>   		bio_set_flag(split, BIO_TRACE_COMPLETION);
>
>
