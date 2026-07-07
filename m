Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495821386C9;
	Tue,  7 Jul 2026 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397795; cv=none; b=uUur5iYDWtZKeXPJLwD0uax5FkVdBSgnb6/Ow3kYvQp0yxk4EVeXkWlCIQqzpMVb/mYlWfJ/4SUET2nT38+kOD6yXtvPgsMEifQkpfULWiWhSJAEePECgqdDPUL/peka/zuskGBXUgIuh+3zP2aBABL+XyntFjbF8TMl3fvLLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397795; c=relaxed/simple;
	bh=yPB1qQAo2YKyrfBFTU3zn2/qTf8euUAWSo0o5zaGY9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxpmglbV2gB/0SMQC4x9ZFHuJ8S+XQRsIIfJWA/bPBt97AS7V4dY3esO6SVvHzCQxNV7XgT9ABSMOID+C5UegrNyxmPuqKSZaQVrFDuUEpocdxp3tuxuE9h1kZS85g8Lx8Ix2bH1gUFYFEE4mEz8+z0wmL6dl6PLuyost28mEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwKULv8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwKULv8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2706B1F000E9;
	Tue,  7 Jul 2026 04:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783397793;
	bh=DNYrtg9ouhD1UCkr2Oc3ploskcIbVJXx+Zuka9SPV0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UwKULv8TtiubjasgEoM0VDiBlCsXe9aR0T9CJZQawQNpQNynDsyYU6abmp640O1sb
	 eMMEoOXg5NWRJS1vyUUc3pNKY3x1tJGUeAHhhwtAsX5EC5DTqpQQzA/28gL5gmDg6I
	 U3+6QwdzlrkasiBPcvvYUJkAuui3aTplXdwdzyMMERmoiJAoePgFaVy2qIrZpwQOP/
	 rdR4GKf91FOaFP6ga6OR8SiAG2iuY23jblxyxTY1FvLFUUTSpEHaiXyA5SL/RzsHpj
	 tgdR6yseVps1ZYKKsfGliqybz/A/eYXtY61f8IG8/RqLTQu+e2dk0N/X0gnUwcGcp6
	 U1XES8swhNwAA==
Message-ID: <0ab391b1-20e2-4ae9-a606-7111014e489c@kernel.org>
Date: Tue, 7 Jul 2026 13:16:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] null_blk: give the file-scope mutex a descriptive
 name
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-3-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-3-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The file-scope lock mutex serializes access to global null_blk state,
> including the nullb_list and device creation/removal. Rename it to
> "nullb_global_lock" to make its purpose clear. No functional change.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eba204b27785..98f6935bb502 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -66,7 +66,7 @@ struct nullb_page {
>  #define NULLB_PAGE_FREE (MAP_SZ - 2)
>  
>  static LIST_HEAD(nullb_list);
> -static DEFINE_MUTEX(lock);
> +static DEFINE_MUTEX(nullb_global_lock);

Since this seem to protect only the device list, why not simply call this
nullb_list_lock ?

>  static int null_major;
>  static DEFINE_IDA(nullb_indexes);
>  static struct blk_mq_tag_set tag_set;
> @@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
>  {
>  	int ret;
>  
> -	mutex_lock(&lock);
> +	mutex_lock(&nullb_global_lock);
>  	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> -	mutex_unlock(&lock);
> +	mutex_unlock(&nullb_global_lock);

Nothing in nullb_update_nr_hw_queues() touches the device list. So it is very
odd that nullb_global_lock is used for serialization here instead of a
nullb_device mutex. If you change this, why not a prep patch to introduce such a
mutex ?

>  
>  	return ret;
>  }
> @@ -435,9 +435,9 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>  {
>  	int ret;
>  
> -	mutex_lock(&lock);
> +	mutex_lock(&nullb_global_lock);
>  	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
> -	mutex_unlock(&lock);
> +	mutex_unlock(&nullb_global_lock);

Same here.

>  
>  	return ret;
>  }


-- 
Damien Le Moal
Western Digital Research
