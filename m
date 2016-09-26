Return-Path: <shaun.tancheff@seagate.com>
MIME-Version: 1.0
In-Reply-To: <20160926163752.GA13876@infradead.org>
References: <1474888483-29762-1-git-send-email-damien.lemoal@hgst.com>
 <1474888483-29762-8-git-send-email-damien.lemoal@hgst.com> <20160926163752.GA13876@infradead.org>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Mon, 26 Sep 2016 18:12:24 -0500
Message-ID: <CAJVOszCdwMhLyZAJAWDnDBziyAejxdwi5J-X197RXwNuvC82GA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] blk-zoned: implement ioctls
To: Christoph Hellwig <hch@infradead.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 26, 2016 at 11:37 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> +     zones = kzalloc(sizeof(struct blk_zone) * rep.nr_zones,
>> +                     GFP_KERNEL);
>> +     if (!zones)
>> +             return -ENOMEM;
>
> This should use kcalloc to get us underflow checking for the user
> controlled allocation size.

Ah. yes. Will fix that.

>> +     if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report))) {
>> +             ret = -EFAULT;
>> +             goto out;
>> +     }
>> +
>> +     if (rep.nr_zones) {
>> +             if (copy_to_user(argp + sizeof(struct blk_zone_report), zones,
>> +                              sizeof(struct blk_zone) * rep.nr_zones))
>> +                     ret = -EFAULT;
>> +     }
>
> We could actually do this with a single big copy_to_user.  Not that
> it really matters, though..

Except our source locations are disjoint (stack and kcalloc'd).

>> -/*
>> - * Zone type.
>> - */
>> -enum blk_zone_type {
>> -     BLK_ZONE_TYPE_UNKNOWN,
>> -     BLK_ZONE_TYPE_CONVENTIONAL,
>> -     BLK_ZONE_TYPE_SEQWRITE_REQ,
>> -     BLK_ZONE_TYPE_SEQWRITE_PREF,
>> -};
>
> Please don't move this code around after it was added just two
> patches earlier.  I'd say just split adding the new blkzoned.h
> uapi header into a patch of it's own and add that before the
> core block code.

Sounds good. Will reshuffle the patchset tonight.

Thanks!
-- 
Shaun Tancheff
