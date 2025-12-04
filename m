Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA41DE894;
	Thu,  4 Dec 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872563; cv=none; b=PxLmuxFQzYurr74q0/M8FgazGbD1kA/gdFXoPBQJs1j15DhmZ4OuWamUBqHg8zIQ9RRnQUriOW0csMLzHZFeK7G/s7lwjfrWhlrLt5IIb6fAIV5TzdzQebekKHvPMPxNefr+cNcR4Gp02IoYl5KJdBHfmVtycdD9F1mZXEW5kR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872563; c=relaxed/simple;
	bh=XlCuzaNUiyu4wnfTROGkhBHf6ZHXJIFTAaZ9hxvB6ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcqANrdTt6qVai1Fil1MTKyShHkokb3lF9OFTR+X613ujmqhoJFWFaqY4Ojp6vc4JVXBzlqYCEpRjNmPJl+zpKvxyigkBDWMAukgs33pEfQec9yoJlUDCa6WFIoreOiyNuNbW8iDtsFrPfH29O0MWRIR64x8HxCGVI657RqV74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BDh8OEQM; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BDh8OEQM"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMjXv3gMWz1XM0pg;
	Thu,  4 Dec 2025 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764872556; x=1767464557; bh=uSt3LQxRGpjDmMgYwHR3vatY
	0L+HSvxBS4jGX4ynEhY=; b=BDh8OEQMeMGOmbaMpaZ8cfAW7Vn13mFGdLUxghFQ
	qASqhrTIOH2eJF0gdpTuJAI4Vi/+WjasOSyUWWs1odHF8CYHxFFJ/GD1KPeldydw
	/Fe/pI90m6Q9jMY/W9j3ZF8313NMjZCNKaRBFC8y9OXY5doG6fTvem9QK2apU7lW
	G4JOuR9B0tcnmCfu5GsJf6TsziA9+sfMACyq7rjb6egFubDQexPNgRfc61n4zYRS
	EPDQxlvOz1GPgoWk+ULFd3YMtfQiQBthsLr6HixT+0LJtigha8TJ77HpO4foZkh5
	mBqqoVEkJrjf1e7aUc3dhKa22d961cd43U6osr/NN+48Yw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FtvBUV3owpqd; Thu,  4 Dec 2025 18:22:36 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMjXg1zTgz1XM0pF;
	Thu,  4 Dec 2025 18:22:26 +0000 (UTC)
Message-ID: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
Date: Thu, 4 Dec 2025 08:22:23 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204181212.1484066-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 8:11 AM, Mohamed Khalfella wrote:
> @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   		blk_mq_update_tag_set_shared(set, false);
>   	}
>   	mutex_unlock(&set->tag_list_lock);
> +
> +	synchronize_rcu();
>   	INIT_LIST_HEAD(&q->tag_set_list);
>   }
Yikes. This change slows down all blk_mq_del_queue_tag_set() callers.
Please fix the reported deadlock by modifying the NVMe code instead of
slowing down the block layer.

Thanks,

Bart.
