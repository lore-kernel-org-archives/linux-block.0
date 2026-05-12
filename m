Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E873FFAD3
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565486; cv=none; b=jRVbjIVNN7QfDPBi2NXxC4S2QIWuj3amkWp5gvxSdOn6Esgzk92U0sS1+OtCeDdpf/MeWRHYauKHw7SIiwFsofa50COHumqbeOB29oxNBN2I9QoWT35pN0LLz7jTUQYuPEj45TNkumfLBSPYZiHrTPBLTNz3byEMed+TMgRCsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565486; c=relaxed/simple;
	bh=I4P2K3NDeEiID8tJFNDDaV1ulvJ5LK3yOgNr/X/VspM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDk3vAOCeFdL0ZIn3y3j5i5kPe9E9ZPam8RUFiH5hChq5LE0wJjuqR9VqCalYj77vj6tpae+lPHIdR0z4Uck49aX3yXjVEJTON9swlLi6SQ+vFmcnEB8fsgdUJv0DvlJe1Sv9nK8WqnOzeoBul8hJGZt4wtc0gcrajVO+C8y0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sd8bCxKU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbiWeM95; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sd8bCxKU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbiWeM95"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5CLL33443736
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 05:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LQoDCYgO0PTjoC7vV0SqsIyxGR2z04I0lSmR7QkFCLY=; b=Sd8bCxKUJ802Yc35
	uoiJZTujGp4nnt6samW75C/9zhSFfjr1g3Xp9LQ3cTxqm05ctCmaAVbI5OLau80e
	R4jBofuYWHYmTD55rMu9WF+nJGcrPIn6wDiMPsoKxhjNfRxaDx8RlPYJe+bsjXsA
	Wn3hVrXjObGHXJsORhF5AzcDL/Cg7ttxm53F2wjLV6N9qUcCCCh85haWlFYRiNyx
	P9XGoplv1kGh734A8UDmcow3BYqT6VpxhC+yzS2Yl9Iw4bAqrudOng9sVYGjN0zx
	N35a20J/mJa0cd8lHd+maGu7lJkGJKQ5+VNgHiAu9goGsjqWGzWRruQV1un/+A5T
	QWqjlQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0hptk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 05:57:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-366122e01fcso5825280a91.2
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778565473; x=1779170273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQoDCYgO0PTjoC7vV0SqsIyxGR2z04I0lSmR7QkFCLY=;
        b=IbiWeM95/+O8pYDIieU6RA5mx/r8ja5ELOqIBttAoe/wVMkstfOiThbMt7vHUaM5w3
         I5suU7QhNzNvE4RFvAZWuS3f8HJOQC71CZelKuMR+JI2Er+XWewRKMnymMpAFBufg+07
         nzE3A89WxTq26BiUFsShmlp1cgfEwZJB+1uEdM0FeUAy+5nMeQTlQRQCBI4/vuPtShK6
         HTocysANOcdcjPeKg9X5fjK0SiM+NiY7Xj3nbCfaArn3JEX04xNNL0w51IYCUgVZXJo6
         wZ3HVpk/q5zUWlI4PvK+pyxU+XjIgJCnnB+pvUVfKI8u6wANlN8l2V32pDJ6yf+4XMqq
         Nn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778565473; x=1779170273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQoDCYgO0PTjoC7vV0SqsIyxGR2z04I0lSmR7QkFCLY=;
        b=rP8TndwxQG/A/MF5cmwt/7afj7awUx7v6ykkDADmc9C8PvNCsvOwCouXe1SIoX6tJp
         F87Ks2xZvgrXVUXZNni471eOOe1GzQe2MUvJeq+6kXd8LLfMVFxKGTtRVnKXL+/Z7iiN
         qYJCk6yohaKWWxr/YjHrZ62VJ/cPp06oMHG9Srcmt4F0UmCsBoIXxKNDvYtEwQg4Wixj
         e62ncRa2WdYQPgaUw1lokkLXSFJCeNGLldZEwa7xngagjXZdWolbNxRtiZoya0iBVjkn
         sdTJEURk7Y+HH51wlzJjg+IeqqW27Z07eQv7LXs3rFt3u6cbgh0gctuudcuhN8oO8Z1F
         JU4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Z9hKkmoJUfobrRzwIZWwKW5h9GRLeXp/l3y+bU9tkuNLP2vSHa6hgrLKkBAbpqKtLG0DR1Bj3AQruoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkicIcitH3m34uK+AQS8WpJxIuBx2tuRgyYzGJ/GjrOAnqzzh3
	1t8Nm4hn+xjE5J2RWrWEfALO58P2cYnF7nvzY1fNFvFqhmuytereLwzWykUJxrxYzx51qvINXm1
	nGPTFhaH1ueZujanM9RwiLU3D9DM0T49n7pWvRb6Y1nN4aVLqMEan/orh9NDp3REtCA==
