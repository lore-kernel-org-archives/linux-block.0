Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218F2E716A;
	Thu, 21 Aug 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788258; cv=none; b=rFidQ38b39oK/rbHL7atuCUUEwubSGfU975sfaRzYwMK0yo5Zoib49Cu2WAJrXspRgH8rCizO376TeAQldJNPeBQgRdM9wuDZ1Jt5j6IOdQMnPnI4fFjcIiCT1hMbx7odsl2/WzHZPKdW8pW2ByYGzPevF/UUJAhGsGIQOjmEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788258; c=relaxed/simple;
	bh=laPGmDl41JZKz3BhEeXIHr2uUQRH9LH4+PgrYEbfBKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9zvUYH1AgSZTbaMZWX6h+JDJBeAfY+pOxM/wjcbr3c1TQjYUI0SBeSVOTFlbpzTKyEWftlA5ynBe/hSmvKZrY9lZ5v8gMwmcZnaA0ARYhNadFERrqOJY3Q1mW+WgZitQygosAfDiziMlanas7UbYuGbToP4wfTmYd87mKGY4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c75yf5dx7zKHN8n;
	Thu, 21 Aug 2025 22:57:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 45A011A13D1;
	Thu, 21 Aug 2025 22:57:30 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP4 (Coremail) with SMTP id gCh0CgAHzw_YM6dolcvKEQ--.41858S3;
	Thu, 21 Aug 2025 22:57:30 +0800 (CST)
Message-ID: <651105d2-b87e-4558-d2b7-b5d47c72d29b@huaweicloud.com>
Date: Thu, 21 Aug 2025 22:57:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] blk-mq: fix elevator depth_updated method
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
 bvanassche@acm.org, ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <20250821060612.1729939-2-yukuai1@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20250821060612.1729939-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHzw_YM6dolcvKEQ--.41858S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48uF1DZrW5uFW3Ar47urg_yoW8Cry5pr
	WakF43tw1Utw1xuF1fZ3W3Xw4rJws5Zr12yFsxtryft34qvanaqF1rG3W8WFZ2vrWrAr47
	Gr1DG3s5Gr18ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQV
	y7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2025/8/21 14:06, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Current depth_updated has some problems:
> 
> 1) depth_updated() will be called for each hctx, while all elevators
> will update async_depth for the disk level, this is not related to hctx;
> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
> this hctx update failed, q->nr_requests will not be updated, while
> async_depth is already updated with new nr_reqeuests in previous
> depth_updated();
> 3) All elevators are using q->nr_requests to calculate async_depth now,
> however, q->nr_requests is still the old value when depth_updated() is
> called from blk_mq_update_nr_requests();
> 
> Those problems are first from error path, then mq-deadline, and recently
> for bfq and kyber, fix those problems by:
> 
> - pass in request_queue instead of hctx;
> - move depth_updated() after q->nr_requests is updated in
>    blk_mq_update_nr_requests();
> - add depth_updated() call inside init_sched() method to initialize
>    async_depth;
> - remove init_hctx() method for mq-deadline and bfq that is useless now;
> 
> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/bfq-iosched.c   | 22 +++++-----------------
>   block/blk-mq-sched.h  | 11 +++++++++++
>   block/blk-mq.c        | 23 ++++++++++++-----------
>   block/elevator.h      |  2 +-
>   block/kyber-iosched.c | 19 +++++++++----------
>   block/mq-deadline.c   | 16 +++-------------
>   6 files changed, 41 insertions(+), 52 deletions(-)
> 

LGTM

Reviewed-by: Li Nan <linan122@huawei.com>

-- 
Thanks,
Nan

