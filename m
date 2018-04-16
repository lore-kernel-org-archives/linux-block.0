Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and
 BLK_EH_RESET_TIMER
To: Martin Steigerwald <martin@lichtvoll.de>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>,
        Israel Rukshin <israelr@mellanox.com>
References: <20180415154357.19788-1-ming.lei@redhat.com>
 <4563853.Bq5iVV2DL3@merkaba> <20180416004508.GA20345@ming.t460p>
 <4122070.FIbsgdqFrb@merkaba>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b459a445-1e3a-2734-e669-68142fab03d6@oracle.com>
Date: Tue, 17 Apr 2018 00:04:35 +0800
MIME-Version: 1.0
In-Reply-To: <4122070.FIbsgdqFrb@merkaba>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Martin and Ming

Regarding to the issue "RIP: scsi_times_out+0x17",

the rq->gstate and rq->aborted_gstate both are zero before the requests are allocated.
looks like the timeout value of scsi in Martin's system is small.
when the request_queue timer fires, if there is a request which is allocated for the first time,
the rq->gstate and rq->aborted_gstate both are 0,

static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
		struct request *rq, void *priv, bool reserved)
{
	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
		blk_mq_rq_timed_out(rq, reserved);
}

blk_mq_terminate_expired will identify the req is timed out and invoke scsi_times_out.
and at the moment, the scsi_cmnd is not initialized, so scsi_cmnd->device is NULL and we
get the crash.

maybe we could try this:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16e83e6..be9b435 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2077,6 +2077,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 
        seqcount_init(&rq->gstate_seq);
        u64_stats_init(&rq->aborted_gstate_sync);
+       WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
        return 0;
 }

Thanks
Jianchao

On 04/16/2018 09:12 PM, Martin Steigerwald wrote:
> Ming Lei - 16.04.18, 02:45:
>> On Sun, Apr 15, 2018 at 06:31:44PM +0200, Martin Steigerwald wrote:
>>> Hi Ming.
>>>
>>> Ming Lei - 15.04.18, 17:43:
>>>> Hi Jens,
>>>>
>>>> This two patches fixes the recently discussed race between
>>>> completion
>>>> and BLK_EH_RESET_TIMER.
>>>>
>>>> Israel & Martin, this one is a simpler fix on this issue and can
>>>> cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request,
>>>> could
>>>> you test V4 and see if your issue can be fixed?
>>>
>>> In replacement of all the three other patches I applied?
>>>
>>> - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a
>>> request.mbox'
>>>
>>> - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair
>>> into rcu_read_{lock,unlock}().mbox'
>>>
>>> - '[PATCH v4] blk-mq_Fix race conditions in request timeout
>>> handling.mbox'
>>
>> You only need to replace the above one '[PATCH v4] blk-mq_Fix race
>> conditions in request timeout' with V4 in this thread.
> 
> Ming, a 4.16.2 with the patches:
> 
> '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
> request.mbox'
> '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
> rcu_read_{lock,unlock}().mbox'
> '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
> timeout isn'\''t handled.mbox'
> '[PATCH V4 2_2] blk-mq_fix race between complete and 
> BLK_EH_RESET_TIMER.mbox'
> 
> hung on boot 3 out of 4 times.
> 
> See
> 
> [Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime 
> and boot failures with blk_mq_terminate_expired in backtrace
> https://urldefense.proofpoint.com/v2/url?u=https-3A__bugzilla.kernel.org_show-5Fbug.cgi-3Fid-3D199077-23c13&d=DwIDAw&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=29cf23VbYAblDS0xYyNaxkkds9LZmeGgn9B-hW-coT4&s=k3RMTv8QJ0j9pqbU-5vXgeUiJ2hiR7Lz1X69QyI0JkI&e=
> 
> I tried to add your mail address to Cc of the bug report, but Bugzilla 
> did not know it.
> 
> Fortunately it booted on the fourth attempt, cause I forgot my GRUB 
> password.
> 
> Reverting back to previous 4.16.1 kernel with patches from Bart.
> 
>>> These patches worked reliably so far both for the hang on boot and
>>> error reading SMART data.
>>
>> And you may see the reason in the following thread:
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dblock-26m-3D152366441625786-26w-3D2&d=DwIDAw&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=29cf23VbYAblDS0xYyNaxkkds9LZmeGgn9B-hW-coT4&s=HyhVTq4b6Ti5CkkAONj5WcLISRyumzfpK2nIJJZE4nU&e=
> 
> So requests could never be completed?
> 
>>> I´d compile a kernel tomorrow or Tuesday I think.
> 
> Thanks,
> 
