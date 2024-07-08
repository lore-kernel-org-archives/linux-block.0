Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421C2AF05;
	Mon,  8 Jul 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444497; cv=none; b=ZuAQT78qp3uzOcZSnXzAkc+yYuNfdLEsRQhxG7oJls0vsUQv4ZluidLypjG9kA4EwHuxYvFHBIyIuBNhMGAF57cQB6yvmQkKM3dqm8PiVxN/6KbZB331KAFSgXV4Vv8pXrWQqtJudsSIyj4sABGLVhHFk3Zy4UWMbIwftHEWf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444497; c=relaxed/simple;
	bh=m1fXyXqwx2KFFZE/0GK5tUG2v7NXfLNQ0nL+TMoXgb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghvFS+TpeseoMaEUKhi60wyTv73PGuCm5lkiSr0cwlaFMC/uef/Shb43b5jH6YJKGnplDPcFtFJA90ilSQp3/2HqkuwBq828LTkO2hIIEzjlWYVLAgchS4/h6bsMxFwbeg7sfQaCqmRzKaNZLTciFg6iRTghlTmt9Z5z7bitsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WHl2h4vMjz4f3lg7;
	Mon,  8 Jul 2024 21:14:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 712A21A0184;
	Mon,  8 Jul 2024 21:14:49 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgCnD4VF5otm3NscBg--.12840S3;
	Mon, 08 Jul 2024 21:14:47 +0800 (CST)
Message-ID: <e4a4a9a2-a7a7-67e6-a2ca-31f016fd3e2e@huaweicloud.com>
Date: Mon, 8 Jul 2024 21:14:45 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
To: linan666@huaweicloud.com, axboe@kernel.dk
Cc: czhong@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240603065350.1619493-1-linan666@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240603065350.1619493-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnD4VF5otm3NscBg--.12840S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWDAFy5KF1UXw4rCF15Arb_yoW8Kr1rpF
	Z5Gw1xKrWkJa1UZa17twnrJry5W3WUKFy7WrsxJa4fWa90yr9xA3y3Ga1jgFZrK34xWFyU
	JF4Dua4S93WUJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping...

在 2024/6/3 14:53, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
> 
> When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
> first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
> WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
> issue.
> 
> Fix it by adding the check in ublk_ctrl_start_recovery() and return
> immediately in case of zero 'ub->nr_queues_ready'.
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000028
>    RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
>    Call Trace:
>     <TASK>
>     ? __die+0x20/0x70
>     ? page_fault_oops+0x75/0x170
>     ? exc_page_fault+0x64/0x140
>     ? asm_exc_page_fault+0x22/0x30
>     ? ublk_ctrl_start_recovery.constprop.0+0x82/0x180
>     ublk_ctrl_uring_cmd+0x4f7/0x6c0
>     ? pick_next_task_idle+0x26/0x40
>     io_uring_cmd+0x9a/0x1b0
>     io_issue_sqe+0x193/0x3f0
>     io_wq_submit_work+0x9b/0x390
>     io_worker_handle_work+0x165/0x360
>     io_wq_worker+0xcb/0x2f0
>     ? finish_task_switch.isra.0+0x203/0x290
>     ? finish_task_switch.isra.0+0x203/0x290
>     ? __pfx_io_wq_worker+0x10/0x10
>     ret_from_fork+0x2d/0x50
>     ? __pfx_io_wq_worker+0x10/0x10
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
> Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
> Reported-and-tested-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
> v2: add the check to ublk_ctrl_start_recovery().
> 
>   drivers/block/ublk_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e159948c912..ebd997095b65 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2661,6 +2661,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
>   	mutex_lock(&ub->mutex);
>   	if (!ublk_can_use_recovery(ub))
>   		goto out_unlock;
> +	if (!ub->nr_queues_ready)
> +		goto out_unlock;
>   	/*
>   	 * START_RECOVERY is only allowd after:
>   	 *

-- 
Thanks,
Nan

