Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5834C8F;
	Mon,  4 Aug 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268454; cv=none; b=XAPHzKklY5ohZGy3FKTbNK/5hXxdRG5a5m2Hf2PsFJ9KaKU+9gEw093eMnHSYigg5E5WI1ArdhZ1pbIW32/rnufBjA0P+nIkZS/jIjujW6JMLyTUo0UJ86fJgqCFagVu70xjbnS2+9iJ+QaY+d5kM30ok3Qj/J5kX8IJvaLPhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268454; c=relaxed/simple;
	bh=+/W9CYW0Yh+ewesGTTpIaOLJacb/3YZsvGB7zJPqPJ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sCvqyMM2rSLjqkK6VjKjOl87y1zuEnO05kkkNe4to+lLIvmmiNYe9VcErgv3fAdmRBLfZ/QSsSn8+AT8rONSeM/Ee1q2Ygy6hkAaK1yqE0oZOgLSNHv1TC8bhR2fbtM6HyS1zEsG3BKk+39jqFW8Znb21R8ARAevzRNSuHiUpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bwHvZ5rHfzKHMrx;
	Mon,  4 Aug 2025 08:47:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9B411A0A26;
	Mon,  4 Aug 2025 08:47:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERIYA5BouVP1CQ--.49366S3;
	Mon, 04 Aug 2025 08:47:21 +0800 (CST)
Subject: Re: [PATCH] block, bfq: Reorder struct bfq_iocq_bfqq_data
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ac0e993a-3e6d-6616-ce6c-03f0aa2429da@huaweicloud.com>
Date: Mon, 4 Aug 2025 08:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERIYA5BouVP1CQ--.49366S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr45XFy3uw1UXF15CFyUJrb_yoW8tr17pa
	n3Kw4j9FW8tw13Kr18ua1DXr93twnxXry7KFsrXryYyw1UGFnF9rn0ka4FvFy29rWkCFnr
	ZFyj9FyDWrsrKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/02 15:25, Christophe JAILLET Ð´µÀ:
> The size of struct bfq_iocq_bfqq_data can be reduced by moving a few fields
> around.
> 
> On a x86_64, with allmodconfig, this shrinks the size from 144 to 128
> bytes.
> The main benefit is to reduce the size of struct bfq_io_cq from 1360 to
> 1232.
> 
> This structure is stored in a dedicated slab cache. So reducing its size
> improves cache usage.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> On my system, struct bfq_io_cq are stored in 8 pages slab. Each of these
> slabs hold 24 entries.
> 
> $ sudo cat /proc/slabinfo | grep bfq_io
> bfq_io_cq            378    384   1360   24    8 : tunables    0    0    0 : slabdata     16     16      0
> 
> With the new layout, we should store 26 entries.
> (8 * 4096 / 1232 = 26.60)
> ---
>   block/bfq-iosched.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 687a3a7ba784..0b4704932d72 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -427,9 +427,6 @@ struct bfq_iocq_bfqq_data {
>   	 */
>   	bool saved_IO_bound;
>   
> -	u64 saved_io_start_time;
> -	u64 saved_tot_idle_time;
> -
>   	/*
>   	 * Same purpose as the previous fields for the values of the
>   	 * field keeping the queue's belonging to a large burst
> @@ -450,6 +447,9 @@ struct bfq_iocq_bfqq_data {
>   	 */
>   	unsigned int saved_weight;
>   
> +	u64 saved_io_start_time;
> +	u64 saved_tot_idle_time;
> +
>   	/*
>   	 * Similar to previous fields: save wr information.
>   	 */
> @@ -457,13 +457,13 @@ struct bfq_iocq_bfqq_data {
>   	unsigned long saved_last_wr_start_finish;
>   	unsigned long saved_service_from_wr;
>   	unsigned long saved_wr_start_at_switch_to_srt;
> -	unsigned int saved_wr_cur_max_time;
>   	struct bfq_ttime saved_ttime;
> +	unsigned int saved_wr_cur_max_time;
>   
>   	/* Save also injection state */
> -	u64 saved_last_serv_time_ns;
>   	unsigned int saved_inject_limit;
>   	unsigned long saved_decrease_time_jif;
> +	u64 saved_last_serv_time_ns;
>   
>   	/* candidate queue for a stable merge (due to close creation time) */
>   	struct bfq_queue *stable_merge_bfqq;
> 

