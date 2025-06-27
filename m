Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C28BEC;
	Fri, 27 Jun 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750994139; cv=none; b=s4HsqlwcFT+QpeooNHb4CURQtQW75ixm2kadqAVbK55Q7fQxJtQ4JrlwlJ0U+CejnxrevBKPsFtabsHtVrNACIybyqc6u3yp/pelCPU6qoICAoKgBqwUmbq2zvizKOuIopVweOvDTh0/XkqWvmH+3ZYdbMQ0266+6UlyCpp2+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750994139; c=relaxed/simple;
	bh=a0CGExzVudbjEs/7OpmdV+QtDD9QXm5eiAJ65IEE+zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8sqTD0DWh5J2klEWV6PvPVPDFJa4Kz0L8mzlHPJdQYiY/Bx0zoFetEBoifOuukRHePxSV3sV55TYa1XFMCZb48b6qGqJzRdT8CKLHaXBhvPZxsZLHu1C8svJLDqjF4kLFj9QwyR4aRxhkl31aE329cXx0tXwZp47XHlTDLmOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bT1062dPSzYQtr2;
	Fri, 27 Jun 2025 11:15:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4348A1A1342;
	Fri, 27 Jun 2025 11:15:33 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8LRDF5oYa0bQg--.13049S3;
	Fri, 27 Jun 2025 11:15:31 +0800 (CST)
Message-ID: <ad6d0fd9-1260-4c55-a440-472d6a228536@huaweicloud.com>
Date: Fri, 27 Jun 2025 11:15:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix uaf in nbd_genl_connect() error path
To: Zheng Qixing <zhengqixing@huaweicloud.com>, josef@toxicpanda.com,
 axboe@kernel.dk, xiubli@redhat.com, prasanna.kalever@redhat.com,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, zhengqixing@huawei.com
References: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3F8LRDF5oYa0bQg--.13049S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43XF4rXw43urWUCrW3KFg_yoW5uFyxpF
	sxGFZ7CrW8ua40gaykCw1UuF15t3W7Xry3KryxJw15ZF9xAr4j9F9Y9a45XF4UKry8uFy7
	AFnFqrWxK3WUKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Gentle ping.


Thanks,

Qixing


在 2025/6/12 21:24, Zheng Qixing 写道:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> There is a use-after-free issue in nbd:
>
> block nbd6: Receive control failed (result -104)
> block nbd6: shutting down sockets
> ==================================================================
> BUG: KASAN: slab-use-after-free in recv_work+0x694/0xa80 drivers/block/nbd.c:1022
> Write of size 4 at addr ffff8880295de478 by task kworker/u33:0/67
>
> CPU: 2 UID: 0 PID: 67 Comm: kworker/u33:0 Not tainted 6.15.0-rc5-syzkaller-00123-g2c89c1b655c0 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: nbd6-recv recv_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:408 [inline]
>   print_report+0xc3/0x670 mm/kasan/report.c:521
>   kasan_report+0xe0/0x110 mm/kasan/report.c:634
>   check_region_inline mm/kasan/generic.c:183 [inline]
>   kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>   instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>   atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
>   recv_work+0x694/0xa80 drivers/block/nbd.c:1022
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3319 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
> nbd_genl_connect() does not properly stop the device on certain
> error paths after nbd_start_device() has been called. This causes
> the error path to put nbd->config while recv_work continue to use
> the config after putting it, leading to use-after-free in recv_work.
>
> This patch moves nbd_start_device() after the backend file creation.
>
> Reported-by: syzbot+48240bab47e705c53126@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68227a04.050a0220.f2294.00b5.GAE@google.com/T/
> Fixes: 6497ef8df568 ("nbd: provide a way for userspace processes to identify device backends")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   drivers/block/nbd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7bdc7eb808ea..2592bd19ebc1 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2198,9 +2198,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   				goto out;
>   		}
>   	}
> -	ret = nbd_start_device(nbd);
> -	if (ret)
> -		goto out;
> +
>   	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
>   		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
>   					  GFP_KERNEL);
> @@ -2216,6 +2214,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   		goto out;
>   	}
>   	set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags);
> +
> +	ret = nbd_start_device(nbd);
>   out:
>   	mutex_unlock(&nbd->config_lock);
>   	if (!ret) {

