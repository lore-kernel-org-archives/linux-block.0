Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556D163A97;
	Mon, 17 Jun 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659855; cv=none; b=RVchaXvDB465syA2beKHYt5liyTmerT3MaBnJhciVVPNgrrriSwhD+/wqXN9/174BfRb7Ob+069HLqk8MJMSP52Rs2WdHTCMCG7jws1wNOo/lP7UqNrMkjXrb+L9Kv85gHjLJNpY6En5yYWTVmx/8egYO7OMtDNflGfZ7Jxeyn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659855; c=relaxed/simple;
	bh=xQJSSXTxcpVkT2GcrlHdUloPT83E43RcVlTAMvY3kRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+NWne4T0OHmzOoaqgBhQbOCQspblsPprjqgupql33JU0VSZKxXYiMfq5yQHwkhRqfjEBJlWMuhU8TgulUmYF0SILl76ypeZyQZU1h1EZpq0uR472cdnd0Ixx4BOSuMkyIUGNddU2A54zhrYhcE0gov6kC1c9H8yhStDZ8086SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N14Bc0NQ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N14Bc0NQ"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W33313fRgz6Cnk97;
	Mon, 17 Jun 2024 21:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718659847; x=1721251848; bh=2c/ABcgQoPM8qZHfToAW5tBn
	lzQYAgD5E2iyiuUHAuw=; b=N14Bc0NQiL6Ix02fn60gnsJSHS9nAAzoxaL0Kh4A
	ayj74YMqhrU8FffyHxOl7dd55/JpwwuG8yzM16Ba51b7reX4Rf9wwVCXK2nZ86nH
	a+r7s4yd18loA3NOllXtz3F0U0QiFICCnm/l+e43gAOcgs4DRIVsdpyXo5hCcftX
	RlWbBQpnRP6JLhf4sai0zm4dKOB6rsyfZiL4cxEzTpzAxZjfRtwmzAqWPUAYA80h
	e9L39ZKEzsKyHZmOwUedShHK86x2bZQsEgL/JHyZiOEhezM03aPvc/0tNCjTqgSs
	/kTnoWpZWiJ/qYU0rQpDPmQ+etWlwRrzm7EQgN7okidqQw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r5og0gpZSSxq; Mon, 17 Jun 2024 21:30:47 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W332r2RKRz6Cnk95;
	Mon, 17 Jun 2024 21:30:44 +0000 (UTC)
Message-ID: <a574532a-c6c4-48cb-9081-34c918e950a0@acm.org>
Date: Mon, 17 Jun 2024 14:30:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Add ioprio to block_rq tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dongliang cui <cuidongliang390@gmail.com>,
 Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com
References: <20240614074936.113659-1-dongliang.cui@unisoc.com>
 <7d0f68b8-ecdb-45fb-ae10-954eac5ed32c@acm.org>
 <CAPqOJe1=+dqcapg-_Y+Fq9W61wDMMzDLzP+CQqcTW69WdKQqRw@mail.gmail.com>
 <84e024ba-b921-481c-a83d-eec0dd0e8328@acm.org>
 <20240617130754.3b4dbd62@rorschach.local.home>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240617130754.3b4dbd62@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 10:07 AM, Steven Rostedt wrote:
> On Mon, 17 Jun 2024 10:02:48 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
>>>> Do we really want to include the constant "[0]" in the tracing output?
>>> This is how it is printed in the source code.
>>>   From the code flow point of view, there is no need to print this value
>>> in trace_block_rq_requeue.
>>> Do we need to consider the issue of uniform printing format? If not, I
>>> think we can delete it.
>>
>> I'm not aware of any other tracing statement that prints out a constant.
>> Is there perhaps something that I'm missing or overlooking?
> 
> The only time that is done, is if the trace event is used in multiple
> places and there's one place that the value will always be the same.

Thanks for the clarification Steven.

Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
