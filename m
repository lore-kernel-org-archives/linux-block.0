Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027314294;
	Tue,  4 Jun 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481551; cv=none; b=Ajm2aYGZuPAJFOhoVRCoGFFM0N7uwXChYFHNkRJmOy/ixEf+VisC+lhptw0A6VHbv6qtuNorQ+qGKiFrZzpIN+H3uubSzTIKhiH1m4TN5Cw91qmzwO1xxF7qzPfcNSAqvVQKt4iUpJa6eSo87GaXElGFapU5YiHqFsyL4Y6wnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481551; c=relaxed/simple;
	bh=DGGP/Rplelsv7Ug2joBC4Oe+Q/RBrQPCpgeRhztTN/I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oMN20PzK9AmYm3bRC5mSy8pwbEcSTGzYhXs0FuJgd5chCE4XNaxcRiXXKcfiIsKIj6E8bHRwlmkt4T9oLDk3Mk6oLo9606mYyaSLe3C6SbNDB6RBTA0UBue7st2TwDUoSrAcP5HZ7qOgjCLR4S4HcDTnWC4JjBhr1rhA82lxhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtgH113Vwz4f3n6L;
	Tue,  4 Jun 2024 14:12:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3B9501A0199;
	Tue,  4 Jun 2024 14:12:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFGsF5mJvsYOg--.35067S3;
	Tue, 04 Jun 2024 14:12:23 +0800 (CST)
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Ming Lei <ming.lei@redhat.com>, Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
Date: Tue, 4 Jun 2024 14:12:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFGsF5mJvsYOg--.35067S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1UGw43KrW3KFWDtr4rAFb_yoW8Kw47pr
	W5tF1xKrZ5t342vw1DW34rAF1Iyws7trsrJr10gryfCa4UuF9xJF48KF43t3WkGFWkJF1D
	Wa1rJrZ5Kw1qgaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/06/04 11:25, Ming Lei 写道:
> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>
>> Configuration for sbq:
>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>
>> 1. There are 64 requests in progress:
>>    map->word = 0xFFFFFFFFFFFFFFFF
>> 2. After all the 64 requests complete, and no more requests come:
>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>> 3. Now two tasks try to allocate requests:
>>    T1:                                       T2:
>>    __blk_mq_get_tag                          .
>>    __sbitmap_queue_get                       .
>>    sbitmap_get                               .
>>    sbitmap_find_bit                          .
>>    sbitmap_find_bit_in_word                  .
>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>        return false;                         __sbitmap_get_word -> nr=-1
>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>      atomic_long_andnot()                    /* map->cleared=0 */
>>                                                if (!(map->cleared))
>>                                                  return false;
>>                                       /*
>>                                        * map->cleared is cleared by T1
>>                                        * T2 fail to acquire the tag
>>                                        */
>>
>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>> up due to the wake_batch being set at 6. If no more requests come, T1
>> will wait here indefinitely.
>>
>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>> remove swap_lock"), which causes this issue.
> 
> I'd suggest to add the following words in commit log:
> 
> Check on ->cleared and update on both ->cleared and ->word need to be
> done atomically, and using spinlock could be the simplest solution.
> 
> Otherwise, the patch looks fine for me.

Maybe I'm noob, but I'm confused how can this fix the problem, looks
like the race condition doesn't change.

In sbitmap_find_bit_in_word:

1) __sbitmap_get_word read word;
2) sbitmap_deferred_clear clear cleared;
3) sbitmap_deferred_clear update word;

2) and 3) are done atomically while 1) can still concurrent with 3):

t1:
sbitmap_find_bit_in_word
  __sbitmap_get_word
  -> read old word, return -1
		t2:
		sbitmap_find_bit_in_word
		 __sbitmap_get_word
		 -> read old word, return -1
  sbitmap_deferred_clear
  -> clear cleared and update word
		sbitmap_deferred_clear
		-> cleared is cleared, fail

BYW, I still think it's fine to fix this problem by trying the
__sbitmap_get_word() at least one more time if __sbitmap_get_word()
failed.

Thanks,
Kuai

> 
> Thanks,
> 
> 
> .
> 

