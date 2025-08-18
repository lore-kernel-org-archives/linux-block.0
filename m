Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B5F4F1;
	Mon, 18 Aug 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484155; cv=none; b=MimTPzQ42Qn4/90pqRVrEBOpakUM41HO457C4CSCBCZ8+G4TYhV1hEf5D0CDgxpDy+nBxrW01ae6bDP7Qyl5Ji/MLSXjBT4XCin1e/m+PG2K2TvH+fOZOIiTt2SoDCAbdmSCFGBAEIQOsPYmEII6ub0WJeT8+n20NjvTaWi4lvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484155; c=relaxed/simple;
	bh=EaYUwZ/xhmW2DLVw5jE8lIzLLZGLCWowj2oxFp81BiY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t21UtF//0EM7QXKOhpWR0ItCZZXBGgKMS4y2mv5FxBEAcDxS8aBUHm2iKSjh+WKS646nifw2MqelRA79O66CIi8fSmIKqPKU3yl0DjFUnh3051dxTYekIsK9GnbSCF6dHSh1R0avA4AVhYcs0yd6zrcsLzfAbtkNkEG6w5T42l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c4xVZ0lrGzYQv0Z;
	Mon, 18 Aug 2025 10:29:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD2B01A0194;
	Mon, 18 Aug 2025 10:29:08 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLzj6JoqIM5EA--.37913S3;
	Mon, 18 Aug 2025 10:29:08 +0800 (CST)
Subject: Re: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to
 lo_calculate_size
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814191004.60340-1-rajeevm@hpe.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0fbff649-a2ca-510e-780e-f2625f20ad5e@huaweicloud.com>
Date: Mon, 18 Aug 2025 10:29:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814191004.60340-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhLzj6JoqIM5EA--.37913S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF
	0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/15 3:10, Rajeev Mishra Ð´µÀ:
> - Renamed get_size to lo_calculate_size.
> - Merged get_size and get_loop_size logic into lo_calculate_size.
> - Updated all callers to use lo_calculate_size.
> - Added header to lo_calculate_size.
> 
> Signed-off-by: Rajeev Mishra<rajeevm@hpe.com>
> ---
>   drivers/block/loop.c | 26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

