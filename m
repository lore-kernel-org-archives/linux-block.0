Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B07C6E6;
	Tue, 17 Dec 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473596; cv=none; b=Q/BEy/UdNUqg2O/oRHFe7TMc+/lH906CLn893McBDl7Q1tS8ESA6/ibXreiLbRpm3blN73CsnoWZfdWKMKXneJHTbJav6D1guepifGkHx0+oHM2pxbsOopC08cfe6eu6dWWtvHkAql773+DEaAhNGrFuDVlEc8ubw+XC0bMaueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473596; c=relaxed/simple;
	bh=HdgySUBqHDMEKBAL34kG+ckzp8P2uGyJViCY8YaVJ4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcS/pwa0OJEfqnRzsB7Bhnacf/Y3E/Aa4Fhe268XsX03hZlVCfPM3HKB7vKltdDAWDgeeq/8UCFROWv9yDWG/QqC9lHtfGO5dzCBbLQ6OJ48TXLm+hk7soBN+Eob4v9rOc7Pp2ypnBJ5X9eWrG6xJP1+1nB/Tsa9j4CJG9IDCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jL2uieR8; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jL2uieR8"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCWKQ3NwTzlff0H;
	Tue, 17 Dec 2024 22:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734473589; x=1737065590; bh=M+/x75l0vOkbX9v5AzXNizw7
	y0RN86h2Pymz9kvPMHE=; b=jL2uieR8Az8AZoXtMs06Q+vFUJOH5YyF02tqognH
	HnXv/SiwmHha0XjB93OWXYkTfzalV8E/PBF46TwS1NPEEe5xipxT1eKmxzq24weO
	eqabu82r1jyoChwZ1iBARHX+o7gexMzJj/lelLhw1/oYnK+epirx9+qtALOFP3Pz
	pxLhLG8YpAM1UHNvsYgjCqnrSqZTyLw5V+6sdSYcLuiDmR4V4qfiT9drx5KYwxn7
	fobnga+LePbtS+htfHKkbGx234GY/Ke0ejuyqZyKnwO3LVAq1r2Ax6CC7Ua+6xWQ
	tFczQ4/RCIxMRpHJ96n3GRJxMfQraYqIpZJgXk+zhAAY3g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eKTlfz2Odg6k; Tue, 17 Dec 2024 22:13:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCWKH28WKzlfflB;
	Tue, 17 Dec 2024 22:13:06 +0000 (UTC)
Message-ID: <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
Date: Tue, 17 Dec 2024 14:13:06 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217024047.1091893-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 6:40 PM, Yu Kuai wrote:
> +static unsigned int min_async_depth = 64;
> +module_param(min_async_depth, int, 0444);
> +MODULE_PARM_DESC(min_async_depth, "The minimal number of tags available for asynchronous requests");

Users may not like it that this parameter is read-only.

> @@ -513,9 +523,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
>   
> -	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);

Shouldn't this assignment be retained instead of removing it? 
Additionally, some time ago a user requested to initialize 
dd->async_depth to q->nr_requests instead of 3/4 of that value because
the lower value introduced a performance regression.

Thanks,

Bart.

