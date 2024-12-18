Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65373597C;
	Wed, 18 Dec 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544866; cv=none; b=u9xcqUDe7QfGRN2DD0wDctqGesYjrgpQ/PWXAErRXxz7aXCYvqqctbV5bULDsFkGYo0gWeYsNoSZUHYFQ5/vC21nDC2/aEy/dA2KPAB16/qSK536V5kAPOZsqGGveM/HPXsg1J1dI70AoY1jgp9RFVGxA/cSSbY2rVMJyuK98xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544866; c=relaxed/simple;
	bh=nCRFkNBILC2//hm4ycMs/C31IlG9+XR4ValfcPovi4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF7DVlnHcafdyRIj/4FTu9Z4zYqVNotMXwQUvM4xS/aOej1XeeL/z0XZAvT9+4r09Z8HX+nBKpSKIgpabtJTXzEVMHnWQ2T94LGIUv3qzIblIixobnHyqoz1MHlzHzL8eNfPXH/yANXZkoQypNsXSgwPAcpDeqc0XYeG3JJkBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sqdkTL9d; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sqdkTL9d"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YD1h01ZFLz6ClY9q;
	Wed, 18 Dec 2024 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734544858; x=1737136859; bh=nCRFkNBILC2//hm4ycMs/C31
	IlG9+XR4ValfcPovi4Q=; b=sqdkTL9d208zyS6OhFHmoQ7TohC8NIeUo0ADklZu
	KdbnZKEBTtdfGvDqLWslmsNMSGVPtgFA7Ui8f3pz7cWAeFfCanzWxTTP80uCNKsx
	dr3dQOclEmC5Twf62oW7LT3YlLa//HZ56vUyl3snC4Un6ccqskqv+IkRvgnDrzj9
	KZCvr95Hm7Jq26tS406l8ZMpYC//dlCZ6QuMfLAQdQXb9KwKunHH8d6LSMptNUta
	gpVTG0v9CQHFF4x0k04PyyVk6D3vSgoQEXFcJ8VxEgxd/9fjEHOEYJCVYhbYOHR+
	DWzPwBnPsvEKXPQR6j/AWAUptDKMpC5R5nQ+zhG0pt1UjQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0-juHuZE_U3E; Wed, 18 Dec 2024 18:00:58 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YD1gm3sg1z6ClY9D;
	Wed, 18 Dec 2024 18:00:51 +0000 (UTC)
Message-ID: <f2b95b70-f074-4f58-b03d-5e7fb20f4274@acm.org>
Date: Wed, 18 Dec 2024 10:00:50 -0800
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
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
 <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
 <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
 <96556f82-b511-b3ef-01b5-e9a32557db95@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <96556f82-b511-b3ef-01b5-e9a32557db95@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 5:14 PM, Yu Kuai wrote:
> I can't make this read-write, because set lower value will cause
> problems for existing elevator, because wake_batch has to be
> updated as well.

Should the request queue perhaps be frozen before wake_batch is updated?

Thanks,

Bart.

