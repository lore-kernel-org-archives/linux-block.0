Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72879285C8A;
	Tue, 29 Jul 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778794; cv=none; b=fuI+YcrIA0bukT/rZXejIM9ETg8BivbyW55RArwoZWWDR/52DPYgZudAIy20LznBPiAcZ/ZO+qAPVs8SReDcOO+4TLelzRGwowo1ioXestF32CjFNzkKheAJJhssURxWjntGH/zmzJHhxEXszYEHgH78AKo17FuIGRxbmcPpLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778794; c=relaxed/simple;
	bh=oh7259dSLrjEFh6LnTRaGQqaqna89ARwQXYNssjqAuk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vxva55aYbIbnjHYCckWUR/x5UPPFyEfilCt71sD49LwqhA15aoHmPnHNLafkW+kn6x2t0VLnNW58G+UrWjBztPF6Z2/6MtARnraRa8Mihwi/3KXc+V0oaKsCmcFmvN4/Cxr4IFM0rO78ow0cFHZSGbAfPbF9htUN/jFf/YqM78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brpqB0yP5zYQvXm;
	Tue, 29 Jul 2025 16:46:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9E571A1435;
	Tue, 29 Jul 2025 16:46:28 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhNgioho09d2Bw--.64472S3;
	Tue, 29 Jul 2025 16:46:26 +0800 (CST)
Subject: Re: [PATCH] brd: use page reference to protect page lifetime
To: Hou Tao <houtao@huaweicloud.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@lst.de, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250729070915.487189-1-yukuai1@huaweicloud.com>
 <51c0afe6-decc-67bd-0336-177a250acb3b@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <185788ed-2d5c-aac1-e171-9ab69e4f9175@huaweicloud.com>
Date: Tue, 29 Jul 2025 16:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51c0afe6-decc-67bd-0336-177a250acb3b@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhNgioho09d2Bw--.64472S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFWrury8Ww4fGF4rXwb_yoW7Jw1fpF
	WDJFyxA3y5Jr4akw17Xwn8CFyFv34IgF4fK3y3Ja1Skrn7Cr9IyFy0yw1Fga45CrWUCr4k
	AF4DtrnrurZYqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/29 15:52, Hou Tao 写道:
> Hi,
> 
> On 7/29/2025 3:09 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> As discussed [1], hold rcu for copying data from/to page is too heavy.
>> it's better to protect page with rcu around for page lookup and then
>> grab a reference to prevent page to be freed by discard.
>>
>> [1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/brd.c | 56 +++++++++++++++++++++++----------------------
>>   1 file changed, 29 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index 0c2eabe14af3..ce311d054cab 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -44,45 +44,55 @@ struct brd_device {
>>   };
>>   
>>   /*
>> - * Look up and return a brd's page for a given sector.
>> + * Look up and return a brd's page with reference grabbed for a given sector.
>>    */
>>   static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>>   {
>> -	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
>> +	struct page *page;
>> +
>> +	rcu_read_lock();
>> +	page = xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
>> +	if (page)
>> +		get_page(page);
> 
> get_page_unless_zero() instead ? Er, it seems even with
> get_page_unless_zero(), it is not enough, becausethe page may be reused.
> Maybe we need to read the brd_pages xarray to ensure the page is still
> there.

Yes, you're right, refer to the pagecache procedures, I'll switch to use
xas_load + xas_reload in the next version.

Thanks,
Kuai

>> +	rcu_read_unlock();
>> +
>> +	return page;
>>   }
>>   
>>   /*
>>    * Insert a new page for a given sector, if one does not already exist.
>> + * The returned page will grab reference.
>>    */
>>   static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
>>   		blk_opf_t opf)
>> -	__releases(rcu)
>> -	__acquires(rcu)
>>   {
>>   	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
>>   	struct page *page, *ret;
>>   
>> -	rcu_read_unlock();
>>   	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
>> -	if (!page) {
>> -		rcu_read_lock();
>> +	if (!page)
>>   		return ERR_PTR(-ENOMEM);
>> -	}
>>   
>>   	xa_lock(&brd->brd_pages);
>>   	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
>>   			page, gfp);
>> -	rcu_read_lock();
>> -	if (ret) {
>> +	if (!ret) {
>> +		brd->brd_nr_pages++;
>> +		get_page(page);
>>   		xa_unlock(&brd->brd_pages);
> 
> If I understand correctly, the initial ref-count after alloc_page() is 1
> instead of 0, so I think the get_page(page) here and get_page(ret) below
> is unnecessary and it will lead to memory leak.
>> -		__free_page(page);
>> -		if (xa_is_err(ret))
>> -			return ERR_PTR(xa_err(ret));
>> +		return page;
>> +	}
>> +
>> +	if (!xa_is_err(ret)) {
>> +		get_page(ret);
>> +		xa_unlock(&brd->brd_pages);
>> +		put_page(page);
>>   		return ret;
>>   	}
>> -	brd->brd_nr_pages++;
>> +
>>   	xa_unlock(&brd->brd_pages);
>> -	return page;
>> +	put_page(page);
>> +	return ERR_PTR(xa_err(ret));
>>   }
>>   
>>   /*
>> @@ -95,7 +105,7 @@ static void brd_free_pages(struct brd_device *brd)
>>   	pgoff_t idx;
>>   
>>   	xa_for_each(&brd->brd_pages, idx, page) {
>> -		__free_page(page);
>> +		put_page(page);
>>   		cond_resched();
>>   	}
>>   
>> @@ -117,7 +127,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>>   
>>   	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>>   
>> -	rcu_read_lock();
>>   	page = brd_lookup_page(brd, sector);
>>   	if (!page && op_is_write(opf)) {
>>   		page = brd_insert_page(brd, sector, opf);
>> @@ -135,13 +144,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>>   			memset(kaddr, 0, bv.bv_len);
>>   	}
>>   	kunmap_local(kaddr);
>> -	rcu_read_unlock();
>>   
>>   	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
>> +	if (page)
>> +		put_page(page);
>>   	return true;
>>   
>>   out_error:
>> -	rcu_read_unlock();
>>   	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
>>   		bio_wouldblock_error(bio);
>>   	else
>> @@ -149,13 +158,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>>   	return false;
>>   }
>>   
>> -static void brd_free_one_page(struct rcu_head *head)
>> -{
>> -	struct page *page = container_of(head, struct page, rcu_head);
>> -
>> -	__free_page(page);
>> -}
>> -
>>   static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>>   {
>>   	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
>> @@ -170,7 +172,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>>   	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
>>   		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>>   		if (page) {
>> -			call_rcu(&page->rcu_head, brd_free_one_page);
>> +			put_page(page);
>>   			brd->brd_nr_pages--;
>>   		}
>>   		aligned_sector += PAGE_SECTORS;
> 
> .
> 

