Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539769C
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 03:12:48 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZMD921Xnz4f3lWC
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 19:12:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F77A1A051F
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 19:12:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6skFxlD7EgBg--.30692S3;
	Tue, 21 Nov 2023 19:12:45 +0800 (CST)
Subject: Re: [PATCH] block: move .bd_inode into 1st cacheline of block_device
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20231121101156.378105-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b07d6d9b-7926-d5b1-71ab-29640e2a84f8@huaweicloud.com>
Date: Tue, 21 Nov 2023 19:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231121101156.378105-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6skFxlD7EgBg--.30692S3
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUury5Aw18tw45GF15Jwb_yoW8Cw48pF
	sxur4xC3yvg3y7u34kC3WxZryfWa18Cw1Utryagr1FyFyaqF1vgF1kJr15AFW8CFZ2yr47
	tFnruFWrC34UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/11/21 18:11, Ming Lei Ð´µÀ:
> The .bd_inode field of block_device is used in IO fast path of
> blkdev_write_iter() and blkdev_llseek(), so it is more efficient to keep
> it into the 1st cacheline.
> 
> .bd_openers is only touched in open()/close(), and .bd_size_lock is only
> for updating bdev capacity, which is in slow path too.
> 
> So swap .bd_inode layout with .bd_openers & .bd_size_lock to move
> .bd_inode into the 1st cache line.

This patch looks good, do you want me do take it for a v3 for the
other patchset?

And by the way, can we also move 'int bd_writers' to near 'atomic_t
bd_fsfreeze_count' to save 8 bytes(int 64bit platform)?

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 07abd0165226..a47ab9249bdd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -63,11 +63,11 @@ struct block_device {
         int                     bd_holders;
         struct kobject          *bd_holder_dir;

+       int                     bd_writers;
         atomic_t                bd_fsfreeze_count; /* number of freeze 
requests */
         struct mutex            bd_fsfreeze_mutex; /* serialize 
freeze/thaw */

         struct partition_meta_info *bd_meta_info;
-       int                     bd_writers;

Thanks,
Kuai
> 
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/linux/blk_types.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d5c5e59ddbd2..f7d40692dd94 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -49,9 +49,10 @@ struct block_device {
>   	bool			bd_write_holder;
>   	bool			bd_has_submit_bio;
>   	dev_t			bd_dev;
> +	struct inode		*bd_inode;	/* will die */
> +
>   	atomic_t		bd_openers;
>   	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
> -	struct inode *		bd_inode;	/* will die */
>   	void *			bd_claiming;
>   	void *			bd_holder;
>   	const struct blk_holder_ops *bd_holder_ops;
> 

