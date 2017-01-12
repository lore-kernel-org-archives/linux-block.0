Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Rename blk_queue_zone_size and bdev_zone_size
To: Damien Le Moal <damien.lemoal@wdc.com>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
 <20170112035214.GA27546@kernel.dk>
 <884ea9c8-6191-2630-78fd-ffed62a81f16@wdc.com>
 <36f3cd82-93f3-06ce-df75-f3c7d98322c3@kernel.dk>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-block@vger.kernel.org,
 Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9cdcae8c-ad41-bd22-1e0d-0facdae52a71@kernel.dk>
Date: Thu, 12 Jan 2017 13:49:17 -0700
MIME-Version: 1.0
In-Reply-To: <36f3cd82-93f3-06ce-df75-f3c7d98322c3@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/11/2017 09:38 PM, Jens Axboe wrote:
> On 01/11/2017 09:36 PM, Damien Le Moal wrote:
>> Jens,
>>
>> On 1/12/17 12:52, Jens Axboe wrote:
>>> On Thu, Jan 12 2017, Damien Le Moal wrote:
>>>> All block device data fields and functions returning a number of 512B
>>>> sectors are by convention named xxx_sectors while names in the form
>>>> of xxx_size are generally used for a number of bytes. The blk_queue_zone_size
>>>> and bdev_zone_size functions were not following this convention so rename
>>>> them.
>>>>
>>>> This is a style fix and no functional change is introduced by this patch.
>>>
>>> I agree, this cleans it up. Applied.
>>
>> Thank you. I saw that you applied to for-4.11/block. Could we get these
>> in applied to 4.10-rc so that the zoned block device API is cleaner from
>> the first stable release of that API?
> 
> Sure, I did consider that as well. Since I just pushed out the 4.11
> branch, I'll rebase and yank these into the 4.10 branch instead.

Just in case you missed it, I had to fold your two patches. Looking at
it again, what is going on? You rename a function, and then patch #2
renames the use of that function in a different spot? How did that ever
pass your testing? For something intended for the current series, please
be more careful than that, that's just sloppy.

-- 
Jens Axboe
