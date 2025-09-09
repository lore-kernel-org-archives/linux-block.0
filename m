Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4A279DDB
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409053; cv=none; b=Li7kuhuQNjZjzc3rJUv5FMGacOg4gbgQnV+lp9jykT+VGg3RghnVtrl7b4bD1fD8M2q6KBZh9VDNYqZ2ycvMCWEoiyNz2x7efjgpmG33i3gyeVWRKqoYks1W/Th3izTS+pdvSWcZLo6K90/HPChbz2CPrH8g3lzygQSkMY9lbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409053; c=relaxed/simple;
	bh=KDnDgxydqJPl0T0lJIKANcVClC7jqb2vooyoMaHdKNs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UFRuPNPNU9vw7QWrfN8V5KILeUya86HeSAnnrnZYMb46PnGrPiwgvI2DdCszPqx0gIQW5JOFhvcUo8nkiEfd+91dJD9rtYs/7wjsur57vsPTKniN56vn0Nbz7SM/SlUPi2uGrRZt24CGIUqzwpzmi0wEXzZZgn+1Q9p5pB4hU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLdMr0SqMzKHN36
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 17:10:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3CC651A1ED9
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 17:10:48 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y0W779oT3ajBw--.27845S3;
	Tue, 09 Sep 2025 17:10:48 +0800 (CST)
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized array
 from struct bio
To: John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-3-hch@lst.de>
 <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
 <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
 <8e5b16eb-a5f9-4fdb-8422-34be7c24b93b@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a82f2839-0fa9-258f-0dd7-0381eaa009a7@huaweicloud.com>
Date: Tue, 9 Sep 2025 17:10:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e5b16eb-a5f9-4fdb-8422-34be7c24b93b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y0W779oT3ajBw--.27845S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1UZFW3Jr1Uur47Ar43ZFb_yoW8ZF48pF
	yktFWjyrW5Jr18Xryjvw4UZryrtwn7ta4UGryIg3WDZry7XF1qgr4DXr1q9r1UAr4rCF18
	Ar48tr1UZr9xJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/09 16:55, John Garry 写道:
> On 09/09/2025 09:40, Yu Kuai wrote:
>>
>> 在 2025/09/09 16:16, John Garry 写道:
>>>> diff --git a/drivers/md/bcache/movinggc.c 
>>>> b/drivers/md/bcache/movinggc.c
>>>> index 4fc80c6d5b31..73918e55bf04 100644
>>>> --- a/drivers/md/bcache/movinggc.c
>>>> +++ b/drivers/md/bcache/movinggc.c
>>>> @@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
>>>>               continue;
>>>>           }
>>>> -        io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
>>>> -                     DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
>>>> -                 GFP_KERNEL);
>>>> +        io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
>>>> +                DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
>>>> +                GFP_KERNEL);
>>>
>>> this seems a common pattern, so maybe another helper (which could be 
>>> used by bio_kmalloc)? I am not advocating it, but just putting the 
>>> idea out there... too many helpers makes it messy IMHO
>>
>> Not sure how to do this, do you mean a marco to pass in the base
>> structure type, nr_vecs and the gfp_mask?
> 
> something like the following (which I think is messy and an imprecise 
> API, so again I am not advocating it):
> 
> struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
> {
>      return kmalloc(sizeof(struct bio) + nr_vecs * sizeof(struct bio_vec),
> gfp_mask);
> }
> 
> struct bio *bio_kmalloc_inline(unsigned short nr_vecs, gfp_t gfp_mask)
> {
>      if (nr_vecs > BIO_MAX_INLINE_VECS)
>          return NULL;
>      return bio_kmalloc(nr_vecs, gfp_mask);
> }
> 
However, the caller is allocating the base structure that bio is
embedded, the above helper to return bio is still not common.

Perhaps this patch is better anyway.

Thanks,
Kuai
> 
> .
> 

