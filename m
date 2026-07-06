Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C72E6CB3;
	Mon,  6 Jul 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349150; cv=none; b=cArk0T+0m3yiLKqiLEpzcRZn+zkIxcwTiJBUC1wOzV4dbvdIAdQaJOvdSmpp2fivvePlKXuqTxtOFmqNuAqUEDQw3bEKjVsbX3rsqNlWXZbNzdSisXjz6naj75WseHOE3KlIYaZw/+ERzTSIakmVmBmQ82rSAtRttnWAWsDmJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349150; c=relaxed/simple;
	bh=5FF82p5yqBFNyjiv52zXQu0y4MzLFESUlUBmIVFIf94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBjxEyICiRzrHCCaenzHZn/J82Zenw/vqRwyboCkxFC87F3dH6GGTocnJX27WxGYPP7I0wcK7sfpx0ORNtC78e8TyRLWhOrlGN9DMkuU60qlpXewItVQXZ6on9EIhnaaU0k3HFsHPYHUY09A/XfS/Cp+w967Hm2sZhKcsmK2IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sTO8zeyk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sTO8zeyk"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gv6bx03XYz1XM6JQ;
	Mon,  6 Jul 2026 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783349144; x=1785941145; bh=HaF39ur/i/EmXJ82xXzWqPJI
	Bqle1XYeHYVmVNH5g3g=; b=sTO8zeykUlp7+1JcFuGXmS+9gTKfBod9fTfSGjZ4
	WmnE/eEQXjIav7yQIltQJky6n0vGPXOy2LyNqro46WeQmY7OhIhTokFKu15N05ku
	vz3/GB1NGKsWkPrN56LmF9rgyFRl+JjhIKLPAYdTxkyjqrfzF9Vp3ipkMhZ0fBme
	5L/cxvqQXvWWdVLSu1Asgzs6FjodnX1WanVNg47UuH9woqNWUs2860BOB1swAKON
	vMioUxa+hUWggUr/ErZ2EhSeQZH9jvtcoKRfdyAbFsJUV7lHuCvm1lhizciDNYNu
	wQw8m6s8YxP6s/7rS1xsPFaI145UgILyVZSQFnHnYDjNgQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QjjKBSfuP5LG; Mon,  6 Jul 2026 14:45:44 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gv6bk5Th2z1XM6J4;
	Mon,  6 Jul 2026 14:45:38 +0000 (UTC)
Message-ID: <e20382ed-255e-4fdd-b864-657785d309f8@acm.org>
Date: Mon, 6 Jul 2026 07:45:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] null_blk: give the file-scope mutex a descriptive
 name
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-3-wozizhi@huaweicloud.com>
 <9004743e-f522-424e-a1ab-8779ecc6da02@acm.org>
 <5f99b2f3-05c1-4754-9827-d55528861ecc@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5f99b2f3-05c1-4754-9827-d55528861ecc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 6:21 AM, Zizhi Wo wrote:
> Thanks for the reminder! Agreed that "nullb_list_lock" is too narrow
> since it also serializes nullb_device_power_store() and
> nullb_update_nr_hw_queues().
> 
> However, I'm a bit worried that "nullb_lock" is easy to confuse with the
> per-device spinlock "nullb->lock"... They are only one "->" apart?
> 
> Would "nullb_global_lock" (or "nullb_config_lock") work better? It
> reflects the broader purpose and avoids clashing with nullb->lock.

Not sure what others prefer but nullb_global_lock sounds good to me.

Thanks,

Bart.
