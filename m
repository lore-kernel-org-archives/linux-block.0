Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8627F4F5;
	Mon,  8 Sep 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321573; cv=none; b=aDngM0RpRRYrFXyq0TgG+YiQumRoq+97UizsY29XepYE/37UuQtkw3ErI7HrHttMqumyLeFwpUcc8/LT+r41yzG+F8/Pw73fAWWoKXYINqcXOxRm3G9BioWfiKSEnZRXchxGUk0zzJWoN1eqJEGUIpsGnbfHy6qjhbv6V7yB/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321573; c=relaxed/simple;
	bh=jBpVsRQ8QZGPbPfImZzqtkhQboLi9nW2oeuNSFlR4yg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=saU88Sl2TJXqdW7iylntcAMh0u13yAAlDjMM658r+Z2oMR54gYCQT9YJ6XJA6LInxsW7XmJvZDX0ZQG4tR+BacA3rYXYOCPesbLyZv7xecuTKCI4shLcVlIShaf4NDSGYaqub1aDYcLZe6lyfWwA6b0Y+GT0027n/9F+RxJGOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cL11X30BZzYQvCJ;
	Mon,  8 Sep 2025 16:52:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E0A941A16C2;
	Mon,  8 Sep 2025 16:52:46 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY5cmb5oBT8vBw--.65078S3;
	Mon, 08 Sep 2025 16:52:46 +0800 (CST)
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <68bb4160.050a0220.192772.0198.GAE@google.com>
 <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
 <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com>
Date: Mon, 8 Sep 2025 16:52:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY5cmb5oBT8vBw--.65078S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fAr4fGw15uFyfKw15Jwb_yoW8AFW8pF
	4UWFWjkr97KFy7XFsavw4ktFs5Awn09a4kK3yUG3sF9rZrCF1fAF1UtFs5ZryUCws3Gr42
	va15WanakF4xuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1aFAJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/06 17:16, Eric Dumazet 写道:
> On Fri, Sep 5, 2025 at 1:03 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Sep 5, 2025 at 1:00 PM syzbot
>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
> 
> Note to NBD maintainers : I held about  20 syzbot reports all pointing
> to NBD accepting various sockets, I  can release them if needed, if you prefer
> to triage them.
> 
I'm not NBD maintainer, just trying to understand the deadlock first.

Is this deadlock only possible for some sepecific socket types? Take
a look at the report here:

Usually issue IO will require the order:

q_usage_counter -> cmd lock -> tx lock -> sk lock

Hence the condition is that if the sock_sendmsg() will hold sk lock to
allocate new memory, and can trigger fs reclaim, and finally issue new
IO to this nbd?

Thanks,
Kuai

>>
>> Question to NBD maintainers.
>>
>> What socket types are supposed to be supported by NBD ?
>>
>> I was thinking adding a list of supported ones, assuming TCP and
>> stream unix are the only ones:
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 6463d0e8d0ce..87b0b78249da 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct
>> nbd_device *nbd, unsigned long fd,
>>          if (!sock)
>>                  return NULL;
>>
>> +       if (!sk_is_tcp(sock->sk) &&
>> +           !sk_is_stream_unix(sock->sk)) {
>> +               dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
>> should be TCP or UNIX.\n");
>> +               *err = -EINVAL;
>> +               sockfd_put(sock);
>> +               return NULL;
>> +       }
>> +
>>          if (sock->ops->shutdown == sock_no_shutdown) {
>>                  dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
>> shutdown callout must be supported.\n");
>>                  *err = -EINVAL;
> 
> .
> 

