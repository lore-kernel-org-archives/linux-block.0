Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705944CF22
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314588; cv=none; b=SCzdR9+EsD+B5WFLrvCOJ0KHzYYlMH2DKSkoMR8LqrMQ6DMnfOcxXKyGG6slYAw5ODFxXfRhOjnLNBonujm6dN/55JU4n4yCjIyq5S0IKZVju+KP3YvwHbTzqqeMAymcQYzuIAd2yPCpyF23g8xa8ZRGUYq23W4J/3ful5OVsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314588; c=relaxed/simple;
	bh=FtMo1W63Y0+J09ZMYdiQrRUV5guBJpdw8x7gi/iM2g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq7ybkoIJCiPcWwqOkyPkE0KF7w5QKBoiLwaX1Toc8eKo4sF9XtDG7nwuhQo9t0EBuX3RGtQMjRl1wrs2GgLBYAOKmx0NqobqetYYubpi+B0TxM/h185SLiALf9XmCp3mwF5Ys043s9jmB1n4tMqSJN3SXTAPl+1ELiDjKpO+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UurdF+J5; arc=none smtp.client-ip=95.215.58.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UurdF+J5"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FtMo1W63Y0+J09ZMYdiQrRUV5guBJpdw8x7gi/iM2g8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792314583; v=1; x=1792919383;
 b=UurdF+J5GtzfbTrFj5/xuNp/NMrK/7uqVdDDKTSaJ6wFGzcohE4RYWCpIxTbvCWTAJIgJ/Zg
 pEKyIHNhE+BJjgdb4WZsHoqCTuj+xz+RYKW4UCFnpONRLmOb7PCvLElQpV8UgjXVDyOKVwtCQfz
 hF54Z1mDPXnHh6WbJVGpLO3E=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3bffa196ad0c80d9;
	Sun, 18 Oct 2026 09:09:43 +0000
X-Mizu-Trace-ID: 3bffa196ad0c80d9
X-Migadu-Flow: FLOW_OUT
Message-ID: <a2be62ea-f062-4d68-b16d-8e26ab347adf@linux.dev>
Date: Sun, 18 Oct 2026 17:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: add direct dispatch support for mq-deadline
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20261017105400.95967-1-kaitao.cheng@linux.dev>
 <307b05d7-16dd-493a-a10a-d5ac50ec219b@acm.org>
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <307b05d7-16dd-493a-a10a-d5ac50ec219b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/17 22:19, Bart Van Assche 写道:
> On 10/17/26 3:54 AM, Kaitao Cheng wrote:
>> Bandwidth in MiB/s:
>>
>>    Workload        none    mq-deadline    my-patch
>>    jobs1-4k        1209           1047        1174
>>    jobs10-4k       2458            946        2349
>>    jobs1-32k       2568           2565        2562
> 
> Can I conclude from the above numbers that "none" performs
> better than "mq-deadline" and hence that it's better not to use
> and I/O scheduler rather than to complicate the mq-deadline source
> code?

During testing, I found that the none scheduler does not outperform
mq-deadline in every scenario. There seems to be a tendency for none
to perform better on faster devices, but this is not always the case.
My guess is that effective request merging in mq-deadline improves
performance by reducing the number of requests dispatched to the driver,
while lock contention among multiple threads reduces its performance.
These competing effects make it difficult for users to choose a suitable
I/O scheduler, or decide whether to use none. This patch could
substantially broaden the range of workloads for which mq-deadline is
suitable.

Some users may need scheduler features such as deadlines or priorities,
or may want to add instrumentation through a scheduler. These requirements
may lead them to choose mq-deadline or another custom scheduler. In such
cases, this patch could provide substantial performance improvements.

This approach could potentially benefit any I/O scheduler. With the
skip_request callback, a scheduler can choose whether to sort all requests
unconditionally or only when the device is congested. I suspect that
adapting BFQ to use this callback could provide similar benefits, and I
can test this if there is interest.

The hardware available to me limits the types of storage devices I can
test. But please still let me know if any additional tests are needed,
and I will do my best to run them.

> I have removed the linux-doc and linux-kernel mailing lists from the
> Cc-list. Block layer patches should be posted on the linux-block mailing
> list only.

Could the changes to Documentation/block/deadline-iosched.rst be why
these mailing lists were added to Cc?

> Thanks,
> 
> Bart.

-- 
Thanks
Kaitao Cheng

