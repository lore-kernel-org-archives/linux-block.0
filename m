Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39227781D
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494183; cv=none; b=AafpsJs6gGRKa/h14yfQ17cuxNXQSp/5HpCC0rbx2SkSh4a9Ni1zalY4QSaWIZp8Xtg8qEe8ntMnxMAFr2rZYiinP/fxPeHMbVHUS5tiqbfQRAcgUTI+guDwm+NQuu04QcRDAZmxkJyKotXEpjFmKh8lUu/ILNddwP/Li4OcpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494183; c=relaxed/simple;
	bh=qiTe14huLmlHiwl3FHYgs486rdlT3RT5flZF+uDmyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZB9dvEwb9Pp1L5A27w/IC4/mixA0YKk4bHPilOp/B1VTeC8xdOhIQUHSbyEngroEG3M6QDr4TJDCq5XbPU0nBcGQd1Yqx1tUCNEaf7es/+SyhMNeyRHDIvimGlY/uVYBKFqefA1aVzexgvlQljSpNkX9a1o0Vje6UYsOPlwFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zs0pX2PDnzKHMpS
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 09:16:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24DCF1A06E2
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 09:16:19 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2DiYhlosfg+Lg--.29341S3;
	Tue, 06 May 2025 09:16:19 +0800 (CST)
Message-ID: <8d87eb9d-bb04-4d9c-8c96-809032130d87@huaweicloud.com>
Date: Tue, 6 May 2025 09:16:18 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/7] blk-throttle: Split the blkthrotl queue to solve
 the IO delay issue
To: Jens Axboe <axboe@kernel.dk>, Zizhi Wo <wozizhi@huawei.com>,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com,
 tj@kernel.org
References: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
 <7df3b05d-0e44-43b5-9d79-687e6297136c@huawei.com>
 <0f5ae9f4-05fd-48d1-924a-66ae159389bd@kernel.dk>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <0f5ae9f4-05fd-48d1-924a-66ae159389bd@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2DiYhlosfg+Lg--.29341S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzV
	bUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/5/6 9:09, Jens Axboe 写道:
> On 5/5/25 7:04 PM, Zizhi Wo wrote:
>> friendly ping
> 
> It's not applying to the current 6.16 tree, please resend it.
> 
OK, I will quickly resend a new version.

