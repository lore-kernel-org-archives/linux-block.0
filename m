Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] block: pass in queue to inflight accounting
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
 <1501790516-6924-3-git-send-email-axboe@kernel.dk>
 <1501792550.2922.15.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee279cca-2449-a0ce-2577-ea25f59d892e@kernel.dk>
Date: Thu, 3 Aug 2017 14:37:47 -0600
MIME-Version: 1.0
In-Reply-To: <1501792550.2922.15.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/03/2017 02:35 PM, Bart Van Assche wrote:
> On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
>> No functional change in this patch, just in preparation for
>> basing the inflight mechanism on the queue in question.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/bio.c                   | 16 ++++++++--------
>>  block/blk-core.c              | 22 ++++++++++++----------
>>  block/blk-merge.c             |  4 ++--
>>  block/genhd.c                 |  4 ++--
>>  block/partition-generic.c     |  5 +++--
>>  drivers/block/drbd/drbd_req.c | 10 +++++++---
>>  drivers/block/rsxx/dev.c      |  6 +++---
>>  drivers/block/zram/zram_drv.c |  5 +++--
>>  drivers/md/bcache/request.c   |  7 ++++---
>>  drivers/md/dm.c               |  6 +++---
>>  drivers/nvdimm/nd.h           |  5 +++--
>>  include/linux/bio.h           |  9 +++++----
>>  include/linux/genhd.h         | 14 +++++++++-----
>>  13 files changed, 64 insertions(+), 49 deletions(-)
> 
> Hello Jens,
> 
> Should the DRBD, rsxx, zram, md and nvdimm driver maintainers be CC-ed?

Yeah, they should, forgot to do so. I'll make sure they see it, since
this is the initial posting, I'm assuming I'll have to do a v2 anyway.

-- 
Jens Axboe
