Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665001372;
	Wed, 18 Jun 2025 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205973; cv=none; b=Hqm1ulDmdwyZMxIMvEeXQIwJup/szlP5LqIWyPMCowm12mQJJQzoUjHrRqXSbTWZGsrMEXEQ/xwRaL1ex+m/e3YezhOu0BFRI24ZX9Qe2ufaoLwivsUaqmyBAyfsG2HPtS153fIM1snlfVWH7L0iMKQfznD4irzv9c8iIEy7zcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205973; c=relaxed/simple;
	bh=icjYBfoK1conaL18TuKYZ97I3FET2WfZbndAKc8Ht6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr6ZUhopSLQRdaG4zwuJMd1lD7/AV7n3BXW0T5MSkkk1iTV0sHVqLvHT1rDYuMCzDHqjOuOsw7dIXpbJGs6/oKmgzp8ZC0pkJzZogEe3TBKNt7uXOuhOBC/ZAFV5tISPQfjgyAjoKuzSo5HNaB6cgQlZ9Qwoxkx0hopREGKpZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1gi0s1uB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1gi0s1uB"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bMPW62TgMzm1HbY;
	Wed, 18 Jun 2025 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750205969; x=1752797970; bh=5BDRtoaYC7pOiogJOv1dRMkx
	6/Lvg6YOlAmKmtoA/xQ=; b=1gi0s1uBys4zPl/mezcHdVI7rz4kYCrUmq5aGeJT
	wfRR0XxkLbqLUHmVe5D/uDB6HkbxIKSD4looZUDdeHs7Yh2gG9z82tJi6Z82O33I
	z4ZKRIIW6M4OweJIqeVHt+INbYRDTw2bWPCJBlqCDTk4IRho+QSSdQQQY3PKKOwG
	UZSlarZn+nyqNPOnioHfNTqSfcBiTvvXvRUaGJDKKbzPZQNXosVOnj6VX9R50j85
	zg2YhpSn7BTsIAAzBQteISuyvl2gd9PtkaBVSb0EsejGBYrpYr4KJJC/QVCpH2te
	jcAK4fP4QkW374cy8J0XRVSVpY4q53BWlvLSIDsaIkZskw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G4JOddGAgTwZ; Wed, 18 Jun 2025 00:19:29 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bMPW21BPqzm1HbX;
	Wed, 18 Jun 2025 00:19:24 +0000 (UTC)
Message-ID: <23f31e20-e58f-44e9-b81f-18811ce5c19c@acm.org>
Date: Tue, 17 Jun 2025 17:19:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mq-deadline: check if elevator is attached to
 queue in dd_finish_request
To: Elijah Wright <git@elijahs.space>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617205630.207696-1-git@elijahs.space>
 <1e25d17b-f481-485c-85a6-d5a8440c1c96@acm.org>
 <b2644203-b1cd-4bc9-9afe-bd0ae0390ae4@elijahs.space>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b2644203-b1cd-4bc9-9afe-bd0ae0390ae4@elijahs.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 3:52 PM, Elijah Wright wrote:
> I see. would it be possible to detach the elevator from the queue in 
> elevator_exit instead?

elevator_switch() is called with the request queue frozen.
q_usage_counter is dropped after the blk_mq_finish_request() call
returned. So what you described in your patch description can't happen.

Bart.
