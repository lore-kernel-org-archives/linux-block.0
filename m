Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA224DFF9
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760015; cv=none; b=KlpzrNCrMwBmuayFCEGHwI/HzBixsMVkS8nrwfyDDq8DEMndbEMTmpdgwXWzj0tugDgCHWZZD1OesaU2QZBDAZzOlKdcdrTvGvTws5F6QMK974kXUzXcCBUrt2yBzo1jZZghM/52CTLLHIvi6a7kbUKY2AwXgMz0sYUZFaE4qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760015; c=relaxed/simple;
	bh=7WddneGnSlf5HimcHNS1oz2C+7kFiRdMg8VIR++jEFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bevjmltwFctpOLOdY8kdGL7sDUrTgcEqpIZsptKOYwcgbvIkxf93yqnGQzefRF0DVcRdaMM9ka7yT8HThfb9V4Gsd1YU0Hf/Ihfqe0066h4V7EUae7Dz6wLpb9SwUhDdDRyAAsiRkyoQGmE+9wZA8sh8jO10rKnobEpAAxPzcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hMN1D2YZ2zYQtmJ
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 10:13:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C1DCF4056D
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 10:13:29 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgBXR0ZHy39qG31sCQ--.6543S3;
	Sat, 15 Aug 2026 10:13:29 +0800 (CST)
Message-ID: <d16887c3-8ebe-4bf3-8a11-9cecb39e315b@huaweicloud.com>
Date: Sat, 15 Aug 2026 10:13:27 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/10] null_blk: fix init/exit races and memleaks
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, bvanassche@acm.org, yukuai@fygo.io, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXR0ZHy39qG31sCQ--.6543S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr47Gry5AryDtw15Cr1rZwb_yoW5Ar17pa
	9I93W5Kw4DKr47ArZFkw13ua4rZws5G3yUWrnrJw1rCFWY9F109rn7Cr45XryDJ393WrZI
	qanFv3s5Aa4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb_Ma5UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi Jens, all,

Gentle ping on this series.

It's been a while since I posted it back in July. The series fixes
several issues in null_blk. Most of the patches have already collected
Reviewed-by tags.

In the meantime, I've noticed others starting to send patches for the
same problems, which suggests these fixes may have gone unnoticed.
Reviews on the remaining patches would be very welcome so the series can
move forward.

Thanks,
Zizhi Wo

在 2026/7/25 10:24, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> This series fixes several issues in null_blk around lock initialization,
> memory leaks, concurrent configfs access, and module init/exit.
> 
> See the individual patch descriptions for details.
> 
> Changes since v5:
> - Add a new patch converting the file-scope mutex users to gaurd(mutex).
> - Simplify the last two patches accordingly.
> https://lore.kernel.org/all/20260714041805.1088702-1-wozizhi@huaweicloud.com/
> 
> Changes since v4:
> - Modified patch 5 to fix the check-and-deref race on dev->zones in
>    zone_cond_store().
> - Simplified the fix in patch 7.
> https://lore.kernel.org/all/20260709100452.3520482-1-wozizhi@huaweicloud.com/
> 
> Changes since v3:
> - Added patch 5 (zones array memleak) and patch 6 (cleanup).
> - Added patch 7 (NULL-ptr-deref on shared tag_set queue shrink).
> - Patch 9: reworked the fix from v3's patch 6 to take the file-scope
>    lock in _store instead of scattering READ_ONCE/WRITE_ONCE.
> https://lore.kernel.org/all/20260708073917.2172392-1-wozizhi@huaweicloud.com/
> 
> Changes since v2:
> - Dropped the lock rename patch; the rename and locking rework will be
>    sent as a separate series (per Damien's suggestion).
> - Patch 3: fixed the tense in the commit message.
> - Patch 4: also update dev->NAME in the "!dev->nullb" path, which was
>    previously lost.
> https://lore.kernel.org/all/20260707025542.1299859-1-wozizhi@huaweicloud.com/
> 
> Changes since v1:
> - Added patches 4-6, and modify the lock name in patch 2.
> https://lore.kernel.org/all/20260706123507.3809871-1-wozizhi@huaweicloud.com/
> 
> 
> Zizhi Wo (10):
>    null_blk: use DEFINE_MUTEX for the file-scope mutex
>    null_blk: register configfs subsystem after creating default devices
>    null_blk: move unregister_blkdev() after destroying dev in null_exit()
>    null_blk: free global tag_set on init error path
>    null_blk: free zones array on device power-off
>    null_blk: clean up null_del_dev() to use cached dev pointer
>    null_blk: reject per-device queue resize for shared tag set
>    null_blk: convert file-scope mutex users to guard(mutex)
>    null_blk: serialize configfs attribute stores with the lock
>    null_blk: serialize configfs attribute shows with the lock
> 
>   drivers/block/null_blk/main.c | 92 ++++++++++++++++-------------------
>   1 file changed, 43 insertions(+), 49 deletions(-)
> 

