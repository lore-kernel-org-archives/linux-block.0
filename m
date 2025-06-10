Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80C1386C9
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570558; cv=none; b=efEb4fjvPgQe2QINBQuosEAE63whJv3f94CF6EEqyjbmCkxocVn9omwHA/ZVV91oUSPOvHBGh3iVgOrfs0ugG01CoX/bTPiWiy1Ecp2WAt5agqvmcLj82nSFxz7eBQWZzkMkyfXjGpKY4twJSoHiMz8HUWADnXAySc2FZOHThyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570558; c=relaxed/simple;
	bh=PJ15Oe6/oGP6YhvxcZYawEQFSEXQTjWXuJKZ1rXbEIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuL17kmYwLXIc4zJqkJPX7Rkfqd5SkTTsMNfCq56evM6HS5K3SisjqO6hVIOAsystSNBlekRGINHdfCQpW89pnxLMl22c3FhnXmqUMZY9T6wfBMUP0OpyU0+2aZyDMK5Qg1bXTvJECDMnxTyStnidpMsFyjvpwe2TQnImvS7e6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DTOOlYEG; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DTOOlYEG"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bGtWZ59nszm0N9y;
	Tue, 10 Jun 2025 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749570553; x=1752162554; bh=w2e446YVXsj4lE3vbPCbpFQp
	YK9ccAeDEa7xnnnOxO8=; b=DTOOlYEGivpTvlCgM0iGc/WzMUX+GzrZV2R1WFKO
	4IK4E3+a1UHK0NgcEtv0LOnnJRqDPaUCfKXfKiTdyMl+/y1kDIrTITX+BsL4V3C0
	fms+WyR0QlTWISdirE7RitM/EyKO2QMar2HFRK7sLwSkXAIBsrbyzrMBO2XQ/gN+
	EJELeGs+HtJiat18YFhGRESW90cPj1RxLvyBPCjyUouoUe9mta3twltajm+RZVKl
	ZCgkYqtQEdXJVeop82pKH8WnSTQBNXgTQUSZtdHhTjwfe3OkQurlWI/C1vZ8R31s
	yQ3gtq06hbb/hxSzevJN7RJwAxQlM7q7cx6qonDzwK6DoQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 68w6HqZHWo0l; Tue, 10 Jun 2025 15:49:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bGtWX2Z2Pzm0bfm;
	Tue, 10 Jun 2025 15:49:11 +0000 (UTC)
Message-ID: <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
Date: Tue, 10 Jun 2025 08:49:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 7:05 PM, Shinichiro Kawasaki wrote:
> On Jun 09, 2025 / 10:40, Bart Van Assche wrote:
>> Has the following alternative been considered? Let test script authors add
>> "set -e" and "set +e" where appropriate but only in a subshell. If a failure
>> occurs, only the subshell will be exited and cleanup code will still be
>> executed if it occurs past the subshell. A disadvantage of this
>> approach is that global variables can't be set from inside the subshell
>> and that another mechanism is needed than local variables to pass output
>> from the subshell to the context outside it, e.g. a pipe.
> 
> This idea sounds something to consider, but I'm not sure if I fully understand
> it. The word "subshell" is not clear for me. Do you mean subshells those test
> case authors create in each test script? If so I'm not sure how to ensure that
> "set -e" and "set +e" only happen in the subshells. Or do you mean to modify the
> check script to create subshells dedicated for each test case run? If so, I will
> need some work to understand its impact.

 From https://www.gnu.org/software/bash/manual/bash.html:
<quote>
( list )

Placing a list of commands between parentheses forces the shell to 
create a subshell (see Command Execution Environment), and each of the 
commands in list is executed in that subshell environment. Since the 
list is executed in a subshell, variable assignments do not remain in 
effect after the subshell completes.
</quote>

Here is an example that shows how a subshell can be used to halt a test
with "set -e" if a failure occurs in such a way that error handling is
still executed:

$ bash -c '(set -e; false; echo "Skipped because the previous command 
failed"); echo "Error handling commands outside the subshell are still 
executed"'

Error handling commands outside the subshell are still executed

>>> @@ -372,6 +380,7 @@ _call_test() {
>>>    		fi
>>>    		TIMEFORMAT="%Rs"
>>> +		((ERR_EXIT)) && set -e
>>>    		pushd . >/dev/null || return
>>>    		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
>>>    		TEST_RUN["exit_status"]=$?
>>
>> This change makes it harder to write test code because it forces authors
>> to surround cleanup code with something like if cleanup_code; then :; fi.
> 
> I see, this point makes sense. I'm okay to not call "set -e" in the
> _call_test(). If we take this approach, test cases can do "set -e" and "set +e"
> wherever in the test scripts, but they must declare ERR_EXIT=1.

Do you agree that with the style of the above example ERR_EXIT is not
needed at all?

Thanks,

Bart.
