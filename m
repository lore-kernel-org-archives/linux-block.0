Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47042A9D;
	Wed, 27 Aug 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256046; cv=none; b=amOcyDQn9e/Y7qptGqNVCyBcJW5ObEqZsSjVfq7qzXJ4xWWIcJhml/4IM3nmAcA/8yYWg05FB1yzmtnBwN6hVW0nrPDbTOyWIUMY15ToYvcJ8oKDvrXf6EfdMktO1ELbhaB1MJ6iWaEa6CQ9H30y6F/MXBYIwhFcvI+yUghQvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256046; c=relaxed/simple;
	bh=wTOrv3R+1cJ3rwnjaO6UN6kDblKf2sZTyq3X+JAAOiE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s0o6EAGj8fyoyYZ7t660pQbkATfYhurv9+VP18B0c1fsNHGfi6tKDS8ojt2E76XXgHpbYD/Cnx9FI517RRd3n32s81HpGNvz41LRMGgOyXGd1vr6Fo+O0DzVvTtoAp3hdsq0FR3OfZobLyIEH4ZFNXR4IKoLEvzC1fS2IsSJZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cBQyc6RLMzKHMd0;
	Wed, 27 Aug 2025 08:54:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 871641A0F53;
	Wed, 27 Aug 2025 08:54:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY4mV65oCMasAQ--.45648S3;
	Wed, 27 Aug 2025 08:54:00 +0800 (CST)
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: linan666@huaweicloud.com, axboe@kernel.dk, ming.lei@redhat.com,
 jianchao.w.wang@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bcbeb44e-3901-1b5c-e807-98f6b10df214@huaweicloud.com>
Date: Wed, 27 Aug 2025 08:53:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250826084854.1030545-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY4mV65oCMasAQ--.45648S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17Wr47GF13ur1fury7trb_yoW8Gry3pF
	s3G3Wag34Utr4UAa12va12gFyYkF4kAr97XrZ3Jr1Ig3yUurnYgr4qyr4jqFW8KFZ3CFWI
	q3WUJw4fGa18uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/26 16:48, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> In __blk_mq_update_nr_hw_queues() the return value of
> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> fails, later changing the number of hw_queues or removing disk will
> trigger the following warning:
> 
>    kernfs: can not remove 'nr_tags', no directory
>    WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
>    Call Trace:
>     remove_files.isra.1+0x38/0xb0
>     sysfs_remove_group+0x4d/0x100
>     sysfs_remove_groups+0x31/0x60
>     __kobject_del+0x23/0xf0
>     kobject_del+0x17/0x40
>     blk_mq_unregister_hctx+0x5d/0x80
>     blk_mq_sysfs_unregister_hctxs+0x94/0xd0
>     blk_mq_update_nr_hw_queues+0x124/0x760
>     nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>     nullb_device_submit_queues_store+0x92/0x120 [null_blk]
> 
> kobjct_del() was called unconditionally even if sysfs creation failed.
> Fix it by checkig the kobject creation statusbefore deleting it.
> 
> Fixes: 477e19dedc9d ("blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/blk-mq-sysfs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

