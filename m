Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C667A13A
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587620; cv=none; b=PS/n2LXwjZPuaHNHdTzJxmLX8hHZZGau5AX/9+sHEMlVFVNeBJEv+kc6bjW5ZHfYPBYLB4HGuOIgxT/FePs1aB4dhX8HotKF3lqwwnHT5G9wzh1B/SxAtP2AZWoVXqjsUnoJPIw07Dh/16MMM6Lx+1VSukH1xxxweCh2/gjXMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587620; c=relaxed/simple;
	bh=Uhbp/LVZBJtLQ6ZNL2EGebSEp7A/3bLg7OAMI5c+2XA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aNLLFBR8X5CVTBz8TqRVs/rsNV35Pb310e66yswuky0lDLvULAhs3zI8BOHoiq1JObplmsgB6qFYHZ8zqDnTUAjedMz1+4x0zCkzKTXwDz/465k7BYuT2fz8gMAsL3Sf6kZFPeSamjk360nOLwb8RRnkLf9SaCDx8rsT2+Xf3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zsfxs6f2sz4f3lVM
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 10:54:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E74D51A0359
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 10:55:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl+ayxpoEgOpLg--.43748S3;
	Wed, 07 May 2025 10:55:23 +0800 (CST)
Subject: Re: [PATCH] brd: avoid extra xarray lookups on first write
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250506143836.3793765-1-hch@lst.de>
 <aBotzukGcxHQ0LIX@kbusch-mbp.dhcp.thefacebook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <122ac0f6-74df-1ea8-15ba-8ca4f2bc3de9@huaweicloud.com>
Date: Wed, 7 May 2025 10:55:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aBotzukGcxHQ0LIX@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl+ayxpoEgOpLg--.43748S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15CFWxGFW8tFyfXw18Krg_yoWrAF4UpF
	WkGry8A398Zry5Gw17ZFZ8ur1Fvw1IgFWxKFy8W3WUur4fur9ayasFkryFg3W5CrZrCrZ8
	Aa15tr1DZrs5Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/05/06 23:42, Keith Busch Ð´µÀ:
> On Tue, May 06, 2025 at 04:38:36PM +0200, Christoph Hellwig wrote:
>> +	rcu_read_lock();
>> +	page = brd_lookup_page(brd, sector);
>> +	if (!page && op_is_write(opf)) {
>>   		/*
>>   		 * Must use NOIO because we don't want to recurse back into the
>>   		 * block or filesystem layers from page reclaim.
>>   		 */
>> -		err = brd_insert_page(brd, sector,
>> -				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
>> -		if (err) {
>> -			if (err == -ENOMEM && (opf & REQ_NOWAIT))
>> -				bio_wouldblock_error(bio);
>> -			else
>> -				bio_io_error(bio);
>> -			return false;
>> +		gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
>> +
>> +		rcu_read_unlock();
>> +		page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
>> +		if (!page) {
>> +			err = -ENOMEM;
>> +			goto out_error;
>> +		}
>> +		rcu_read_lock();
>> +
>> +		xa_lock(&brd->brd_pages);
>> +		ret = __xa_store(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT,
>> +				page, gfp);
> 
> On success, __xa_store() says it replaces the old entry ("ret"), with
> your new entry ("page"). I think you want to store the new entry only if
> there is no old entry, so shouldn't this instead be:
> 
> 		ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT,
> 				   NULL, page, gfp);
> 
> ?

Looks this is right, comments from xa_store:

After this function returns, loads from this index will return @entry.
> 
>> +		if (!ret)
>> +			brd->brd_nr_pages++;
>> +		xa_unlock(&brd->brd_pages);
>> +
>> +		if (ret) {
>> +			__free_page(page);
>> +			err = xa_err(ret);
>> +			if (err < 0)
>> +				goto out_error;
>> +			page = ret;
>>   		}
> 
> .
> 

BTW, can we keep the old brd_insert_page, and return inserted page
directly? This change should be simplier.

Thanks,
Kuai

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a3725673cf16..ea481422e53e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -54,7 +54,7 @@ static struct page *brd_lookup_page(struct brd_device 
*brd, sector_t sector)
  /*
   * Insert a new page for a given sector, if one does not already exist.
   */
-static int brd_insert_page(struct brd_device *brd, sector_t sector, 
gfp_t gfp)
+static struct page *brd_insert_page(struct brd_device *brd, sector_t 
sector, gfp_t gfp)
  {
         pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
         struct page *page;
@@ -62,24 +62,30 @@ static int brd_insert_page(struct brd_device *brd, 
sector_t sector, gfp_t gfp)

         page = brd_lookup_page(brd, sector);
         if (page)
-               return 0;
+               return page;

+       rcu_read_unlock();
         page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-       if (!page)
-               return -ENOMEM;
+       if (!page) {
+               rcu_read_lock();
+               return ERR_PTR(-ENOMEM);
+       }

+       rcu_read_lock();
         xa_lock(&brd->brd_pages);
         ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
         if (!ret)
                 brd->brd_nr_pages++;
         xa_unlock(&brd->brd_pages);

-       if (ret < 0) {
-               __free_page(page);
-               if (ret == -EBUSY)
-                       ret = 0;
-       }
-       return ret;
+       if (likely(!ret))
+               return page;
+
+       __free_page(page);
+       if (unlikely(ret == -EBUSY))
+               return brd_lookup_page(brd, sector);
+
+       return ERR_PTR(ret);
  }

  /*
@@ -114,36 +120,31 @@ static bool brd_rw_bvec(struct brd_device *brd, 
struct bio *bio)

         bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);

+       rcu_read_lock();
         if (op_is_write(opf)) {
-               int err;
-
                 /*
                  * Must use NOIO because we don't want to recurse back 
into the
                  * block or filesystem layers from page reclaim.
                  */
-               err = brd_insert_page(brd, sector,
+               page = brd_insert_page(brd, sector,
                                 (opf & REQ_NOWAIT) ? GFP_NOWAIT : 
GFP_NOIO);
-               if (err) {
+               if (IS_ERR(page)) {
+                       int err = PTR_ERR(page);
+
+                       rcu_read_unlock();
                         if (err == -ENOMEM && (opf & REQ_NOWAIT))
                                 bio_wouldblock_error(bio);
                         else
                                 bio_io_error(bio);
                         return false;
                 }
+       } else {
+               page = brd_lookup_page(brd, sector);
         }

-       rcu_read_lock();
-       page = brd_lookup_page(brd, sector);
-
         kaddr = bvec_kmap_local(&bv);
         if (op_is_write(opf)) {
-               /*
-                * Page can be removed by concurrent discard, it's fine 
to skip
-                * the write and user will read zero data if page does not
-                * exist.
-                */
-               if (page)
-                       memcpy_to_page(page, offset, kaddr, bv.bv_len);
+               memcpy_to_page(page, offset, kaddr, bv.bv_len);
         } else {
                 if (page)
                         memcpy_from_page(kaddr, page, offset, bv.bv_len);

