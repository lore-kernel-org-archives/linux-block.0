Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B596253F05
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407239; cv=none; b=lyAjgi8whNN5I84TjkASSQ5Vn6bL8aB3d/RRVtB8NtdRwB2WS2VTzL2RCY68l1hkU0qH4i4fpW2SilJ9EUZgpl1OckfeNtTnKD0g6sIacmcrrMCrkuAcMLQR0E77oBmkfdWFGTWuFyDLSHGeTG/LayVLyKQciRbJuoCUXwu+lsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407239; c=relaxed/simple;
	bh=3ncHeF/ohO0G2fNLNAfPCY73I2CZO+sTAYyUGcsBqXM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DjXx7vV+8kb6cfhbvv7JZF8BYRKujQtOz33ZskkLWa2Z5T+/BkrGE90aKfVxzr3fdynYm7ANJJoAENg0PQ3USCstcyt15w3ni38na9cH8GhNoJ6NoVd8uoxwKaoYyNQZ8vUkgEkGeRs2IcJtVzscOwfnIGy6qVdOfpTssfQOMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLchy2KWxzKHN2G
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B02E1A141A
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:40:34 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY0B6L9owQyhBw--.26772S3;
	Tue, 09 Sep 2025 16:40:34 +0800 (CST)
Subject: Re: [PATCH 2/2] block: remove the bi_inline_vecs variable sized array
 from struct bio
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-3-hch@lst.de>
 <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8257e4d7-cf2e-6913-06fd-f11c2f94f38a@huaweicloud.com>
Date: Tue, 9 Sep 2025 16:40:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42becc1c-e842-4eba-a7ad-5b1e60594243@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY0B6L9owQyhBw--.26772S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr18JrWDtF1xXF1ktr4fZrb_yoWkuwb_Cw
	45Xr17W34UJr45Xr13Jw13XrW7ta1qvr18XF4Syw13XF15Jrn8Jw4Yqwn5Jr15GrW8Jr4U
	Jr1UJr13Ja4DtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07URKZ
	XUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/09 16:16, John Garry 写道:
>> diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
>> index 4fc80c6d5b31..73918e55bf04 100644
>> --- a/drivers/md/bcache/movinggc.c
>> +++ b/drivers/md/bcache/movinggc.c
>> @@ -145,9 +145,9 @@ static void read_moving(struct cache_set *c)
>>               continue;
>>           }
>> -        io = kzalloc(struct_size(io, bio.bio.bi_inline_vecs,
>> -                     DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
>> -                 GFP_KERNEL);
>> +        io = kzalloc(sizeof(*io) + sizeof(struct bio_vec) *
>> +                DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS),
>> +                GFP_KERNEL);
> 
> this seems a common pattern, so maybe another helper (which could be 
> used by bio_kmalloc)? I am not advocating it, but just putting the idea 
> out there... too many helpers makes it messy IMHO

Not sure how to do this, do you mean a marco to pass in the base
structure type, nr_vecs and the gfp_mask?

Thanks,
Kuai

