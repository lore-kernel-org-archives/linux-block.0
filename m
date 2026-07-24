Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992288003D;
	Fri, 24 Jul 2026 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855895; cv=none; b=LddckAZqHcGA4NiJLziGbbisgDevhe/EqH+QrUYtQ2oSrtEG4j+lPD5hTuUELTb+h+9LzESI2ZUZ1ftaOga4Q8IPL9o6OZG3EjdeykEbitBMLilk4wrKKYRXwHZOtl7MLdnDX7bMPIJzIUfi+uTvURiRnDzxlRAuT/nyJAVtUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855895; c=relaxed/simple;
	bh=en6ZnMW746IrBF/4JPyWXS4xsCQFLso4YSUlHEoGIM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fm8w+ODaK/sQ7Lx37MI2w7me8nhnMf9065xz+/9ny3tLgaY1Y/y3v0r2UFwXhYljf//5V10uKyAiLRuaItrfo8Tdtj9cmwB7IU5gA7rHshjKgC+3Rgmf4IcPasjMTddspLNGLe3eWyTIEbzh6AAXSo24IMZrNXrHHpi9whpNLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5qq500yhzYQtxb;
	Fri, 24 Jul 2026 09:17:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D77F40571;
	Fri, 24 Jul 2026 09:18:08 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHRPvWJqfSRTCQ--.22045S3;
	Fri, 24 Jul 2026 09:18:08 +0800 (CST)
Message-ID: <1d06cc3c-df97-46a3-a0fe-9e46ce6a813e@huaweicloud.com>
Date: Fri, 24 Jul 2026 09:18:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/9] null_blk: fix init/exit races and memleaks
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHRPvWJqfSRTCQ--.22045S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48ZF1rJFWrWw43XrW7XFb_yoW8tFyrp3
	9093WYkr4DGr17JrZFyw43WFyrZan3G3yUKF9rJw1rCFWYvFy09r97GF45XFWUJ393WrZI
	qa9Fvr9Yva4qy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping...

在 2026/7/14 12:17, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> This series fixes several issues in null_blk around lock initialization,
> memory leaks, concurrent configfs access, and module init/exit.
> 
> No functional changes to patches 1-4, 6, and 8-9.
> 
> See the individual patch descriptions for details.
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
> Zizhi Wo (9):
>    null_blk: use DEFINE_MUTEX for the file-scope mutex
>    null_blk: register configfs subsystem after creating default devices
>    null_blk: move unregister_blkdev() after destroying dev in null_exit()
>    null_blk: free global tag_set on init error path
>    null_blk: free zones array on device power-off
>    null_blk: clean up null_del_dev() to use cached dev pointer
>    null_blk: reject per-device queue resize for shared tag set
>    null_blk: serialize configfs attribute stores with device setup
>    null_blk: serialize configfs attribute shows with the file-scope lock
> 
>   drivers/block/null_blk/main.c | 93 +++++++++++++++++++++--------------
>   1 file changed, 56 insertions(+), 37 deletions(-)
> 

