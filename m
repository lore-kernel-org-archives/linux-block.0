Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC214430;
	Mon, 14 Apr 2025 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599547; cv=none; b=Juxmk5MoJPkgeeXOdviL4dtlpCj7ghdkQGZcBNbV0NXzf8LUZky2WIsVV3z9j8JzwHsRk21brbmnhKf1dIepzUudmfARAU/q7YFILGHWUevfwcdBySyw4WZd4NUUiG3QHC2r1ZF1uD/5MoSHN2YJ0lsYM+bMDmSRCPBuugdHoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599547; c=relaxed/simple;
	bh=0Uat3Z9qI3tj26hR9Yuiu7497C+rbyEfaPyVTIQFlIo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qHY/3fZTSx8tEmLTTH4wu4oJeXTAmvAVq8qjFysnDD4vzBbrvZKOaw7hZPXVzUmtnFI/MzG5AH2kA04VxBl7u/1pD0KIetJah2qXUe5fn9iHMZkfFqojoov1OgADiuyRc17y1z8/lscXrsvjYH/eDFcKrfh5mg+wRkwJlxbUunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZbX6f1G8Yz4f3jZd;
	Mon, 14 Apr 2025 10:58:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 676361A01A2;
	Mon, 14 Apr 2025 10:58:52 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCH61_qefxn74evJQ--.17968S3;
	Mon, 14 Apr 2025 10:58:52 +0800 (CST)
Subject: Re: [PATCH] block: fix resource leak in blk_register_queue() error
 path
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, zhengqixing@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250412092554.475218-1-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b34d9107-bf6b-163e-9e8c-9e903565bb26@huaweicloud.com>
Date: Mon, 14 Apr 2025 10:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250412092554.475218-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH61_qefxn74evJQ--.17968S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW5Zr4xXw17uw1DXFy7KFg_yoWkWFc_Kr
	yFkr1xWws3Jr4fWF12kF18ZF43C3ykJF4xWFWUXF90q3Z7JFn5GwsruF1rJr42gan7uFs8
	Cr18WryUZry0yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/12 17:25, Zheng Qixing Ð´µÀ:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> When registering a queue fails after blk_mq_sysfs_register() is
> successful but the function later encounters an error, we need
> to clean up the blk_mq_sysfs resources.
> 
> Add the missing blk_mq_sysfs_unregister() call in the error path
> to properly clean up these resources and prevent a memory leak.
> 
> Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>   block/blk-sysfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index a2882751f0d2..1f9b45b0b9ee 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -909,6 +909,8 @@ int blk_register_queue(struct gendisk *disk)
>   out_debugfs_remove:
>   	blk_debugfs_remove(disk);
>   	mutex_unlock(&q->sysfs_lock);
> +	if (queue_is_mq(q))
> +		blk_mq_sysfs_unregister(disk);
>   out_put_queue_kobj:
>   	kobject_put(&disk->queue_kobj);
>   	return ret;
> 

