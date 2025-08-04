Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DE17A2FA;
	Mon,  4 Aug 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293916; cv=none; b=kuOXvOtBlOVI2RbnSIhstWzoHL3V8+PnbrqXrPQu2WsI/zzYy7jRl4/0X7jU7niGQgM0be+GwvbsRRtfmWYuyUgdE5YhPo4H3Fq8W6DBUrcUno5imNyAMPkvkzvMdCM0euLtdyH7yd+E77X8rDOa4UyG1mmYiIxLrPasdBM8etQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293916; c=relaxed/simple;
	bh=LrG+/tvtivwg0ZcBSe2od2nC/VpaBwV8LhuTSc+IHkI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C1eSMMr/0ItUmtuabku6ubeZ4jjHbDi0Eb2Dd6qBEPeSchE1p0Ni/F/uGAWeYqrH/vcmxsxeWJafgcl+Uw8qfyRlLDyw5aXp9JCgVVkgJRSSXAApnWXBaDGWsvlisg0i7oftJnLr70nhedMqaHhHJp3JeUplGiRxeCzGL8JbT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bwTKM3Ts2zKHMSj;
	Mon,  4 Aug 2025 15:51:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C10A1A0359;
	Mon,  4 Aug 2025 15:51:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBGUZpBoQBoXCg--.28613S3;
	Mon, 04 Aug 2025 15:51:50 +0800 (CST)
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
To: Ujwal Kundur <ujwal.kundur@gmail.com>, axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250803134114.2707-1-ujwal.kundur@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e312219e-aa6c-a9a6-fa01-cf38435010be@huaweicloud.com>
Date: Mon, 4 Aug 2025 15:51:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250803134114.2707-1-ujwal.kundur@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBGUZpBoQBoXCg--.28613S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13CrWDAFyUZryDWFy5XFb_yoW8KFyDpF
	ZxWFs0k340vr1v93WUta47GF18Gw1DWFyIkryxJFy2vrnFyr9rtr18KFyxurW0yrZ7urs2
	qa1qqFsxur48AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/03 21:41, Ujwal Kundur Ð´µÀ:
> A potential unsafe locking scenario presents itself when
> mutex_lock(&disk->open_mutex) is called with reader's lock held on
> update_nr_hwq_lock:
>         CPU0                    CPU1
>         ----                    ----
> rlock(&set->update_nr_hwq_lock)
>                                 lock(&nbd->config_lock);
>                                 lock(&set->update_nr_hwq_lock);
> lock(&disk->open_mutex)
> 
This problem is already fixed inside nbd by:
8b428f42f3ed ("nbd: fix lockdep deadlock warning")

Thanks,
Kuai
> When the gendisk is added back concurrently, a writer's lock is
> attempted to be held on update_nr_hwq_lock while holding other locks in
> the call-path, becoming a potential source of deadlock(s).
> 
> Scope read-critical section to blk_unregister_queue, which is the only
> function that interacts with switching elevator and requires
> synchronization with update_nr_hwq_lock.
> 
> Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
> ---
>   block/genhd.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>   mode change 100644 => 100755 block/genhd.c
> 
> diff --git a/block/genhd.c b/block/genhd.c
> old mode 100644
> new mode 100755
> index c26733f6324b..b56f09f5699b
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -696,6 +696,7 @@ static void __del_gendisk(struct gendisk *disk)
>   	struct block_device *part;
>   	unsigned long idx;
>   	bool start_drain;
> +	struct blk_mq_tag_set *set = q->tag_set;
>   
>   	might_sleep();
>   
> @@ -740,7 +741,9 @@ static void __del_gendisk(struct gendisk *disk)
>   		bdi_unregister(disk->bdi);
>   	}
>   
> +	down_read(&set->update_nr_hwq_lock);
>   	blk_unregister_queue(disk);
> +	up_read(&set->update_nr_hwq_lock);
>   
>   	kobject_put(disk->part0->bd_holder_dir);
>   	kobject_put(disk->slave_dir);
> @@ -808,20 +811,15 @@ static void disable_elv_switch(struct request_queue *q)
>    */
>   void del_gendisk(struct gendisk *disk)
>   {
> -	struct blk_mq_tag_set *set;
>   	unsigned int memflags;
>   
>   	if (!queue_is_mq(disk->queue)) {
>   		__del_gendisk(disk);
>   	} else {
> -		set = disk->queue->tag_set;
> -
>   		disable_elv_switch(disk->queue);
>   
>   		memflags = memalloc_noio_save();
> -		down_read(&set->update_nr_hwq_lock);
>   		__del_gendisk(disk);
> -		up_read(&set->update_nr_hwq_lock);
>   		memalloc_noio_restore(memflags);
>   	}
>   }
> 

