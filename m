Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] Rename blk_queue_zone_size and bdev_zone_size
To: Jens Axboe <axboe@kernel.dk>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
 <20170112035214.GA27546@kernel.dk>
 <884ea9c8-6191-2630-78fd-ffed62a81f16@wdc.com>
 <36f3cd82-93f3-06ce-df75-f3c7d98322c3@kernel.dk>
CC: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-block@vger.kernel.org>, Shaun
 Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <94c17646-12de-03ef-7c15-f8ab3b6b8d76@wdc.com>
Date: Thu, 12 Jan 2017 13:43:37 +0900
MIME-Version: 1.0
In-Reply-To: <36f3cd82-93f3-06ce-df75-f3c7d98322c3@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>


On 1/12/17 13:38, Jens Axboe wrote:
> On 01/11/2017 09:36 PM, Damien Le Moal wrote:
>> Jens,
>>
>> On 1/12/17 12:52, Jens Axboe wrote:
>>> On Thu, Jan 12 2017, Damien Le Moal wrote:
>>>> All block device data fields and functions returning a number of 512B
>>>> sectors are by convention named xxx_sectors while names in the form
>>>> of xxx_size are generally used for a number of bytes. The blk_queue_zo=
ne_size
>>>> and bdev_zone_size functions were not following this convention so ren=
ame
>>>> them.
>>>>
>>>> This is a style fix and no functional change is introduced by this pat=
ch.
>>>
>>> I agree, this cleans it up. Applied.
>>
>> Thank you. I saw that you applied to for-4.11/block. Could we get these
>> in applied to 4.10-rc so that the zoned block device API is cleaner from
>> the first stable release of that API?
> =

> Sure, I did consider that as well. Since I just pushed out the 4.11
> branch, I'll rebase and yank these into the 4.10 branch instead.

Thanks !

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
