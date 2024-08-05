Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626CB1494DA
	for <linux-block@vger.kernel.org>; Mon,  5 Aug 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880389; cv=none; b=ZOa2qqcRPwR1tSZWYblMasPBfJdNzUy71n4ceWzaNWdOCTJelXIWfo56mu/I0lwKrLDl/XpdwrTz8ZpdB3Nu/fNr5wRdp2YpphK9mXNbWw9tOqCIWIxGDzi0dVZyZlk8b4SWpS8AHi8lkguO/DHlEuQIWFqnvkKDzVrRZ9m3yYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880389; c=relaxed/simple;
	bh=xKHNFOoL9/OUx8dOwvpNjFv89zbNArxtZQcdMQv6qUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4Aw/LIHOjFDOdO62FX/QZRioxxxObqbnOZPo5RTkJ7SlxSRiZWeLBRE2TCGZ503wOnV6fgV5de87xk4qr5369I0Rimpsn0zr5K6eoJZHdBxuoZFQcZVl8jqTLTrilM87Rm3ZHb94P5U2lD/KyuOOLAz10o1nPnOlWdVWO6j52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zSZvb9Ty; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zSZvb9Ty"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wd3v15Mmnz6ClY9L;
	Mon,  5 Aug 2024 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1722880373; x=1725472374; bh=YoidYY6tuH90CqiCAJ32TK5Q
	FdFUajFOxxuoMaRkex8=; b=zSZvb9TyMNY+wtrTvTDTwzkdPoUIZuHv00i6wviu
	6JcVLqWp6ZWNMjHHFQC9ZTagMR0qgpHwycH9ABO9inIXnO39ZiWn4qQPh+UB5FkV
	aVtMeHrvwUMBzM1n2hWXyHkz8IVwm8t4k8idaOprYgCaKFWYjGe/H6KCgDdsKmpW
	F8JFTt0/B/Qs6AgRzvYXc2Zth27c6JR/Tp4mR9DVIqc5vKMMn91oF0Fhugxsb6jn
	NF4h0OyFTaZPmuXK+TATT84spvFBj76dMfB5pWsMe6c6XfCec/NzEdeZghD26rNR
	+q7kGeXipgNCe51VvfOMb/dw3Ni1tD4b5MLoFeycCvojSQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RGrabfnTZ7D4; Mon,  5 Aug 2024 17:52:53 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wd3tq4zCdz6ClY9K;
	Mon,  5 Aug 2024 17:52:51 +0000 (UTC)
Message-ID: <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
Date: Mon, 5 Aug 2024 10:52:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>, Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>
Cc: axboe@kernel.dk, mingo@kernel.org, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, dhavale@google.com,
 bvanassche@google.com, quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
 quic_rampraka@quicinc.com, quic_narepall@quicinc.com
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 10:35 AM, MANISH PANDEY wrote:
> In our SoC's we manage Power and Perf balancing by dynamically changing 
> the IRQs based on the load. Say if we have more load, we assign UFS IRQs 
> on Large cluster CPUs and if we have less load, we affine the IRQs on 
> Small cluster CPUs.

I don't think that this is compatible with the command completion code
in the block layer core. The blk-mq code is based on the assumption that
the association of a completion interrupt with a CPU core does not
change. See also the blk_mq_map_queues() function and its callers.

Is this mechanism even useful? If completion interrupts are always sent 
to the CPU core that submitted the I/O, no interrupts will be sent to
the large cluster if no code that submits I/O is running on that
cluster. Sending e.g. all completion interrupts to the large cluster can
be achieved by migrating all processes and threads to the large cluster.

> This issue is more affecting UFS MCQ devices, which usages ESI/MSI IRQs 
> and have distributed ESI IRQs for CQs.
> Mostly we use Large cluster CPUs for binding IRQ and CQ and hence 
> completing more completions on Large cluster which won't be from same 
> capacity CPU as request may be from S/M clusters.

Please use an approach that is supported by the block layer. I don't
think that dynamically changing the IRQ affinity is compatible with the
block layer.

Thanks,

Bart.

