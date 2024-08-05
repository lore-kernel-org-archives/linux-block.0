Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657E2C684
	for <linux-block@vger.kernel.org>; Mon,  5 Aug 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878420; cv=none; b=Kg0FFyd9HISi/2TjTXcfGe1gUixPMlHBfr61TiCVtF3UlE3a3g7ulsCC/+opG/FgBt0XlNA5AqK9w6IZEN/n/gtDSzEQ0s8WRq7P30I7x9ns8rHClpS7RepWeDuMa42Wo71e2YbY0NugAcUBR+ylXOyKH+VbDISSSr6rJoXBW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878420; c=relaxed/simple;
	bh=Vm4yMYfHk7sUfETb2wD1qNaftrwKjOTuk6DyOAThqDk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RB60m7Z5vLuLl8Q6b+6NsdXbXjlmzhpPog0hEcoqRknfTYsvgEGE1L5zSeNgbWk2+4FKDHeG+MuVd+1hWwmvHa6qrymcs4O9GxcCqcVzI0PJ19l/GCzixvq8U5hhkXfZbt6EEU2QAtUCxA663NDe0tPfnQJmHjMzf8PyPuT0Bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4sx226/O; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4sx226/O"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wd3684Bf1zlgVnF;
	Mon,  5 Aug 2024 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1722878250; x=1725470251; bh=PlP8qE/eEBDg5RIRVuFyaqMI
	7U6+MwEbl5t5FoaxRr0=; b=4sx226/Ot0iIJlrTnLIdVZAhBXJZgwDWBq1wUD2C
	1gImEOPb6v8FUG4+jloLfUP8aq5+szzVtU4WiwOEo+obvrKlmSiU7A4jQPRWc0kx
	aoWTlJf4KANoArquU3Y8u20CLJpSkIbj3fDExtXha6jRtNJWCnKtr71fhk98f2SV
	FakuKxYuCBOU0GTQ1fcAcEgv8SCWxIku7HcvHmQ7/AzH1yHdNs6wde9le8q6HOyS
	jelgyvouI60ZqRlDS7CeodAD9okYkMu3kX+3MldjPNLFvD7SARoLztAgzcj3KmBA
	SO0M8l+L1+T2GjOpiQ3TWYKw/LwbBBF54en+PVhyqhiS/Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ciTBkFhPgK5m; Mon,  5 Aug 2024 17:17:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wd3601HNYzlgTGW;
	Mon,  5 Aug 2024 17:17:27 +0000 (UTC)
Message-ID: <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
Date: Mon, 5 Aug 2024 10:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>
Cc: MANISH PANDEY <quic_mapa@quicinc.com>, axboe@kernel.dk, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, dhavale@google.com,
 bvanassche@google.com, quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
 quic_rampraka@quicinc.com, quic_narepall@quicinc.com
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
Content-Language: en-US
In-Reply-To: <20240805020748.d2tvt7c757hi24na@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/24 7:07 PM, Qais Yousef wrote:
> irqbalancers usually move the interrupts, and I'm not sure we can
> make an assumption about the reason an interrupt is triggering on
> different capacity CPU.
User space software can't modify the affinity of managed interrupts.
 From include/linux/irq.h:

  * IRQD_AFFINITY_MANAGED - Affinity is auto-managed by the kernel

That flag is tested by the procfs code that implements the smp_affinity
procfs attribute:

static ssize_t write_irq_affinity(int type, struct file *file,
		const char __user *buffer, size_t count, loff_t *pos)
{
	[ ... ]
	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
		return -EIO;
	[ ... ]
}

I'm not sure whether or not the interrupts on Manish test setup are
managed. Manish, can you please provide the output of the following
commands?

adb shell 'grep -i ufshcd /proc/interrupts'
adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do ls -ld 
/proc/irq/${a%:}/smp_affinity; done'
adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do grep -aH 
. /proc/irq/${a%:}/smp_affinity; done'

Thanks,

Bart.
