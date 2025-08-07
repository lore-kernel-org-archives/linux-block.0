Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E0233136;
	Thu,  7 Aug 2025 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556134; cv=none; b=hmEccP75gIEeGoDMElptySTwsPlbmKqT3fmfs3tPhXSRvnMDGPPfNjJ47w1DbL4jYuGj1ArwmmoM3LnDSI0lumWnfFuC2S9IG6qv5U8Z6ZWiQ2fjcep21lIee85+v0AN5GRgwnftwxyzluW9ZdJoQChzQ3AEQg0ROjhEwAVYl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556134; c=relaxed/simple;
	bh=ceE4sp7dfGFQHp6xj4DqCN/j5IW3NjDsuR8JWwW4VS4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T7GE34gb1YcHq9lycWrgYWTqyCv6Y48fyWOHdrbgsbCq2xrWFqhUYcAS1gQV5H2geDW5wqIIBgVPqdUn7kilEGBDJURyUSxwWQgJ6hSRqQrvitLhVzlcpjmjafAnofB0eCp1kQ6ekFYqZMNA/t7+gO0fKDiO2TZp4cPtTfNkETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byLJ11Cj7zKHMnF;
	Thu,  7 Aug 2025 16:42:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 40CC71A018D;
	Thu,  7 Aug 2025 16:42:08 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhPaZpRofnN1Cw--.19038S3;
	Thu, 07 Aug 2025 16:42:04 +0800 (CST)
Subject: Re: [PATCH] block: fix kobject double initialization in add_disk
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
 zhengqixing@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6b63027c-cdbb-5878-28ea-ef58de37fe03@huaweicloud.com>
Date: Thu, 7 Aug 2025 16:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhPaZpRofnN1Cw--.19038S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8trWxtF15ZF48Ary5urg_yoW8CF1fpw
	4agwnrGryvgrWxCwsrC3W7GFy8Wws5Wrs7Ars3Kr1FvrWxAr1qgF4DKwsFvFyDJr4I9F4S
	qF12va13tw15CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/07 15:20, Zheng Qixing Ð´µÀ:
> From: Zheng Qixing<zhengqixing@huawei.com>
> 
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load). This leads
> to kobject double initialization errors when the underlying iSCSI devices
> become temporarily unavailable and then reappear.
> 
> However, if the first add_disk() call fails and is retried, the queue_kobj
> gets initialized twice, causing:
> 
> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
> something is seriously wrong.
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5b/0x80
>    kobject_init.cold+0x43/0x51
>    blk_register_queue+0x46/0x280
>    add_disk_fwnode+0xb5/0x280
>    dm_setup_md_queue+0x194/0x1c0
>    table_load+0x297/0x2d0
>    ctl_ioctl+0x2a2/0x480
>    dm_ctl_ioctl+0xe/0x20
>    __x64_sys_ioctl+0xc7/0x110
>    do_syscall_64+0x72/0x390
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix this by separating kobject initialization from sysfs registration:
>   - Initialize queue_kobj early during gendisk allocation
>   - add_disk() only adds the already-initialized kobject to sysfs
>   - del_gendisk() removes from sysfs but doesn't destroy the kobject
>   - Final cleanup happens when the disk is released
> 
> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
> Reported-by: Li Lingfeng<lilingfeng3@huawei.com>
> Closes:https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
> Signed-off-by: Zheng Qixing<zhengqixing@huawei.com>
> ---
>   block/blk-sysfs.c | 4 +---
>   block/blk.h       | 1 +
>   block/genhd.c     | 2 ++
>   3 files changed, 4 insertions(+), 3 deletions(-)

LGTM, the kobject_init() is called when queue is allocated before the
fix tag.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

