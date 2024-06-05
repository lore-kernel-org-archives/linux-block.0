Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A5747F;
	Wed,  5 Jun 2024 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551668; cv=none; b=NOGrLmhRlIPMGrpFYzy95hIXMeTQjtSC7e0JDoVLZERxfd8iWZUtNMgtbRlUk2pqdf/xa5sN5Pvvk3cUqOisHDEYwDooJDoeaw8/sljoAkasg/3MUPhvKAIIf9MxvSg9kEbM8QWdCPNLhwemfu8ki4KyuLE9AMRYlZuNj2Zl5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551668; c=relaxed/simple;
	bh=cAtWia00jxdE9iyzYZZ3W0sic24lp2m2gIav5E7dFQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ap8bClK2+/Z98tyH7j3TXRIezB03mJT8P59aNSsxurIQS1L9LNBytjh8LJOtmRAyPy6JylHDx9nIxXthpx3N2Citc+TA5Bm3p1t1DXCMv3VEOv09TebRJGS5phAexrGjHTPW2VVRh5OLRDkVQKjo0gfCl4eTHe9soa3M2yuMRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vv9CQ1vkKz4f3n64;
	Wed,  5 Jun 2024 09:40:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 60F471A0C90;
	Wed,  5 Jun 2024 09:41:01 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA8rwl9m0rLaOw--.52172S3;
	Wed, 05 Jun 2024 09:41:01 +0800 (CST)
Message-ID: <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
Date: Wed, 5 Jun 2024 09:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
To: Changhui Zhong <czhong@redhat.com>, Li Nan <linan666@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
 ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXfA8rwl9m0rLaOw--.52172S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4UtrWUuw1UWw4rur17KFg_yoWxGw4fpF
	ykWFW8KFW8Gr18Jws7tr45tF10ya1q9a1DGwnagFy7Was5ur13XFy8CFyjgrWDWw4Utay7
	tFn0grW0gr12qaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/6/4 9:32, Changhui Zhong 写道:
