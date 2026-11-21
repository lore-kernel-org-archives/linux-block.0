Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795272357;
	b=3Dpqe1NKWogza4ZrHa7dpJbk65WqTumgQ4ZKb5j+mILGPbtmb0dMJ0ypFgz+gY8aK3p5
	 cc1+93hteeTUuxZr1XRvWvQUx/2lwmRgEw3V+Lb2jiVTMA6nJc/YLytAVooSTVOm0EIEV
	 V9VLEv6ICBmLcWlTyXOWTYB40KGcB4JHiZJ/uT3KVVI2cQUM7jPRGnO2EuOZ3TxhG+sfL
	 Q/djFNJRwfhxo1BBStwysn/1VP8NxDEBF3tGGFi+o0PsaikUUlF4w4D2H1xh9IONL5V8D
	 HsmqJ64AoSUppDTAAPRizglWEMRVM8sEoXLWS0C0RoQc/ud2PbkcZ4WM94YO2PmIO8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795272357;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qoJjT3XHzhhR0jlFcDuVl40OhsAjxWfq5HgQnsOgtGY=;
	b=NCmFjXeSzr+twpYLwoks3qyWRS0l5rTngKl98TX7FPkCweZRUK5qMepJOhk5NSf1xnBe
	 kAlumW9FHUrM/AdDQbKGl4TKrdL0SjxGAV6ZPisPVb/4UIRn0r02EIEpPc7ANml92uevW
	 Zk+Q5rgfrG6VT4c5u71d8WHjaRW+aRIFsgZKyExoyqSGoWUGjTFMI5q7Cx5F+4jYMWHCZ
	 oHkbrnfDT+hzzhkKnCtedC24kanb7FNkRQi8oLok1qXPlkgGqlwaXEfWdARXRPx67RAyl
	 UHrn8sECgl2sy/63IzeD204avzqWAMU6jXV6y5KPBe2Q9JFd+t40McLd1MwJjJQ1JzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hELqwDLM;
	arc=none smtp.remote-ip=91.218.175.61
Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8ED606A32C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 14:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8ED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hELqwDLM
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=smKWGNoWfIILM/j62Dml3s9EICUrHGZXqHo1D1M0PPk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795272355; v=1; x=1795877155;
 b=hELqwDLMoT6afUpg9uYamEVtxMrqHmyfnhtB/yPXRxI+EoYhiiVPBe9v5ZA3az5rJ9nlBwmK
 ewlaHExFuT8nqipwsYGzw+qG9B5vuDzVRp9qgu0twhkXvy2GJfwgt3R3bN/JJq8RxOO64eZjVbU
 ojX75tC7xglTyOah6i9Cg6Ec=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c0fc2c6103f5af1b;
	Sat, 21 Nov 2026 14:45:54 +0000
X-Mizu-Trace-ID: c0fc2c6103f5af1b
X-Migadu-Flow: FLOW_OUT
Message-ID: <23172468-4a69-4986-ae85-ea1962717f30@linux.dev>
Date: Sat, 21 Nov 2026 22:45:46 +0800
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
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260928093512.3153646-1-cui.tao@linux.dev>
 <df36224b-7fcb-45c4-ab78-d7e726bfeb9d@acm.org>
 <edfc22ef-799d-4f70-8668-bde0caf67bcf@linux.dev>
 <f00cd07f-348d-470f-894a-c70435f45076@acm.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <f00cd07f-348d-470f-894a-c70435f45076@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Bart,

在 2026/11/21 05:23, Bart Van Assche 写道:
> On 9/28/26 7:08 PM, Tao Cui wrote:
>> I'll send v7 with the comment fixed and the redundant cancel removed
>> once Tetsuo's series has landed.
> 
> I can't find v7 in my mailbox. Did I perhaps overlook something? As you
> may have noticed there are no plans to merge Tetsuo's series.
> 

Sorry, you didn't overlook anything, I haven't sent v7 yet.

Thanks for the reminder. I hadn't noticed that there were no longer
plans to merge Tetsuo's series.

I'll refresh the patch, rebase it onto the latest upstream,
incorporate the changes we discussed, and send out v7 shortly.

Thanks,
Tao

> Thanks,
> 
> Bart.

