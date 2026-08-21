Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF7353A7B
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332946; cv=none; b=i8oiYCIM3zNkGgNx3L52Lh6qnA2UVuMBa6iXuEYKPQ2OmtU3EewjBihnqv4R0wDsgjWpuNm5n6tl1TQocejdHqQ9vg6hmw748a358guZL0lgjdXgbKph7hodvhamcMLisb4tBXMblnAtEtEDpaPx68Hrdniu2UjZxyNEKdfXwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332946; c=relaxed/simple;
	bh=bZ5qDQh++isYWJSdhA5tr99wIppL2qpucFubxxsnGPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyltm+IFd5jJzLtFUVz9YVag4PGPH8VVlgZq5a1SU7Sssn4H1vBZF+AwGvfM9aFzHUExGH/fpgTjLf5CMih6O1gqWxJ2wPedBsyl01AQ7mXfhavMhC97OSTnNDZ/tuHlZYJNfHbxskcHDKtuIXBrA/Tw+b1v9MNr7LXExuvQExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vOCGdHQ6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vOCGdHQ6"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hRRvN4Nk8zlfqB0;
	Fri, 21 Aug 2026 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787332941; x=1789924942; bh=PVnUTSNodKVY/5Rexjvn45Hb
	A+9MzdFumvVwsFCMMCs=; b=vOCGdHQ6swEmB26tcZ0EjlWGNUs5vP9kxtJ+7uxy
	DsEby4W4izxwqEuUFYAyGbMrItrwUuU+SnOJ2xC7oELyDI2ErQuZbZyU9BojMRDb
	KfcsIry5Inff+V2JeMPN6bfAIOEW2s0qzvploA6O1nJNMH+BNgPx7JZ0VedLDVoN
	rbGmJc+8E2+Pd+ZL8/2DDF3hC0inrwLLyQrLsgVNlT0LMfOtv0YRb5nNzv5YFyF2
	ZzX4Vib+9Oq0LqftnIzhpyyH1+PLUl9C6uTQs8Rlb0yRoZbqWxLVsFIDjnRDTWsD
	H68NP9yKMkogOF+Xpxdu7I0ddXJ/EyVox2CUHxbwSo9KFg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cQXsoY5ijZD0; Fri, 21 Aug 2026 17:22:21 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hRRvJ6djbzlfvpS;
	Fri, 21 Aug 2026 17:22:20 +0000 (UTC)
Message-ID: <ce3196e7-0082-414f-8b4b-24b575346f95@acm.org>
Date: Fri, 21 Aug 2026 10:22:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: disable I/O priority when
 prio_aging_expire is zero
To: yebin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
 <20260820021246.2681624-2-yebin@huaweicloud.com>
 <7b469479-e9c5-444e-919f-c18c17893bb7@acm.org>
 <6A87B299.2040207@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6A87B299.2040207@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 7:06 PM, yebin wrote:
> On 2026/8/20 23:31, Bart Van Assche wrote:
>> On 8/19/26 7:12 PM, Ye Bin wrote:
>>> Since the mq-deadline scheduler introduced support for I/O priorities,
>>> if a process does not have an I/O priority configured, it becomes bound
>>> to the process's scheduling priority.
>>
>> How can this happen? The scheduling priority (sched_setparam()) and I/O
>> priority (ioprio_set()) are independent as far as I know.
>>
> Yes, I thought so at first. However, after checking the historical records,
> I found that the IO priority was set based on the task scheduling class 
> when
> the IO priority was not configured. This was introduced by the f7eda402878b
> ("block: Return effective IO priority from get_current_ioprio()") and
> a78418e6a04c ("block: Always initialize bio IO priority on submit") 
> commits.
Thank you for having looked this up. Despite this, it should be possible
to assign the same I/O priority to all I/O from all processes by
configuring the io.prio.class cgroup attribute for all cgroups, isn't
it? See also Documentation/admin-guide/cgroup-v2.rst.

Bart.
