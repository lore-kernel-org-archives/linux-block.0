Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50653 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750741AbdA1AOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 19:14:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0RLdir4129609
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 16:39:46 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2884k0ph04-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 16:39:46 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <dougmill@linux.vnet.ibm.com>;
        Fri, 27 Jan 2017 14:39:41 -0700
Subject: Re: [PATCH 1/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
To: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>
References: <1485550748-28075-1-git-send-email-dougmill@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 15:39:35 -0600
MIME-Version: 1.0
In-Reply-To: <1485550748-28075-1-git-send-email-dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6877752c-2935-a27f-5390-95aa4990b2a3@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'd like to request this be flagged for "stable".


Thanks,

Doug


On 01/27/2017 02:59 PM, Douglas Miller wrote:
> percpu_ref_tryget() and percpu_ref_tryget_live() should return
> "true" IFF they acquire a reference. But the return value from
> atomic_long_inc_not_zero() is a long and may have high bits set,
> e.g. PERCPU_COUNT_BIAS, and the return value of the tryget routines
> is bool so the reference may actually be acquired but the routines
> return "false" which results in a reference leak since the caller
> assumes it does not need to do a corresponding percpu_ref_put().
>
> This was seen when performing CPU hotplug during I/O, as hangs in
> blk_mq_freeze_queue_wait where percpu_ref_kill (blk_mq_freeze_queue_start)
> raced with percpu_ref_tryget (blk_mq_timeout_work).
> Sample stack trace:
>
> __switch_to+0x2c0/0x450
> __schedule+0x2f8/0x970
> schedule+0x48/0xc0
> blk_mq_freeze_queue_wait+0x94/0x120
> blk_mq_queue_reinit_work+0xb8/0x180
> blk_mq_queue_reinit_prepare+0x84/0xa0
> cpuhp_invoke_callback+0x17c/0x600
> cpuhp_up_callbacks+0x58/0x150
> _cpu_up+0xf0/0x1c0
> do_cpu_up+0x120/0x150
> cpu_subsys_online+0x64/0xe0
> device_online+0xb4/0x120
> online_store+0xb4/0xc0
> dev_attr_store+0x68/0xa0
> sysfs_kf_write+0x80/0xb0
> kernfs_fop_write+0x17c/0x250
> __vfs_write+0x6c/0x1e0
> vfs_write+0xd0/0x270
> SyS_write+0x6c/0x110
> system_call+0x38/0xe0
>
> Examination of the queue showed a single reference (no PERCPU_COUNT_BIAS,
> and __PERCPU_REF_DEAD, __PERCPU_REF_ATOMIC set) and no requests.
> However, conditions at the time of the race are count of PERCPU_COUNT_BIAS + 0
> and __PERCPU_REF_DEAD and __PERCPU_REF_ATOMIC set.
>
> The fix is to make the tryget routines return an actual boolean instead
> of the atomic long result truncated to a bool.
>
> Fixes: e625305b3907 percpu-refcount: make percpu_ref based on longs instead of ints
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=190751
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> ---
>   include/linux/percpu-refcount.h |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 1c7eec0..88dc96b 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -212,7 +212,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>   		this_cpu_inc(*percpu_count);
>   		ret = true;
>   	} else {
> -		ret = atomic_long_inc_not_zero(&ref->count);
> +		ret = (atomic_long_inc_not_zero(&ref->count) != 0);
>   	}
>
>   	rcu_read_unlock_sched();
> @@ -246,7 +246,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>   		this_cpu_inc(*percpu_count);
>   		ret = true;
>   	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
> -		ret = atomic_long_inc_not_zero(&ref->count);
> +		ret = (atomic_long_inc_not_zero(&ref->count) != 0);
>   	}
>
>   	rcu_read_unlock_sched();

