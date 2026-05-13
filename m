Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049F38E120
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692073; cv=none; b=POPgCg5QGr37lL6TFAqbvE9d04Q7WLzk/X3l7Brqxvgk8Wgb0hzGCS1x4vZYbMMek6PHhPeVWgIPfuPD1EvDkZtUFJuQsqHgMqSnFacD2gKIWlFgDV5E1zqkNQvS/1NksnE5VsnpUjmlFu00efkabpx3rcEXOOMYigOKVnDFtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692073; c=relaxed/simple;
	bh=aes/hAgwpOw6S3qvG+oq6zoa3/xCWUA6Q3bw/QLvj7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgWroaHjHkT+sSv1nzq6hFpNLG3DFKtMmnUEKVg4wKdgRyjHhTND+XdmjMX4+5z5vyHPj+NxxFUiwFfX+wYFBMoWSvUf/pCvhqJn2nH7nLLZZCI65vVp0YD9vwch6njpFGSdnJUacCuKM3h4F2lDdgCbOXPxA3BxdiusD2Fmeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AWkqLbJ8; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AWkqLbJ8"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gG0Jj6ZB3zlfl6P;
	Wed, 13 May 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778692066; x=1781284067; bh=UztdTa60lJqJtLmtFrjQGm4F
	mDahJuknkr9ljxTEVZ0=; b=AWkqLbJ85q9AUH6enVTJjPLcuZkvyTEKdEfptF6j
	u6r4/UY0dFkabamUwvmqw3Vm0yPytdS9P3e8QfRFQ8/JuF/G9uaH8M+AZbP3/T0I
	lPXvu/Hx7YdAhOpDyc/9U2duPfEHmJrEltDnB8HBAO5p0SLwfhVcVHhHQ9B5WZWx
	vM2xMO9UDVtzjCOlfLKRfrknWAWscrSl4T3x/CHtWN57GQdvxkk9V2euXkSK8SOA
	dWWnDKgLzlnYf9RTCLYWZe47SHuHe/0t4I6zsIzrBkQchHVhgQBGMZg4tP4XHgLE
	mX0TsFPftJICboydOyOyMURnJbdmw4OA2lwppD6STjSsYg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TjhRtqNIWD3M; Wed, 13 May 2026 17:07:46 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gG0Jc6VjSzlfl6N;
	Wed, 13 May 2026 17:07:44 +0000 (UTC)
Message-ID: <3ef4e2a4-c0ec-4040-a4c7-3687ed7e2d93@acm.org>
Date: Wed, 13 May 2026 10:07:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <a1668df1-a93a-442a-ae95-e015bcbeec17@flourine.local>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a1668df1-a93a-442a-ae95-e015bcbeec17@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 7:05 AM, Daniel Wagner wrote:
> On Wed, May 13, 2026 at 08:23:25PM +0900, Shin'ichiro Kawasaki wrote:
>> +# Echo a value to a file. This wrapper is used to trace sysfs attribute writes
>> +# when the --cmd-trace option is enabled.
>> +_echo() {
>> +	echo "$1" > "$2"
>> +}
> 
> Stupid question, can't we override the echo function, something like this:
> 
> echo() {
>      builtin echo "$@"
>      builtin echo "$@" >> "/tmp/debug_log.txt"
> }

How can this work since the sysfs/debugfs/configfs attribute is not an
argument of the echo command?

Thanks,

Bart.


