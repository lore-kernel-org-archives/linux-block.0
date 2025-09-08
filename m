Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7ED21C186;
	Mon,  8 Sep 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324078; cv=none; b=KPo5/1XKjSp+v3rLopvJp8teuAGRWTTec/RBfkvSoBsqnEyZopyj6tbUxY0THD4ATrcp5A2CJhHNR4FhruoPGcT5mrM0x9PQnUyRM88bj872pfglf3Kq0CJGa4b7kttF/LKo0CVmjIHZz9P1eAi17iWYKKvr89nC2k1BalavK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324078; c=relaxed/simple;
	bh=YzsJwu4bSe8qpnD0n9Z1JQk+MCIqNJAEcPjaD9JFnJE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dApmv0316Bd8daQezXFTfDB6x+ACCkKCQRHxwi97s1jVgbmoocM2vwcVRlFVFSIPm9JCxL//WXGB/o3765pIRJ7D1NVTj2MaZRnBFUGCguaLzgYjB1LvSW0BrmAjZuWFrmYTBukyhm69Su2ihZhyFeAv5NmIDJ1RUCxdVjvQ54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cL1xh3DCXzKHMyt;
	Mon,  8 Sep 2025 17:34:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 884D41A0DCA;
	Mon,  8 Sep 2025 17:34:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0mo75oX50yBw--.65125S3;
	Mon, 08 Sep 2025 17:34:32 +0800 (CST)
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Eric Dumazet <edumazet@google.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <68bb4160.050a0220.192772.0198.GAE@google.com>
 <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
 <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com>
 <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
Date: Mon, 8 Sep 2025 17:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0mo75oX50yBw--.65125S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XryfKFyruw1ruFWDWr4kWFg_yoWkuwb_Cr
	48uwn3Ga17Xr13tFsxKrn7Gw1qqasYg34DXwn5Ja4fu3Z3ArWUAF18C3WrZw4rtan7KasI
	krZ09a1ftFy3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/08 17:07, Eric Dumazet 写道:
> On Mon, Sep 8, 2025 at 1:52 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2025/09/06 17:16, Eric Dumazet 写道:
>>> On Fri, Sep 5, 2025 at 1:03 PM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> On Fri, Sep 5, 2025 at 1:00 PM syzbot
>>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
>>>
>>> Note to NBD maintainers : I held about  20 syzbot reports all pointing
>>> to NBD accepting various sockets, I  can release them if needed, if you prefer
>>> to triage them.
>>>
>> I'm not NBD maintainer, just trying to understand the deadlock first.
>>
>> Is this deadlock only possible for some sepecific socket types? Take
>> a look at the report here:
>>
>> Usually issue IO will require the order:
>>
>> q_usage_counter -> cmd lock -> tx lock -> sk lock
>>
> 
> I have not seen the deadlock being reported with normal TCP sockets.
> 
> NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> from __sock_xmit(), and TCP seems to respect this.
> .
> 

What aboud iscsi and nvme-tcp? and probably other drivers, where
sk_allocation is GFP_ATOMIC, do they have similar problem?

Thanks,
Kuai

