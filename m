Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD870830;
	Thu,  9 Oct 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029371; cv=none; b=WuDvwxj5DMfNMnSslKeXNLLBR/60CndLq9KezGJT7C3iCMtV+oFUYHeA0YilFl61HsouXuBEcJ1hKui/CzHtddWjKcrVHukx1HmAAWQzewsjqtm5dWwaiUoALS3jqq9lAhmEoqP7iOaiYEO0qkclN/BE3IxapNLWiXoLHayPPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029371; c=relaxed/simple;
	bh=Vk0WZne0ckcXOS9aSDqZ/e8QPHNPr4IH+y0smiVWHaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItMgi20P+f8scLhZhzYvl3LuOkdqmBvzquPW4QuKT9wD7cRqWl+GK5t4j/YZJ0kDokLEBkzfwB36KpLhZRFtJ9Jdd68MT28tTtn8SCim+fv+9fqjo25rnha7kz490Q6Nr++RokS0zIw2j5+lGYfiIxS32oeagRC27eTJrIlI8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iOxEOv+i; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iOxEOv+i"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cjGQd0tqnzm16km;
	Thu,  9 Oct 2025 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760029367; x=1762621368; bh=4fiahecIXq1djVixNOIamEFh
	sM6eRYvOL0gCjVWJ8uc=; b=iOxEOv+ix+f9gnzaB/X06IkAwHlgmBZDjk5D44Nw
	p7LlJmM9jfMZDVqSVOse3D8QREDT2xfdOXSnkbotwkQr7QwRgV0KayrQHS9JJzYs
	4yhWM+sxFJxbLcX4etsXf/tcjrc1JhncA1oBf6xQqBLsO1KLqXPIIUSaThRfuyIS
	ndOGgpcEKumEcZWH0AUL3OprD1brSCroS5vdaX7G+AKwQ5XQR3PG/fotggGHWoun
	I24hGR/Z4+4+ZYAkBWt/F6lwkjr+hLs/M9/GAKebVYPCahyDjgMJ31NzwU4/pRGb
	IcnuXFQWnHjczUt2x66e+pRqNb2EZw03pfWr+2BMsYArVw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UStVePItFUTU; Thu,  9 Oct 2025 17:02:47 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cjGQM2GpKzm16kl;
	Thu,  9 Oct 2025 17:02:34 +0000 (UTC)
Message-ID: <c7ce7e7b-3195-4609-807d-fedc87515740@acm.org>
Date: Thu, 9 Oct 2025 10:02:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 2/7] blk-mq-sched: unify elevators checking for async
 requests
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com,
 nilay@linux.ibm.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251009074634.527661-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 12:46 AM, Yu Kuai wrote:
> +static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
> +{
> +	return op_is_sync(opf) && !op_is_write(opf);
> +}

The "sched" part in the function name suggests that this function
schedules something while it only tests something. Maybe
"blk_mq_is_sync_read()" is a better function name?

Thanks,

Bart.
