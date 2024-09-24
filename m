Received: from msa.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A97282FE;
	Tue, 24 Sep 2024 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155383; cv=none; b=rJomYVFaXIgxOfPT7RB8pWrrmyocroOOVIQpzCclSz7eSWKYwbDFNKw1EVNwva0QQsM2qtp/Lx9rzoYLfkxRcehr3KqircVB2JSN7OLZIem82uOGET/3YWdm0CkCGaIaRtgsegOljD2/7gkEcOl88WghUKMjIJoMxlo9lm9J27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155383; c=relaxed/simple;
	bh=ZP1/yGQ5YTVjSvo1mtVMnbyccRGQi4w5KhgYF3EMqzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDrriwplaZ15gKjxaohfzddWG/dBxZCLoE1KkRO8Q0RHHzTkrkBKNCEEiUSVTUZYwZv6b5Xeb/v2VwX//NQH1TL1MUBtWIBNP9p7MIMEEIWYQ5Af8t4hEfbdp9ca51xHqMVVqdMZ7y2kHeAfEKtmsys3vlXCljvb49HW2hu6tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=coRaZ6LN; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="coRaZ6LN"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id sxzTs7AvWZNvLsxzUswykh; Tue, 24 Sep 2024 07:21:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727155298;
	bh=3qg1uePlgQJRTRzaN5PgikYakBLNOe02mas3jSR8Uto=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=coRaZ6LNNF4Xd1AtehZ+iXbsHSoA+kczDDaJRnItQLdXeMu400q6+Fx94l08m9KaU
	 4TX5WsRoQxCNGiWCXPJ4ZgdTBDqsdTe1JgLxj++dAA21qJqOyTSQgNHUffP2JiaHNE
	 f7f0NbqniR9AE+Jz+WbhfxrN7G3CKsK0XNCqEcRa0Sb2B4nbPcGgCvGnlqO5PnSPFi
	 BjuzI4U4yr4TdmbZj2lZRD5wyqQmtQXavHj3n/It1R2LF/ARmJBN4lpHPlIRYUeiPO
	 37g3VKAco5/0Nxh/agX/sWSU2oG59SjNERGY5RzrhWy80UDy/dZi/UuuwIcWNxeUli
	 riBx0MsvPVEPg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 24 Sep 2024 07:21:38 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
Date: Tue, 24 Sep 2024 07:21:35 +0200
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
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZvHurCYlCoi1ZTCX@skv.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/09/2024 à 00:41, Andrey Skvortsov a écrit :
> On 24-09-23 19:40, Christophe JAILLET wrote:
>> Le 23/09/2024 à 18:48, Andrey Skvortsov a écrit :
>>> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
>>> default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
>>> so we need to make sure that we don't attempt to kfree() the
>>> statically defined compressor name.
>>>
>>> This is detected by KASAN.
>>>
>>> ==================================================================
>>>     Call trace:
>>>      kfree+0x60/0x3a0
>>>      zram_destroy_comps+0x98/0x198 [zram]
>>>      zram_reset_device+0x22c/0x4a8 [zram]
>>>      reset_store+0x1bc/0x2d8 [zram]
>>>      dev_attr_store+0x44/0x80
>>>      sysfs_kf_write+0xfc/0x188
>>>      kernfs_fop_write_iter+0x28c/0x428
>>>      vfs_write+0x4dc/0x9b8
>>>      ksys_write+0x100/0x1f8
>>>      __arm64_sys_write+0x74/0xb8
>>>      invoke_syscall+0xd8/0x260
>>>      el0_svc_common.constprop.0+0xb4/0x240
>>>      do_el0_svc+0x48/0x68
>>>      el0_svc+0x40/0xc8
>>>      el0t_64_sync_handler+0x120/0x130
>>>      el0t_64_sync+0x190/0x198
>>> ==================================================================
>>>
>>> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>>> Fixes: 684826f8271a ("zram: free secondary algorithms names")
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>
>>> Changes in v2:
>>>    - removed comment from source code about freeing statically defined compression
>>>    - removed part of KASAN report from commit description
>>>    - added information about CONFIG_ZRAM_MULTI_COMP into commit description
>>>
>>> Changes in v3:
>>>    - modified commit description based on Sergey's comment
>>>    - changed start for-loop to ZRAM_PRIMARY_COMP
>>>
>>>
>>>    drivers/block/zram/zram_drv.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>>> index c3d245617083d..ad9c9bc3ccfc5 100644
>>> --- a/drivers/block/zram/zram_drv.c
>>> +++ b/drivers/block/zram/zram_drv.c
>>> @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
>>>    		zram->num_active_comps--;
>>>    	}
>>> -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
>>> -		kfree(zram->comp_algs[prio]);
>>> +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
>>> +		/* Do not free statically defined compression algorithms */
>>> +		if (zram->comp_algs[prio] != default_compressor)
>>> +			kfree(zram->comp_algs[prio]);
>>
>> Hi,
>>
>> maybe kfree_const() to be more future proof and less verbose?
> 
> kfree_const() will not work if zram is built as a module. It works
> only for .rodata for kernel image. [1]
> 
> 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> 

If so, then it is likely that it is not correctly used elsewhere.

https://elixir.bootlin.com/linux/v6.11/source/drivers/dax/kmem.c#L289
https://elixir.bootlin.com/linux/v6.11/source/drivers/firmware/arm_scmi/bus.c#L341
https://elixir.bootlin.com/linux/v6.11/source/drivers/input/touchscreen/chipone_icn8505.c#L379
https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/qcom_common.c#L262
...

all seem to be build-able as modules.

I'll try to give it a look in the coming days.

CJ
