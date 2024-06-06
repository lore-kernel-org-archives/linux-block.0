Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B53CF73;
	Thu,  6 Jun 2024 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673694; cv=none; b=CGJaVY9Cv1vCECJCwl8PXCPW6Qf9UpbMl2KCWUMurSOhJqutPQKIOv5U0NMepRnpoohOwMh/4pxe6Q+WZa4fkpsay6cSmlzU59X9cckac8DCxRPgBMwl/MUeILoi6P961/crsTDz51UITkZWVuexbN+dqMBHbiqaogZtF7PLNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673694; c=relaxed/simple;
	bh=ALWHOh7G/hvm7z6dudM/aW1WhK6v9Gzl2sObnuSnWX4=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TMVdrgSx9Zr18Ym3FUtbR5KF6SeYmai+TZnYUChaVbqjaT0xAge/nElBjhb7RtPjGbhUGOfjGj/BSBG35OXYyYU/7SkhThB9AZpeVjZCRhnp82zey6Vrpyafp2jQDDigb8wfTBLABvUP4pQqvXUkR8yTgCZxGiSqezJeHNDEDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vw2L515cvz4f3nTK;
	Thu,  6 Jun 2024 19:34:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 574601A018A;
	Thu,  6 Jun 2024 19:34:48 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7XnmFmtDHnOg--.46212S3;
	Thu, 06 Jun 2024 19:34:48 +0800 (CST)
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
To: Christoph Hellwig <hch@infradead.org>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.lei@redhat.com,
 Ye Bin <yebin10@huawei.com>
From: yebin <yebin@huaweicloud.com>
Message-ID: <66619EB6.4040002@huaweicloud.com>
Date: Thu, 6 Jun 2024 19:34:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmFatW3BEzTPgR7S@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g7XnmFmtDHnOg--.46212S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5i7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
	8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUU
	U==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2024/6/6 14:44, Christoph Hellwig wrote:
> What kernel is this on?  As of Linux 6.9 we are now always freezing
v4.18
> the queue while updating the logical_block_size in the nvme driver,
> so there should be no inflight I/O while it is changing.
>
The root cause of the problem is that there is no concurrency protection 
between
issuing DIO checks in __ blkdev direct IO simple() and updating logical 
block sizes ,
resulting in the block layer being able to see DIOs that are not aligned 
with logical
blocks.

