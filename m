Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696C14A0A3;
	Tue, 17 Dec 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472251; cv=none; b=dtSnZl5JNUw+Gy/lwavqnrTGkDYnedXSDC5u1AmNi8JqNw6NwHUzkbdKevnSkaRba3ylHBxzISJ1zOmgUOOADZYmi7hZnHmdBLeywaK0eUL0iCTx4SJmmciY/I20mVEZvP4MZle3RbTArlC2Y4MbqYXrVq4UFXIKYfvof+GkQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472251; c=relaxed/simple;
	bh=OAwBai08oY+i441nEsQbvRWLwiRlDITvNm7ygS2fNxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHqjEApCuwx6AYPzxMVhRF+xzFrqSapRKF71vXHEJVZEVEvRPwfOvb7GPO6SFcfmhKf9yzc7v8dWcq8900C+JyKaBCCH59UEpt3rAOsKhCzpQrE9brTBx/FdJ6tWZE2Lg1AmVrUTF+0iJxO6xw4/LG7f/ObUFmFLmz8xOJ+hzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O0BM4jrG; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="O0BM4jrG"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YCVqY39cGz6Cnk9B;
	Tue, 17 Dec 2024 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734472242; x=1737064243; bh=vGKreOiMrmkyHbfnHTG/lPe2
	VUgGkuWqkgHuBPeS/4w=; b=O0BM4jrG2cDVDSzLsi8pgP3mIM3FaYhVJh4eeRKP
	cfr4vpAWzV8Up1rRtzZCi+H1ZtmRSK2mgmzssF+bw+oLSmPNKOJih679ho28kFYQ
	Y1gqgw9Y8yWuBO9LnErOplxP193bQQ+7+B47rkZoxTcjyXRNGJUzylRnyH4Pvzc3
	/2FPmGPk4t57QWCOKIwBGnAFqof0rzERaG/5QyqEDMcPMLnCxITgcnBFAZz75c1B
	d75nRNScMFIbJ3LqI1Q0w5RuO2lD2p+xpGIXKG4xnCiYlHU64i6TVoHgQO1igW/o
	ZxKXjOWUrv8bFuDjFUe5pV/B1uEDTCxVoSa35CotMd1RUA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IY2qz15OeoDP; Tue, 17 Dec 2024 21:50:42 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YCVqM72Lhz6ClY9C;
	Tue, 17 Dec 2024 21:50:39 +0000 (UTC)
Message-ID: <ac5aa72f-9944-4436-bed3-43e4e4e97f5e@acm.org>
Date: Tue, 17 Dec 2024 13:50:39 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] block/elevator: choose none elevator for high IO
 concurrency ability disk
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217024047.1091893-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 6:40 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The maximal default nr_requests is 256, and if disk can handle more than
> 256 requests concurrently, use elevator in this case is useless, on the
> one hand it limits the number of requests to 256, on the other hand,
> it can't merge or sort IO because requests are dispatched to disk
> immediately and the elevator is just empty.
> 
> For example, for nvme megaraid with 512 queue_depth by default, we have
> to change default elevator to none, otherwise deadline will lose a lot of
> performance.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/elevator.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 7c3ba80e5ff4..4cce1e7c47d5 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -568,6 +568,17 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
>   	    !blk_mq_is_shared_tags(q->tag_set->flags))
>   		return NULL;
>   
> +	/*
> +	 * If nr_queues will be less than disk ability, requests will be
> +	 * dispatched to disk immediately, it's useless to use elevator. User
> +	 * should set a bigger nr_requests or limit disk ability manually if
> +	 * they really want to use elevator.
> +	 */
> +	if (q->queue_depth && q->queue_depth >= BLKDEV_DEFAULT_RQ * 2)
> +		return NULL;
> +	if (!q->queue_depth && q->tag_set->queue_depth >= BLKDEV_DEFAULT_RQ * 2)
> +		return NULL;
> +
>   	return elevator_find_get("mq-deadline");
>   }

Shouldn't this patch be submitted separately since it is independent of
the rest of the patches in this series?

Thanks,

Bart.


