Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A631BF328;
	Wed, 14 Aug 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665165; cv=none; b=Te0xIMkkkltZ3zOUUllhfvN5Aq4RKUd8YYwLnxZ1wDQcD4+y2qbBHyHFvIVjokB+qCYiZJnxEwG0G22onuIYSKwO/bQuigd7tUGXHe+cCJRX9nMC63ueY3KSlaYe1gDI034GN53HKIs0g5mgMs/Hs6U1xtXf9U5wv5i5L22XbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665165; c=relaxed/simple;
	bh=wMGkEe1etLycsPwQhTJmLNVsBb99Okv6FLIJC2wA57s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3+4lYnV/OPEiFkU5q5iVfBooY/2T7CAKbDv1dyaOlSpB7GZbGJ4QVAx/0vwoVbEllE9mIr8LErH/zlSIUJt+FzU0+w4R/LfLIgFXTcNUgIRFQ3EPI4imRINJhfB0cIJu9mbZUZ7JQPRTZKlcC0kb2jEv7gWrSftHRQad8kMHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=shX6nncd; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="shX6nncd"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wkf6z0GJ8zlgT1H;
	Wed, 14 Aug 2024 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723665159; x=1726257160; bh=b1IEVd9FE0w+3+2w0KHcBJur
	aKD/4Hphe/60k5JHmRA=; b=shX6nncdJWqoUoOMAOi1L51c6izm6MLqw1JLenQ0
	2JOL19dPDvsWM+KgCMg9sbk63WeOBQYAjKrn/OjsVRuwSF1V13BwStu+G12DMATn
	BfSR/uuPJxts6+H+wOnyCucGjC3xsdQfKg0/fJTmV8Uqb467HNwBzZQGyGHNKhwe
	R/MazpV/3sxay72mfAzxuilEhjqK+OrHOZ8UtdYPJy5pAQUPmt8Vdm2tCI+qM33H
	+YhT29d7zGr9Fxn2bg3IRIr9HgEcM2lDSEDLogGSvDEwDdPQ00YX/I9qk85PZF1E
	bLFnd7imQZbukE4wuDU3DSoO9Ri2XMSD4H50F12WJC71Fg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ewFdNgd03Wxt; Wed, 14 Aug 2024 19:52:39 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wkf6s5YQGzlgVnW;
	Wed, 14 Aug 2024 19:52:37 +0000 (UTC)
Message-ID: <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
Date: Wed, 14 Aug 2024 12:52:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix potential deadlock warning in
 blk_mq_mark_tag_wait
To: Li Lingfeng <lilingfeng@huaweicloud.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 4:35 AM, Li Lingfeng wrote:
> When interrupt is turned on while a lock holding by spin_lock_irq it
> throws a warning because of potential deadlock.

Which tool reported the warning? Please mention this in the patch
description.
> 
> blk_mq_mark_tag_wait
>   spin_lock_irq(&wq->lock)
>        --> turn off interrupt and get lockA
>   blk_mq_get_driver_tag
>    __blk_mq_tag_busy
>     spin_lock_irq(&tags->lock)
>     spin_unlock_irq(&tags->lock)
>        --> release lockB and turn on interrupt accidentally

The above call chain does not match the code in Linus' master tree.
Please fix this.

> Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
> Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Please leave a blank line between the patch description and the section
with tags.

> -	spin_lock_irq(&tags->lock);
> +	spin_lock_irqsave(&tags->lock, flags);
>   	users = tags->active_queues + 1;
>   	WRITE_ONCE(tags->active_queues, users);
>   	blk_mq_update_wake_batch(tags, users);
> -	spin_unlock_irq(&tags->lock);
> +	spin_unlock_irqrestore(&tags->lock, flags);
>   }

The code changes however look good to me.

Thanks,

Bart.

