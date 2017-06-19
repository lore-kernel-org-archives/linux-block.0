Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 06/11] fs: add O_DIRECT support for sending down write
 life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-7-git-send-email-axboe@kernel.dk>
 <20170619062824.GE2311@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a2c19014-3406-625a-8afd-4f011196c739@kernel.dk>
Date: Mon, 19 Jun 2017 08:57:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170619062824.GE2311@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 12:28 AM, Christoph Hellwig wrote:
> On Sat, Jun 17, 2017 at 01:59:49PM -0600, Jens Axboe wrote:
>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c | 2 ++
>>  fs/direct-io.c | 2 ++
>>  fs/iomap.c     | 1 +
>>  3 files changed, 5 insertions(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 519599dddd36..b9222a9d285e 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -239,6 +239,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  			should_dirty = true;
>>  	} else {
>>  		bio.bi_opf = dio_bio_write_op(iocb);
>> +		bio.bi_opf |= write_hint_to_opf(iocb_write_hint(iocb));
> 
> Move this into dio_bio_write_op instead of duplicating it?

Good cleanup, will do.


-- 
Jens Axboe
