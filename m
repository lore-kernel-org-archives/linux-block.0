Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35524 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbcKRIZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 03:25:41 -0500
Received: by mail-qk0-f194.google.com with SMTP id n204so30548478qke.2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 00:25:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161118074615.GA9077@infradead.org>
References: <1479421031-6060-1-git-send-email-ckulkarnilinux@gmail.com> <20161118074615.GA9077@infradead.org>
From: chaitany kulkarni <ckulkarnilinux@gmail.com>
Date: Fri, 18 Nov 2016 00:25:40 -0800
Message-ID: <CAK0tqinC_V0G7hSonKNanx1R7XkwWiTzvbDiSfP6N1xwK71_Ug@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] block: add support for REQ_OP_WRITE_ZEROES
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@fb.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sounds good, I'll update the whole series and resend it with v2 prefix.



On Thu, Nov 17, 2016 at 11:46 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Nov 17, 2016 at 02:17:11PM -0800, Chaitanya Kulkarni wrote:
>> From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
>>
>> This adds a new block layer operation to zero out a range of
>> LBAs. This allows to implement zeroing for devices that don't use
>> either discard with a predictable zero pattern or WRITE SAME of zeroes.
>> The prominent example of that is NVMe with the Write Zeroes command,
>> but in the future this should also help with improving the way
>> zeroing discards work.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
>
> I think you'll need to resend the whole series so that nvme can set
> the maximum discard sectors value.
>
>> @@ -575,9 +575,10 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
>>       const int op = bio_op(bio);
>>
>>       /*
>> -      * If not a WRITE (or a discard), do nothing
>> +      * If not a WRITE (or a discard or write zeroes), do nothing
>>        */
>> -     if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD))
>> +     if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD ||
>> +                             op == REQ_OP_WRITE_ZEROES))
>>               return false;
>
> Jens: should we really throttle for discard or write zeroes here?
> Those aren't really writeback driven..
>
>> +static inline unsigned int bdev_write_zeroes(struct block_device *bdev)
>> +{
>> +     struct request_queue *q = bdev_get_queue(bdev);
>> +
>> +     if (q)
>> +             return q->limits.max_write_zeroes_sectors;
>> +
>> +     return 0;
>
> If this returns a sector value I'd name it bdev_write_zeroes_sectors.
>
> Otherwise this looks great.
