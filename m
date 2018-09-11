Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
 <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
 <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
Date: Tue, 11 Sep 2018 10:54:19 -0600
MIME-Version: 1.0
In-Reply-To: <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 10:51 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 9/11/18 10:48 AM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>>>
>>>>> Is this already addressed?
>>>>
>>>> Haven't heard about this one before. What kernel did you last use that
>>>> worked?
>>>
>>> I'm guessing you just need to update the maximum number of policies:
>>>
>>> /*
>>>  * Maximum number of blkcg policies allowed to be registered concurrently.
>>>  * Defined here to simplify include dependency.
>>>  */
>>> #define BLKCG_MAX_POLS          3
>>
>> That is my guess too, hence the suggestion to try and disable the
>> iolatency policy. Just tried here without, and it works, rebooting
>> with to verify that we're running out of policy slots.
> 
> Functions calling this function: blkcg_policy_register
> 
>   File                      Function       Line
> 0 block/bfq-iosched.c       bfq_init       5675 ret =
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_bfq);
> 1 block/blk-iolatency.c     iolatency_init  946 return
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_iolatency);
> 2 block/blk-throttle.c      throtl_init    2511 return
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_throtl);
> 3 block/cfq-iosched.c       cfq_init       4869 ret =
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_cfq);
> 
> And then there were 4...

Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
again, probably worth it to make it dynamic. So for, not really needed. Takashi,
can verify that the below fixes it up for you?


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c19f9078da1e..c630e02836a8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1510,8 +1510,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (!blkcg_policy[i])
 			break;
-	if (i >= BLKCG_MAX_POLS)
+	if (i >= BLKCG_MAX_POLS) {
+		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
 		goto err_unlock;
+	}
 
 	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
 	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..6980014357d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -54,7 +54,7 @@ struct blk_stat_callback;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		3
+#define BLKCG_MAX_POLS		5
 
 typedef void (rq_end_io_fn)(struct request *, blk_status_t);
 

-- 
Jens Axboe
