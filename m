Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/28] ide: convert to blk-mq
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-5-axboe@kernel.dk>
 <bbdcdea9-96a9-b753-6f74-96565ad7fa91@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e45360e3-28b7-8742-bd75-ea05ff0fde3b@kernel.dk>
Date: Sat, 27 Oct 2018 10:51:07 -0600
MIME-Version: 1.0
In-Reply-To: <bbdcdea9-96a9-b753-6f74-96565ad7fa91@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/27/18 4:51 AM, Hannes Reinecke wrote:
> On 10/25/18 11:10 PM, Jens Axboe wrote:
>> ide-disk and ide-cd tested as working just fine, ide-tape and
>> ide-floppy haven't. But the latter don't require changes, so they
>> should work without issue.
>>
>> Add helper function to insert a request from a work queue, since we
>> cannot invoke the blk-mq request insertion from IRQ context.
>>
>> Cc: David Miller <davem@davemloft.net>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   drivers/ide/ide-atapi.c |  25 ++++--
>>   drivers/ide/ide-cd.c    | 175 +++++++++++++++++++++-------------------
>>   drivers/ide/ide-disk.c  |   5 +-
>>   drivers/ide/ide-io.c    | 101 +++++++++++++----------
>>   drivers/ide/ide-park.c  |   4 +-
>>   drivers/ide/ide-pm.c    |  28 ++-----
>>   drivers/ide/ide-probe.c |  68 +++++++++++-----
>>   include/linux/ide.h     |  13 ++-
>>   8 files changed, 240 insertions(+), 179 deletions(-)
>>
> There are some things here which are curious (like always setting the 
> queue depth to 32, and the insert_head thingie), but as this is legacy 
> anyway:

The insert head addition is needed, the alternative would be
making the blk-mq locks irq safe. And that would be a performance
hit that isn't acceptable. Perhaps I should make that clearer
in the commit message...

The 32 hard code is a bit strange, but I doubt it matters that much.
It's enough to saturate the drive for sure, and it'll be twice that
number if a scheduler is attached, ensuring we have plenty of
request to get the merging we want.

> Reviewed-by: Hannes Reinecke <hare@suse.com>

Thanks!

-- 
Jens Axboe
