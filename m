Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06321CA9C;
	Tue, 29 Apr 2025 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891298; cv=none; b=D6K/aK9HUnBHWKsd0RC4lP5TBZ+9iA5ApcQpYZg/zkgYmfWdmiIbxmDC/5t9Q3v8+h/hmgUUQEjKD//aiQp//A2uIi/Gs6B2mVkQNygLsRUDRHlRYBQmWBcTrihRZKNzqyP7HDGTgtX2DUtYVaNyv01IlFXV/8pO7rZoob9JMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891298; c=relaxed/simple;
	bh=PJ40Ky8bkjg+BOc4I0/brfIGn/WDXPe1tD9/zb9a6Mg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GoveFgrWY0YbRP7a5nCLsgK/8O2sOI29MHMd6/gjvbn9CFCMC0fbt+oKe0JdJ/XOtB6nf0jLSwmholJUmEc5mcvrPa+HCSw22zstgfqxcH/c6gmyfWu18NrDxgsW7vwm4dUnHZODqEzOmZsq3ju4rYg6Y2Ih+ZUHoDhfE6wkAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZmjrZ3vMbzYQttP;
	Tue, 29 Apr 2025 09:48:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06B341A0AF2;
	Tue, 29 Apr 2025 09:48:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_dLxBoVoqBKw--.58321S3;
	Tue, 29 Apr 2025 09:48:13 +0800 (CST)
Subject: Re: [PATCH v2 1/3] brd: protect page with rcu
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250427083925.157984-1-yukuai1@huaweicloud.com>
 <20250427083925.157984-2-yukuai1@huaweicloud.com>
 <20250428125207.GB27794@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cdca4c95-27a0-5964-e242-173281c4e8f9@huaweicloud.com>
Date: Tue, 29 Apr 2025 09:48:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250428125207.GB27794@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl_dLxBoVoqBKw--.58321S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr43tF1fAw4DJFWfGw17Jrb_yoWfCwbEka
	13W3srta43ury0ya13W343X397tFWkCa1qvr1fAFs3XFW5JrZFyw4xJws5ta40qF1293yx
	GF9rAa45G342qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/28 20:52, Christoph Hellwig Ð´µÀ:
> On Sun, Apr 27, 2025 at 04:39:23PM +0800, Yu Kuai wrote:
>>   	page = brd_lookup_page(brd, sector);
>>   
>>   	kaddr = bvec_kmap_local(&bv);
>>   	if (op_is_write(opf)) {
>> -		BUG_ON(!page);
>> -		memcpy_to_page(page, offset, kaddr, bv.bv_len);
>> +		if (page)
>> +			memcpy_to_page(page, offset, kaddr, bv.bv_len);
> 
> This could use a comment on why page can be NULL here.
OK

> 
>>   	} else if (page) {
>>   		memcpy_from_page(kaddr, page, offset, bv.bv_len);
>>   	} else {
>>   		memset(kaddr, 0, bv.bv_len);
> 
> And why the above change my if/else cascade doesn't really make much sense
> any more and this should become:
> 
> 	} else {
> 		if (page)
> 	 		memcpy_from_page(kaddr, page, offset, bv.bv_len);
> 		else
> 	 		memset(kaddr, 0, bv.bv_len);
>   	}
OK, I will send a new version soon.

Thanks for the review!
Kuai

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> .
> 

