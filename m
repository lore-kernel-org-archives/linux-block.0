Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D12BAF9;
	Sat, 28 Jun 2025 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071723; cv=none; b=N0eCZ8C/80HYJyutKadWoCnBe7PPlkfpar/KRyT5171/xDIBstH0n7rcUewI8xclZ+R6oA+fypjeqcnxJXjnZ7nReX+/Fw9CiJEqki9UjnBeGac8hUEtgPeuN/ANmegfz+Rp8gKjpE/ryX+mlF80h9rWhXxygugE6i949ZxthOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071723; c=relaxed/simple;
	bh=S/1dj4c0e/92a+xcA9DUGE5FJr8PLpUKdBvTlmjRRic=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dGP3nu/a51XLTbgAshpQ04UZGFEekfWOG4FQMpYDZOC5UwVfPOA6htlBrq43yMm/YS2r74m9KcV2ZX8fGejiRkEIP8FcePVRvVRubw68CNy8ORVBjczZh+9j7Fet6C9SbmtM4K8z19V1c7TjNXgN66pNsldp+sT5QE1ukz9b+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bTYh66Z4QzKHMd5;
	Sat, 28 Jun 2025 08:48:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A8311A0EB9;
	Sat, 28 Jun 2025 08:48:37 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDhO19oJp97Qw--.50612S3;
	Sat, 28 Jun 2025 08:48:35 +0800 (CST)
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
 nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
Date: Sat, 28 Jun 2025 08:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aF56oVEzTygIOUTN@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGDhO19oJp97Qw--.50612S3
X-Coremail-Antispam: 1UD129KBjvdXoWrAw1fCFWrGr17JF43Zw1UKFg_yoWxGwc_u3
	WS9a40gr1jyrZ0y3s7Kwn7CrnrWw1xKFykJr40yr1xWr13X3yfK3yDGa45Xr1DXa1xuw1q
	vr9rCw4Igr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/06/27 19:04, Ming Lei Ð´µÀ:
> I guess the patch in the following link may be simper, both two take
> similar approach:
> 
> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/

I this the above approach has concurrent problems if nbd_start_device
concurrent with nbd_start_device:

t1:
nbd_start_device
lock
num_connections = 1
unlock
	t2:
	nbd_add_socket
	lock
	config->num_connections++
	unlock
		t3:
		nbd_start_device
		lock
		num_connections = 2
		unlock
		blk_mq_update_nr_hw_queues

blk_mq_update_nr_hw_queues
//nr_hw_queues updated to 1 before failure
return -EINVAL

Thanks,
Kuai

