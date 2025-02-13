Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6229C147;
	Thu, 13 Feb 2025 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414848; cv=none; b=uCKyjv0HRmWx6655STTfK7bhbVo1tyIm/JsHl49T8ftM8hM4vfTP74SwkyU+5Ky5SwoYuDxamXqn2OFzYmx6JVmLma1z2+bgx4w75bhDspH9oQBn/U/Gw6MWdDe+aaCYNzo9zPZTPTlMGMm1cCQki1+wgFBp5H2eE+i+IO+4PgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414848; c=relaxed/simple;
	bh=3HggUM6FYjY39fqn0Kamf82d+aJfTcb1GbbNZh2OR2s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P4FnEqu4coYhT0VNzAUoUitjgowMMHpzDBhhqwtyXO+2xzvJ7jUrrqMCdsafHcaFqj4V7PkLRVQ4h0VwjP73OW7d3ZIGg7s4pImCmXvp5qoP4sukxaSmCRbsv40X0h8aMDsZaQnzuoyYumkg8XyXZp1nott74Wb/LcTCUG0z5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ytfj639vyz4f3jq4;
	Thu, 13 Feb 2025 10:47:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 816231A180A;
	Thu, 13 Feb 2025 10:47:22 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGA5Xa1nF8jGDg--.12255S3;
	Thu, 13 Feb 2025 10:47:22 +0800 (CST)
Subject: Re: [PATCH RFC v3 0/7] lib/sbitmap: fix shallow_depth tag allocation
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241221093710.926309-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <baf509ad-95d6-9c28-d913-0b672c73562f@huaweicloud.com>
Date: Thu, 13 Feb 2025 10:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241221093710.926309-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGA5Xa1nF8jGDg--.12255S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtF18GFyfKr45Cr4UWFy7GFg_yoW8JF1rpr
	Z3tFnxKr4vkrZrury3Xw13ZryrJw1kXr1UAF17tw18CryUArs7Jr1rJF1rJr92vFyxtrsr
	WF15JFW5KF1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/12/21 17:37, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in RFC v3:
>   - only patch 1,2 is from v1/v2, others are new patches, in order to change
>   async_depth to request queue attribute.
> 
> Changes in RFC v2:
>   - update commit message for patch 1;
>   - also handle min_shallow_depth in patch 2;
>   - add patch 3 to choose none elevator by default;
>   - add patch 4 to fix default wake_batch;
> 

Friendly ping ...

> Yu Kuai (7):
>    lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
>    lib/sbitmap: make sbitmap_get_shallow() internal
>    block/elevator: add new ops async_depth_updated()
>    block: change the filed nr_requests to unsgined int in request_queue
>    block: add new queue sysfs api async_depth
>    block/mq-deadline: switch to use queue async_depth
>    block/kyber-iosched: switch to use queue async_depth
> 
>   block/blk-sysfs.c       | 35 ++++++++++++++++++++
>   block/elevator.h        |  1 +
>   block/kyber-iosched.c   | 31 +++--------------
>   block/mq-deadline.c     | 57 ++++++--------------------------
>   include/linux/blkdev.h  |  8 ++++-
>   include/linux/sbitmap.h | 19 +----------
>   lib/sbitmap.c           | 73 +++++++++++++++++++++++++----------------
>   7 files changed, 103 insertions(+), 121 deletions(-)
> 

