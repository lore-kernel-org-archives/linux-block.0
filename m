Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317C72604;
	Wed, 30 Jul 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841038; cv=none; b=jL6uR88+8TiRkBmDA5IY8vootAE4N2YZ81P46PDrK2ZkB4slLWtdim0WbTa+ZCkOGD3emFZmKJRyYIltQ8kPdaY+5K5e2sESkH/HojOtDb0+pYzoDjcqEjUei/C/+6kyefsNMkd7Q+W76c2uhpC5VCQuj7LKLklJ3BM23HTp6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841038; c=relaxed/simple;
	bh=Wti2siLeCSDhznXr3b9edwTbQXtYVMSR8BE/9IPJodM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vz/9rxx5gOuvFUy1l2iNoY/Q0HJE3DeMZ/Ur1rXVPNDV2eNy7jPzALSeCcjnx0tDdbpwkxZid2YK0uHdIr6QcBHOAhEhQpGTJzUCUPZWu3Q/49CDbgf/U46iFW4yvV334p+uURJ6wePub5FQctZtcwoehM3rNq24Qz9h5az2vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bsFr93JRbzKHMcq;
	Wed, 30 Jul 2025 10:03:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B6A41A236D;
	Wed, 30 Jul 2025 10:03:52 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxCGfYlo6l_HBw--.37246S3;
	Wed, 30 Jul 2025 10:03:52 +0800 (CST)
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 dlemoal@kernel.org, ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, Omar Sandoval <osandov@fb.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
Date: Wed, 30 Jul 2025 10:03:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxCGfYlo6l_HBw--.37246S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW5CFyrGFW7uw47tr1UZFb_yoW5Gw13pF
	W7Ka1akr1kX3429r45Xw47WFn0yw1Sgr13JFn8K3y7C3s8A3savrn5ta1YgFy7Xrsru3y0
	vFs2vr9xuF1kXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/29 18:16, Jan Kara Ð´µÀ:
> On Tue 29-07-25 11:19:05, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently elevators will record internal 'async_depth' to throttle
>> asynchronous requests, and they both calculate shallow_dpeth based on
>> sb->shift, with the respect that sb->shift is the available tags in one
>> word.
>>
>> However, sb->shift is not the availbale tags in the last word, see
>> __map_depth:
>>
>> if (index == sb->map_nr - 1)
>>    return sb->depth - (index << sb->shift);
>>
>> For consequence, if the last word is used, more tags can be get than
>> expected, for example, assume nr_requests=256 and there are four words,
>> in the worst case if user set nr_requests=32, then the first word is
>> the last word, and still use bits per word, which is 64, to calculate
>> async_depth is wrong.
>>
>> One the other hand, due to cgroup qos, bfq can allow only one request
>> to be allocated, and set shallow_dpeth=1 will still allow the number
>> of words request to be allocated.
>>
>> Fix this problems by using shallow_depth to the whole sbitmap instead
>> of per word, also change kyber, mq-deadline and bfq to follow this.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> I agree with these problems but AFAIU this implementation of shallow depth
> has been done for a reason. Omar can chime in here as the original author
> or perhaps Jens but the idea of current shallow depth implementation is
> that each sbitmap user regardless of used shallow depth has a chance to
> allocate from each sbitmap word which evenly distributes pressure among
> available sbitmap words. With the implementation you've chosen there will
> be higher pressure (and thus contention) on words with low indices.

Yes, this make sense. However, consider that shallow depth is only used
by elevator, this higher pressure should be negligible for deadline and
bfq. As for kyber, this might be a problem.
> 
> So I think we would be good to fix issues with shallow depth for small
> number of sbitmap words (because that's where these buggy cornercases may
> matter in practice) but I believe the logic which constrains number of used
> bits from each *word* when shallow_depth is specified should be kept.  It
> might make sense to change the API so that shallow_depth is indeed
> specified compared to the total size of the bitmap, not to the size of the
> word (because that's confusing practically everybody I've met and is a
> constant source of bugs) if it can be made to perform well.

Do you think will it be ok to add a new shallow depth API to use the
total size, and convert bfq and deadline to use it?

Thanks,
Kuai

> 
> 								Honza

