Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] direct-io: Remove unused DIO_ASYNC_EXTEND flag
To: Nikolay Borisov <nborisov@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 rgoldwyn@suse.de, linux-block@vger.kernel.org
References: <1519386329-2734-1-git-send-email-nborisov@suse.com>
 <f0132588-86e0-1430-dd2c-157e59272f40@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bea25d90-9e92-dce5-7e32-edf99b4161a2@kernel.dk>
Date: Mon, 12 Mar 2018 09:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <f0132588-86e0-1430-dd2c-157e59272f40@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/12/18 2:54 AM, Nikolay Borisov wrote:
> 
> 
> On 23.02.2018 13:45, Nikolay Borisov wrote:
>> This flag was added by 6039257378e4 ("direct-io: add flag to allow aio
>> writes beyond i_size") to support XFS. However, with the rework of
>> XFS' DIO's path to use iomap in acdda3aae146 ("xfs: use iomap_dio_rw")
>> it became redundant. So let's remove it.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Jens,
> 
> On a second look I think you are the more appropriate person to take
> these patches. SO do you have any objections to merging those via the
> block tree. ( I did CC you but didn't cc linux-block).

Both look fine to me, I can add them for 4.17. Thanks.

-- 
Jens Axboe
