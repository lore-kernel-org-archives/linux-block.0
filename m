Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B77FD;
	Fri,  8 Aug 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619602; cv=none; b=h6+thY2moCapGgWp/1y1Y6GTvnWH/ug2Qxf1tfqFbfLyaL1wWf7PYkXu6dKgDXoC2EN1GJsquPECz54szUdmbMA6bdT3qemK7hhK6r66cBg3npA3ZEodz81T7Li6+F4P4Wk+/naoc013HdtsdEkl7w8Qhxij65AUg2W2JA2d2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619602; c=relaxed/simple;
	bh=xIvmFm2/GHTqIpFAi81ebAVhq1c96BxSLGySZlk9PaY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GrHs9SqKeqsTo4d05o+3AvwhPTOfR8c4gQTCFCX8eG8x1VVrSa8+NpBARJwCpRisnE583CNBI3uYVVOUKXOCozxXSn3iMFSBwQwTJAP4wMYkRpikbaC3KkSPDh0ZaD0dtoZR5NYiOaMgsgvFGUo51Tv1/dZigc93QgLjLLKj37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bynmR0lq0zYQtpM;
	Fri,  8 Aug 2025 10:19:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9C611A018D;
	Fri,  8 Aug 2025 10:19:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhLEXpVoKT3ICw--.54946S3;
	Fri, 08 Aug 2025 10:19:49 +0800 (CST)
Subject: Re: [PATCH] loop: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250807135559.560837-1-rongqianfeng@vivo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9794f6ac-bb3f-3e7b-14b4-2dcda2fdb1d2@huaweicloud.com>
Date: Fri, 8 Aug 2025 10:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250807135559.560837-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhLEXpVoKT3ICw--.54946S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/07 21:55, Qianfeng Rong Ð´µÀ:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong<rongqianfeng@vivo.com>
> ---
>   drivers/block/loop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

