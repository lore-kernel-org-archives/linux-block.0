Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B927933A;
	Tue,  5 Aug 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408145; cv=none; b=diABHhkwoPr5SmNdspCllMRmp3baMn1I02QGwqWMJ0dch8F6RdYD3cIcAgu1Ml88YcVHjTKCTm0YnnCKdzR2z0qCI1cKD0cagSS8ZYLjqksmOfVWINmBQXyyCuCNwi94Fb0HIr3NJXIc9tVgDvs07DrBwXS6EalreHdkSnhHZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408145; c=relaxed/simple;
	bh=+5Qsxq/T4w0ZGPyPBqCczmAvgqWgVMUPoZBStuR3Cpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdAQgajM1z1Ts+8Xp32WxWAwBrMr+urqSMnqmsgdtcUOZRB9DSxbHh1FiAzd05kKI1QnFoB4S6VaGJbLxhzRH9D1ZybHVPiboid4hURDdrS62i6MgD/N+ZM19Y2z/Al8vdUCdehg+s8dObm4FdjZACtKVhp5NCQDli+M9bwmrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pOZA8Qkr; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pOZA8Qkr"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bxHZ64DQyzlgqTp;
	Tue,  5 Aug 2025 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1754408140; x=1757000141; bh=+5Qsxq/T4w0ZGPyPBqCczmAv
	gqWgVMUPoZBStuR3Cpo=; b=pOZA8Qkr8YPMD/b7BTfKqmUQMx6ORCS0ZwzLX5ht
	6bmiBmWw1nBIIifB7SXF5OyI/YLTRMcnE4k3HY17hYLmPk18LdlDbD//Xc8tzp9/
	CYK9tVGKU81T2cvIWe6PAxHQBqOpfyr6YoNWe98Az7BOPV4E3s3FgIvovVYcvV5e
	j8Sfiky9rEzi8TkQ3RMkHXNt8qBg5owIrmLlDbCoXDJbunoIagWGiJ3R0onNcG/a
	vsJtBXfPQBjoq312oW1LMoE4kfGD9Za/7rf7k6/ouebxI9H9WvJRU7KEjnpJztCK
	FDFGOKHLjGWdl76hVkZLbG5pHxicDZMbRX2GJPPSIlpSyQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E_0mWYxqqj9m; Tue,  5 Aug 2025 15:35:40 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bxHYw3GW5zlgqTr;
	Tue,  5 Aug 2025 15:35:31 +0000 (UTC)
Message-ID: <1d0a2486-1295-49d6-af36-3bf9c15bd05e@acm.org>
Date: Tue, 5 Aug 2025 08:35:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] lib/sbitmap: make sbitmap_get_shallow() internal
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, dlemoal@kernel.org,
 jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250805073748.606294-1-yukuai1@huaweicloud.com>
 <20250805073748.606294-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250805073748.606294-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 12:37 AM, Yu Kuai wrote:
> Because it's only used in sbitmap.c

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

