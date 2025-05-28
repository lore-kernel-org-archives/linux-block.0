Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62D28C011
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448591; cv=none; b=KAfpStcg/+RN639eOG8Hy0PbjWTtTMAozojasGXZMaWY5ErGkSzNYtL6kmDSnK3NvvAyPDVS0jlenRPF+dH3u2fb1Rf2z8cZgidzUpZsk0YerEZHRLynKv3e8J90Ajc0OQkOesMitJcrl1yaxCO0bK+YGsBllEmvNLbA2Ynbsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448591; c=relaxed/simple;
	bh=TnQAWFKYf4lMxWOf3CR+zbunC1Qb2FMWlTeuPRII9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf1xzWuOUySOFInpW90AZoelY9c4gqoH5ZNKXIVuG8h2aqlxWGV0I3U9bx3MybRGOHYjtmS/yIJ0UUwladVpkDW8LwsQRmXe8qjJuckhwUD+eulGOoCdXmmmwpdyfCFD3HDHKMi/QHakwdT78WZpsfDAIfOtSlUtLr54LZQr4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W9/wh6UQ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W9/wh6UQ"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b6vbC0nzszm0NB6;
	Wed, 28 May 2025 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748448580; x=1751040581; bh=r2wp/d4pkDYfzJZ5ca4Sfu4t
	OHD64EcJs5Vn2rFbVmA=; b=W9/wh6UQ+T05KDNRp8J+SVfdp3cmbzpFJoIL594R
	IVTAGGUJ9vwFzGwfP1jxXHH3s1Bqv0cI/5b/PimDbSXSJ9sDrco7TK8LcC2EtE4W
	hwL1oR3RYoriIXhMBrXNxrfnAlUb6NJaEdBB6mDKvq3W5BfZka/3sQvQkLItFja1
	fnZPiIqkecDshnCf4Zp8lfYifCpOoK8w89AzUsxZe8sbMZnodIp/zz8QWz0b1umi
	9wyadPL+FTzVtx4YBxBqVsVWyElO7kfloVBSQLkjSh7DHL6i1V0Y1b2v+ECVC6VR
	CSNy/y4HukFioDTyaCscVZ2kUddPn/GcsJ15xkqE1USbYQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gnQSQokHVdHA; Wed, 28 May 2025 16:09:40 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b6vb62L8rzm1Hc1;
	Wed, 28 May 2025 16:09:37 +0000 (UTC)
Message-ID: <f8284cf0-0b05-413d-83e5-5cbd1c72ad35@acm.org>
Date: Wed, 28 May 2025 09:09:36 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fggaqqc5dxwbrvkps6d6yj34a6isbcsr7cxepg64bppinpk2w6@dkmleb5pncjt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 9:15 PM, Shinichiro Kawasaki wrote:
> Said that, "set -e" is a good practice in general. If it will help blktests
> contributors including you, I would like to revisit this topic.
> 
> When I had tried to support "set -e", I faced were two obstacles:
> 
> 1) There are certain amount of places which trigger sudden exit under "set -e"
>     condition. To fix this, dirty code changes are required, and this code change
>     will need rather large amount of effort.

If we would have to make a choice between set -e and code readability
and/or maintainability, I prefer the latter.

> 2) When a test case exits by "set -e", it may not clean up the test environment.
>     This may leave unexpected test conditions and affect following test cases.
> 
> Now I can think of two solutions respectively.
> 
> 1) Apply "set -e" practice only for the limited test cases. The new test case
>     zbd/013 will be the first one. With this approach, we can keep exisiting
>     scripts as they are, and don't need to spend time to modify them.

Does this mean no "set +e" statements anywhere and hence that statements
that may fail should be surrounded with something that makes bash ignore
their exit status, e.g. if ... then ... fi? In some of my own shell
scripts I define the following function to make it easy to ignore the
exit status of shell commands that may fail:

ignore_failure() {
     if "$@"; then :; fi
}

> 2) Use ERR trap to detect if each test case exited by "set -e". If so, force
>     stop the "check" script run to avoid influence to following test cases.

As you probably know there should only be one trap ERR or trap EXIT
statement. So that statement should probably occur in the ./check source
instead of in each test script. To make that trap statement perform test
specific cleanup it would have to call a cleanup function defined in the
test/*/* source files.

Another solution is to concatenate all statements that shouldn't fail 
with "&&" but that doesn't make the test code look pretty.

Thanks,

Bart.
