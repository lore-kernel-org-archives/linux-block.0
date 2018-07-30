Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-5-bart.vanassche@wdc.com>
 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
 <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
 <cc184e4f68bd2794ab714d264fece552753727f9.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1b12202e-39d9-af51-c85f-171aab8b6e8d@oracle.com>
Date: Mon, 30 Jul 2018 10:27:55 +0800
MIME-Version: 1.0
In-Reply-To: <cc184e4f68bd2794ab714d264fece552753727f9.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>



On 07/27/2018 11:29 PM, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 09:57 +0800, jianchao.wang wrote:
>> Something like:
>>
>> 	percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
>> 	if (!percpu_ref_is_zero(&q->q_usage_counter)) {
>> 		ret = -EBUSY;
>> 		pm_runtime_mark_last_busy(q->dev);
>>      	} else {
>> 		blk_set_preempt_only(q);
>> 		if (!percpu_ref_is_zero(&q->q_usage_counter) {
>> 			ret = -EBUSY;
>> 			pm_runtime_mark_last_busy(q->dev);
>> 			blk_clear_preempt_only(q);
>> 		} else {
>> 			q->rpm_status = RPM_SUSPENDIN;    
>> 		}
>>         }
> 
> I think this code is racy. Because there is no memory barrier in
> blk_queue_enter() between the percpu_ref_tryget_live() and the
> blk_queue_preempt_only() calls, the context that sets the PREEMPT_ONLY flag
> has to use synchronize_rcu() or call_rcu() to ensure that blk_queue_enter()
> sees the PREEMPT_ONLY flag after it has called percpu_ref_tryget_live().
> See also https://urldefense.proofpoint.com/v2/url?u=http-3A__lwn.net_Articles_573497_&d=DwIFgQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=mkAOXQtxuVTAej2tBjOvEed2h4TRvX3mE-EPeNEUD5E&s=xTgTB2x1JwvRUQVyOL8m3rhbbk8xhOkZMC_Io9bmpFc&e=.

Yes, a synchrorize_rcu is indeed needed here to ensure a q_usage_counter is
got successfully with increasing one,  or unsuccessfully without increasing one.

Thanks
Jianchao
