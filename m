Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E91E0E14
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534752; cv=none; b=MPVlaDubO0LHX5L39tTbFb2WlrYE3y7ANGfat8u76oZy0UyWemEBQpTApm6Ogz7frO9I93ype6/FYnQKChY+WhiXBvJgqMBsy9eEP/EQMF4UJgoWEGVd+IBwovKQV4fY/FF3ts6Z/blHuLS6TWA+tkc8V9LtPCzAtvXiXQhyqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534752; c=relaxed/simple;
	bh=Hp+PXlqAVcmyRpFnq821TYLZjDonLfpylJEiEB6S0oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueFIG5ggquvtNAkKF3SR8OxFDI4dgSQam5FVXdccQ/eNlyYymVSdyhTbqJtleXR7hIJUhd99SxClTWQ1Jzjke699MGyUUERUD32/436v06HX6GlARjClxsV5WU2KCSChWavKuKFaJ+iGt/Ue0CYQT7gpLY2j8kUHCwTRKljDV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tZp/4xAv; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tZp/4xAv"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b7WSF0cqTzm1HbY;
	Thu, 29 May 2025 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748534747; x=1751126748; bh=uQpoH8kOGmoWh7DE1AkZttlv
	smlmDgY2SukbiuJNgr8=; b=tZp/4xAv7y0J82COXCPxWtVVd+/CIeVRgoELQsvb
	6KbcOFfClBBMNT/oOL2FYBARLS2kkkf1X1IGEe2eK8XAZp0Wm8QHXgJfbnCcbtQk
	SGc2AsouqmA+rB+X1fAkJFzzOUDogD7bX8dwjOuh3GSp8x0xkTj/YZSuqdGfIcwe
	ixHpiA9eTaJEtF5WHFddlbkZTb+9bSzqKhm83w6rSB6rTA9vRkn6ZePsyqC1fsbA
	0r+0+8lLe8OlAhz8L6qR8qftm9GNwaE8inQE5J4JXNcXshqSTtE1mBbGfmg1DzKq
	KRRnbATDhYVZ7zsCfGXFpC0vKvZOiBTh86p+Bc2j7MJikg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K9Emw1xxBc38; Thu, 29 May 2025 16:05:47 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b7WS869Xkzm0ytY;
	Thu, 29 May 2025 16:05:43 +0000 (UTC)
Message-ID: <e2983028-08ae-4135-98d3-2223d0450d85@acm.org>
Date: Thu, 29 May 2025 09:05:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch <hch@lst.de>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
 <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
 <fggaqqc5dxwbrvkps6d6yj34a6isbcsr7cxepg64bppinpk2w6@dkmleb5pncjt>
 <f8284cf0-0b05-413d-83e5-5cbd1c72ad35@acm.org>
 <ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 6:08 PM, Shinichiro Kawasaki wrote:
> On May 28, 2025 / 09:09, Bart Van Assche wrote:
>> Does this mean no "set +e" statements anywhere and hence that statements
>> that may fail should be surrounded with something that makes bash ignore
>> their exit status, e.g. if ... then ... fi?
> 
> What I'm thinking of is different. What's in my mind is below: (I have not yet
> implemented, so I'm not yet sure if it is really feasible, though)
> 
> - If a contributor thinks a new test case should be error free, declare it
>    by adding the "ERREXIT=1" flag at the beginning of the test case.
> - When "check" script finds the "ERREXIT=1" flag in a test case, it does
>    "set -e" before calling test() or test_device() for the test case. After
>    the call, do "set +e".
> 
> With this approach, the existing test cases are not affected. And we can do the
> "set -e" error check in the selected new test cases.
> 
> Will this approach fit your needs?

Although I'm not enthusiast about the introduction of yet another global
variable, this would fit my needs.

Does this mean that it is hard to make set -e work in individual tests?
_check() calls _run_group() in a subshell and _run_group() also calls
_run_test() in a subshell so the exclamation mark in front of the
subshell creation shouldn't cause set -e to be ignored, isn't it? The
use of "time" in _call_test() doesn't affect set -e to be ignored either
as far as I know.

Thanks,

Bart.
