Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5681A2550;
	Tue, 10 Dec 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799303; cv=none; b=LArCJXSVaF62OINl/K3nhEj2A1HRYazScyIJ+R/fF6lVGaXGDVeWd3ATPbU8Y/GesYcpGn7+2hDI8LIyKrRNX2uI2YUe5bsapphgFyzxlyxQeMHU+I7YJ6Do0bKQdNJRROBzDV22r5pSJkIR/byR0009BT7OFtrB+W8om4TNrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799303; c=relaxed/simple;
	bh=8P3Z5n9VyHY++xUzrfQ7aEPq+kYAsNopEZVrvCpwDJ0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OnoSxsD5VqVoGvWQnMJgps1NdKwnJIKC28Tg2XBXKnInihgQA/ZbdlKEMjrYSAfVRWh4lRt6g0Dqxa6E00KIgJ3RwOzm67sDJyk1a4nC9Q4mxcyO+o8+3QYDDfYyNAD3Ky6CF/Fwvv+iglsmfK+uSTkYhoxtvzPEIA0JCeml6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6jxd4CB5z4f3lVp;
	Tue, 10 Dec 2024 10:54:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C8C821A1771;
	Tue, 10 Dec 2024 10:54:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoZ3rVdnCfKpEA--.28113S3;
	Tue, 10 Dec 2024 10:54:49 +0800 (CST)
Subject: Re: [PATCH RFC 2/3] lib/sbitmap: don't export sbitmap_get_shallow()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 ming.lei@redhat.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-3-yukuai1@huaweicloud.com>
 <87f569d6-fb17-4d3b-8075-1a74d11148a9@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <916dba91-07b9-23ef-4d40-21120c7287b3@huaweicloud.com>
Date: Tue, 10 Dec 2024 10:54:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87f569d6-fb17-4d3b-8075-1a74d11148a9@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoZ3rVdnCfKpEA--.28113S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtFWrZF1rXrW5GrWfGr1Utrb_yoW8Jr4rpF
	4xtFyUCr95t34j9wn7Xw4DXF93Zws3Gr9xGFnIgryFkr4DJ3Z7Zrn5CFZ5Aa47u3yrZF4f
	ZFZYy34fCr1UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/12/10 2:05, Bart Van Assche 写道:
> On 12/9/24 7:55 PM, Yu Kuai wrote:
>> -/**
>> - * sbitmap_get_shallow() - Try to allocate a free bit from a &struct 
>> sbitmap,
>> - * limiting the depth used from each word.
>> - * @sb: Bitmap to allocate from.
>> - * @shallow_depth: The maximum number of bits to allocate from a 
>> single word.
>> - *
>> - * This rather specific operation allows for having multiple users with
>> - * different allocation limits. E.g., there can be a high-priority 
>> class that
>> - * uses sbitmap_get() and a low-priority class that uses 
>> sbitmap_get_shallow()
>> - * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the 
>> low-priority
>> - * class can only allocate half of the total bits in the bitmap, 
>> preventing it
>> - * from starving out the high-priority class.
>> - *
>> - * Return: Non-negative allocated bit number if successful, -1 
>> otherwise.
>> - */
>> -int sbitmap_get_shallow(struct sbitmap *sb, unsigned long 
>> shallow_depth);
> 
> Please retain the above comment block by moving it into lib/sbitmap.c.
> 

Since the comment must be updated after patch 3, I'll apply the last
patch and update comment first, and do this cleanup at last.

Thanks,
Kuai

> Thanks,
> 
> Bart.
> .
> 

