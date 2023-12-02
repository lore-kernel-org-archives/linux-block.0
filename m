Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF99D181;
	Sat,  2 Dec 2023 01:19:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sj4BP5ZLTz4f3kFv;
	Sat,  2 Dec 2023 17:19:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CFE961A07F3;
	Sat,  2 Dec 2023 17:19:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6d9mpldVEZCg--.44620S3;
	Sat, 02 Dec 2023 17:19:27 +0800 (CST)
Subject: Re: [PATCH next] trace/blktrace: fix task hung in blk_trace_ioctl
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 pengfei.xu@intel.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <00000000000047eb7e060b652d9a@google.com>
 <tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
Date: Sat, 2 Dec 2023 17:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6d9mpldVEZCg--.44620S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW7Jw1xXw1ktFyUZrW8JFb_yoW8CrW5pa
	yUGrsIkr95Ars8ta409w1fu397J3yv9FWUJr98Xr1rZ34DAryagF1Ivr4UurW8Kry8tFZ2
	yFy5Zr1F9w4UXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/12/02 17:01, Edward Adam Davis Ð´µÀ:
> The reproducer involves running test programs on multiple processors separately,
> in order to enter blkdev_ioctl() and ultimately reach blk_trace_ioctl() through
> two different paths, triggering an AA deadlock.
> 
> 	CPU0						CPU1
> 	---						---
> 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> 
> 
> The first path:
> blkdev_ioctl()->
> 	blk_trace_ioctl()->
> 		mutex_lock(&q->debugfs_mutex)
> 
> The second path:
> blkdev_ioctl()->				
> 	blkdev_common_ioctl()->
> 		blk_trace_ioctl()->
> 			mutex_lock(&q->debugfs_mutex)
I still don't understand how this AA deadlock is triggered, does the
'debugfs_mutex' already held before calling blk_trace_ioctl()?

> 
> The solution I have proposed is to exit blk_trace_ioctl() to avoid AA locks if
> a task has already obtained debugfs_mutex.
> 
> Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
> Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   kernel/trace/blktrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 54ade89a1ad2..34e5bce42b1e 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -735,7 +735,8 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>   	int ret, start = 0;
>   	char b[BDEVNAME_SIZE];
>   
> -	mutex_lock(&q->debugfs_mutex);
> +	if (!mutex_trylock(&q->debugfs_mutex))
> +		return -EBUSY;

This is absolutely not a proper fix, a lot of user case will fail after
this patch.

Thanks,
Kuai

>   
>   	switch (cmd) {
>   	case BLKTRACESETUP:
> 

