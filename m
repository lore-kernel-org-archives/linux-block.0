Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036444;
	b=YX16267N6K+/HT1bOAkmrqey4auYVNb9OAt0bjk8JjV9juTYvjmKwXqRobpADA6OV+p2
	 Yt/UNSxmIN+ssAbsQrfivrUN4WXXDT05EP71rFjNYwaB+8oJl3BsgYi4KNTw7wNFFtS/0
	 T0yUdNXiPGzZITF9RH2kB7H2tEf4S76mRMWB9/4wswXzTBpuQpcvpeDy+FbcE38QPNZbC
	 w25WenHkWuFlDyAewcFeMc9NKyqckZD2FUY06wY43R72pVOZuUVEpK0TXFh1BQVbCOErR
	 XmVuu9jFmq0WWhqCE7u0zQD8lo+wEmdXmBamnKS0BDL1DIiQlyhxCX89iz06Rgaxg8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6HBCpv1D50rW4AdfY6Zn71vT7BLiSMsWQxZimr8PLSA=;
	b=EXPG2oOCCxS8VPb+a/QogP4pgqZCHuyX/ZzlZWv05qTXBUHyzVsDz2hITr8MLhYO4HnA
	 XggwUOpX39+LaVNye/faTyGQOjbXKw3kmDZfUjwsrwWVSo6ZTjAIck8f2dxZQ4t6Btvdu
	 ICMz3cpAoxAx4ncd0JTgIruoona8PkHJbLm4f8xDKqtGlPj1laZdzQT9nFDymbWc5Jsvb
	 o5Mf7JmgDSSRYTmTcklAX3rwdAtDASxKw9MChD72QVMdnTDbNB3FFGq4ZjBfWEBHpbsqx
	 NltCdETkvqPg6u4burg4z335AP3Nq6RvwdHu4ZogD5SAu6iAvLnYiG9v0NbO6EhKJ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JOgNhNsl;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E04606A31A
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 17:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8E04606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JOgNhNsl
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jD1B31kXFz1XM30g;
	Mon, 26 Oct 2026 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793036441; x=1795628442; bh=6HBCpv1D50rW4AdfY6Zn71vT
	7BLiSMsWQxZimr8PLSA=; b=JOgNhNslo3oby5M2HFKjJgbZlgYTdklqBo016/G6
	sZEkTa0sH2Rcobnex/WxyxG3WNk0TFUhnuNC2USgwvkgQiW8VkEygH23fq9HQYcn
	AvHLdinlMgn84oOzQrOOfSusjgnY9s4Lk8RHhGZgmLztq71MCQcriNltJ8fb7MPZ
	kyf6R+bWvIo9d+dmIgc8L97Z4HGIY1YSd3ZezgvCNNoRXJbjRlRAFztbl4gZVXwP
	QSiSbRL3fFNGzjDlbEXP7+qjMoTdWvO+zTvdWi+zdx4pQui2s1WuANWOq4Ml9ho1
	HGcBx/m4ZkoUzfS7tBHYj+MbmoMFvncENPO5lbOcV3nTKA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MAQPx4w3Ik-n; Mon, 26 Oct 2026 17:40:41 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jD1B1356nz1XM4Tl;
	Mon, 26 Oct 2026 17:40:41 +0000 (UTC)
Message-ID: <de07b8d7-80ce-49ef-a424-9693042e57d4@acm.org>
Date: Mon, 26 Oct 2026 10:40:40 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: check for read-write open mode on
 LOOP_SET_STATUS in lo_compat_ioctl()
To: Dominik Maier <dmnk@google.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dmnk+artist@google.com
References: <20261025200740.2064379-1-dmnk@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261025200740.2064379-1-dmnk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 1:07 PM, Dominik Maier wrote:
> Assisted-by: ARTIST LLM
> Signed-off-by: Dominik Maier <dmnk@google.com>
Since this is a permission bypass, please add

Cc: stable@vger.kernel.org.

Anyway:

Reviewed-by: Bart Van Assche bvanassche@acm.org
