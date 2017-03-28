Return-Path: <tahsin@google.com>
MIME-Version: 1.0
In-Reply-To: <835b6175-6f18-164c-2363-74023ae6cbcb@kernel.dk>
References: <20170306200319.GF19696@htj.duckdns.org> <20170309080531.9048-1-tahsin@google.com>
 <835b6175-6f18-164c-2363-74023ae6cbcb@kernel.dk>
From: Tahsin Erdogan <tahsin@google.com>
Date: Tue, 28 Mar 2017 15:01:23 -0700
Message-ID: <CAAeU0aNNV_hYtc2=z2TD4vY9b_rVs9ifksGWMkrHAAi_3Dus+g@mail.gmail.com>
Subject: Re: [PATCH v5] blkcg: allocate struct blkcg_gq outside request queue spinlock
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Thanks!

On Tue, Mar 28, 2017 at 2:59 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 03/09/2017 01:05 AM, Tahsin Erdogan wrote:
>> blkg_conf_prep() currently calls blkg_lookup_create() while holding
>> request queue spinlock. This means allocating memory for struct
>> blkcg_gq has to be made non-blocking. This causes occasional -ENOMEM
>> failures in call paths like below:
>>
>>   pcpu_alloc+0x68f/0x710
>>   __alloc_percpu_gfp+0xd/0x10
>>   __percpu_counter_init+0x55/0xc0
>>   cfq_pd_alloc+0x3b2/0x4e0
>>   blkg_alloc+0x187/0x230
>>   blkg_create+0x489/0x670
>>   blkg_lookup_create+0x9a/0x230
>>   blkg_conf_prep+0x1fb/0x240
>>   __cfqg_set_weight_device.isra.105+0x5c/0x180
>>   cfq_set_weight_on_dfl+0x69/0xc0
>>   cgroup_file_write+0x39/0x1c0
>>   kernfs_fop_write+0x13f/0x1d0
>>   __vfs_write+0x23/0x120
>>   vfs_write+0xc2/0x1f0
>>   SyS_write+0x44/0xb0
>>   entry_SYSCALL_64_fastpath+0x18/0xad
>>
>> In the code path above, percpu allocator cannot call vmalloc() due to
>> queue spinlock.
>>
>> A failure in this call path gives grief to tools which are trying to
>> configure io weights. We see occasional failures happen shortly after
>> reboots even when system is not under any memory pressure. Machines
>> with a lot of cpus are more vulnerable to this condition.
>>
>> Update blkg_create() function to temporarily drop the rcu and queue
>> locks when it is allowed by gfp mask.
>
> Added for 4.12, thanks for your persistence in pulling this through.
>
> --
> Jens Axboe
>
