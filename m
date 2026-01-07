Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF33570C6;
	Wed,  7 Jan 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804576; cv=none; b=F7L7ag0SN9kvmyrqlfUa0q5GbP/BpY2DqXADYyqalpLkPwucJpHPv1XwJHeVZlj7Lh26u622K3TAhEr8VyiQDW2PGPKoTJGU4AqQL0QQ3Ke3x0LSbvMbg++JlWKiX2spKPXetkO6/wDm6JW2WvNLQgSgYfK/yU2/VJGFJzLcgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804576; c=relaxed/simple;
	bh=VKdu3bx/VTWb9k/XWm+Md+EFeUh250TyGemxa3DN+XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG38vihnO5EtoYfNbfvdBCfQL+pQd9E3RmWx8+bq4aRLh9UaBTICO75NXFoctsIqfcsv3eNScXf+oIPzzkHxUl5cIQTDZxnbgp7XUBG88AFDdqZl84DEW+Vr878ujqX3UVJ9EbG15olU+LnjFY2XA2ySqYviu9c8pE+83I/IrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=frb0QsNy; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="frb0QsNy"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dmYsX4WKnz1XMG5X;
	Wed,  7 Jan 2026 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1767804557; x=1770396558; bh=bitR6agTQW/31+L3e0E7bwA3
	h7hVrWoInNy8lX/7CJA=; b=frb0QsNyahNylgR6b5GxZftVX0CDZRJ2bpnDHLuS
	l5ylc7XZsh+fxmyrVTrTeaAQBkpYK1epHQbvFSmrFdTHIcyTgj6joNzZHbWqp5Hf
	yxR1E0tQla+NABPfEfmdzahOYR0WVnWF+PedDhrR+g4vY7uUYU9uHchmN07Cw3u/
	PdFN79z38W2XzExY+pS8IsLXq3tOMNCwXRr0lhcEEmiNYOcpCql/vP531ApzwY8n
	pxoG2xog0Hy7hYLIVkcx7Ux2ftHeSXT9Np3ZDQ/BJdoI6TgDVvpjyxXy6YZbafgT
	X0kiszrVuhFUAzcwwtdZajKm5IQMzVdD7u9GCJtN5+CGhw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vVThanmLKq2i; Wed,  7 Jan 2026 16:49:17 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dmYsQ3Y15z1XM6Ht;
	Wed,  7 Jan 2026 16:49:14 +0000 (UTC)
Message-ID: <96794e1b-d733-4b3b-a6ea-0193a9833efe@acm.org>
Date: Wed, 7 Jan 2026 08:49:13 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
To: Mikulas Patocka <mpatocka@redhat.com>,
 Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>,
 Fengnan Chang <changfengnan@bytedance.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: rcu@vger.kernel.org, linux-block@vger.kernel.org
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 8:56 AM, Mikulas Patocka wrote:
> --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
>   		 * Make sure reading the old queue_hw_ctx from other
>   		 * context concurrently won't trigger uaf.
>   		 */
> -		synchronize_rcu_expedited();
> -		kfree(hctxs);
> +		kfree_rcu_mightsleep(hctxs);
>   		hctxs = new_hctxs;
>   	}
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
