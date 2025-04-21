Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DB4964E;
	Mon, 21 Apr 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745219347; cv=none; b=tm1LDxLPHTuSEdogUYfHXS/MlK3otdnWueeaq8dXEymmS6zQJf0zhBPXhuwBwgnQ73N15ZlXOTAeDTh9dyDvv30Iy2wz7mbuvBKcKKlg/5AwN71/zC8RQnYQQfSF7jY0ADvaD1DYyCWIQRLM4Yt2Df1DsGb1qP9ivnptcDR7hEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745219347; c=relaxed/simple;
	bh=kiwyWqOC6H414FypC8nJL7JL5ezcim4ZcGc0xvmG47I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FeVL/I6UO+DbxL1203r+USmmVjWvsCxnskJQhgsihUSkHGjCUZOG4vrbs9ame2oGNBJMep7/SkGmkj2bjfRPQRNgolLjBO1dX95BfSKd4SVvdveoHoCuk05PWIQwFdMv+FC6vSs/Ydb7hA2GfdBhmONTjUtAu/eBYR+wLCSVPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZgxKt4Clpz4f3m6n;
	Mon, 21 Apr 2025 15:08:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 035A51A07BB;
	Mon, 21 Apr 2025 15:09:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXu18K7wVo9fl3KA--.2539S3;
	Mon, 21 Apr 2025 15:08:59 +0800 (CST)
Subject: Re: [PATCH 2/5] brd: synchronize using page and free page with rcu
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, linux-mm@kvack.org, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-3-yukuai1@huaweicloud.com>
 <aAXWgjauEVvw5183@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8de49859-8441-ee02-6114-ec2c9f89ada1@huaweicloud.com>
Date: Mon, 21 Apr 2025 15:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAXWgjauEVvw5183@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu18K7wVo9fl3KA--.2539S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr43tw13XFyfCF1kWw48WFg_yoW5XFW7pF
	WUAFyxCrWDZr17K3WSq3Z0vryFq3s2qrWrGFWxG3yUK3sxCr9Fya48tw1rWF4rCrn5Gr42
	vws0yryxZwn5A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

ÔÚ 2025/04/21 13:24, Christoph Hellwig Ð´µÀ:
> On Fri, Apr 18, 2025 at 05:38:23PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, after fetching the page by xa_load() in IO path, there is no
>> protection and page can be freed concurrently by discard:
> 
> Ah, I guess this helps with the race I mentioned in reply to the
> previous patch.  Is the rcu_head in struct page available for use
> by subsystems freeing the page?

Take a look at other union fileds int the struct page, in this case,
the page:
  - not used for pagecache or anonymous page
  - not used for page_pool
  - not used for compound page
  - not used for zone device page

So, I think it's fine to use the rcu_head.

We may want to avoid the page reference here since it's atomic and will
affect IO performance.

BTW, perhaps this patch should be the first patch in this set. :)

Thanks,
Kuai
> 
>>
>> cpu0
>> brd_submit_bio
>>   brd_do_bvec
>>    page = brd_lookup_page
>>                            cpu1
>>                            brd_submit_bio
>>                             brd_do_discard
>>                              page = __xa_erase()
>>                              __free_page()
>>    // page UAF
>>
>> Fix the problem by protecting page with rcu.
>>
>> Fixes: 9ead7efc6f3f ("brd: implement discard support")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/brd.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index a6e4f005cb76..740ed13faaff 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -208,6 +208,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>>   			goto out;
>>   	}
>>   
>> +	rcu_read_lock();
>>   	mem = kmap_local_page(page);
>>   	if (!op_is_write(opf)) {
>>   		copy_from_brd(mem + off, brd, sector, len);
>> @@ -217,11 +218,19 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>>   		copy_to_brd(brd, mem + off, sector, len);
>>   	}
>>   	kunmap_local(mem);
>> +	rcu_read_unlock();
>>   
>>   out:
>>   	return err;
>>   }
>>   
>> +static void brd_free_one_page(struct rcu_head *head)
>> +{
>> +	struct page *page = container_of(head, struct page, rcu_head);
>> +
>> +	__free_page(page);
>> +}
>> +
>>   static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>>   {
>>   	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
>> @@ -232,7 +241,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>>   	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
>>   		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>>   		if (page) {
>> -			__free_page(page);
>> +			call_rcu(&page->rcu_head, brd_free_one_page);
>>   			brd->brd_nr_pages--;
>>   		}
>>   		aligned_sector += PAGE_SECTORS;
>> -- 
>> 2.39.2
>>
>>
> ---end quoted text---
> 
> .
> 

