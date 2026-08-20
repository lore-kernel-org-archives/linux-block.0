Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA89476CCA
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239898; cv=none; b=fZRF3yoPWlHubA1wMMsgw+mr5ycY3fkQ/pXaKrzsEKvATyjVyWUptarUQnrEi4J6idzb87umlAYgMITmFpgL4/Sj1WBRaSqJrI3VUNp71N3u0dXcyUoZ+tAIz17y2wRTY+KBGtjf/P1Jtfpb47zRnEUYn82wDxDeZqvr9HB6LiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239898; c=relaxed/simple;
	bh=klab0SduQ0fJaMSq2fUFLkqEqkKNAQEZklclG/k/C8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JL93p1FHMr9kLkfPgDxP+VBKrySrr1ScMvevRO8vt8Yyeya9Jn5truq8gx0HsC8It4TnSxZpxqH/Y8/UjsMc+iMG2wmUw8Vje4N6gQ6DQBw5ujnJP3qjqNSLlk43IZkOE0g1STthsE45ZZFQ3t6ee+ASOwaC2HKC5s15r1WKzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oFixJ8cb; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oFixJ8cb"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQnTy3sBDzlfwJB;
	Thu, 20 Aug 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787239891; x=1789831892; bh=klab0SduQ0fJaMSq2fUFLkqE
	qkKNAQEZklclG/k/C8o=; b=oFixJ8cbeTIyG5axGBWAY9UxD2gh+OQiGnqnkNPu
	i19IeooWrCgNd78ebujj+3R+XpV9bFP0zO41UhHTn2TFsoldSXc91sCD1em+pvaV
	83q1d9Fo+1jAKEzftQLoig3TOwwpZuYVYl+WllPF6HnXS6tdLAMnWl4ZiXNCe660
	6G6IHHJECCb9d7H4kpWaOMGsmoTF8eQ4G5gTukdp+xu7tAUMpbShfEwkoIPge9IC
	LUwKrXnWxP8ii477P7U1pzH1d4SK+4jtV43zkOPSr8aORWyr56IyKxpkCPLlRGtV
	dhj07lldhzuQuXFiNH4K4XK1/nRFQcL1o8kl5RRpQAZ6wQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HCpJjfhgBe62; Thu, 20 Aug 2026 15:31:31 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQnTt1x3jzlfvpW;
	Thu, 20 Aug 2026 15:31:29 +0000 (UTC)
Message-ID: <7b469479-e9c5-444e-919f-c18c17893bb7@acm.org>
Date: Thu, 20 Aug 2026 08:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: disable I/O priority when
 prio_aging_expire is zero
To: Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
 <20260820021246.2681624-2-yebin@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260820021246.2681624-2-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 7:12 PM, Ye Bin wrote:
> Since the mq-deadline scheduler introduced support for I/O priorities,
> if a process does not have an I/O priority configured, it becomes bound
> to the process's scheduling priority.

How can this happen? The scheduling priority (sched_setparam()) and I/O
priority (ioprio_set()) are independent as far as I know.

> Setting prio_aging_expire to zero does not actually turn off I/O
> priority in mq-deadline.

prio_aging_expire should not be set to zero. Feel free to submit a patch
that disallows setting prio_aging_expire to zero.

Thanks,

Bart.
