Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20802FB2
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745890718; cv=none; b=A9PaG2fkO6eA3Z/oRogOf67dy97TWJe8WA2NE/HBS1eCI0+8YNeiXTiyFApmSLmuTHB139YaIOJEzGjsF6piMcEt3ygyWjsblPpCYBhP7NJO45xfaB94OkOCPhx0+awI8sOXinSi4eRhhkmGokb+ihWPpEV3ZWl02ObR4VNwjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745890718; c=relaxed/simple;
	bh=kXS7/kZVR001fMZ12batfBQDY1uf8Kby8PphRf8Yb5M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qdbnE4BDZwPJveM+m6T4qIBsBs02C6pjucdxk9U85VsbhJX9+pq1/HAldU4LkASvfoczAttrd+0MZmNTtb7uOMhNMb8BXZZbQFRAaTGlhNot0p+kAICFDhNDblJpCdfMkSsLVhmLZm7bvAZBmS4GNwsV8XgOl4ySsm64Tvn5wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zmjcz2qPxz4f3jt7
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 09:38:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49E821A0B19
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 09:38:30 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGCULRBoOduAKw--.54194S3;
	Tue, 29 Apr 2025 09:38:30 +0800 (CST)
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250428141014.2360063-1-hch@lst.de>
 <20250428141014.2360063-5-hch@lst.de>
 <aA_Dyp97AIAqJ70G@kbusch-mbp.dhcp.thefacebook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <221bce43-83b7-b5ac-c6d2-ded23158dd06@huaweicloud.com>
Date: Tue, 29 Apr 2025 09:38:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aA_Dyp97AIAqJ70G@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGCULRBoOduAKw--.54194S3
X-Coremail-Antispam: 1UD129KBjvdXoWrury3XF4fWF1xGFW5Jry3twb_yoW3Xrc_ZF
	n5Cr97KwsrAFWkJF4ft3sxAFyft3WFgry5tr48Xa13Ww1xJanxWF4v9ryfur1rGrnxtFn5
	Wwnag3yUAr4YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/29 2:07, Keith Busch Ð´µÀ:
> On Mon, Apr 28, 2025 at 07:09:50AM -0700, Christoph Hellwig wrote:
>> A lot of complexity in brd stems from the fact that it tries to handle
>> I/O spanning two backing pages.  Instead limit the size of a single
>> bvec iteration so that it never crosses a page boundary and remove all
>> the now unneeded code.
> 
> Doesn't bio_for_each_segment() already limit bvecs on page boundaries?
> You'd need to use bio_for_each_bvec() to get multi-page bvecs.

I think it only limit bvecs on page boundaries on the issue side, not
disk side.

For example, if user issue an IO (2k + 4k), will bio_for_each_segment()
split this IO into (2k + 2k) and (4k + 2k), I do not test yet, but I
think the answer is no.

Thanks,
Kuai

> 
> .
> 

