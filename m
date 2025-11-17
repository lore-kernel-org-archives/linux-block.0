Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326D240611;
	Mon, 17 Nov 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422571; cv=none; b=kjfaKDWXLQzdGwZbhoQiMUyKh/G27e7eUwOZ5jO64y+lqZJclKGxKQw3os44lvsk6xM/y1xNSIJAQYDMC/m15AJSHi2zF2g1BKR5nvQQ4gyadZyg5Pkz41S5Epa/4K1RzCMVmPQxDMJfHpw9sch4WV8mSTpPMKqvNv9A8MCU4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422571; c=relaxed/simple;
	bh=CqAiuWx671TfGJazmy60B8X8L2YiHYWbb/x1rDa6xLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfmPQz2AhdfHJQtf568WIWND3pQHTQn8TqDBI7INp7F5uDWI1PPzjB8YAGFtzuYreeccftAuhPqhylKKpbdnHsYf8EdoolD6AiNytaziv1GD4t0U552UII5PUMOjqf2hZFXzXuPEl0JArqKNPc0Q4NAkPaqoqlrp98XNPOG9fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V2EHWgXr; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V2EHWgXr"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d9PJJ1FwGzm178n;
	Mon, 17 Nov 2025 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763422558; x=1766014559; bh=jGLbVq8zMLhosLbIKOrPYTfi
	DKj7b4/R4ulQpHaS8o4=; b=V2EHWgXrRPm1QHwuIAamGgnXWz71yH8V8DUIYt5o
	bb9Q91HhO4LcquSGqjpWdqNYAxw2YVPrQ1pYzB5Aar+ezzQL5YMdQUfV0Iuza0QX
	ZOjcAhYX0xSD77RKK4f0UowY1bqWaa2PKHQF8Ta0yqlwrzBU0kpt9xDkTjzkYWoF
	lJHTA84MiUb8aJXwuzCVljLxnERtoFNVqqIKZXWR/FeAlGCdBz2/itj7dOMMGgYI
	ymiv8Pvyr+jX5/OoKCX7KrBh4eaj2IIVU46+0FxW0RSDJa4dNM7pDGTnold8jH7u
	V/q5tENp6u6SBydyniqyH8+VoVxyjcA0c4D6eLfz0fQVHQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tX9Bqg6I4ZDi; Mon, 17 Nov 2025 23:35:58 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d9PJC3Gsmzm10gb;
	Mon, 17 Nov 2025 23:35:54 +0000 (UTC)
Message-ID: <d6073899-710e-450d-9907-1a7a69a4a87d@acm.org>
Date: Mon, 17 Nov 2025 15:35:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 2/7] blk-mq-sched: unify elevators checking for
 async requests
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nilay@linux.ibm.com
References: <20251116035228.119987-1-yukuai@fnnas.com>
 <20251116035228.119987-3-yukuai@fnnas.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251116035228.119987-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/25 7:52 PM, Yu Kuai wrote:
> +static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
> +{
> +	return op_is_sync(opf) && !op_is_write(opf);
> +}

The name of this function suggests that it performs an action while it
only performs a test. Please consider renaming this function into e.g.
blk_mq_is_sync_read(). I think the suggested name reflects much more
clearly what this function does than "blk_mq_sched_sync_request()".

Thanks,

Bart.
