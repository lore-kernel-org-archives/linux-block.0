Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763F36C;
	Fri, 16 Aug 2024 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769571; cv=none; b=j1iWdz8YkBPX+q65Oegpaiy/Y2eWYP3rAb2VMO4WFWNhlMh/m5YnR9prCRjN5lHpGDMO3Y8NqKDH1HaY4szJxm6fqofjaw8oQ/NNSzH2pKdRxLdP1vz1E/vXJ4dHrAWpZlzrSFwY1aEaWNHiSkkXgbaQvaCn4x3yLmHUlJDzbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769571; c=relaxed/simple;
	bh=dw6Pqgr8lvrksTBdoBejsOTj5Hyq7dAKaTOwE26YFpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJsJyHpI1X0KoYE8p1XojAucoludzazPyWZH8UEvveFGfi4aMsh1zHA5ZDbZhsK0Aof3DGn/JZMI1ZHlasZ7uVAU9bgdlqhs/uq+t7nuRHI78mdZk1dQGBqqqxXxeW034mX1/pg6JcAi1lbXaH+IpS0JJjaWonJHnL8gyxW3TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3nw2dCel; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3nw2dCel"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WlNkn0qHvz6ClY91;
	Fri, 16 Aug 2024 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723769565; x=1726361566; bh=6zjpwiLOmp/KRcliGjn6/FHn
	HCQrzC1SvDbQyKhRDU4=; b=3nw2dCelLkxzgGciiWczZNFExpqE4VJYeeAtevbq
	VtlprYtylEUSK1jsa9G/g/dxCBYTSe06UUe0Lc6L9jfrJ/01xgrT/YwCArXEQCNe
	KbO0fjgjlgUXWt1Wulb2+l+lhmhtndK8e/A8eEh/W2MeE1CJJHoyhj9hATNl8sEi
	qXVad5al89Hgpgq7NuDgc4OxZyFk3rPLU2nv6X0ih3f9G/dFGHQPmpE2LHKumlJl
	KAtp+X1sJMGTCYxtuezJSj9+LK008nCIA+wL6+RA6cvB72+J5pWuZFHOjI/yt4w2
	1vrKgKibPS+sKwbuNexYYxgEiTeMdupNBUmIRlGLoQm1Gw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tFGeddOYSSeY; Fri, 16 Aug 2024 00:52:45 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WlNkg4RQGz6ClY90;
	Fri, 16 Aug 2024 00:52:43 +0000 (UTC)
Message-ID: <d9513e0b-d70e-449d-95c0-99aa9a605e36@acm.org>
Date: Thu, 15 Aug 2024 17:52:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix lockdep warning in blk_mq_mark_tag_wait
To: Li Lingfeng <lilingfeng@huaweicloud.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240815024736.2040971-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 7:47 PM, Li Lingfeng wrote:
> @@ -56,11 +57,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   			return;
>   	}
>   
> -	spin_lock_irq(&tags->lock);
> +	spin_lock_irqsave(&tags->lock, flags);
>   	users = tags->active_queues + 1;
>   	WRITE_ONCE(tags->active_queues, users);
>   	blk_mq_update_wake_batch(tags, users);
> -	spin_unlock_irq(&tags->lock);
> +	spin_unlock_irqrestore(&tags->lock, flags);
>   }
>   
>   /*

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
