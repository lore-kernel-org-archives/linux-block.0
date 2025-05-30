Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D35198845
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620634; cv=none; b=kLzZod000SI1RQF3v/846IUiIsd3rXWw94BZYrptYzmhdRYu/CUucva3up7ipG0w7nvG1hv3F72HRmJAAUDGPFlhVkz/TAs8v/dAaKkyncc4DijbZ6ALodQdaBBYBZFZAzIriC1BLdW0Y7TucjrDPImG+QCjM5aUmJqRwcz8CNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620634; c=relaxed/simple;
	bh=6fbT4+YzmDRnoE73urgO0jdO324xwOBwY37D3gAZ0SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DuIxjks/inIVtNiqHbQIffx2NqE3AcWxutfQK5z/voaCPuIQHyY/irAYsHK+hPkduyuMrlFY0wkPiK9QeTWyyF8icDyiPn3Z3mDyVF+utpL9VlbDSKmZiuBJQiPPfNVmzhznJTczoHhAMk8TjLp9tFaUAR3j1JvmjxTmp64jZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=C+m6DRGh; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="C+m6DRGh"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b87Ch5Swwzm0Ql5;
	Fri, 30 May 2025 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748620623; x=1751212624; bh=Givco5m03jheVAqmiim0bBRa
	pl/JKBg37CZ51uW21A4=; b=C+m6DRGhajjvZTbQmWp7JbmHyICxixnYhXBl35v+
	B5R1NhBX/brujg0R2cytuAyA79jZOJc0KU7QB5z2ZzoNjccdpRwJ/e6kIF/UsNj6
	ZyM17wdkmmcD184ksQlegqO+JeWe9jQEjEH4bH5369eB5dTPUhIX621ZqoMFKiCs
	6beZvrB2Z4xBU8u+YiVv4W7qs3uY70FIqEFUy35YG9PtBIErLY9HioOn6gmD4K61
	AukOYcJglfiLBAoesHn9biLyPT21iMKDXVQjPJI14bKIMezSa4E9kpxf+yh8L4dc
	XT9a8Cj8YV/0PaE1C0WI+GAWLhSWfQu4pT3lyfJKfoel9A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Q2PPhiCOoI-T; Fri, 30 May 2025 15:57:03 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b87Cc5w0Hzlw64d;
	Fri, 30 May 2025 15:56:59 +0000 (UTC)
Message-ID: <0d4dec4a-7a47-459b-876e-d9e3c4d24f55@acm.org>
Date: Fri, 30 May 2025 08:56:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests RFC 1/2] check: allow strict error-checking by
 "set -e" in each test case
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
 <20250530075425.2045768-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250530075425.2045768-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 12:54 AM, Shin'ichiro Kawasaki wrote:
> diff --git a/check b/check
> index dad5e70..3cf741a 100755
> --- a/check
> +++ b/check
> @@ -502,9 +502,9 @@ _check_and_call_test_device() {
>   			fi
>   		fi
>   		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
> -		if ! _call_test test_device; then
> -			ret=1
> -		fi
> +		_call_test test_device
> +		# shellcheck disable=SC2181
> +		(($? != 0)) && ret=1

These alternatives may be easier to read than the above:

if _call_test test_device; then :; else ret=1; fi

if ! { _call_test test_device; }; then ret=1; fi

Additionally, please add a comment that explains that ! should not be
used directly because it causes set -e to be ignored in the called
function.

> @@ -695,9 +695,9 @@ _check() {
>   		if [[ $group != "$prev_group" ]]; then
>   			prev_group="$group"
>   			if [[ ${#tests[@]} -gt 0 ]]; then
> -				if ! ( _run_group "${tests[@]}" ); then
> -					ret=1
> -				fi
> +				( _run_group "${tests[@]}" )
> +				# shellcheck disable=SC2181
> +				(($? != 0)) && ret=1

Is the above change necessary? This command shows that the exclamation
mark does not affect subshells:

$ bash -c '!(set -e; false; echo set -e has been ignored)'
$

Thanks,

Bart.
