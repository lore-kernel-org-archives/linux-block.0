Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37D1FDD;
	Sat,  8 Jun 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717828502; cv=none; b=Rw4Tg9A7MbYwG/Z7yRGtiwaWzO3T/mvdrkYSW5bOersGOCwKucy60E6ciRn6KivkuBGT+YgiTcsR4r0K0OnGwnM0waGqq9LEU0TcXVGJBdgkVmpzEecG7qHAksbKidLP6cw6hfEpA+SlNgqDAm5Hrx6I9EKFAXY+93VvWcR0U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717828502; c=relaxed/simple;
	bh=DBAl/ILKUEIMjwI+MRt4bavWsNe8hbGt+5PR1aOKcj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBJlgclKWeMHdCtNYnb61ZA1zOrTqQuxx5c5iyhOXJKVS9DUcakPRlXiazLfXrlCRnfSksWuMT7nyZyDMxrfChkAeixSM7zxw9Wz98kMBmRErczgyxcwIO2tY5O+AnSEgaWubDY1Z1kt0N/59FP4CU+CW/bZGa0d7rvtF49jK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vx7b15dpVz4f3m6t;
	Sat,  8 Jun 2024 14:34:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 121AE1A0181;
	Sat,  8 Jun 2024 14:34:49 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAuH+2NmA+0OPQ--.50205S3;
	Sat, 08 Jun 2024 14:34:48 +0800 (CST)
Message-ID: <dd486a95-b7e8-5760-9ff1-7e9c1cfc9873@huaweicloud.com>
Date: Sat, 8 Jun 2024 14:34:47 +0800
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
To: Ming Lei <ming.lei@redhat.com>, Li Nan <linan666@huaweicloud.com>
Cc: Changhui Zhong <czhong@redhat.com>, axboe@kernel.dk,
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
 <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
 <ZmGGzNLLC6WpM9tb@fedora>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZmGGzNLLC6WpM9tb@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnmAuH+2NmA+0OPQ--.50205S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7Ar1xJF15Jr1UArW5ZFb_yoW5GrWxpa
	4xG3WDKr4UXryxJa4Iyw4qgFyjqw4SyFZ5Wrn5Jr1fC3Wqg3W8K340kr4jkF9xCr4ku3W2
	vw4DWwnrKa45C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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



在 2024/6/6 17:52, Ming Lei 写道:
> On Thu, Jun 06, 2024 at 04:05:33PM +0800, Li Nan wrote:
>>
>>
>> 在 2024/6/6 12:48, Changhui Zhong 写道:
>>
>> [...]
>>
>>>>
>>>> Hi Changhui,
>>>>
>>>> The hang is actually expected because recovery fails.
>>>>
>>>> Please pull the latest ublksrv and check if the issue can still be
>>>> reproduced:
>>>>
>>>> https://github.com/ublk-org/ublksrv
>>>>
>>>> BTW, one ublksrv segfault and two test cleanup issues are fixed.
>>>>
>>>> Thanks,
>>>> Ming
>>>>
>>>
>>> Hi,Ming and Nan
>>>
>>> after applying the new patch and pulling the latest ublksrv,
>>> I ran the test for 4 hours and did not observe any task hang.
>>> the test results looks good！
>>>
>>> Thanks，
>>> Changhui
>>>
>>>
>>> .
>>
>> Thanks for you test!
>>
>> However, I got a NULL pointer dereference bug with ublksrv. It is not
> 
> BTW, your patch isn't related with generic/004 which won't touch
> recovery code path.
> 
>> introduced by this patch. It seems io was issued after deleting disk. And
>> it can be reproduced by:
>>
>>    while true; do make test T=generic/004; done
> 
> We didn't see that when running such test with linus tree, and usually
> Changhui run generic test for hours.
> 
>>
>> [ 1524.286485] running generic/004
>> [ 1529.110875] blk_print_req_error: 109 callbacks suppressed
> ...
>> [ 1541.171010] BUG: kernel NULL pointer dereference, address: 0000000000000000
>> [ 1541.171734] #PF: supervisor write access in kernel mode
>> [ 1541.172271] #PF: error_code(0x0002) - not-present page
>> [ 1541.172798] PGD 0 P4D 0
>> [ 1541.173065] Oops: Oops: 0002 [#1] PREEMPT SMP
>> [ 1541.173515] CPU: 0 PID: 43707 Comm: ublk Not tainted
>> 6.9.0-next-20240523-00004-g9bc7e95c7323 #454
>> [ 1541.174417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.16.1-2.fc37 04/01/2014
>> [ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300
> 
> This one looks one io_uring issue.
> 
> Care to provide which line of source code points to by 'io_fallback_tw+0x252'?
> 
> gdb> l *(io_fallback_tw+0x252)
> 
(gdb) list * io_fallback_tw+0x252
0xffffffff81d79dc2 is in io_fallback_tw 
(./arch/x86/include/asm/atomic64_64.h:25).
20              __WRITE_ONCE(v->counter, i);
21      }
22
23      static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
24      {
25              asm volatile(LOCK_PREFIX "addq %1,%0"
26                           : "=m" (v->counter)
27                           : "er" (i), "m" (v->counter) : "memory");
28      }

The corresponding code is:
io_fallback_tw
   percpu_ref_get(&last_ctx->refs);

I have the vmcore of this issue. If you have any other needs, please let me
know.

-- 
Thanks,
Nan