> On Mon, Jun 3, 2024 at 10:20 AM Li Nan <linan666@huaweicloud.com> wrote:
>>
>>
>>
>> 在 2024/6/3 8:39, Ming Lei 写道:
>>
>> [...]
>>
>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>> index 4e159948c912..99b621b2d40f 100644
>>>> --- a/drivers/block/ublk_drv.c
>>>> +++ b/drivers/block/ublk_drv.c
>>>> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>>>>    {
>>>>       int i;
>>>>
>>>> -    WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
>>>> +    if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
>>>> +            return;
>>>
>>> Yeah, it is one bug. However, it could be addressed by adding the check in
>>> ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
>>> what do you think about this way?
>>>
>>
>> Check ub->nr_queues_ready seems better. How about:
>>
>> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct
>> ublk_device *ub,
>>           mutex_lock(&ub->mutex);
>>           if (!ublk_can_use_recovery(ub))
>>                   goto out_unlock;
>> +       if (!ub->nr_queues_ready)
>> +               goto out_unlock;
>>           /*
>>            * START_RECOVERY is only allowd after:
>>            *
>>
>>>
>>> Thanks,
>>> Ming
>>
>> --
>> Thanks,
>> Nan
>>
> 
> 
> Hi,Nan
> 
> After applying your new patch, I did not trigger "NULL pointer
> dereference" and "Warning",
> but hit task hung "Call Trace" info, please check
> 
> [13617.812306] running generic/004
> [13622.293674] blk_print_req_error: 91 callbacks suppressed
> [13622.293681] I/O error, dev ublkb4, sector 233256 op 0x1:(WRITE)
> flags 0x8800 phys_seg 1 prio class 0
> [13622.308145] I/O error, dev ublkb4, sector 233256 op 0x0:(READ)
> flags 0x0 phys_seg 2 prio class 0
> [13622.316923] I/O error, dev ublkb4, sector 233264 op 0x1:(WRITE)
> flags 0x8800 phys_seg 1 prio class 0
> [13622.326048] I/O error, dev ublkb4, sector 233272 op 0x0:(READ)
> flags 0x0 phys_seg 1 prio class 0
> [13622.334828] I/O error, dev ublkb4, sector 233272 op 0x1:(WRITE)
> flags 0x8800 phys_seg 1 prio class 0
> [13622.343954] I/O error, dev ublkb4, sector 233312 op 0x0:(READ)
> flags 0x0 phys_seg 1 prio class 0
> [13622.352733] I/O error, dev ublkb4, sector 233008 op 0x0:(READ)
> flags 0x0 phys_seg 1 prio class 0
> [13622.361514] I/O error, dev ublkb4, sector 233112 op 0x0:(READ)
> flags 0x0 phys_seg 1 prio class 0
> [13622.370292] I/O error, dev ublkb4, sector 233192 op 0x1:(WRITE)
> flags 0x8800 phys_seg 1 prio class 0
> [13622.379419] I/O error, dev ublkb4, sector 233120 op 0x0:(READ)
> flags 0x0 phys_seg 1 prio class 0
> [13641.069695] INFO: task fio:174413 blocked for more than 122 seconds.
> [13641.076061]       Not tainted 6.10.0-rc1+ #1
> [13641.080338] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [13641.088164] task:fio             state:D stack:0     pid:174413
> tgid:174413 ppid:174386 flags:0x00004002
> [13641.088168] Call Trace:
> [13641.088170]  <TASK>
> [13641.088171]  __schedule+0x221/0x670
> [13641.088177]  schedule+0x23/0xa0
> [13641.088179]  io_schedule+0x42/0x70
> [13641.088181]  blk_mq_get_tag+0x118/0x2b0
> [13641.088185]  ? gup_fast_pgd_range+0x280/0x370
> [13641.088188]  ? __pfx_autoremove_wake_function+0x10/0x10
> [13641.088192]  __blk_mq_alloc_requests+0x194/0x3a0
> [13641.088194]  blk_mq_submit_bio+0x241/0x6c0
> [13641.088196]  __submit_bio+0x8a/0x1f0
> [13641.088199]  submit_bio_noacct_nocheck+0x168/0x250
> [13641.088201]  ? submit_bio_noacct+0x45/0x560
> [13641.088203]  __blkdev_direct_IO_async+0x167/0x1a0
> [13641.088206]  blkdev_write_iter+0x1c8/0x270
> [13641.088208]  aio_write+0x11c/0x240
> [13641.088212]  ? __rq_qos_issue+0x21/0x40
> [13641.088214]  ? blk_mq_start_request+0x34/0x1a0
> [13641.088216]  ? io_submit_one+0x68/0x380
> [13641.088218]  ? kmem_cache_alloc_noprof+0x4e/0x320
> [13641.088221]  ? fget+0x7c/0xc0
> [13641.088224]  ? io_submit_one+0xde/0x380
> [13641.088226]  io_submit_one+0xde/0x380
> [13641.088228]  __x64_sys_io_submit+0x80/0x160
> [13641.088229]  do_syscall_64+0x79/0x150
> [13641.088233]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> [13641.088237]  ? do_io_getevents+0x8b/0xe0
> [13641.088238]  ? syscall_exit_work+0xf3/0x120
> [13641.088241]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> [13641.088243]  ? do_syscall_64+0x85/0x150
> [13641.088245]  ? do_syscall_64+0x85/0x150
> [13641.088247]  ? blk_mq_flush_plug_list.part.0+0x108/0x160
> [13641.088249]  ? rseq_get_rseq_cs+0x1d/0x220
> [13641.088252]  ? rseq_ip_fixup+0x6d/0x1d0
> [13641.088254]  ? blk_finish_plug+0x24/0x40
> [13641.088256]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> [13641.088258]  ? do_syscall_64+0x85/0x150
> [13641.088260]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> [13641.088262]  ? do_syscall_64+0x85/0x150
> [13641.088264]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> [13641.088266]  ? do_syscall_64+0x85/0x150
> [13641.088268]  ? do_syscall_64+0x85/0x150
> [13641.088270]  ? do_syscall_64+0x85/0x150
> [13641.088272]  ? clear_bhb_loop+0x45/0xa0
> [13641.088275]  ? clear_bhb_loop+0x45/0xa0
> [13641.088277]  ? clear_bhb_loop+0x45/0xa0
> [13641.088279]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [13641.088281] RIP: 0033:0x7ff92150713d
> [13641.088283] RSP: 002b:00007ffca1ef81f8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000d1
> [13641.088285] RAX: ffffffffffffffda RBX: 00007ff9217e2f70 RCX: 00007ff92150713d
> [13641.088286] RDX: 000055863b694fe0 RSI: 0000000000000010 RDI: 00007ff92164d000
> [13641.088287] RBP: 00007ff92164d000 R08: 00007ff91936d000 R09: 0000000000000180
> [13641.088288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
> [13641.088289] R13: 0000000000000000 R14: 000055863b694fe0 R15: 000055863b6970c0
> [13641.088291]  </TASK>
> 
> Thanks，
> Changhui
> 

After applying the previous patch, will the test environment continue to
execute test cases after WARN? I am not sure whether this issue has always
existed but was not tested becasue of WARN, or whether the new patch
introduced it.

-- 
Thanks,
Nan

