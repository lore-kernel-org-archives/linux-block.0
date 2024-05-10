Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4F176FA7;
	Fri, 10 May 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383387; cv=none; b=lRIUWM3YkpGp4VJJC+xFzLgBamhCA0TbwdrUmOLqtZl6jK/6x45+DyPONPa+BpB3xUg+4wED3UAk89U7dyc6v3KI4gjAqvs5epwYkX6AwDqEAmAcSFBHNDqvjpFCBrB/uJmcMXMG0ubheWyVDOwOCbHn+OhW/2uqqJDHY1hgTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383387; c=relaxed/simple;
	bh=yf0FNSjbNgNh569vaKttKl6BvtWgoLVJ7oycuOUTvPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcGTQEe/tG8BwAYFoLmmO0I9juFsr7VMR310ZYksxuPLhlztKZaW2D1Dv+KjKul9pnIV1AfJUx2GphmLOX/DvcfJq0+f+K3hVbr98aXq97iGf9cA4TcThasfFBpmgZ1hB3Sxa56dDKqxuJy53xS+ulRvVeUpJ78V/Pfowzf2++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uj0AKQCB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uj0AKQCB"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VblL05vCSzlgVnW;
	Fri, 10 May 2024 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715383382; x=1717975383; bh=CzEDEmar4vsS2I118T5B//2s
	E8cJCPpqhlzHZWV8EcY=; b=uj0AKQCBAE3s4MP1IZ41tUiPyIra1cn69rsXPpN4
	cevWDAEpQ8m/pD4PUucE/4xyl8B52xP2WakpjoJeu0hYYGaqtyk/rUPDFp9Bwzvf
	n6btg1lkxI0hINgWC5QcUqdg6mFaGYLA3t+Hxow/M9jBUt4IA2Jo7OoHQ0VmOZFr
	L+F+hHTIK1sp0429k8ZkACIwr2/v2OSNnMAGGKjTLbEKrURqzHPcsb+vBqNsHd/j
	D4G5/O9A/9c/WCBQynM10+6EhQsX0XuQTl7zSP4Yw5tipWx0Tgitp8CRr9K8HQBC
	nuphGhrQj2IM0pPGZT3L+2JYN9J70fS5IW5/Io+Udi6+Ww==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ps412-NO1kid; Fri, 10 May 2024 23:23:02 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VblKw52rxzlgVnN;
	Fri, 10 May 2024 23:23:00 +0000 (UTC)
Message-ID: <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
Date: Fri, 10 May 2024 16:22:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/24 3:35 PM, Paul E. McKenney wrote:
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index c00cc6c0878a1..78593b40fe7e9 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -194,9 +194,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>    * This data_race() macro is useful for situations in which data races
>    * should be forgiven.  One example is diagnostic code that accesses
>    * shared variables but is not a part of the core synchronization design.
> + * For example, if accesses to a given variable are protected by a lock,
> + * except for diagnostic code, then the accesses under the lock should
> + * be plain C-language accesses and those in the diagnostic code should
> + * use data_race().  This way, KCSAN will complain if buggy lockless
> + * accesses to that variable are introduced, even if the buggy accesses
> + * are protected by READ_ONCE() or WRITE_ONCE().
> + *
> + * This macro *does not* affect normal code generation, but is a hint to
> + * tooling that data races here are to be ignored.  If code generation must
> + * be protected *and* KCSAN should ignore the access, use both data_race()
> + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
>    *
> - * This macro *does not* affect normal code generation, but is a hint
> - * to tooling that data races here are to be ignored.
>    */

This patch changes the end of the comment from "*/" into "*\n*/".
That's probably unintended? Otherwise this patch looks good to me.

Thanks,

Bart.

