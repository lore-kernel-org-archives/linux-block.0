Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3D25B09D;
	Sat, 15 Aug 2026 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786759355; cv=none; b=STWNpRZUZdcXP2PPkqrghNx/Vn2vpUJppQWwea/z5B6jCXteeJZ6/b60H0k8LFThn62aQVZvx5MBEfc8tbiecOqBjrhJWrXUY2aWeDaNAXWLbmARoE96f7llHnI0b9nZ6Q+8LhhJvJKQwxpxaYuGAFRctDeYZLZZUaHWvFj4Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786759355; c=relaxed/simple;
	bh=zHcP/5fUAscFS77ze1yaVnPox+MdrRD0d3h9RoOK0G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPEC+o2YPu25b5Gj6Ng2pidknniQjLAgmflIpuhQWTSwV0tZ8aY32E/WZ22Z3JBrE4c9ZmfnhbwS6GvKQQ6CeJxyWlj0yYbX6DxC3JUFQVXjMMW4uQat/6WGAMbKTrbpCtIrPnjkfd4p4kVnwqzvXO8NsqGoRhIymW1u9byIpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hMMmF4QldzKHMR8;
	Sat, 15 Aug 2026 10:02:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 75C95405B0;
	Sat, 15 Aug 2026 10:02:27 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kWtyH9qvolrCQ--.4530S3;
	Sat, 15 Aug 2026 10:02:24 +0800 (CST)
Message-ID: <f960076e-727d-4c5a-ac42-8f0f7a3079b0@huaweicloud.com>
Date: Sat, 15 Aug 2026 10:02:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nullb: free zones when device is power-off
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, shli@fb.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6a7e5b5b.f70deec7.2acc03.000e.GAE@google.com>
 <tencent_2E6878C66E4C2CC96EFC9650EA82ECFACF0A@qq.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <tencent_2E6878C66E4C2CC96EFC9650EA82ECFACF0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD35kWtyH9qvolrCQ--.4530S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17KF4Utw4ftr1rAr15XFb_yoW5JrW7pF
	W5KF45Kryvy3WUAFsrW3WFgFyrua1kA3yUWry7AwnY9a45Ar9Ikr9Fva45XF4DJ395Cr4S
	qFn8Za95Ja4UWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi, Edward

在 2026/8/14 16:21, Edward Adam Davis 写道:
> A user powers off the device by writing 0 to `./config/nullb/nullb1/power`
> via the nullb configfs interface, and later powers it on by writing 1
> to the same file.
> 
> When the power-off command is executed, the zones created by the previous
> task are not freed before new zones are created upon powering on again;
> this results in the memory leak described in [1].
> 
> Add an operation to free zones within nullb_device_power_store().
> 
> [1]
> BUG: memory leak
> unreferenced object 0xffff888126990000 (size 56000):
>    backtrace (crc 5c9573f8):
>      null_init_zoned_dev+0x108/0x520 drivers/block/null_blk/zoned.c:94
>      null_add_dev+0x8a6/0xae0 drivers/block/null_blk/main.c:1993
>      nullb_device_power_store+0xf9/0x1f0 drivers/block/null_blk/main.c:501
>      flush_write_buffer fs/configfs/file.c:207 [inline]
>      configfs_write_iter+0x10d/0x1a0 fs/configfs/file.c:229
>      new_sync_write fs/read_write.c:595 [inline]
>      vfs_write+0x3ac/0x720 fs/read_write.c:687
> 
> Fixes: cedcafad8277 ("nullb: add interface to power on disk")
> Reported-by: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f57d67a92532a98a562d
> Tested-by: syzbot+f57d67a92532a98a562d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   drivers/block/null_blk/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..fb001d002d17 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -511,6 +511,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
>   		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
>   			dev->power = newp;
>   			null_del_dev(dev->nullb);
> +			null_free_zoned_dev(dev);
>   		}
>   		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>   	}

Thanks for the patch. This issue has already been addressed in my
null_blk series posted back in July:

https://lore.kernel.org/all/20260725022509.714271-6-
wozizhi@huaweicloud.com/

The series has already collected some Reviewed-by tags but hasn't been
merged yet. After it, null_free_zoned_dev() no longer needs to be called
from null_free_dev(), so this fix is handled differently there.

Thanks,
Zizhi Wo

