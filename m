Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABC29ACF7;
	Mon,  8 Dec 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221769; cv=none; b=USPjc35M2/Bjif1bbKXk4EsgyYjy67487DnWXitYKG7LOnfVowtYpN1ktGT2AD6JviKcmi9KJxxtsnqpaqRdnhLm7lb3dz0/D23xWfonXLCKRHKMjgy6JfgTbjJZ72K7iEcvZNgwDD0pV5wMZ5tmiEMuKr7Jcpr6gy723lD5tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221769; c=relaxed/simple;
	bh=mNuj5LwPWF/jYu6CvXbhyKwkzLa9BtQBSbG1QwBw+3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNq6Vx2p6sECPfz9rbGofI3xs8zyacQlmSl6Ki+2+CVIOkYfHE7V/1QzwlW3xSWWYn0UE8Yyby8INjLtZQwqghP4YT4o2a/rNus5ZO02XY3nwef27Oy866kgQpEVbj/ZjIKAfOknSOMBwHsBwDZQYXZoa00VJEuyNZehS0K/xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MNIo/rCg; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MNIo/rCg"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dQBhK3tPRz1XM0pl;
	Mon,  8 Dec 2025 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765221758; x=1767813759; bh=PvtBCN8q7OJHTmZPU/1Pvq3W
	WRAphxJgKeW0vRrevtM=; b=MNIo/rCgdYiwN8mRWKxBEqCy5/qxUG2dLgqnXhq6
	SP9gsLIQUYXfLm/OSeUGMkLmtmUyD6cXtRKo6U39hH16BzLR+F2nnRWnZjiQyjEG
	+8peEO7LV5QANPpdCkGNylsIz4WQfaJRxZbatoM15inLdnR041nIuYOnEQvll2pY
	De5FahEfwAg9XBAWsMVWWXAtVsXFqq23BImDxpJGBRIczxCfXnYoknDSb47R3tRg
	E1NsVJpcTPVKt+5MZGky6BPCIllhgjEEnX4Jion15JPI5zPhcoFYzet8Ac18mTvU
	HapCtboazPEDJwyM2RD26+B6R3ZGcQkxiILAKOMqZvmgEw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E80-xswuVyhH; Mon,  8 Dec 2025 19:22:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dQBhC0SVyz1XM0pk;
	Mon,  8 Dec 2025 19:22:34 +0000 (UTC)
Message-ID: <f24709c4-ba5e-4fb8-b20a-883d14185b2f@acm.org>
Date: Mon, 8 Dec 2025 11:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Casey Chen <cachen@purestorage.com>, Yuanyuan Zhong
 <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org> <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org> <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 6:32 PM, Keith Busch wrote:
>   static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *shared = NULL;
>   
>   	mutex_lock(&set->tag_list_lock);
>   	list_del(&q->tag_set_list);
> @@ -4302,15 +4305,25 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   		/* just transitioned to unshared */
>   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>   		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, false);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
>   	}
>   	mutex_unlock(&set->tag_list_lock);
>   	INIT_LIST_HEAD(&q->tag_set_list);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>   }

Although harmless, with this approach the queue_set_hctx_shared() calls
by blk_mq_del_queue_tag_set() and blk_mq_add_queue_tag_set() can be
reordered. I like Mohamed's approach better because it results in code
that is easier to review and to reason about.

Thanks,

Bart.
