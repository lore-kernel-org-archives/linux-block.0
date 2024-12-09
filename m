Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F213BAEE;
	Mon,  9 Dec 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767396; cv=none; b=M9Dj5a1Rv7PL2uQ4a7y08bcD2xgjNtN7pViCzQCP7jgwNjReLkWMZFBFrdFpE/j6xRjuIf229ijR5aWcofh77k3byNE7XrlF4R4aBZCWHYmTxiiah8+sYMyMlB4P8lRqB4SU/W+l49zQYj+ikv/C2BD0FXrymj8AK6BxYpY6wQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767396; c=relaxed/simple;
	bh=Xkf3rZcdNKIgI2QpssiA9RRjQfb0jQHBav21vRF0HlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEYT+6eGbFOEBaHzyZuX6u2Rw3gT1pzAvHpurkJEgIZ9Qxawz0lbawphE6zwZjOYGdOKqF0/BwcYmbsjnPdthFYhRArn7AqQhyMcJsXza/LQIh85LzcoTvEv5khLPBYYOROs0UPKRp7q1XOUelt7t5ArYEm/bMdGVNpKBWbrzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JxNxtaei; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JxNxtaei"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y6V8X3vv5z6CmM6N;
	Mon,  9 Dec 2024 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733767382; x=1736359383; bh=QyfTuLMhyhlY0D4S6FtpsgDx
	2SCepf9ur753iNIB9Sk=; b=JxNxtaeieeSZDDtTLa0WCuED+PR6h93dfAINCUcu
	s0InJ1y5TttweQ5Z8kaLRsAS/U3ufKW3D/ZCA9R5bWVGfJ2L3jGQMVj1VC+isIjo
	4mllyQABB2gKKUO01L4dc8DssnVSdnbl7V2ZtYGu3gg0jo7iBfL43Gwgz29DrLUK
	AzpGEd3Vwp8HgaympCrVzcouQkQF1svaC3z7QKABtmplr/ZkkNb/vzclDskM+UZM
	y4jOAO5MdaJASBTHMvtoUY+5BeKpiow2vEnrts58kyJqHP+ZX6xU3U+Q+kFxJwWl
	5Cqlux3y2IUJmmf4Y8KftM/jzJuoK2d9fTFUBROaj7dkIw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DHC-zwyMc0Gc; Mon,  9 Dec 2024 18:03:02 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6V8J6Shfz6CmQtQ;
	Mon,  9 Dec 2024 18:02:56 +0000 (UTC)
Message-ID: <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
Date: Mon, 9 Dec 2024 10:02:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yang.yang@vivo.com, ming.lei@redhat.com,
 yukuai3@huawei.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241209115522.3741093-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/9/24 7:55 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This reverts commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8.
> 
> Because tag reservation is not fixed and will introduce performance
> problem.

As explained in detail in the patch description and in the comments
added by that patch, commit 39823b47bbd4 ("block/mq-deadline: Fix the
tag reservation code") fixes broken code. So reverting that commit is
wrong. I think that patches 1/3 and 3/3 of this series should be
combined into a single patch.

> 1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
>     deadline has no reason to do this. And this will cause performance
>     degradation in some high concurrency test, for both IO bandwidth
>     and cpu usage.

As explained in the commit message, this is done because
min_shallow_depth must be less than or equal to shallow_depth.
Additionally, mq-deadline is not the only I/O scheduler that sets
min_shallow_depth to 1. BFQ does this too.

> 2) async_depth is nr_requests, hence shallow_depth will always set to
>     1 << bt->sb.shift. For consequence, no tag can be reserved.

This is not correct. dd->async_depth can be modified via sysfs.

Bart.
