Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173121C19A
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490818; cv=none; b=HuRtxix2eirXGajUMnLLKRk2FOOYZX5R8ZILGdepf77hwLSiKPTq4lYy/ZUdTZ+q+UWbtMVJx+p4ZhmaP8gOxkQstFM4tKBhn+CoiIe1MfqHhvlL4vazWdgfFcKTtcUMgsyng32iZG2WgqCNLwvmg5CSv/kMLRJTBX9uKTAyhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490818; c=relaxed/simple;
	bh=9X0G7nYN6l4kjB5+YX/XQ5nFoD9whyGbSB0pX5xW1co=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f7xZlSIftpgLPR3W7sbR0RTQqaXtisExYyRV87wjXEINmlIQAyloF84VnqQFmTsxLeGmvvh9ssR06vnUkApM0kIHhEtN6xboWDVszBd6haVMNtTXkyHW7DRGYNmbyGm/LAg6tmSIBdNqWtqRdXU0DgLy28ikFCX1L2gxFICq0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LjFsDxzU; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LjFsDxzU"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bGK280v6Gzlgqyg;
	Mon,  9 Jun 2025 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749490815; x=1752082816; bh=vFlzsptVG2irLPHkX4q/04tt
	b/LxsvmL07xhdydL43U=; b=LjFsDxzUhRtfEu6xrNJVWlVqyD5bOmryRw2bOxv7
	iONB4e8YTHRDqxoLDtRGvlym3/+bU9/98GMmULlPrDXcm7ogcv+BqZmVplP19uoG
	yurC+TMenCDiu/X4cLTfV5JVC0X5yrEb6QHpHZi4kMiO7lPglpEfDfWvRZffY8G5
	Sv9nx5AiYdZ1wRk9JaXrUJiOEHQgp1Rk1Jh+ghhNRXJxTk1o/M1kQrA5CYDWSIZy
	vudsDBrWVuWUs6hE80p1SbA7KA0i+2VVbEpL9ECA5aUsPqEwvUg0VrQpXb/JsG8n
	r7hO48jPgxRFmjZvMdy6H9g1IIQFTyRV4OmoiUNqpUnsuA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S6UZS95YzLKd; Mon,  9 Jun 2025 17:40:15 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bGK2618J3zlgqVn;
	Mon,  9 Jun 2025 17:40:12 +0000 (UTC)
Message-ID: <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
Date: Mon, 9 Jun 2025 10:40:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 8:56 PM, Shin'ichiro Kawasaki wrote:
> The second problem is impact on following test cases. When the error-
> checking is enabled for a test case, the test case script exits
> immediately encountering an error. This skips the cleanup steps in the
> test case, potentially leaving the test system in a dirty state, which
> may affect subsequent test cases.
> 
> To address the two problems, introduce the new flag ERR_EXIT. When a
> test case sets ERR_EXIT=1 at the beginning of its file, the blktests
> check script calls "set -e" for the test case. The test case does not
> need to call "set -e". This allows the strict error-checking to be
> applied to test cases selectively.
> 
> If a test case with ERR_EXIT=1 exits due to a non-zero status, catch the
> exit in _cleanup(). Then print an error message to the user and stop the
> test script. This ensures the following test cases are not run.

Has the following alternative been considered? Let test script authors 
add "set -e" and "set +e" where appropriate but only in a subshell. If a 
failure occurs, only the subshell will be exited and cleanup code will 
still be executed if it occurs past the subshell. A disadvantage of this
approach is that global variables can't be set from inside the subshell
and that another mechanism is needed than local variables to pass output
from the subshell to the context outside it, e.g. a pipe.

> @@ -372,6 +380,7 @@ _call_test() {
>   		fi
>   
>   		TIMEFORMAT="%Rs"
> +		((ERR_EXIT)) && set -e
>   		pushd . >/dev/null || return
>   		{ time "$test_func" >"${seqres}.out" 2>&1; } 2>"${seqres}.runtime"
>   		TEST_RUN["exit_status"]=$?

This change makes it harder to write test code because it forces authors
to surround cleanup code with something like if cleanup_code; then :; fi.

Thanks,

Bart.
