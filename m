Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AD174EF0;
	Tue, 22 Apr 2025 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285967; cv=none; b=AZyQeratiHt6w8xGoHkpKH4JZO1JrTHdLA80EhrMCLLyXynZ17Cj2GYl/HCNrT6zN42Ww20me3yqaCvKej+g2RJ8C8GFraC9cf5flQTDKAfMFgrUhxqgkMMqoY14ODBwVchq9zBl7Gca3ZRVOy88/H4eiRhaOntDDgowKmxhqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285967; c=relaxed/simple;
	bh=CT5o7RpJXfCEEp6Sre0lq/6CJdxYt0AcbWSFF9CdX5U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L8ZPkdRAXPzzeX88NVq/01ca4E6heJ18X9MF05d3fGPQxOUCTCG3D8QvSv1cat47S1YDIX9nq4FO2rImKcNP5TTu7oE8werglmK3JBWNwCxhiZy7Wyvm+OQRMSjQSKCOZPdl0Ay4hNRBdG2cHzfaQ0oXGI2l9EroJMjPHs3fO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZhPz44PvXz4f3jY8;
	Tue, 22 Apr 2025 09:38:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 838F61A07BD;
	Tue, 22 Apr 2025 09:39:20 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3219F8wZo6szEKA--.19869S3;
	Tue, 22 Apr 2025 09:39:18 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Matt Fleming <mfleming@cloudflare.com>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
 <CAGis_TXyPtFiE=pLrLRh1MV3meE4aETi6z36NWLrMkYKkcjGNQ@mail.gmail.com>
 <aAaUKenXzkFPZaMb@kbusch-mbp.dhcp.thefacebook.com>
 <CAGis_TU1V2_L227SP9Ut1gSTNx9-AT9nbwgJH6azzH8==35hBQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ceefa848-082b-0153-e41d-26c0559f3666@huaweicloud.com>
Date: Tue, 22 Apr 2025 09:39:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGis_TU1V2_L227SP9Ut1gSTNx9-AT9nbwgJH6azzH8==35hBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3219F8wZo6szEKA--.19869S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xWr45CFW5ZrWUGry3Jwb_yoW8try5pF
	ZYgF4fKF4DG348Aw4Ivw4UZryak397Ga43Xa95J3WIvrn0gryft34I93yagFW7Ary0krWS
	vw4Fgas3W3sFy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/22 3:10, Matt Fleming 写道:
> On Mon, 21 Apr 2025 at 19:53, Keith Busch <kbusch@kernel.org> wrote:
>>
>> Not sure. I'm also guessing cond_resched is the reason for your
>> observation, so that might be worth confirming is happening in whatever
>> IO paths you're workload is taking in case there's some other
>> explanation.
> 
> Yep, you're spot on. We're hitting cond_resched() from various code
> paths (xfs_buf_delwri_submit_buffers(), swap_writepage(),
> rmap_walk_file(), etc, etc).

All pluged IO must be submited before scheduled out, there is no point
for this direction. :(

Please check the other mail that I replied to your original report,
it'll make sense if a task keeps running on one cpu for milliseconds.

Thanks,
Kuai

> 
> sudo bpftrace -e 'k:psi_task_switch {        $prev = (struct
> task_struct *)arg0;        if ($prev->plug != 0) {
>                  if ($prev->plug->cur_ktime) {
>                          @[kstack(3)] = count();
>                  }
>          }
> }'
> Attaching 1 probe...
> ^C
> 
> @[
>      psi_task_switch+5
>      __schedule+2081
>      __cond_resched+51
> ]: 3044
> 
>> fs-writeback happens to work around it by unplugging if it knows
>> cond_resched is going to schedule. The decision to unplug here wasn't
>> necessarily because of the plug's ktime, but it gets the job done:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fs-writeback.c?h=v6.15-rc3#n1984
>>
>> Doesn't really scale well to copy this for every caller of
>> cond_resched(), though. An io specific helper implementation of
>> cond_resched might help.
>>
>> Or if we don't want cond_resched to unplug (though I feel like you would
>> normally want that), I think we could invalidate the ktime when
>> scheduling to get the stats to read the current ktime after the process
>> is scheduled back in.
> 
> Thanks. Makes sense to me. I'll try this out and report back.
> 
>> ---
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6978,6 +6978,9 @@ static void __sched notrace preempt_schedule_common(void)
>>                   * between schedule and now.
>>                   */
>>          } while (need_resched());
>> +
>> +       if (current->flags & PF_BLOCK_TS)
>> +               blk_plug_invalidate_ts(current);
>>   }
>>
>>   #ifdef CONFIG_PREEMPTION
>> --
> 
> .
> 

