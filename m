Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA623B0;
	Fri, 19 Jul 2024 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358930; cv=none; b=kOH31KRHPSySvIdcvgTjg2j8SFgy+bjqVQIcMnAsT9TQwfY4PEJHcLjUQL+a9fGM/R5QmM756nuDJO4Jnk2KPnt+JBU/B6AF7kfiLikdg/rArjE/MSeH3t7OJWcXgYPyd4UGbYNrfEj1k5+jDnLC+7cHrVQQU/EcvBaLFid1eL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358930; c=relaxed/simple;
	bh=9r9VaX7WBj33b5Ca1NQAzQZ6oU1wOpuKr2v2zJYbabs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DEekYo2AvblGgq5CJNogknS5OcItqjx+WAKmTjJ44Q99eQ9yRayFLZUnKpNhRNnExwZkaUsOL04lcGJw0Wf6fNiWIGrK1cMN6BKOQEuuIwK0BkL4kkliz+mymSmgP0jqWrrXh7MT1pRLiHS0jtlbORM1TDcAFVBxhVaZmIvzcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQFCy5R2Pz4f3kw9;
	Fri, 19 Jul 2024 11:15:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 130071A0F49;
	Fri, 19 Jul 2024 11:15:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHazlK2plmtZ4mAg--.58042S3;
	Fri, 19 Jul 2024 11:15:23 +0800 (CST)
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
To: Bart Van Assche <bvanassche@acm.org>, YangYang <yang.yang@vivo.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
 <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
 <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
 <a81cdd5b-d6ad-2a4f-0f6d-40e9db6233cd@huaweicloud.com>
 <51411297-f579-4229-a72c-c5bd5f27df34@vivo.com>
 <e7c95d49-d279-451c-9bd0-3f4009c7afcd@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <331c036b-322e-0658-ff88-4cce080c5aba@huaweicloud.com>
Date: Fri, 19 Jul 2024 11:15:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7c95d49-d279-451c-9bd0-3f4009c7afcd@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazlK2plmtZ4mAg--.58042S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWUXry7Gr4xGrykXF1kXwb_yoW3trc_uw
	1Yqr1DGa48ZF1vqrsIkw18GryUCa1fKF4xu3yvqFs8JFyxXwn8Zw4rGrZ09r1qqa1IvwnI
	gr4rWFWUKry7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



在 2024/07/18 0:23, Bart Van Assche 写道:
> On 7/17/24 3:15 AM, YangYang wrote:
>> These sysfs nodes are in different directories, the scsi node located
>> at /sys/bus/scsi/devices/0:0:0:0 and the gendisk node located at
>> /sys/block/sda. Would it be necessary to wait for the completion of
>> the scsi sysfs nodes' read/write operations before removing the
>> gendisk sysfs node?
> 
> No. sysfs_remove_files() waits for pending read and write operations to
> complete.
> 

So I check this and actually gendisk kobject is a child of scsi disk
kobject, not the other way. sda/device is just a symbol link.

sda/device -> ../../../14:2:0:0.

So, the sysfs api for gendisk itself doesn't issue IO, and as long as
related driver doesn't create new such api under gendisk, this won't
be a problem.

Thanks,
Kuai
> Bart.
> 
> .
> 

