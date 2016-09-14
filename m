Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] block : Patches related to io_polling
To: Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org
References: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
Cc: hch@lst.de
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3863895a-e165-4708-d636-9cb3c82c2709@kernel.dk>
Date: Wed, 14 Sep 2016 08:42:38 -0600
MIME-Version: 1.0
In-Reply-To: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/13/2016 12:23 PM, Stephen Bates wrote:
> While profiling the performance of the io_poll feature of the blk-mq
> section of the block layer I found it useful to add another entry to
> the io_poll stats counters. I also found it really useful to be able
> to zero the stats counters by echoing into the relevant sysfs entry.
>
> These two patches are based off commit 0eadf37afc in Jen's
> for-4.9/block. I am not sure if that is the right repo and can rebase
> if necessary.
>
> In full disclosure the zeroing patch is based heavily on a code
> snippet Jens send me a few months ago.

Thanks Stephen, added for 4.9.

-- 
Jens Axboe
