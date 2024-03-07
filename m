Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C394A21
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774011; cv=none; b=LB32Sa0hyZSnyee7yCnqAmqpaNGomnal6/Hswmie1E3219SD6ZHxP6qshyLCkQO3uDBchJi6if+iuejO5/beprei0BAOAWqVks108jZbA8q2M0h2Wwox060fmAJ0jPKj5TD9k+pMQ8jmrYMgXPJ6bRIGeY1l80wjvE5coYSgrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774011; c=relaxed/simple;
	bh=V1ptu6rTZfNlxPcko3hTbOwKQfeZzxxfw1V0UPMjDAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFfPWdW5wZf6JQMGROHkqB0H8Q1kKsi0S73fmMvEpTAGW9zdu8+/UbPC6Wv9k8iaRnNS4haSDiwDdKb04xbVtEd01VlZ+xACxlqxWz977Fx8SkF6Ahvi7c+wirxT0EwsPnBR1fv4AHHQRPA0ocsCIT54fVH1h2CeUHU/0b+Fipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kqqgBN+H; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kqqgBN+H"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Tqrpk2BxlzlgVnN;
	Thu,  7 Mar 2024 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1709773868; x=1712365869; bh=hwUBKkD6zKVtnQGhD+5dM2vZ
	iZ6ulQhef+zlW7P6NbY=; b=kqqgBN+H5FFnHPcKF0/JwBpibc1cyBg2+Qh7ERPL
	HLlL0YhSR2gT1V47irRLawcJwHgDMGM71gfeM8YHuGQTfUPEXeQwHeNYCBAXPC3T
	LuuhWO9SLp1UGTYiP6oSU0xYF+gQY/LPzxvt2J6/qchUAkJG47BFP1H8SNxLkLZH
	OqtaGajIfksJbFrz7v+5fWLKHYMD9uKZr/mOnYMrD6RuxRj85QmwLnCUFD4Cv8IJ
	GMkKgg5ukcM4a/eDmBoBV+9/cR1EnxeD0gtarARxM5h0OsSveQ7GlrzEGTktMGGB
	SBrxMOaQNJJnfaAEwwPAULdRqiizEhcXKhQYPyPxTIQ0VA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FYy-lUg0oQnU; Thu,  7 Mar 2024 01:11:08 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Tqrpf2HnkzlgVnK;
	Thu,  7 Mar 2024 01:11:05 +0000 (UTC)
Message-ID: <b2907ddb-6e48-4c9a-b4e7-d6239550d5c3@acm.org>
Date: Wed, 6 Mar 2024 17:11:03 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Support building the iocost and iolatency policies
 as kernel modules
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240306003911.78697-1-bvanassche@acm.org>
 <396d15a0-eedc-bf00-dd56-c064293fcaa5@huaweicloud.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <396d15a0-eedc-bf00-dd56-c064293fcaa5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 17:34, Yu Kuai wrote:
> Looks like there are lots of work need to be done as well, for
> exapmle:
> 
> - ping the iocost Module before enabling it for a disk, otherwise unload
> the Module will cause problems;

Hmm ... loading a block driver, loading blk-iocost, unloading the block
driver and unloading blk-iocost works fine on my test setup.

> - free the iocost structure after disabling it, otherwise iocost Module
> can never be unloaded;

I will check whether struct ioc is freed when unloading blk-iocost.

Thanks,

Bart.
