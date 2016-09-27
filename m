Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0045.outbound.protection.outlook.com ([104.47.37.45]:63890
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933433AbcI0OnM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2016 10:43:12 -0400
Subject: Re: [PATCH 5/9] block: Extend blk_freeze_queue_start() to the
 non-blk-mq path
To: Ming Lei <tom.leiming@gmail.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <7c8af8d2-2ac9-2767-5e5f-8de72eba3814@sandisk.com>
 <CACVXFVO=GFp=ArC_FT+xPSmL84m01fX6bzReBQ8DeLQ4fUD5cQ@mail.gmail.com>
CC: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        "Keith Busch" <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <a8e8796e-7266-4c8a-a4eb-31cedf73ec8a@sandisk.com>
Date: Tue, 27 Sep 2016 07:42:57 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVO=GFp=ArC_FT+xPSmL84m01fX6bzReBQ8DeLQ4fUD5cQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/27/16 06:22, Ming Lei wrote:
> On Tue, Sep 27, 2016 at 2:27 AM, Bart Van Assche
> <bart.vanassche@sandisk.com> wrote:
>> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
>> ---
>>  block/blk-core.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 8cc8006..5ecc7ab 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -689,7 +689,10 @@ void blk_freeze_queue_start(struct request_queue *q)
>>         freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
>>         if (freeze_depth == 1) {
>>                 percpu_ref_kill(&q->q_usage_counter);
>> -               blk_mq_run_hw_queues(q, false);
>> +               if (q->mq_ops)
>> +                       blk_mq_run_hw_queues(q, false);
>> +               else if (q->request_fn)
>> +                       blk_run_queue(q);
>
> Just wondering if you have a non-blk-mq drivers which need this change,
> cause we only hold .q_usage_counter for sync bio.

Hello Ming Lei,

Patch 8/9 calls blk_quiesce_queue() and blk_resume_queue() from a code 
path that is used in both blk-mq and non-blk-mq mode. Although it 
wouldn't be hard to modify that patch such that it only uses these two 
functions in blk-mq mode, that wouldn't be very elegant.

Jens, regarding non-blk-mq mode and q_usage_counter: do you prefer that 
I rework patch 8/9 such that blk_quiesce_queue() and blk_resume_queue() 
are only used in blk-mq mode or are you OK with adding a 
blk_queue_enter() call in get_request() and a blk_queue_exit() call to 
__blk_put_request()?

Bart.