X-Gm-Gg: Acq92OEoQAP4IjY3YKKqThITjecefuKVBgcAvD6hgLfZXrujoC24My8WM0KskyUIVHn
	xihlMbjdlNyHnGrhb/cBvzOLL9Xq4fTBgf4Wp16hvPOCr4PwXnYzaovV1slW9qO/J5xeJfZ0Qvc
	GuZj2+WwUyc1a06uI49QCTZFEpTHcF7o0t8EdoOMaDiBZCQp8dp1NF5yNTXFRgh60EFFKvM9AIs
	OJrnsXmtSqx/S0CtMmHlQKx0uNeX+E+aWnIX9hn7pWxxErXFw1tFBEBwkQUqrmla5eJxcu6azXr
	xtZw8A39hyJkZjws1f4d/t7q0pzj/GLtRikCDN/pndgo4wUA//Wf199AiXktgR9vi1mjsr8eEeX
	K7BohNYqYNZzjKnAUQSWfwjNDbN9kMHKvaL7Jv9sarOJHVB872D6aUlzG2w+SmulVotz3CebM47
	f6g+TX1E3DLiiOWdo=
X-Received: by 2002:a17:90b:1d4f:b0:365:fd4b:24ef with SMTP id 98e67ed59e1d1-368b24f48c4mr1826472a91.8.1778565473335;
        Mon, 11 May 2026 22:57:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1d4f:b0:365:fd4b:24ef with SMTP id 98e67ed59e1d1-368b24f48c4mr1826441a91.8.1778565472690;
        Mon, 11 May 2026 22:57:52 -0700 (PDT)
Received: from [10.249.20.221] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d684009esm9991552a91.11.2026.05.11.22.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 22:57:52 -0700 (PDT)
Message-ID: <5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:56:55 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: disable preemption around blk_flush_plug in
 sched_submit_work
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Michael Wu <michael@allwinnertech.com>
References: <20260423125528.2917171-1-tom.leiming@gmail.com>
Content-Language: en-US
From: Xiaosen <xiaosen.he@oss.qualcomm.com>
In-Reply-To: <20260423125528.2917171-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a02c162 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=6Ujbnq6iAAAA:8 a=pGLkceISAAAA:8 a=fk9MhG10RmsXh4Jbe1IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=-sNzveBoo8RYOSiOai2t:22
X-Proofpoint-GUID: HV-ySc4pzOT0ZDyVw0ScomkojY4yrlI8
X-Proofpoint-ORIG-GUID: HV-ySc4pzOT0ZDyVw0ScomkojY4yrlI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1NSBTYWx0ZWRfX2n8eJRDM0frx
 0deapH7zdR4/GjycuGUR68QEAugBWqshXFfyBiVq4upt2+VWvypxxh/X2w5tx9Zq6mOa28MRe8K
 25sPS1C4fAMhUKBi1RGku2MjYo32bpqR3dSjkfXT8vYnfp7SkydHwAuusdlZauJF2W1CEo6KNyv
 q6UCCPsfhvHSG88bf9qNMYnmtAYXFZTzAKBBfF83htZ2J+OhvTBPSHhhX+qHrgzY6G0eLgSdSoK
 cUcKXdMAn9t0duVPqkkfxk6WWyCi4uXxUdKUso9MNrhB72M4C1L8zTreX1aKuMgbYIdraVBaRxK
 a4pdoLUH1lPBs1EEnT8HDBYU3iNdwVA0kgAkv+8LJmClSBAdw5216oN5cdbdu9iyn3jIIRNcDKw
 z7VgJLOQWWQB287KDzJDKsjPZuoZRC0WJdQMPvDluortwW3kx8YRVpfYvB4F3CuPMphswn7bHSw
 oa7xP119IPgcYh3xqwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120055

There is another deadlock caused by preemption during calling
blk_flush_plug() in sched_submit_work().
blk_mq_dispatch_list
  percpu_ref_get(&this_hctx->queue->q_usage_counter)
    percpu_ref_get_many(ref, 1);
          rcu_read_lock()
            __rcu_read_lock()
            rcu_lock_acquire
                  lock_acquire
                    preempt_schedule_irq  --> writeback worker got
preempted here and be scheduled out in D state

1. task kworker/u32:6 had dirty pages from f2fs node inode submitted to
block layer and the corresponding request was added to plug list of the
current task.
2. task snpe-net-run acquired gc_lock waiting for the request that
contained page from node inode to be completed.
3. task kworker/u32:6 needed to acquire gc_lock to perform foreground
GC, since the gc_lock had already been acquired by task snpe-net-run, so
it called blk_flush_plug() in sched_submit_work() before sleeping to
avoid deadlocks, but task kworker/u32:6 got preempted in RCU critical
section before running hw queue to issue plugged requests. so the
plugged requests were pending in local request list. task kworker/u32:6
was scheduled out waiting to be woken up by the release of gc_lock.
4. so, there is a deadlock to cause RCU STALL.

I think task kworker/u32:6 should not be scheduled out before returning
from blk_flush_plug(), and I think this patch should be able to fix such
deadlocks.

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:   Tasks blocked on level-0 rcu_node (CPUs 0-7): P18782/1:b..l
rcu:   (detected by 0, t=5255 jiffies, g=4338701, q=1751 ncpus=8)
task:kworker/u32:6   state:D stack:0     pid:18782 tgid:18782 ppid:2
 task_flags:0x24208060 flags:0x00000010
