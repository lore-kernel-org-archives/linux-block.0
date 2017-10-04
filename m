Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33121 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdJDO4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 10:56:08 -0400
Received: by mail-io0-f195.google.com with SMTP id j201so823033ioj.0
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2017 07:56:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171003080444.GB8345@infradead.org>
References: <1506013972-23049-1-git-send-email-idryomov@gmail.com>
 <1506013972-23049-3-git-send-email-idryomov@gmail.com> <20171003080444.GB8345@infradead.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 4 Oct 2017 16:56:06 +0200
Message-ID: <CAOi1vP9NLx2c7CD-2g6KVVN0ceZpupkzFvteUnRkJedYiJBWdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 3, 2017 at 10:04 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Sep 21, 2017 at 07:12:52PM +0200, Ilya Dryomov wrote:
>> sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
>> permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
>> is set.  Because REQ_OP_WRITE_ZEROES is implemented in terms of WRITE
>> SAME, blkdev_issue_zeroout() may fail with -EREMOTEIO:
>>
>>   $ fallocate -zn -l 1k /dev/sdg
>>   fallocate: fallocate failed: Remote I/O error
>>   $ fallocate -zn -l 1k /dev/sdg  # OK
>>   $ fallocate -zn -l 1k /dev/sdg  # OK
>>
>> The following calls succeed because sd_done() sets ->no_write_same in
>> response to a sense that would become BLK_STS_TARGET/-EREMOTEIO, causing
>> __blkdev_issue_zeroout() to fall back to generating ZERO_PAGE bios.
>>
>> This means blkdev_issue_zeroout() must cope with WRITE ZEROES failing
>> and fall back to manually zeroing, unless BLKDEV_ZERO_NOFALLBACK is
>> specified.  For BLKDEV_ZERO_NOFALLBACK case, return -EOPNOTSUPP if
>> sd_done() has just set ->no_write_same thus indicating lack of offload
>> support.
>>
>> Fixes: c20cfc27a473 ("block: stop using blkdev_issue_write_same for zeroing")
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  block/blk-lib.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 6b97feb71065..1cb402beb983 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -316,12 +316,6 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
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
>> @@ -374,6 +368,27 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>                       &bio, flags);
>>       if (ret == 0 && bio) {
>>               ret = submit_bio_wait(bio);
>> +             /*
>> +              * Fall back to a manual zeroout on any error, if allowed.
>> +              *
>> +              * Particularly, WRITE ZEROES may fail with -EREMOTEIO if the
>> +              * driver signals zeroing offload support, but the device
>> +              * fails to process the command (for some devices there is no
>> +              * non-destructive way to verify whether this operation is
>> +              * actually supported).
>> +              */
>> +             if (ret && bio_op(bio) == REQ_OP_WRITE_ZEROES) {
>
> No need for the additional levels of indentation here.  Also I
> really do not like the logic, we shouldn't have to duplicate much
> of the logic multiple times.
>
> I'd more go for something like (sketched in mail):
>
>         bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
>
> retry:
>         bio = NULL;
>         blk_start_plug(&plug);
>         if (try_write_zeroes)
>                 ret = __blkdev_issue_write_zeroes(...)
>         else
>                 ret = __blkdev_issue_zero_pages(...)
>         if (ret == 0 && bio) {
>                 ret = submit_bio_wait(bio);
>                 bio_put(bio);
>         }
>         blk_finish_plug(&plug);
>         if (ret && try_write_zeroes) {
>                 try_write_zeroes = false;
>                 goto retry;
>         }

Yeah, I didn't like the code flow either but we are going to duplicate
some of it either way.  In particular, !bdev_write_zeroes_sectors() ->
ret = -EOPNOTSUPP part is still needed to avoid propagating -EREMOTEIO
in BLKDEV_ZERO_NOFALLBACK case:

        if (try_write_zeroes)
                ret = __blkdev_issue_write_zeroes(...);
        else if (!(flags & BLKDEV_ZERO_NOFALLBACK))
                ret = __blkdev_issue_zero_pages(...);
        else if (!bdev_write_zeroes_sectors(bdev))
                ret = -EOPNOTSUPP;

bs_mask check from __blkdev_issue_zeroout() too.

I'll post v2 in a few.

Thanks,

                Ilya
