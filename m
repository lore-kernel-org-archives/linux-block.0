Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58C204080;
	Thu, 13 Feb 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417911; cv=none; b=MpR4wunVcsHt3PhhyT9gc2lvuNL8BVBcnV0XDpUZMvsSAGaShT6Ots6JrpyGIFvBJJ0KFORI/XTvmUahhx/Uhd2sgsf3nzqA2kYgElO2dFVx+VLhlVQoz1aeevrG6t/Rhh0uv1JA3DvdjUL2l15riOLCGWY5R/flc4Z9xnA+ZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417911; c=relaxed/simple;
	bh=YvUP2oYZOBIz7MiyhBYXzlL7FDycSv4JpNWjTW0Rvto=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dpn5iT8Nrr9qcemYoQhck18dDmQNsQWoF0sinzK80InQapLYRQTbg9Try5iIMBj7swwCm09EKAx6ZiPj8rHfzvUoTwKZZt+f7oj10gXgx4oGCmVwOvUKfe4i/+cmtaRw2XgcSsP/CeleWAONhVqnGHjCb0BOL3jTFV67ccQhb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ytgqz5gsQz4f3jks;
	Thu, 13 Feb 2025 11:38:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D96801A08B5;
	Thu, 13 Feb 2025 11:38:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul4uaa1nrzvKDg--.9280S3;
	Thu, 13 Feb 2025 11:38:23 +0800 (CST)
Subject: Re: [PATCH] block: Modify the escape character
To: Donglei Wei <veidongray@qq.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <tencent_208A5FC4C96DBFC52E02FC3CC394272EFB0A@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f5182f1c-eec9-9144-114c-1bdbd2571990@huaweicloud.com>
Date: Thu, 13 Feb 2025 11:38:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_208A5FC4C96DBFC52E02FC3CC394272EFB0A@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul4uaa1nrzvKDg--.9280S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyktr4xCr1xtr4UCr1rZwb_yoW8Xr1DpF
	W5GasxA39F9w4IgF1DGa1avrnav3ZIqa1SqrsIgw4Ykr13WwnF9F1kAryqyFWkuF4xtr4f
	XFsagFyDtw1Duw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

Please change the title.

ÔÚ 2025/02/09 20:35, Donglei Wei Ð´µÀ:
>      The iocg->cfg_weight/WEIGHT_ONE code has a data type of long unsigned int,
>      which is escaped using %u, which generates a compilation warning.
> 
>      Signed-off-by: Donglei Wei <veidongray@qq.com>
> ---

I never see this warning, is this because USEC_PER_MSEC is long, causing
other fields in the same enum to be long?

Thanks,
Kuai

>   block/blk-iocost.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 65a1d4427ccf..693e642d4235 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3078,7 +3078,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>   	struct ioc_gq *iocg = pd_to_iocg(pd);
>   
>   	if (dname && iocg->cfg_weight)
> -		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
> +		seq_printf(sf, "%s %lu\n", dname, iocg->cfg_weight / WEIGHT_ONE);
>   	return 0;
>   }
>   
> @@ -3088,7 +3088,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
>   	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
>   	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
>   
> -	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
> +	seq_printf(sf, "default %lu\n", iocc->dfl_weight / WEIGHT_ONE);
>   	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
>   			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
>   	return 0;
> 

