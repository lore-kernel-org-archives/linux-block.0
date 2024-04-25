Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA943AA8
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063151; cv=none; b=hZAvLhTp6/luXskSA7hIbNi1B7yTPdHSuPzJACqFe2iV0kJEfgb0YnY5slOEK0YAH1TPVXRpfAi2VAVOe2yZR7sMskkscZKZAtSZoipPhk83jXZ/uFix+xepWjzKIsRX7nSkbuoTwg6lxr1SjnAXkDXOUD0uLiFuZkhtkcpZCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063151; c=relaxed/simple;
	bh=BXSfMFmsmr9TKsuvawCF4dHqk22N7RQNm6RjXnBKiUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gD6eig3mglBcvs84h07mbhui8v0O14AJoBjLmjB+2fQngpb7NNjuMgEUk2Mg1XUj8Rygf/el6x1zeuybm52hoC9Bznl1JWY8aK7rhaeL7XOB8jcJHptqmB2r3AdR1nvT1tUdC8AtSGohxqFONOc+6ENugMxKIzgiKRqpraLiQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uaA5ALfd; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uaA5ALfd"
Message-ID: <090427ca-85a2-409d-af1f-f41a1735226e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714063146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFaP/6gx9wrCuKESc0fZKE1isJuUlTsPiSFeS6pVwMY=;
	b=uaA5ALfdYrH+luH3bdNUxtDzHqZj1hXXPlAu0A+kexCyVl3JNkj+SS/MB9gpyRP7NmAMe+
	vxGHTUwSycEcpadEDECsy0mIbsA1FSz/Pt+ABHWULrptoPg+XJX+l63fKJ6thL5Z7gc97V
	SZXdrvdJf/cweiP7SQsph8pQuXTArd4=
Date: Thu, 25 Apr 2024 18:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] null_blk: Fix the problem "mutex_destroy missing"
To: Jens Axboe <axboe@kernel.dk>, dlemoal@kernel.org,
 linux-block@vger.kernel.org
References: <20240425153844.20016-1-yanjun.zhu@linux.dev>
 <65f8ef75-0555-47e8-9da9-c5a99892202a@linux.dev>
 <5f922577-514e-49c8-8046-79f6cf7baab3@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <5f922577-514e-49c8-8046-79f6cf7baab3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/4/25 18:22, Jens Axboe 写道:
> On 4/25/24 10:16 AM, Zhu Yanjun wrote:
>> ? 2024/4/25 17:38, Zhu Yanjun ??:
>>> When a mutex lock is not used any more, the function mutex_destroy
>>> should be called to mark the mutex lock uninitialized.
>>>
>> Sorry. Fixes tag is missing.
>> I will send out the V2 with this Fixes tag.
> Then please also fix the commit title, it's pretty bad. Make it
> something ala:

Got it.

Zhu Yanjun

> null_blk: fix missing mutex_destroy() at module removal
>
-- 
I only represent myself.

