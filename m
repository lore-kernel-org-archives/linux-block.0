Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AF19E98E;
	Mon, 23 Sep 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113775; cv=none; b=JvnE18Uu1zfcs6a4aVSmkMD6ZZNL1aUiF8Ddc3gY3a51k3RO4H3n4fXsYIrIMhr/Zw8pCVpC7nAHiTGfWk372MhCulmcomy2TBVB8E22DaGy/ATKY3UeM8Ox+EIyHcglxOfDrG4Hmxug1tMsrbEVSLBnaPKNNgRya5PF8OsRGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113775; c=relaxed/simple;
	bh=fW/2G+S1k2HxLvPCQ/EgaFLF7W5MmBH3WEeAVb5ugJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYaXnpD2WnEQ9xjwGr0ZXYmqqjw7QAJYirChs+/ZR/4yTJBvqpPBRjYocNOWZB4v57L3QQzL9qZi3RxuOCTiugjCABlE2iLgE0HRk7KadJ96S56jD9R6At4s5lekB/ny29rgMj8wegMS8M1bEuj3bJMPSCyQmu4Od3eZvT0AniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Vj2GTC40; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Vj2GTC40"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id sn2xskkHDKyjDsn2xsMS1L; Mon, 23 Sep 2024 19:40:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727113228;
	bh=tA69b6jolyXcZI7KcLlBCkaVX/5x0DGi73pMrAgE16E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Vj2GTC40KZEfkWANLsirjwuwRTvW18DQUjoQXtxyvIXnFeyM6JR2DME7kwLNnqaTV
	 AMcJEoI5NKxrE66RkPZpveBPCYQatztilCPJqF/KYoxYoyCn0/hOllSifh5lq/gWZa
	 mWrdHpQ3E5+nyBn0TtBeY2F0T/zp92t1XHgShNmIkp1bxhttiOfu2Pdvi06DDysrvV
	 leWrWB4UBQD4KjyReF6dR4FI7G46gPiwm87iJ8UvUUGqRoLnPkMAM3Ln/VqnN0Vjvm
	 78hZ60nv3FpzsKWtrznDF+He003apMVOE+8AuM9u9VxnQutvNjA8+zyJfWFOvPzQSw
	 szQhA4W64cqVA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 23 Sep 2024 19:40:28 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
Date: Mon, 23 Sep 2024 19:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zram: don't free statically defined names
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/09/2024 à 18:48, Andrey Skvortsov a écrit :
> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
> default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
> so we need to make sure that we don't attempt to kfree() the
> statically defined compressor name.
> 
> This is detected by KASAN.
> 
> ==================================================================
>    Call trace:
>     kfree+0x60/0x3a0
>     zram_destroy_comps+0x98/0x198 [zram]
>     zram_reset_device+0x22c/0x4a8 [zram]
>     reset_store+0x1bc/0x2d8 [zram]
>     dev_attr_store+0x44/0x80
>     sysfs_kf_write+0xfc/0x188
>     kernfs_fop_write_iter+0x28c/0x428
>     vfs_write+0x4dc/0x9b8
>     ksys_write+0x100/0x1f8
>     __arm64_sys_write+0x74/0xb8
>     invoke_syscall+0xd8/0x260
>     el0_svc_common.constprop.0+0xb4/0x240
>     do_el0_svc+0x48/0x68
>     el0_svc+0x40/0xc8
>     el0t_64_sync_handler+0x120/0x130
>     el0t_64_sync+0x190/0x198
> ==================================================================
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 684826f8271a ("zram: free secondary algorithms names")
> Cc: <stable@vger.kernel.org>
> ---
> 
> Changes in v2:
>   - removed comment from source code about freeing statically defined compression
>   - removed part of KASAN report from commit description
>   - added information about CONFIG_ZRAM_MULTI_COMP into commit description
> 
> Changes in v3:
>   - modified commit description based on Sergey's comment
>   - changed start for-loop to ZRAM_PRIMARY_COMP
> 
> 
>   drivers/block/zram/zram_drv.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index c3d245617083d..ad9c9bc3ccfc5 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
>   		zram->num_active_comps--;
>   	}
>   
> -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> -		kfree(zram->comp_algs[prio]);
> +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> +		/* Do not free statically defined compression algorithms */
> +		if (zram->comp_algs[prio] != default_compressor)
> +			kfree(zram->comp_algs[prio]);

Hi,

maybe kfree_const() to be more future proof and less verbose?

CJ

>   		zram->comp_algs[prio] = NULL;
>   	}
>   

