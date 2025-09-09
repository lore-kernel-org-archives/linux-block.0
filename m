Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAA3115A2;
	Tue,  9 Sep 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409382; cv=none; b=LNQuuDlYhdfsB3nu3Qq6cgFjZHX3Iro8d5wzs8+DOmOKU930EMZsch9l8d8HHz3IBVaRIgOvKKzSmoeaYY3ituvyujOZhtn0x/QrD3cmsk7zD03VwgN8iIA/Ee4ttwtuqTFPyx2BDWNqHGVo20CytZABf6QWKZVddIs9EeX+7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409382; c=relaxed/simple;
	bh=KhNe5EohkIJJ/ORZD64COqm6Rpner7HoEznaf9Hkt4g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g6gQMmNA4Km3J5naCeH6rjj6f49IPVfDFqtvkbop6+A8sPcybZV1YZ9ewFPLCw5zWI6H2gXOL/82Yd1tGT+mSLW1rCaw6P/wq6UPuMassD6T203LMf4U0wwkF2JcHircU4QTlYvjqNSSjdhvQuQLqy6ZbAsNH37oaaLkiFwjdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLdV96KrvzYQv4V;
	Tue,  9 Sep 2025 17:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 603261A1EF0;
	Tue,  9 Sep 2025 17:16:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o5f8L9oUeWjBw--.25902S3;
	Tue, 09 Sep 2025 17:16:16 +0800 (CST)
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
 <51adf9cb-619e-9646-36f0-1362828e801e@huaweicloud.com>
 <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5b3daf68-7657-a96c-9322-43e5ed917174@huaweicloud.com>
Date: Tue, 9 Sep 2025 17:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iLhNzYUdtuaz9+ZHvwpbsK6gGfbCWmoic+ACQBVJafBXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o5f8L9oUeWjBw--.25902S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFykKr4rXw47JFWDWr1UGFg_yoW5JFW3pF
	48Gayj9rs7JFW8C3s2qw4jkryUtrZ3Ga4aqFyDKr13uF9FyFn5Xr17Kan8WFWUWr4kCw1a
	va1Yqas29r13Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKE_MDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/08 17:40, Eric Dumazet 写道:
> On Mon, Sep 8, 2025 at 2:34 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2025/09/08 17:07, Eric Dumazet 写道:
>>> On Mon, Sep 8, 2025 at 1:52 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2025/09/06 17:16, Eric Dumazet 写道:
>>>>> On Fri, Sep 5, 2025 at 1:03 PM Eric Dumazet <edumazet@google.com> wrote:
>>>>>>
>>>>>> On Fri, Sep 5, 2025 at 1:00 PM syzbot
>>>>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
>>>>>
>>>>> Note to NBD maintainers : I held about  20 syzbot reports all pointing
>>>>> to NBD accepting various sockets, I  can release them if needed, if you prefer
>>>>> to triage them.
>>>>>
>>>> I'm not NBD maintainer, just trying to understand the deadlock first.
>>>>
>>>> Is this deadlock only possible for some sepecific socket types? Take
>>>> a look at the report here:
>>>>
>>>> Usually issue IO will require the order:
>>>>
>>>> q_usage_counter -> cmd lock -> tx lock -> sk lock
>>>>
>>>
>>> I have not seen the deadlock being reported with normal TCP sockets.
>>>
>>> NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
>>> from __sock_xmit(), and TCP seems to respect this.
>>> .
>>>
>>
>> What aboud iscsi and nvme-tcp? and probably other drivers, where
>> sk_allocation is GFP_ATOMIC, do they have similar problem?
>>
> 
> AFAIK after this fix, iscsi was fine.
> 
> commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Sep 15 17:11:11 2023 +0000
> 
>      scsi: iscsi_tcp: restrict to TCP sockets
> 
>      Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
>      pointing to non TCP socket (af_unix for example).
> 
>      Return -EINVAL if this is attempted, instead of crashing the kernel.
> 
>      Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator:
> Initiator code")
>      Signed-off-by: Eric Dumazet <edumazet@google.com>
>      Cc: Lee Duncan <lduncan@suse.com>
>      Cc: Chris Leech <cleech@redhat.com>
>      Cc: Mike Christie <michael.christie@oracle.com>
>      Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
>      Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
>      Cc: open-iscsi@googlegroups.com
>      Cc: linux-scsi@vger.kernel.org
>      Reviewed-by: Mike Christie <michael.christie@oracle.com>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
> .
> 

Yes, now I also agree similiar fix in nbd make sense. Perhaps can you
cook a patch?

Thanks,
Kuai

