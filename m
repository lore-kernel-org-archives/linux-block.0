Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E9195;
	Wed, 11 Dec 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886038; cv=none; b=lXGJvtfgXZSIm5Q1G0+QzATiGt0F3S4mW6GTsprntkt9bmARO38HNEAZY+bdZwcrV9jIlKvqexi/Qzhu/gM3WEcMDR2G+iyIbBwCws5xzkKG/9nd96eyfcyu/L+vYN9s0/0MSbYI9vUoMKN/Tw4VvVAdRy9P1JXyUqwby3/gNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886038; c=relaxed/simple;
	bh=s4eVvSXbq1oJohInK5tnYWWhfTKIv+hCrre1YMt8dsg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=au2qv0ialY4WJzQwnfaogoJthLSSltvsBlpJWI486kfmyX70dH8cYnlfhnxDQKihQyHySmd/9jU0X1L1K3bmDt4PhSKhvW8wMJt0ywE1OXdj80Kb9os72zBD7j2RGh+8Uwhb+xBzvDkG+zvbcZlzPCXicJTQH2xBk5ajHqADB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y7L1m4CnRz4f3jcs;
	Wed, 11 Dec 2024 11:00:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D0BF91A0359;
	Wed, 11 Dec 2024 11:00:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4NOAFlnBdQJEQ--.11293S3;
	Wed, 11 Dec 2024 11:00:31 +0800 (CST)
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 ming.lei@redhat.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
 <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com>
 <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
 <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8a0a5ae2-b4f4-75ee-483e-205fb80efeb4@huaweicloud.com>
Date: Wed, 11 Dec 2024 11:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4NOAFlnBdQJEQ--.11293S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	F9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/11 4:33, Bart Van Assche 写道:
> How much does this affect performance? If this affects performance
> significantly I agree that this needs to be fixed.

We are testing megaraid-sas, with 24 jobs * 1024 iodepth, for randread
and randrw tests, v5.10 is about 20% better than v6.6.

I verified that just set wake_batch from 1 back to 8 can fix this.

Thanks,
Kuai

