Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7201D556;
	Tue, 11 Jun 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125761; cv=none; b=Q8rK4QkTpv7yZnDu243TYj7AJ7ijXdaWxKhXb98b5pddQX+gMRDsIiNilneeN9h/7nL11M7SvikLubUMFafCV89Ar5niCkkQO4PMXHbCwtEDytpiPR/bNLg9Mi6iG5IEdoiV4r7tmYURvAJ/JJnFA32o/Ak4t4BHMoWfqzu0dU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125761; c=relaxed/simple;
	bh=dYgsw05Lo16Ag/IxvPvdK+EMqjmf3VE9WltXmI0XKMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJLVKUbSpdDEkE1wRtzT7nPvg3+cGOVrSb84KuffYS4K2XseOYaAdy5/YCjwTT+GrmofCBMoAZVQHYOpUVpDe7egAEn/2cwk0+Yem0p0B//ZKvb5gLYq+94JsayVScjxFVvUHHvDJHogVTd2D7qzy7Nqnew08V3pCKCiXuoNpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PXJxWVIS; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PXJxWVIS"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VzFWy4pNsz6CmR07;
	Tue, 11 Jun 2024 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718125754; x=1720717755; bh=3VVTPR0M/NALXqh4EpubQH9z
	bsUNZAmwZku1/KglkEk=; b=PXJxWVISEXZjM3Dcrc21AGooxtc1JJQ1Mw6FIDyL
	XvfoFjvtUNoZFchtRQCezqGc7dsFBBe4d1TP6zj5ApBYmY68rr9tPNsS3OsAVF1b
	wJg3oJ9qb2vTRNwkeOCQdFy4+ufWuV28dbMUK8xAz33OLSNLGX248x1s2eJVlzo4
	q4oHLQ1hHwrNobcdU6qp/IoZ9TV8bO7B09CaAmzNq8jg3x0nux2LwlMZL5rl4d9K
	LdJLK65TBlgipBqRy8onUDMTBmHX+OwPjdhqqTrtnx1oOh2gmByyn9gzGPL975EC
	cI/qWNFidFMG9XwTVr6mSafPLsMBDAoQFCG5qOzAJOltSw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ljpgvnq9GFne; Tue, 11 Jun 2024 17:09:14 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VzFWr5phWz6Cnv3Q;
	Tue, 11 Jun 2024 17:09:12 +0000 (UTC)
Message-ID: <be0dc105-e205-4b0e-9bd4-49690249fd26@acm.org>
Date: Tue, 11 Jun 2024 10:09:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Add ioprio to block_rq tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, ebiggers@kernel.org,
 ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com, cuidongliang390@gmail.com
References: <20240611073519.323680-1-dongliang.cui@unisoc.com>
 <86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
 <20240611125440.6d095270@gandalf.local.home>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240611125440.6d095270@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 9:54 AM, Steven Rostedt wrote:
> On Tue, 11 Jun 2024 09:26:54 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
>> On 6/11/24 12:35 AM, Dongliang Cui wrote:
>>> +#define IOPRIO_CLASS_STRINGS \
>>> +	{ IOPRIO_CLASS_NONE,	"none" }, \
>>> +	{ IOPRIO_CLASS_RT,	"rt" }, \
>>> +	{ IOPRIO_CLASS_BE,	"be" }, \
>>> +	{ IOPRIO_CLASS_IDLE,	"idle" }, \
>>> +	{ IOPRIO_CLASS_INVALID,	"invalid"}
>>
>> Shouldn't this array be defined in a C file instead of in a header file?
> 
> The way the TRACE_EVENT() macro works, this will not work in a C file.

Hmm ... if the above array is terminated with a { -1, NULL } sentinel and if
__print_symbolic() is changed into trace_print_symbols_seq(p, ...) then the above
array can be moved into a C file, isn't it?

Thanks,

Bart.

