Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8E158A2D
	for <linux-block@vger.kernel.org>; Tue,  9 Apr 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698616; cv=none; b=aGUNQsS/x071uzOyLOAteFONv/Qho9VAmnNj0e9ZtfynIheE1DBOfSoD3gqwXG+k60el6NXFVLIaJp/wUXVBvh6djnBU6NoxbXJ/Fi/JgmEKzm2XWNVy/+ALIHVIPet1T7x7j3APeSFICeEGHQm5fm/rdtZ3hGT4mmUWt7lQqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698616; c=relaxed/simple;
	bh=toMwUdybO3TmwAJqxOIQKt2IefjGal/g06587IJlq9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pyEUUYXyo9L0f+GkXQQpbCx5jfUeYgj1gsHEScbJQXif58Xv+KPWtju6nkS3EQlq/rEvyID17g6fNEp4xCwECJjy0w1mYpveAHF4ZuyochjL4NC6IzMvuy5AMetNmO+ekroBqc1h3afuIbtGhoFXgTveDbiaTjt1VlLanpE3+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JZGolBks; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JZGolBks"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VDfRn6Nxzz6Cnk8s;
	Tue,  9 Apr 2024 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712698613; x=1715290614; bh=toMwUdybO3TmwAJqxOIQKt2I
	efjGal/g06587IJlq9k=; b=JZGolBksHNXWz+5Mh6x56aFHhO/53jWtG/QK7eFN
	NT8W7VjNQN+GK1hUEZxIGz+mlworpc3p8UYI7Nez1HfBpnck2F73a3qbS23lv80a
	/2A7SUYPownXykBg+7cO3BVs2QFn2S1+nE/bptv09FcOHTb0uhdl6mhQcECHfTqG
	y4b294s3INQAxqzSdC/q0fHytIMC+UIQY5CRDBSqEcsvF2Z+tNzV7ziMiBjTzqnk
	KdeUOyCcv9pGgpXzsMpNRxHsH7/MFSzS5wg6/P0NRRkTgwM+9FnOyK+nu49oCXqb
	R2/13bPsgnA3b3y5AFmCqe3kXSPsUaJVOiMdy4/KFeOzkA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 57srnu30beAi; Tue,  9 Apr 2024 21:36:53 +0000 (UTC)
Received: from [100.125.77.89] (unknown [104.132.0.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VDfRm5fLGz6Cnk8m;
	Tue,  9 Apr 2024 21:36:52 +0000 (UTC)
Message-ID: <9049e9d1-1f39-466d-ba55-ad33693b49f4@acm.org>
Date: Tue, 9 Apr 2024 14:36:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: convert the debugfs interface to read/write
 iterators
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <dc58cf1e-cfbc-4771-80b8-4dfdf5d7f0d1@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dc58cf1e-cfbc-4771-80b8-4dfdf5d7f0d1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 08:00, Jens Axboe wrote:
> Convert the block debugfs interface to use read/write iterators rather
> than the older style ->read()/->write().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
