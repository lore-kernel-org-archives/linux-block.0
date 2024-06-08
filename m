Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEA1FDD;
	Sat,  8 Jun 2024 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717829058; cv=none; b=QlqEGgr3a8zqMK/CYxwErRZKmSTHHvBVvZ+zQ9rCkIzLf5AWOzZk8xtYWpyGEn5QW2eky63zHsMyRR03Zni5uIDpxmf2pJCxQzPqmH2phbUrBFAhb317kK7IW9NqOfQXKztz3wuFb6yB8hFYvxyJdRi63TocWMfRG9CF4AzA+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717829058; c=relaxed/simple;
	bh=LIdbb5dyeR0Wcx2MqMie1Vp/1VbGTqntUHGDdy32Le0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDvITtq6Xx6Rn+nbvIFv8bkhvMMTGEaB6qvEFGL6K+AFkF3K0kRnzf2cXedVJBCubLbzwGD2YP7g0kxxq0NrvZx4DeZU3yee13AiwwtADCFjOhnviiJQuA3jtze0Oxb53BNF5xF3czwhklBVapHhcTKzQ9lxyvvuScUgSNIkAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vx7nn1kwqz4f3jHx;
	Sat,  8 Jun 2024 14:43:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0FDA81A0181;
	Sat,  8 Jun 2024 14:44:07 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQyz_WNmIowPPQ--.42198S3;
	Sat, 08 Jun 2024 14:44:04 +0800 (CST)
Message-ID: <30654e55-c639-4caa-af7d-9eea1bcf3cf7@huaweicloud.com>
Date: Sat, 8 Jun 2024 14:44:03 +0800
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
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
 <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora>
 <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
 <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
 <CAGVVp+WdWxAZdhpuDTuMvb+JvX-Ji9B+A4+Pv49JXLiXM++DHQ@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAGVVp+WdWxAZdhpuDTuMvb+JvX-Ji9B+A4+Pv49JXLiXM++DHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXOQyz_WNmIowPPQ--.42198S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18tw1xKr18GF1DCr4DArb_yoW8XF48pF
	97Wa13Kr1DGry8GayIv39xu3W2qF4rCrn8WF18Grn3Z3s0vF1IgrW8A3y2kFZ2grykuF1U
	Z3WDX3ZrJ345GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/6/6 21:43, Changhui Zhong 写道:
> On Thu, Jun 6, 2024 at 4:05 PM Li Nan <linan666@huaweicloud.com> wrote:
>>
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
>> introduced by this patch. It seems io was issued after deleting disk. And
>> it can be reproduced by:
>>
>>     while true; do make test T=generic/004; done
>>
> 
> Hi,Nan
> 
> I can not reproduce this issue with repo
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
> ,
> which kernel repo do you using for test?
> 
> Thanks,
> Changhui
> 

I tested with the latest block code, commit
2ab79514109578fc4b6df90633d500cf281eb689, this issue also can be
reproduced.

The space of the root path has been filled up by
ublksrv(tests/tmpublk_loop_data_xxx), which may the issue be related to this?

-- 
Thanks,
Nan