Workqueue: writeback wb_workfn (flush-254:55)
Call trace:
 __switch_to+0x214/0x3fc (T)
 __schedule+0xa70/0x1048
 preempt_schedule_irq+0x70/0xd4
 raw_irqentry_exit_cond_resched+0x2c/0x44
 irqentry_exit+0x38/0x64
 exit_to_kernel_mode+0x28/0x38
 el1_interrupt+0x5c/0xa8
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x84/0x88
 lock_acquire+0x170/0x29c (P)
 rcu_lock_acquire+0x38/0x44
 blk_mq_dispatch_list+0x190/0x69c
 blk_mq_flush_plug_list+0x13c/0x170
 __blk_flush_plug+0x11c/0x17c
 sched_submit_work+0x7c/0xb8
 schedule+0x38/0xc4
 schedule_preempt_disabled+0x18/0x2c
 rwsem_down_write_slowpath+0x768/0x10c0
 down_write+0x98/0x240
 f2fs_down_write_trace+0x30/0x84
 f2fs_balance_fs+0x130/0x17c
 f2fs_write_single_data_page+0x42c/0x738
 f2fs_write_data_pages+0x8c0/0xe80
 do_writepages+0xd4/0x1a0
 __writeback_single_inode+0x78/0x5bc
 writeback_sb_inodes+0x2b8/0x580
 __writeback_inodes_wb+0xa0/0xf0
 wb_writeback+0x188/0x4bc
 wb_workfn+0x3ec/0x658
 process_one_work+0x284/0x62c
 worker_thread+0x260/0x3b4
 kthread+0x150/0x288
 ret_from_fork+0x10/0x20

Task name: snpe-net-run     [affinity: 0xff] pid:  10012 tgid:  10012
cpu: 2 prio: 120 start: 0xffffff8a1eafc6c0
state: 0x2[D] exit_state: 0x0 stack base: 0xffffffc0a77c0000
Stack:
 __switch_to+0x214
 __schedule+0xa70
 schedule+0x48
 schedule_timeout+0xa0
 io_schedule_timeout+0x48
 f2fs_wait_on_all_pages+0x84
 do_checkpoint+0x804
 f2fs_write_checkpoint+0x820
 f2fs_gc+0x1f0
 f2fs_balance_fs+0x14c
 f2fs_map_blocks+0xd1c
 f2fs_file_write_iter+0x3c0
 vfs_write+0x270
 ksys_write+0x78
 __arm64_sys_write+0x1c
 invoke_syscall+0x58
 el0_svc_common+0xa8
 do_el0_svc+0x1c
 el0_svc+0x40
 el0t_64_sync_handler+0x84
 el0t_64_sync+0x1c4

Regards,
Xiaosen

On 4/23/2026 8:55 PM, Ming Lei wrote:
> On preemptible kernels, a three-way deadlock can occur involving
> blk_mq_freeze_queue and blk_mq_dispatch_list:
> 
> - Task A holds a filesystem lock (e.g., f2fs io_rwsem) and enters
>   __bio_queue_enter(), waiting for mq_freeze_depth == 0
> - Task B holds mq_freeze_depth=1 (elevator_change) and waits for
>   q_usage_counter to reach zero in blk_mq_freeze_queue_wait()
> - Task C is going to sleep waiting for the filesystem lock. Before
>   sleeping, schedule() calls sched_submit_work() -> blk_flush_plug()
>   -> blk_mq_dispatch_list(), which acquires q_usage_counter via
>   percpu_ref_get(). If Task C gets preempted before percpu_ref_put(),
>   it will not be scheduled back because the task is already in
>   uninterruptible sleep state (TASK_UNINTERRUPTIBLE). This means it
>   holds the percpu_ref indefinitely, preventing freeze from completing.
> 
> This is fundamentally an ABBA deadlock between queue freeze and the
> filesystem lock, exposed by preemption creating an artificial hold
> on q_usage_counter during the plug flush.
> 
> Fix by disabling preemption around blk_flush_plug() in
> sched_submit_work(). The _notrace variants are used since this runs
> in scheduler context. preempt_enable_no_resched_notrace() is correct
> because we are already inside __schedule() and about to pick the next
> task.
> 
> Fixes: 73c101011926 ("block: initial patch for on-stack per-task plugging")
> Reported-by: Michael Wu <michael@allwinnertech.com>
> Tested-by: Michael Wu <michael@allwinnertech.com>
> Link: https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b7f77c165a6e..4217aaaa8e47 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6966,7 +6966,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
>  	 * If we are going to sleep and we have plugged IO queued,
>  	 * make sure to submit it to avoid deadlocks.
>  	 */
> +	preempt_disable_notrace();
>  	blk_flush_plug(tsk->plug, true);
> +	preempt_enable_no_resched_notrace();
> 
>  	lock_map_release(&sched_map);
>  }
> --
> 2.53.0
> 
> 

