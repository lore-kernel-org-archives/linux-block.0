Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E3216E32;
	Fri, 29 Aug 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448172; cv=none; b=j+LI+SLIZi5IOII7DJPG+hLeA3tHwrDDSKtDsu67PMfRI2ov5Q4/FRXMhZHLqgTIC+t1aW20NYoqrFLr8LKUlH8bcPlWdNdYa6nksEBCOhn7sw7j86YJnvNnEAJV6oXM9oQv9jpYpz0inN9TC3s//SG7BVVb2l8DN7p1gqrkdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448172; c=relaxed/simple;
	bh=VHHVMb8XgCPvYCPfC3eGNbcc1M15wSJqME8WVjJz3vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJWULgUlyICwEcK14diek0wyFTEjcsYVxe/Jhaqg+ptj3Y36j82KNM+XXT4L29zKSL0UFTJb1lCDB/C7yrz3p/y0s5Y65OHDrUeY0Bghjrrfy/2c3hBUEdDahXMLyTFY1RSzlF8Jpj9LecOJTujmqTHNG9jzMwaQx4lo/e10q8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cCp1M5SfGzYQtL4;
	Fri, 29 Aug 2025 14:16:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49BE81A0E11;
	Fri, 29 Aug 2025 14:16:06 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIykRbFoprasAg--.25285S3;
	Fri, 29 Aug 2025 14:16:06 +0800 (CST)
Message-ID: <d6702b7c-a674-6fb8-f326-acbd87b148bb@huaweicloud.com>
Date: Fri, 29 Aug 2025 14:16:04 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] block/mq-deadline: Remove the redundant rb_entry_rq in
 the deadline_from_pos().
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250829034505.95468-1-pilgrimtao@gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20250829034505.95468-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIykRbFoprasAg--.25285S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4rWr43ur4xKry8JrW7XFb_yoWDXFX_Gr
	WIkrZ7Cw48AFn5uws5CFy3XFW5t3W8K393C3WkGrWxA3WxW3WkCFyDJrn8Za97WFZ3Wa98
	C3sYvF47Krn8JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07Al
	zVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x07jb2-nUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/29 11:45, chengkaitao 写道:
> From: chengkaitao <chengkaitao@kylinos.cn>
> 
> In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
> was removed, but the "rb_entry_rq(node)" and some other code were
> inadvertently left behind. This patch fixed it.
> 
> Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
> ---
>   block/mq-deadline.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 1a031922c447..63145cc9825f 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -133,10 +133,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
>   	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
>   	struct request *rq, *res = NULL;
>   
> -	if (!node)
> -		return NULL;
> -
> -	rq = rb_entry_rq(node);
>   	while (node) {
>   		rq = rb_entry_rq(node);
>   		if (blk_rq_pos(rq) >= pos) {

LGTM

Reviewed-by: Li Nan <linan122@huawei.com>

-- 
Thanks,
Nan

