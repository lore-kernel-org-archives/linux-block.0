Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38032 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdISJo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 05:44:27 -0400
Received: by mail-it0-f66.google.com with SMTP id 85so2064609ith.5
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2017 02:44:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOi1vP_Jpx+F7hTt2nJX5pJreN3G2QqVJgzzzuDMs=gUGMk-zw@mail.gmail.com>
References: <1504719490-7523-1-git-send-email-idryomov@gmail.com> <CAOi1vP_Jpx+F7hTt2nJX5pJreN3G2QqVJgzzzuDMs=gUGMk-zw@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 19 Sep 2017 11:44:25 +0200
Message-ID: <CAOi1vP9EwjdpKkrChVfCHHpnhuFw18PP8Txr5rBi5ZktaVrpTg@mail.gmail.com>
Subject: Re: [PATCH] block: cope with WRITE SAME failing in blkdev_issue_zeroout()
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 13, 2017 at 11:50 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Sep 6, 2017 at 7:38 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
>> permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
>> is set.  This means blkdev_issue_zeroout() must cope with WRITE SAME
>> failing with BLK_STS_TARGET/-EREMOTEIO and explicitly write zeroes,
>> unless BLKDEV_ZERO_NOFALLBACK is specified.
>>
>> Commit 71027e97d796 ("block: stop using discards for zeroing") added
>> the following to __blkdev_issue_zeroout() comment:
>>
>>   "Note that this function may fail with -EOPNOTSUPP if the driver signals
>>   zeroing offload support, but the device fails to process the command (for
>>   some devices there is no non-destructive way to verify whether this
>>   operation is actually supported).  In this case the caller should call
>>   retry the call to blkdev_issue_zeroout() and the fallback path will be used."
>>
>> But __blkdev_issue_zeroout() doesn't fail in this case: if WRITE SAME
>> support is indicated, a REQ_OP_WRITE_ZEROES bio is built and returned
>> to blkdev_issue_zeroout().  -EREMOTEIO is then propagated up:
>>
>>   $ fallocate -zn -l 1k /dev/sdg
>>   fallocate: fallocate failed: Remote I/O error
>>   $ fallocate -zn -l 1k /dev/sdg  # OK
>>
>> (The second fallocate(1) succeeds because sd_done() sets ->no_write_same
>> in response to a sense that would become BLK_STS_TARGET.)
>>
>> Retry __blkdev_issue_zeroout() if the I/O fails with -EREMOTEIO.  This
>> is roughly what we did until 4.12, sans BLKDEV_ZERO_NOFALLBACK knob.
>>
>> Fixes: c20cfc27a473 ("block: stop using blkdev_issue_write_same for zeroing")
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: stable@vger.kernel.org # 4.12+
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  block/blk-lib.c | 49 +++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 33 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 3fe0aec90597..876b5478c1a2 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -287,12 +287,6 @@ static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
>>   *  Zero-fill a block range, either using hardware offload or by explicitly
>>   *  writing zeroes to the device.
>>   *
>> - *  Note that this function may fail with -EOPNOTSUPP if the driver signals
>> - *  zeroing offload support, but the device fails to process the command (for
>> - *  some devices there is no non-destructive way to verify whether this
>> - *  operation is actually supported).  In this case the caller should call
>> - *  retry the call to blkdev_issue_zeroout() and the fallback path will be used.
>> - *
>>   *  If a device is using logical block provisioning, the underlying space will
>>   *  not be released if %flags contains BLKDEV_ZERO_NOUNMAP.
>>   *
>> @@ -343,6 +337,34 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>  }
>>  EXPORT_SYMBOL(__blkdev_issue_zeroout);
>>
>> +/*
>> + * This function may fail with -EREMOTEIO if the driver signals zeroing
>> + * offload support, but the device fails to process the command (for
>> + * some devices there is no non-destructive way to verify whether this
>> + * operation is actually supported).  In this case the caller should
>> + * retry and the fallback path in __blkdev_issue_zeroout() will be used
>> + * unless %flags contains BLKDEV_ZERO_NOFALLBACK.
>> + */
>> +static int __blkdev_issue_zeroout_wait(struct block_device *bdev,
>> +                                      sector_t sector, sector_t nr_sects,
>> +                                      gfp_t gfp_mask, unsigned flags)
>> +{
>> +       int ret;
>> +       struct bio *bio = NULL;
>> +       struct blk_plug plug;
>> +
>> +       blk_start_plug(&plug);
>> +       ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
>> +                       &bio, flags);
>> +       if (ret == 0 && bio) {
>> +               ret = submit_bio_wait(bio);
>> +               bio_put(bio);
>> +       }
>> +       blk_finish_plug(&plug);
>> +
>> +       return ret;
>> +}
>> +
>>  /**
>>   * blkdev_issue_zeroout - zero-fill a block range
>>   * @bdev:      blockdev to write
>> @@ -360,17 +382,12 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>                 sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
>>  {
>>         int ret;
>> -       struct bio *bio = NULL;
>> -       struct blk_plug plug;
>>
>> -       blk_start_plug(&plug);
>> -       ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
>> -                       &bio, flags);
>> -       if (ret == 0 && bio) {
>> -               ret = submit_bio_wait(bio);
>> -               bio_put(bio);
>> -       }
>> -       blk_finish_plug(&plug);
>> +       ret = __blkdev_issue_zeroout_wait(bdev, sector, nr_sects,
>> +                                         gfp_mask, flags);
>> +       if (ret == -EREMOTEIO)
>> +               ret = __blkdev_issue_zeroout_wait(bdev, sector, nr_sects,
>> +                                                 gfp_mask, flags);
>>
>>         return ret;
>>  }
>
> Ping...  This fixes a regression introduced in 4.12.  Christoph,
> Martin, could you please take a look?

Christoph, the regression got introduced with your "always use
REQ_OP_WRITE_ZEROES for zeroing offload" series, could you please look
at this?

Thanks,

                Ilya
