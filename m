Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B2DDD2;
	Thu,  6 Jun 2024 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661143; cv=none; b=kR4XJFfi2w+Zs5SlsuZDeg5ioAvuTCG92K1tH6J5bHRggfSllVSY7keDmToOpkpX2qoYjZpRPu/jnZIZiFVZCnl4w4NuqcIqEMwgLuqJg3k/tkn4mXgJsRn2YZO2D2GIgUNS8epFrPlDX3R14OTNpzDJ/R1jbwctkz+7RRyYDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661143; c=relaxed/simple;
	bh=djshAUx8bo/RDOx9ATGoxchxDJlrmcOAHO+qgnthJy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j39mkWHJMxHW9+kstIM/ORrEnqgGEI127vmYceFhJo4N5KAqHqgu3wDg1UMk257fn1DB30ar3jmijL5QhhLPK86njwgPGS81BbbrgtvcsJnXzZhzdSWVDssn24/hzdVx7+JawP7SYNJN9ljN+vaSTsIWJpViH3yGm5+bF8CPo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vvxhh48CGz4f3n5h;
	Thu,  6 Jun 2024 16:05:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BC3DA1A0184;
	Thu,  6 Jun 2024 16:05:35 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA_NbWFmwqpTPA--.42412S3;
	Thu, 06 Jun 2024 16:05:35 +0800 (CST)
Message-ID: <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
Date: Thu, 6 Jun 2024 16:05:33 +0800
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
To: Changhui Zhong <czhong@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: Li Nan <linan666@huaweicloud.com>, axboe@kernel.dk,
 ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
 <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora>
 <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXfA_NbWFmwqpTPA--.42412S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1xtrW3AFyfXrWxArWDJwb_yoWxZr45pw
	18Gr1UGrW8Jry3JF47Jr18Aw1xtw13AFn3G39Fqw1a93W5Xw4Utry0gr4qvr4DGr1kXryI
	qa1UWw18Kw4DGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/6/6 12:48, Changhui Zhong 写道:

[...]

>>
>> Hi Changhui,
>>
>> The hang is actually expected because recovery fails.
>>
>> Please pull the latest ublksrv and check if the issue can still be
>> reproduced:
>>
>> https://github.com/ublk-org/ublksrv
>>
>> BTW, one ublksrv segfault and two test cleanup issues are fixed.
>>
>> Thanks,
>> Ming
>>
> 
> Hi,Ming and Nan
> 
> after applying the new patch and pulling the latest ublksrv,
> I ran the test for 4 hours and did not observe any task hang.
> the test results looks good！
> 
> Thanks，
> Changhui
> 
> 
> .

Thanks for you test!

However, I got a NULL pointer dereference bug with ublksrv. It is not
introduced by this patch. It seems io was issued after deleting disk. And
it can be reproduced by:

   while true; do make test T=generic/004; done

