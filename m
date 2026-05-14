Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F128325707
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775161; cv=none; b=GfMfeoQgeVqwv8GijVLDYGmFaXlB00bQ9bDNhXa4KgzkrlcROt4qIVo1tjnI26koNgrB4QkI8PeWHg+DFP/kwxHfna9GraXEXDA+eo0oRw074KPUncXlXd4fHa60Ajyx1UlwipLWnGfJ2HVQetTK0CPMb0bRih0UxfNchwpK/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775161; c=relaxed/simple;
	bh=Ehjy/JrrT12HK2vccgyGL9peLPB521IHtb29lWL6aS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If3SAV3og6j71TjDf+nikHwDXpGovhRZS5WQCRN+rPuvXdKjCvr3dSdKKCBDj3VMCm/8dIdMbpKuzCA4BYC0oGTgxXQvMakwaT1btLmS2rgrDBLSNdMXnuw1vGJX4UTmX3XiDloOtkwREBwstZo2Ys2Ch8qyIyb+uiZ8p460US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mOxbZMbk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mOxbZMbk"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gGb2b4TV1z1XM6JY;
	Thu, 14 May 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778775157; x=1781367158; bh=nZAUtkVu5GRkZcTo36RIkzGi
	xNJqJiz4Uakv6OFA6hY=; b=mOxbZMbk7uOG2MpuiNNnXtS2mH2tUW9VUbOrI6Pa
	yNoGU75ltIlLkFmOFF7hfnUamQbFzb1dYMo1ewuolYz773ncs7xgnii/QISn4dHU
	bsevV6GHfHNUEvxA8ZWUJVXKRDlxr6j94GqpFAdP5tVfKfCYkjJ4VeJSBFjiajaJ
	2v6dITKxNRnkZPcv50f4La9NBdn3p5e8/lk70rK8NsAVTrLaFhqLFJ0zSMPDa23c
	WoTl/NlWuBxj79qZfO+c3m6p9DXcMnFeT6bF1xTrsuHQQFNULEWZCv6Yz8rPtx2/
	I6tn5q5aMv1AFbh3roSUDKzAlQEr0ZtZhrmXKWww7GhJPw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8_kknodqWNtF; Thu, 14 May 2026 16:12:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gGb2X2z4Zz1XM6JX;
	Thu, 14 May 2026 16:12:36 +0000 (UTC)
Message-ID: <ea583981-3446-4fec-83bd-ece55bbf7486@acm.org>
Date: Thu, 14 May 2026 09:12:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/3] check: add --cmd-trace option
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-2-shinichiro.kawasaki@wdc.com>
 <10bc69b1-762f-40a1-94b0-9ce6580b17e1@acm.org> <agWWgSBS2v0sSlUl@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <agWWgSBS2v0sSlUl@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 2:36 AM, Shin'ichiro Kawasaki wrote:
> On May 13, 2026 / 10:08, Bart Van Assche wrote:
>> On 5/13/26 4:23 AM, Shin'ichiro Kawasaki wrote:
>>> diff --git a/check b/check
>>> index c166fae..a68049b 100755
>>> --- a/check
>>> +++ b/check
>>> @@ -458,7 +458,17 @@ _call_test() {
>>>    		TIMEFORMAT="%Rs"
>>>    		pushd . >/dev/null || return
>>> +		if ((CMD_TRACE)); then
>>> +			exec 8>"${seqres}.cmdtrace"
>>> +			export BASH_XTRACEFD=8
>>> +			set -x
>>> +		fi
>>
>> Hmm ... my experience is that set -x breaks most tests.
> 
> I ran whole blktests in my test environment with this series and the --cmd-trace
> option, and observed no new failure. If the bash xtrace feature does not work in
> any environment, I would like to understand the condition.

I should have added in my email "without setting BASH_XTRACEFD". If
BASH_XTRACEFD I think that "set -x" should be fine.

Thanks,

Bart.


