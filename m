Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Keith Busch <keith.busch@intel.com>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
 Sebastian Ott <sebott@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
Message-ID: <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
Date: Tue, 22 May 2018 13:38:06 -0600
MIME-Version: 1.0
In-Reply-To: <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/22/18 1:03 PM, Jens Axboe wrote:
> On 5/22/18 12:47 PM, Jens Axboe wrote:
>> On 5/22/18 11:17 AM, Jens Axboe wrote:
>>> On 5/22/18 10:44 AM, Jens Axboe wrote:
>>>>
>>>> On 5/22/18 10:25 AM, Bart Van Assche wrote:
>>>>> Recently the blk-mq timeout handling code was reworked. See also Tejun
>>>>> Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
>>>>> (https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
>>>>> This patch reworks the blk-mq timeout handling code again. The timeout
>>>>> handling code is simplified by introducing a state machine per request.
>>>>> This change avoids that the blk-mq timeout handling code ignores
>>>>> completions that occur after blk_mq_check_expired() has been called and
>>>>> before blk_mq_rq_timed_out() has been called.
>>>>
>>>> I'll take a look at this again, getting rid of cmpxchg64 makes me
>>>> much more comfortable.
>>>
>>> FWIW, a quick pass on runtime testing works fine. As expected, it's
>>> more efficient than what's currently in the kernel, testing with both
>>> null_blk (1 and nr_cpus worth of queues), and nvme as well. A huge win
>>> is that we shrink the request size from 360 bytes to 312, and I did
>>> a small followup patch that brings that to 304. That's a 15% reduction,
>>> massive.
>>
>> Ran into this, running block/014 from blktests:
>>
>> [ 5744.949839] run blktests block/014 at 2018-05-22 12:41:25
>> [ 5750.723000] null: rq 00000000ff68f103 timed out
>> [ 5750.728181] WARNING: CPU: 45 PID: 2480 at block/blk-mq.c:585 __blk_mq_complete_request+0xa6/0x0
>> [ 5750.738187] Modules linked in: null_blk(+) configfs nvme nvme_core sb_edac x86_pkg_temp_therma]
>> [ 5750.765509] CPU: 45 PID: 2480 Comm: kworker/45:1H Not tainted 4.17.0-rc6+ #712
>> [ 5750.774087] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
>> [ 5750.783369] Workqueue: kblockd blk_mq_timeout_work
>> [ 5750.789223] RIP: 0010:__blk_mq_complete_request+0xa6/0x110
>> [ 5750.795850] RSP: 0018:ffff883ffb417d68 EFLAGS: 00010202
>> [ 5750.802187] RAX: 0000000000000003 RBX: ffff881ff100d800 RCX: 0000000000000000
>> [ 5750.810649] RDX: ffff88407fd9e040 RSI: ffff88407fd956b8 RDI: ffff881ff100d800
>> [ 5750.819119] RBP: ffffe8ffffd91800 R08: 0000000000000000 R09: ffffffff82066eb8
>> [ 5750.827588] R10: ffff883ffa386138 R11: ffff883ffa385900 R12: 0000000000000001
>> [ 5750.836050] R13: ffff881fe7da6000 R14: 0000000000000020 R15: 0000000000000002
>> [ 5750.844529] FS:  0000000000000000(0000) GS:ffff88407fd80000(0000) knlGS:0000000000000000
>> [ 5750.854482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 5750.861397] CR2: 00007ffc92f97f68 CR3: 000000000201d005 CR4: 00000000003606e0
>> [ 5750.869861] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 5750.878333] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 5750.886805] Call Trace:
>> [ 5750.890033]  bt_iter+0x42/0x50
>> [ 5750.894000]  blk_mq_queue_tag_busy_iter+0x12b/0x220
>> [ 5750.899941]  ? blk_mq_tag_to_rq+0x20/0x20
>> [ 5750.904913]  ? __rcu_read_unlock+0x50/0x50
>> [ 5750.909978]  ? blk_mq_tag_to_rq+0x20/0x20
>> [ 5750.914948]  blk_mq_timeout_work+0x14b/0x240
>> [ 5750.920220]  process_one_work+0x21b/0x510
>> [ 5750.925197]  worker_thread+0x3a/0x390
>> [ 5750.929781]  ? process_one_work+0x510/0x510
>> [ 5750.934944]  kthread+0x11c/0x140
>> [ 5750.939028]  ? kthread_create_worker_on_cpu+0x50/0x50
>> [ 5750.945169]  ret_from_fork+0x1f/0x30
>> [ 5750.949656] Code: 48 02 00 00 80 e6 80 74 29 8b 95 80 00 00 00 44 39 e2 75 3b 48 89 df ff 90 2 
>> [ 5750.972139] ---[ end trace 40065cb1764bf500 ]---
>>
>> which is this:
>>
>>         WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
> 
> That check looks wrong, since TIMED_OUT -> COMPLETE is also a valid
> state transition. So that check should be:
> 
>         WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE &&
>                      blk_mq_rq_state(rq) != MQ_RQ_TIMED_OUT);

I guess it would be cleaner to actually do the transition, in
blk_mq_rq_timed_out():

        case BLK_EH_HANDLED:                                                    
                if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT,                
                                                MQ_RQ_COMPLETE))                
                        __blk_mq_complete_request(req);                         
                break;        

This works for me.

-- 
Jens Axboe
