Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835193F12D5;
	Wed,  8 Jul 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525908; cv=none; b=jA2E78cBMlfmEWDsrvUjYSGKSdowlEccJEJwfY0SL/u3WCHdoJg3bHaQ8/R45vp0Eu8wy99sG76m4RwTFXVYOjyTpVXtqSJ+trZY7yuQz5e8usujVOhR+iQppmR+SiD2snoBLs++bxMnifSJGji5qJh6LXVR+xS/gXq4XqZEcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525908; c=relaxed/simple;
	bh=OJAcbhk5zj4hH/jQW/vNxNhm8abqaAro2yHIkqNXOn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMr1n+6IeNVBJV28jWnqPSisGnOYwZEM+APmE3E28xyfeEC47T5QjPA3y600eb9AP1J2wiCS5/CpFVmq4FtTud2tCF3H9DtvdBhcl3lqEOmRzinUyYGxHjoiF/xS3Lx8MrX2KIyO1CPxu7bmrZR4N/yAmCJqz8qXHTjsgsLMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ozUJ5o44; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ozUJ5o44"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gwMz60h3Cz1XM0pc;
	Wed,  8 Jul 2026 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783525900; x=1786117901; bh=OJAcbhk5zj4hH/jQW/vNxNhm
	8abqaAro2yHIkqNXOn4=; b=ozUJ5o44OtSXQLNLhzRIohC7FOn+s0k+dGXVVib7
	CmS/aTPkv1oDf1v8/OUiVqGfHoEAcUT/NFjfR+OeWcCEUVShtXkY/6yEIqQ8RlCa
	0PjyP6WhmacZTVMgxO6JaRUAPVKXugZ/zbBVeZ6NWI1oZC49njvLwKV5Bc3FRQO7
	nGn7AJwFK1WXnHcYziB4DLgXBnWoee/bbJEIgw3GTvKl+asgoxDWzRA6dOce1zn1
	BBoL0ufIvgEzWDQkVsLiDtfrBac7ibuezQh/wDo2b+wytxhB1AuMThtJaBUttdNs
	oOjgVX0Q6RZkU3CD9wMkSs8pxPFk7y1WgyOpPPNAqwaPKw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WsqnUPaW9Q2C; Wed,  8 Jul 2026 15:51:40 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gwMyx2VwKz1XM6Ht;
	Wed,  8 Jul 2026 15:51:36 +0000 (UTC)
Message-ID: <c569af6a-8a05-4c2f-9f43-f3b435f54749@acm.org>
Date: Wed, 8 Jul 2026 08:51:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/6] null_blk: move unregister_blkdev() after
 destroying dev in null_exit()
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-4-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260708073917.2172392-4-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 12:39 AM, Zizhi Wo wrote:
> In null_exit(), unregister_blkdev() is called before the null_blk instances
> are destroyed, which is inconsistent with the cleanup order in null_init().
> Move it after null_destroy_dev() so that teardown happens in the reverse
> order of initialization.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
