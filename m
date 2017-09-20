Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: ignore non-nbd ioctl's
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
References: <1494037518-31903-1-git-send-email-jbacik@fb.com>
 <20170920143806.laqzcrjhxsumtdov@destiny>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a02f52ec-74c4-4903-b61b-83a1fd5b8488@kernel.dk>
Date: Wed, 20 Sep 2017 09:49:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170920143806.laqzcrjhxsumtdov@destiny>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 08:38 AM, Josef Bacik wrote:
> On Fri, May 05, 2017 at 10:25:18PM -0400, Josef Bacik wrote:
>> In testing we noticed that nbd would spew if you ran a fio job against
>> the raw device itself.  This is because fio calls a block device
>> specific ioctl, however the block layer will first pass this back to the
>> driver ioctl handler in case the driver wants to do something special.
>> Since the device was setup using netlink this caused us to spew every
>> time fio called this ioctl.  Since we don't have special handling, just
>> error out for any non-nbd specific ioctl's that come in.  This fixes the
>> spew.
>>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
> 
> Jens,
> 
> This fell through the cracks, could you pick it up, thanks,

Sure, applied.

-- 
Jens Axboe
