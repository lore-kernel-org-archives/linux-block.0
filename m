Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA47A935
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572376; cv=none; b=AdX4o3ILAiSnYcOwZXtprr4vltMBdfUX/Rc7KZHw+IHDMU2Hnu4goc5xutPFv0iEgoKZn7y8uUepF0xRPS+w586p33esUZocQMyTZDrW+gNT1Tithz/UpFAKn2paRdOwcFyiJmQwso6Tm5brpci/BnqQuuWp9s4xjBXk0US6wo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572376; c=relaxed/simple;
	bh=7ZQ4pC9QJnUI5TRrnScH0WkQ0HBeVzzuHzZuwS1CHCw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nyXTX6RmY3QR/dct0j9KTRliNvJ2cAwwuK19VhV0xa2xb1HyJIGvmg/GvNIRkHDYaiFjlWSzTVddGv9jRbffE+QuwwMwTfzzxnUqTJUMMuwKvBFAVQ4jthSTOYyX6iUJkwdhym9FYjUXsg0wimrCqjePaLPs27RcQ9ghyv0Jfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZB0c0654Lz4f3jQd
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 10:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF08E1A1669
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 10:06:09 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCH618RSc5nLR0xGA--.63204S3;
	Mon, 10 Mar 2025 10:06:09 +0800 (CST)
Subject: Re: [PATCH] badblocks: Fix a nonsense WARN_ON() which checks whether
 a u64 variable < 0
To: colyli@kernel.org, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, Dan Carpenter <dan.carpenter@linaro.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250309160556.42854-1-colyli@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a7c5442-1fad-4cd5-dba8-9eb91e03b6a4@huaweicloud.com>
Date: Mon, 10 Mar 2025 10:06:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250309160556.42854-1-colyli@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH618RSc5nLR0xGA--.63204S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18tF45GF48Cr4rGrWkXrb_yoWktrX_Aw
	1F9FZ5Xrn5XFWYyw1Ykwn0qrZYkFyUCr10934Yyrs7XrZ5ta1DAF4rJFW5ArnxWFyxGFsI
	vFyfZrZIvw10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yE_t
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/03/10 0:05, colyli@kernel.org Ð´µÀ:
> From: Coly Li <colyli@kernel.org>
> 
> In _badblocks_check(), there are lines of code like this,
> 1246         sectors -= len;
> [snipped]
> 1251         WARN_ON(sectors < 0);
> 
> The WARN_ON() at line 1257 doesn't make sense because sectors is
> unsigned long long type and never to be <0.
> 
> Fix it by checking directly checking whether sectors is less than len.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Coly Li <colyli@kernel.org>
> ---
>   block/badblocks.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/badblocks.c b/block/badblocks.c
> index 673ef068423a..ece64e76fe8f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1242,14 +1242,15 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>   	len = sectors;
>   
>   update_sectors:
> +	/* This situation should never happen */
> +	WARN_ON(sectors < len);
> +
>   	s += len;
>   	sectors -= len;
>   
>   	if (sectors > 0)
>   		goto re_check;
>   
> -	WARN_ON(sectors < 0);
> -
>   	if (unacked_badblocks > 0)
>   		rv = -1;
>   	else if (acked_badblocks > 0)
> 

