Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34651 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbdAFDbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2017 22:31:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170103164312.GA20421@redhat.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <1482854250-13481-13-git-send-email-tom.leiming@gmail.com> <20170103164312.GA20421@redhat.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 6 Jan 2017 11:30:26 +0800
Message-ID: <CACVXFVNLx7PRXDcKDTf4bW6oDdo7YrUp3ES7JJ-NJ5TmN2FQfw@mail.gmail.com>
Subject: Re: [PATCH v1 12/54] dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        "maintainer:DEVICE-MAPPER LVM, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org open list:SOFTWARE RAID Multiple DisksSUPPORT"
        <dm-devel@redhat.com>, Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 4, 2017 at 12:43 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Tue, Dec 27 2016 at 10:56am -0500,
> Ming Lei <tom.leiming@gmail.com> wrote:
>
>> For BIO based DM, some targets aren't ready for dealing with
>> bigger incoming bio than 1Mbyte, such as crypt target.
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>>  drivers/md/dm.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index 3086da5664f3..6139bf7623f7 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -899,7 +899,16 @@ int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
>>               return -EINVAL;
>>       }
>>
>> -     ti->max_io_len = (uint32_t) len;
>> +     /*
>> +      * BIO based queue uses its own splitting. When multipage bvecs
>> +      * is switched on, size of the incoming bio may be too big to
>> +      * be handled in some targets, such as crypt.
>> +      *
>> +      * When these targets are ready for the big bio, we can remove
>> +      * the limit.
>> +      */
>> +     ti->max_io_len = min_t(uint32_t, len,
>> +                            (BIO_MAX_PAGES * PAGE_SIZE));
>>
>>       return 0;
>>  }
>> --
>> 2.7.4
>
> dm_set_target_max_io_len() is already meant to be called by the .ctr
> hook for each DM target.  So why not just have the dm-crypt target (and
> other targets if needed) pass your reduced $len?
>
> That way only targets that need to be fixed (e.g. dm-crypt) impose this
> limit.

Looks better way, and I will do it in V2.


Thanks,
Ming Lei
