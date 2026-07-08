Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC22E8DEF;
	Wed,  8 Jul 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526218; cv=none; b=KBaUqH9vjBjvfJ0DKoA11OVquGQf8fpoK4PmF3XzBCGcK91vbLPU7Q0R90yZmC1frOZ8E+++Y2DLPGAzwm4WmetR+CACSOkFonAB79m1gdLOfEVFiL3pmYtvuokL/zqsFIDvt+L7m31tFQsur8sAsTfMIRdZZmOhppzGO6/rEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526218; c=relaxed/simple;
	bh=8NTr12HZaM/6bKRakUCK6RBLe30VzH4U+w7HDhk0ZnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+xMc6IndV3bd2Aqy6QecDSWsfcmhJjdBB2NwjBJv0TiE+YGic61v7Njhfw2QwobzTvW8OcsDUe2dl5rumxhUjR0UvTrLIv0UJ92tct91Yj3pzI+6X2YQHFrDtKCx5HKraVfnRQ9qwoLFV7EltzKBeUXcRxC7W5fTMY4CCRHWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=23JzXDLV; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="23JzXDLV"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gwN553kShz1XM0pF;
	Wed,  8 Jul 2026 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783526212; x=1786118213; bh=8NTr12HZaM/6bKRakUCK6RBL
	e30VzH4U+w7HDhk0ZnE=; b=23JzXDLVlw4bdLVw2BbCZstnwcdUYOohkyCLw5+J
	lGjaQpC+gMg+jjKUWjt3csM13TidWoj7JtlHqS5gU7a6WaLN6QeR4SRV7njPZcxx
	J5PvKQS/KVSBB3YyAUQZvWa8xTZJZT4gbIchC9bCVhuowkcywe7ge5JineF/R6gz
	gdBzbmjMzqIGDl4qsM++NmvolXICvvNA+gnbh0OUzDd5nqbHPeL4ABv0B2h8bfRZ
	mjzypSpvMefubgnoNJ1WX99WEoIaXRutxjdfmScQCqIzr/A2FcZgG5l0wIfzE+U1
	D5tbnm4Ma3Kn+WPWvy5VQByjd5LCXgS+9skdF81pwTuIFw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UdZMNvvO08J7; Wed,  8 Jul 2026 15:56:52 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gwN4x3wW1z1XM6JZ;
	Wed,  8 Jul 2026 15:56:49 +0000 (UTC)
Message-ID: <dd16980b-1fe8-45ba-b7d7-6f93df9f69d2@acm.org>
Date: Wed, 8 Jul 2026 08:56:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/6] null_blk: free global tag_set on init error path
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-5-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260708073917.2172392-5-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 12:39 AM, Zizhi Wo wrote:
> Free the global tag_set in err_dev, matching null_exit() which does
> if (tag_set.ops) blk_mq_free_tag_set(&tag_set).
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
