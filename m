Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C601DDC3F;
	Thu,  9 Oct 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029983; cv=none; b=rZt01dj9mNt3m6vcPeFvUOW0BVmOyc99+WHiajjHpoV0n0sQLMHtF1AA4LlUKChSP7IW1m3Tp6S27uG0orln3uANXJwLxBhDYJD/YOFvfF3YapXNBcApl3BxYlf+oofRZZxEceUhSULOR+UQlsKijx0Y++Ky3kjW1G1NtF2bTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029983; c=relaxed/simple;
	bh=U9lo+9kioT8562wFkWGZbm7DktFlqU3BOSDmQ77c25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhMoAi7/Wg3ww9Kv9Ksx99njiI5Wvray+Z+z4CpDPd+k2Rs9hZs/hSI+z4IDt1F2DanurvKLDDc3zCkzc2OeVsnzkjIHHX/eRWOnmnPAqVrrJkdxI+K5CA7WL6QSewNB23YSp9Vz5+WF160G4U//jVIUoO/wOg69uJMfMaZEn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A1Y+6zcD; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A1Y+6zcD"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cjGfH5D35zlgqV5;
	Thu,  9 Oct 2025 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760029973; x=1762621974; bh=ia8+pMNuyAPR6VuP12vXLSyS
	Ybeqd3esYzupBzto1gU=; b=A1Y+6zcDiT4APTcGfTAlFIRm/L7wbFqEmTk2UJLd
	KzdiZNajKc9VArevzVl2e0hU6Er2Vp+YEjqaaXS8QhyU39mdwh8BpOqglDtim7SD
	dAj2rLCpcF5tJV4xTUwd6iepZpU0+Jc7CzKshBV5EHEScUYDfV7aQoM7210rvnBJ
	VJnwfUDDB1C9/co+oRU6P9Q73U+zabljOUUM1bzYlFDPltUmTusfrVZbD8TYXrEs
	Z75Ky56uQ4oNVlUCqucE/ac6MpJ4RwXEetu+Q/CgsSJr0KgnN3EIGohkTFMO7BUu
	38zZHIIdCCi9zFyb7YQsuSvt5UZufFo5Ltgl1h1HguPbRw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id njhFni6-9k0G; Thu,  9 Oct 2025 17:12:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cjGf52pyszlrwfR;
	Thu,  9 Oct 2025 17:12:43 +0000 (UTC)
Message-ID: <37a9cfa0-b6dd-4191-be41-ffa7b509b1a1@acm.org>
Date: Thu, 9 Oct 2025 10:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 5/7] mq-deadline: covert to use
 request_queue->async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com,
 nilay@linux.ibm.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251009074634.527661-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 12:46 AM, Yu Kuai wrote:
> In downstream kernel, we test with mq-deadline with many fio workloads, and
> we found a performance regression after commit 39823b47bbd4
> ("block/mq-deadline: Fix the tag reservation code") with following test:
> 
> [global]
> rw=randread
> direct=1
> ramp_time=1
> ioengine=libaio
> iodepth=1024
> numjobs=24
> bs=1024k
> group_reporting=1
> runtime=60
> 
> [job1]
> filename=/dev/sda
> 
> Root cause is that mq-deadline now support configuring async_depth,
> although the default value is nr_request, however the minimal value is
> 1, hence min_shallow_depth is set to 1, causing wake_batch to be 1. For
> consequence, sbitmap_queue will be waken up after each IO instead of
> 8 IO.
> 
> In this test case, sda is HDD and max_sectors is 128k, hence each
> submitted 1M io will be splited into 8 sequential 128k requests, however
> due to there are 24 jobs and total tags are exhausted, the 8 requests are
> unlikely to be dispatched sequentially, and changing wake_batch to 1
> will make this much worse, accounting blktrace D stage, the percentage
> of sequential io is decreased from 8% to 0.8%.
> 
> Fix this problem by converting to request_queue->async_depth, where
> min_shallow_depth is set each time async_depth is updated.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

