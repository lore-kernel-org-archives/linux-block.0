Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>, Ming Lei <ming.lei@redhat.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linux SCSI List <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block <linux-block@vger.kernel.org>,
 Bart Van Assche <bart.vanassche@wdc.com>, Omar Sandoval <osandov@fb.com>
References: <20180702050642.26265-1-ming.lei@redhat.com>
 <ca67f73e-8b6b-1581-f4d3-3bb676414fd5@interlog.com>
 <3be4902f-2ad4-30a1-9793-a105b62deb34@kernel.dk>
 <CACVXFVM0Ze_Qd1UArtGcmPQ=i4OaRpi=v7TYXBSNFKN5DqtrEA@mail.gmail.com>
 <c86cc681-13dd-a42c-2234-a59ff42e6e16@kernel.dk>
Message-ID: <25dff40b-39cc-e1de-7348-cd6cc6d05483@kernel.dk>
Date: Tue, 3 Jul 2018 09:41:28 -0600
MIME-Version: 1.0
In-Reply-To: <c86cc681-13dd-a42c-2234-a59ff42e6e16@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 8:05 AM, Jens Axboe wrote:
> On 7/2/18 5:43 PM, Ming Lei wrote:
>> On Tue, Jul 3, 2018 at 4:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/2/18 2:28 PM, Douglas Gilbert wrote:
>>>> On 2018-07-02 07:06 AM, Ming Lei wrote:
>>>>> With the introduced module parameter of 'use_blk_mq', it is easy
>>>>> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
>>>>> module, so that we can test scsi_mq/blk_mq related regressions easily.
>>>>>
>>>>> Cc: Douglas Gilbert <dgilbert@interlog.com>
>>>>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>> Cc: Omar Sandoval <osandov@fb.com>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>   drivers/scsi/scsi_debug.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>>>>> index 24d7496cd9e2..236cfb669df3 100644
>>>>> --- a/drivers/scsi/scsi_debug.c
>>>>> +++ b/drivers/scsi/scsi_debug.c
>>>>> @@ -144,6 +144,7 @@ static const char *sdebug_version_date = "20180128";
>>>>>   #define DEF_SUBMIT_QUEUES 1
>>>>>   #define DEF_UUID_CTL 0
>>>>>   #define JDELAY_OVERRIDDEN -9999
>>>>> +#define DEF_USE_BLK_MQ  0
>>>>>
>>>>>   #define SDEBUG_LUN_0_VAL 0
>>>>>
>>>>> @@ -671,6 +672,7 @@ static bool sdebug_verbose;
>>>>>   static bool have_dif_prot;
>>>>>   static bool write_since_sync;
>>>>>   static bool sdebug_statistics = DEF_STATISTICS;
>>>>> +static bool sdebug_use_blk_mq = DEF_USE_BLK_MQ;
>>>>>
>>>>>   static unsigned int sdebug_store_sectors;
>>>>>   static sector_t sdebug_capacity;   /* in sectors */
>>>>> @@ -4537,6 +4539,7 @@ module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
>>>>>                 S_IRUGO | S_IWUSR);
>>>>>   module_param_named(write_same_length, sdebug_write_same_length, int,
>>>>>                 S_IRUGO | S_IWUSR);
>>>>> +module_param_named(use_blk_mq, sdebug_use_blk_mq, bool, S_IRUGO | S_IWUSR);
>>>>>
>>>>>   MODULE_AUTHOR("Eric Youngdale + Douglas Gilbert");
>>>>>   MODULE_DESCRIPTION("SCSI debug adapter driver");
>>>>> @@ -5849,6 +5852,8 @@ static int sdebug_driver_probe(struct device *dev)
>>>>>      sdebug_driver_template.can_queue = sdebug_max_queue;
>>>>>      if (sdebug_clustering)
>>>>>              sdebug_driver_template.use_clustering = ENABLE_CLUSTERING;
>>>>> +    if (sdebug_use_blk_mq)
>>>>> +            sdebug_driver_template.force_blk_mq = 1;
>>>>>      hpnt = scsi_host_alloc(&sdebug_driver_template, sizeof(sdbg_host));
>>>>>      if (NULL == hpnt) {
>>>>>              pr_err("scsi_host_alloc failed\n");
>>>>>
>>>>
>>>> Hi,
>>>> It is up to others whether this patch goes through. It seems the default
>>>> associated with blk_mq may soon change. So two things:
>>>>    - I'd like to see a MODULE_PARM_DESC(use_blk_mq, ...) entry in patch
>>>>    - perhaps a 3 valued use_blk_mq: 1 --> force blk_mq; 0 (def) --> accept
>>>>      default mq setting; -1 --> turn off mq (if possible, if not it's a
>>>>      NOP)
>>>
>>> The point is that the parameter is going to be short lived, since the
>>> non-mq path will be going away. We don't want drivers exposing this
>>> sort of thing, just to remove the option shortly again. Once we're
>>> happy with scsi-mq for a release or two, the old code should be
>>> deleted. Once that happens, then the option will have no purpose.
>>
>> Not like other drivers, scsi_debug is a bit special, since it is for
>> test purpose. We may switch to scsi_mq at default soon, but the
>> whole MQ(block, scsi_mq) code may take ages to be removed,
>> maybe never.
> 
> It'll definitely get removed, the motivation to do that is strong. I'm
> not in violent disagreement with you, my main point is just that it's
> going to be a temporary option. Once we flip the switch again and remove
> the non-mq path for SCSI a few releases later, then the option is dead.
> 
>> We may use the per-driver parameter to test both mq and non-mq
>> path, especially for comparing both, then speed up to make MQ code
>> mature & stable. That is why I think this patch is very useful.
> 
> Also possible with just a reboot, or fiddle with the scsi_mod.use_blk_mq
> option...

Just to drive the point home, you can easily do:

echo N/Y > /sys/module/scsi_mod/parameters/use_blk_mq

to make scsi_debug default to one or the other, without adding this
module specific parameter.

-- 
Jens Axboe
