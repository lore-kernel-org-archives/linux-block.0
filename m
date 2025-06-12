Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC291BC2A;
	Thu, 12 Jun 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735457; cv=none; b=gwCntKOaAXrUc26t/kSUohLrMyxOGKXU7gOhnptcgdMpsU6NzsCGLBuHmQIp06vP8yPXXbfdE96Dlric6PeMXwkikqEh3Ngj83IN2JEQRicrk90ykBXf9EG7Z7GIKEx2NTJr1E8m2rn2+iuALEP0ZG9UMv6ue5/ck0U39PRn+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735457; c=relaxed/simple;
	bh=aaey3Uz+j7q0vSfDmUJZDjBRcZyVcuXCOVxqyQYZO8E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nP0zLt2q+UX8Cm6lQPraJLGxaQJF+giqFwTUE8gHA1nPy6ZZd1Cq4ARGO8tlOOChmx334f3LRHYYp968QMaZSBLDJuWkoDQKcY1JxSTSk6AZKQzI3gkrjJoF71jQXvYFaGbWBKqf+ABI90vRJ5GfoL2tvIQwfSUzTPVg56HTaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bJ3Vh6zBWzYQvMX;
	Thu, 12 Jun 2025 21:37:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E8DB21A0D5D;
	Thu, 12 Jun 2025 21:37:31 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl8a2Epo7CMxPQ--.16770S3;
	Thu, 12 Jun 2025 21:37:31 +0800 (CST)
Subject: Re: [PATCH] nbd: fix uaf in nbd_genl_connect() error path
To: Zheng Qixing <zhengqixing@huaweicloud.com>, josef@toxicpanda.com,
 axboe@kernel.dk, xiubli@redhat.com, prasanna.kalever@redhat.com,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 zhengqixing@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c12c045b-fba4-c03d-1d2e-db90f6a5d76b@huaweicloud.com>
Date: Thu, 12 Jun 2025 21:37:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250612132405.364904-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl8a2Epo7CMxPQ--.16770S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWkKr13JFW8ZFyxXw1fZwb_yoW5GrWDpa
	nxG3s7CrW8u34vy395A3W8CFy8JF43Xr4fGryxJw13uFW3Ar4j9r9Y93Z8WFyDGry0vFy5
	AF9Fqry8K3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/06/12 21:24, Zheng Qixing Ð´µÀ:
> From: Zheng Qixing<zhengqixing@huawei.com>
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
> Reported-by:syzbot+48240bab47e705c53126@syzkaller.appspotmail.com
> Closes:https://lore.kernel.org/all/68227a04.050a0220.f2294.00b5.GAE@google.com/T/
> Fixes: 6497ef8df568 ("nbd: provide a way for userspace processes to identify device backends")
> Signed-off-by: Zheng Qixing<zhengqixing@huawei.com>
> ---
>   drivers/block/nbd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

