Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D88C147;
	Mon, 11 Aug 2025 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874266; cv=none; b=fl9RvafSYRbKZ37g/BsmfT6OLVP8jCnxrvpSBW+t3eyB2eYe8ObCky4n/Y8opQ4ZgqNrfKpTR4j28tIELYDUPhrNCfi/acxigv1zrW6AGaBdbDX7I81Z/PnU3xULwoeYhcqGihuPj4MDFRAnxGgMapY0yo+FcQ8tblln9Gu4XYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874266; c=relaxed/simple;
	bh=p8yqQhQyohRX96oJqy3VRATJYn+EzphDxYBXqNyb7IA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MBj0EBGE/pbHFTgzr/Vt4LQQ5h3Ixd5QdUSHVE+hk8jbCLWz+5YH7kU+cwTlV/Uy1SWJ2Eg6LULHouT/0WRwD+ZWbw/VkWAJ8zTxInMWP/m0xfIFEZAAfQalV7OxM7obko7l4vfETHWEL/BHA2n9P/4G/j6bgPY8O1WAKOXbv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c0bxq4ZSgzKHMky;
	Mon, 11 Aug 2025 09:04:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE3D51A07BD;
	Mon, 11 Aug 2025 09:04:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxSNQZloAJcWDQ--.24074S3;
	Mon, 11 Aug 2025 09:04:14 +0800 (CST)
Subject: Re: [PATCH v2] block: fix kobject double initialization in add_disk
To: Christoph Hellwig <hch@infradead.org>,
 Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, zhengqixing@huawei.com, lilingfeng3@huawei.com,
 nilay@linux.ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
 <aJi1-l0ye4Xxv3IH@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <635971f1-1797-c343-a0c0-5a71336548a5@huaweicloud.com>
Date: Mon, 11 Aug 2025 09:04:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJi1-l0ye4Xxv3IH@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxSNQZloAJcWDQ--.24074S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xJFy3KFWDGw47Zr1DZFb_yoWxAFb_Cr
	ySv34xJws8JF40ga17KrsxXrs7C3yUXrsrXFZ2qr97W34Fv398u3Wvk39I93W8Gw1YqFWY
	9F1aqF98JwnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb_Ma5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/10 23:08, Christoph Hellwig Ð´µÀ:
> On Fri, Aug 08, 2025 at 01:36:09PM +0800, Zheng Qixing wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> Device-mapper can call add_disk() multiple times for the same gendisk
>> due to its two-phase creation process (dm create + dm load).
> 
> We'll need to fix that, instead of adding complex workarounds in the
> block layer for something that should not happen.
> 
AFAIK, a thorough will require complex refactor in the device mapper,
I feel it's better to fix the regression the easy way first, and it's
better for backport. Or do you have any suggestions how to fix this?

Thanks,
Kuai

> 
> .
> 

