Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E217BA1;
	Tue,  3 Sep 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384722; cv=none; b=KPC/FJZn8cAD8OekuHyvjx4GC3IHZaGMgmjM5ax2kiCGALPzeLKJnZrv67VjvfNmBRNGK4jYNYIbnUiB75/3Kwh2xtHUM9LulkI6t1/RUwub1mjUsfohKs0EmUNxX1cEQBfgGDjdWSmPGMlxg11oc532j7aaVt98yB7ESRTLu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384722; c=relaxed/simple;
	bh=YNJvZ10III8fSzlNqoOO8Yi3tp6FC0ZOEsOObcglD+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGW4pAXAnTfyjlrQ7Yc7RLV2rnuntobXAORCZkBu1Pu4kkNqCbbwESq1Gti3yaLOKpcaLr7QFQkId9hVEisoJy+YNLZaJdyna467V8lOBWzk3gge4hit/ojeVvoPKRDpoGQDfxGnnD4BV04Vv0zLz9C9X0WsbuL7P6l39Qj67EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cUlfnWoh; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cUlfnWoh"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WyszR67vtz6ClY96;
	Tue,  3 Sep 2024 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725384513; x=1727976514; bh=ETztvBENBFjFa2gtk14V2B70
	sTk4L6Jv4z6bXiLJo50=; b=cUlfnWoh3aYMyiQiBxdJbLKqiePWdx2g6demDFze
	Blp7qKf5B7orQrTQ4UIAh92PDAud9g3yJw682SxO0Gkyb0Yr1BsrCeALG25Cnvpt
	Cm9aCvVSeCtH0xWar+tnzIGNo0stnjLpc0i16OMxa0bSVkkMw9j2LXRsm0X4uiXS
	Vm4p2mEBxSTIG4/RR44FGO4khmTLE/4pcPRUoO1A3tVQaeOrhjWf8QRPPb9JFS+k
	F1X1mbh+w0vmUIuCmZzpNUkQPdtUnK/Pv38eH6qJHv2cPNjAS3Q8FqZ352a73moq
	ApKjgx8Vg/4kifdwKPjCOtXe3lX+P7qj4qySkgGn6TFQSg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zgjE9tvZc3mS; Tue,  3 Sep 2024 17:28:33 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WyszP3YDXz6ClY93;
	Tue,  3 Sep 2024 17:28:33 +0000 (UTC)
Message-ID: <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
Date: Tue, 3 Sep 2024 10:28:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 4:54 AM, ZhangHui wrote:
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore,
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms.
> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
> scheduling efficiency.
> 
> Let's fixed this issue by moved non sync request completion flow to
> softirq, and keep the sync request completion in the top-half.

An explanation is missing from the patch description why this issue
cannot be solved by changing rq_affinity to 2.

Thanks,

Bart.