[ 1524.286485] running generic/004
[ 1529.110875] blk_print_req_error: 109 callbacks suppressed
[ 1529.110881] I/O error, dev ublkb0, sector 164512 op 0x0:(READ) flags 0x0 
phys_seg 9 prio class 0
[ 1529.113801] I/O error, dev ublkb0, sector 161000 op 0x0:(READ) flags 0x0 
phys_seg 6 prio class 0
[ 1529.114711] I/O error, dev ublkb0, sector 164576 op 0x1:(WRITE) flags 
0x8800 phys_seg 7 prio class 0
[ 1529.117441] I/O error, dev ublkb0, sector 164632 op 0x1:(WRITE) flags 
0x8800 phys_seg 8 prio class 0
[ 1529.118400] I/O error, dev ublkb0, sector 164584 op 0x0:(READ) flags 0x0 
phys_seg 8 prio class 0
[ 1529.119314] I/O error, dev ublkb0, sector 161176 op 0x1:(WRITE) flags 
0x8800 phys_seg 10 prio class 0
[ 1529.120274] I/O error, dev ublkb0, sector 165136 op 0x1:(WRITE) flags 
0x8800 phys_seg 6 prio class 0
[ 1529.121213] I/O error, dev ublkb0, sector 165184 op 0x1:(WRITE) flags 
0x8800 phys_seg 10 prio class 0
[ 1529.122166] I/O error, dev ublkb0, sector 161256 op 0x1:(WRITE) flags 
0x8800 phys_seg 5 prio class 0
[ 1529.123101] I/O error, dev ublkb0, sector 161048 op 0x0:(READ) flags 0x0 
phys_seg 11 prio class 0
[ 1536.366869] blk_print_req_error: 181 callbacks suppressed
[ 1536.366885] I/O error, dev ublkb0, sector 181496 op 0x1:(WRITE) flags 
0x8800 phys_seg 9 prio class 0
[ 1536.368449] I/O error, dev ublkb0, sector 181568 op 0x1:(WRITE) flags 
0x8800 phys_seg 5 prio class 0
[ 1536.369398] I/O error, dev ublkb0, sector 181608 op 0x1:(WRITE) flags 
0x8800 phys_seg 10 prio class 0
[ 1536.370351] I/O error, dev ublkb0, sector 180976 op 0x0:(READ) flags 0x0 
phys_seg 7 prio class 0
[ 1536.371266] I/O error, dev ublkb0, sector 183696 op 0x1:(WRITE) flags 
0x8800 phys_seg 9 prio class 0
[ 1536.372217] I/O error, dev ublkb0, sector 175112 op 0x1:(WRITE) flags 
0x8800 phys_seg 5 prio class 0
[ 1536.373168] I/O error, dev ublkb0, sector 183768 op 0x1:(WRITE) flags 
0x8800 phys_seg 8 prio class 0
[ 1536.374120] I/O error, dev ublkb0, sector 175152 op 0x1:(WRITE) flags 
0x8800 phys_seg 5 prio class 0
[ 1536.375070] I/O error, dev ublkb0, sector 181032 op 0x0:(READ) flags 0x0 
phys_seg 8 prio class 0
[ 1536.375977] I/O error, dev ublkb0, sector 181096 op 0x0:(READ) flags 0x0 
phys_seg 8 prio class 0
[ 1541.171010] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1541.171734] #PF: supervisor write access in kernel mode
[ 1541.172271] #PF: error_code(0x0002) - not-present page
[ 1541.172798] PGD 0 P4D 0
[ 1541.173065] Oops: Oops: 0002 [#1] PREEMPT SMP
[ 1541.173515] CPU: 0 PID: 43707 Comm: ublk Not tainted 
6.9.0-next-20240523-00004-g9bc7e95c7323 #454
[ 1541.174417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.16.1-2.fc37 04/01/2014
[ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300
[ 1541.175808] Code: ff 48 83 05 ef 7f 45 0c 01 e9 f7 fe ff ff 5b 48 83 05 
31 80 45 0c 01 5d 41 5c 41 5d c3 48 83 05 0b 4d 45 0c 01 49 8b 44 24 20 
<3e> 48 83 0c
[ 1541.177682] RSP: 0018:ffffc900036bbd00 EFLAGS: 00010202
[ 1541.178221] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000100001
[ 1541.178947] RDX: ffff888177180000 RSI: 0000000000000001 RDI: 
ffff88817727d000
[ 1541.179669] RBP: ffff8881345da290 R08: 0000000000100001 R09: 
0000000000000000
[ 1541.180393] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff888173324800
[ 1541.181120] R13: 0000000000000001 R14: ffff888177180000 R15: 
0000000000000008
[ 1541.181852] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) 
knlGS:0000000000000000
[ 1541.182666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1541.183256] CR2: 0000000000000000 CR3: 00000001718bc004 CR4: 
0000000000770ef0
[ 1541.183978] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1541.184683] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 1541.185392] PKRU: 55555554
[ 1541.185668] Call Trace:
[ 1541.185927]  <TASK>
[ 1541.186148]  ? show_regs+0x83/0x90
[ 1541.186497]  ? __die_body+0x22/0x90
[ 1541.186862]  ? __die+0x35/0x50
[ 1541.187184]  ? page_fault_oops+0x1cc/0x630
[ 1541.187604]  ? pick_eevdf+0x65/0x210
[ 1541.187979]  ? check_preempt_wakeup_fair+0x283/0x300
[ 1541.188483]  ? xfs_iext_lookup_extent+0xa4/0x2e0
[ 1541.188967]  ? do_user_addr_fault+0x118/0xab0
[ 1541.189418]  ? exc_page_fault+0xde/0x390
[ 1541.189825]  ? asm_exc_page_fault+0x22/0x30
[ 1541.190247]  ? io_fallback_tw+0x252/0x300
[ 1541.190652]  tctx_task_work_run+0x181/0x1c0
[ 1541.191090]  tctx_task_work+0x3f/0x80
[ 1541.191473]  task_work_run+0x81/0xf0
[ 1541.191841]  do_exit+0x53e/0x1360
[ 1541.192179]  ? tctx_task_work+0x3f/0x80
[ 1541.192578]  do_group_exit+0x34/0xc0
[ 1541.192953]  get_signal+0xe10/0xe20
[ 1541.193317]  ? blk_finish_plug+0x30/0x50
[ 1541.193730]  ? io_submit_sqes+0x9e0/0xd70
[ 1541.194133]  arch_do_signal_or_restart+0x32/0x400
[ 1541.194607]  ? __do_sys_io_uring_enter+0x170/0x8d0
[ 1541.195097]  syscall_exit_to_user_mode+0x2a1/0x430
[ 1541.195591]  do_syscall_64+0xb9/0x240
[ 1541.195973]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1541.196489] RIP: 0033:0x7fcc6c8b34a5
[ 1541.196863] Code: Unable to access opcode bytes at 0x7fcc6c8b347b.
[ 1541.197490] RSP: 002b:00007fcc6c1ffd38 EFLAGS: 00000202 ORIG_RAX: 
00000000000001aa
[ 1541.198257] RAX: 000000000000003c RBX: 0000000000000000 RCX: 
00007fcc6c8b34a5
[ 1541.198984] RDX: 0000000000000001 RSI: 000000000000003c RDI: 
0000000000000000
[ 1541.199711] RBP: 00007fcc64002f68 R08: 00007fcc6c1ffd70 R09: 
0000000000000018
[ 1541.200438] R10: 0000000000000019 R11: 0000000000000202 R12: 
00007fcc6c1ffd90
[ 1541.201165] R13: 0000000000000000 R14: 0000000000000000 R15: 
00000000000001aa
[ 1541.202228]  </TASK>
[ 1541.202465] Modules linked in:
[ 1541.202798] CR2: 0000000000000000
[ 1541.203143] ---[ end trace 0000000000000000 ]---

-- 
Thanks,
Nan

