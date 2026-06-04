Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A474C040A
	for <linux-block@vger.kernel.org>; Thu,  4 Jun 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593534; cv=none; b=PiuTkzKl0Nd4p1H2Jj4jA7SzVX42Xg6XADLy60WcTAgK59la40A8n915i24DbtPZeMOA4eOXJJO5/GvVb7PF+6Ad56bSWRMSUiwaj/B1jF/vQzkQE+DmcuSiIw2WQlfrfootXcWZDEDoyd8QnGoAwt4w9dzBf2R6gPKYgFOdZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593534; c=relaxed/simple;
	bh=zLYBvEMyeULf1eJSkTOC0ZYckL5SPIL2B2zifTeMQms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWXkvyBad/lUAulZrjs9+i3aou4Ne7PMaOCbrUI5YHWjqx8AupMZkyeUyN953ernRHFxOU040G4M5OlcZzpDJQQrmoO8DjWkZxTGK8YTQKz8MXThk3jN9Cufg5nVCAmmA5WRZNosiH7isfDgb5LeVya654fw+0azzn442Z+jrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d0YIWwj5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d0YIWwj5"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gWWWC4DPfzlgyZS;
	Thu,  4 Jun 2026 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780593525; x=1783185526; bh=jZkLhAgLUJOtCey9CtTnOp+P
	EPi6wFn+Sl6hrhZJeWg=; b=d0YIWwj52w3+Ef0l2DbvGZI/xkFfko8+Z6X8Tvhs
	E19HpBCYk8V5Xa62QXJWC6P6Uyid+w83MoDKuEhytAxzOKPtvgAWirfdhfOM1rrj
	kLnjgVChoi5GjvW9Zik2do6qEk6g43/iAH95EDyiBfYAlZt/xzlSy0S3EoUljyYk
	Ct2PoEngslnOC0ZPT8zRh/K+ZXuE314tI/WYXU3ZvfN4NoYrm+X5ZM9q9YOFyvvu
	ms7Id+kqqE2ZJ2bfa3kf2cf6X6wrjoFBY/m7OyKJ8ORv5JrcJwCHtlvqdrEtV321
	HnLkTTYWzKrO1myiLp8/p4UlIDWAjtMvKNDovEjoZSu6iw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vl8ClgHYU0-i; Thu,  4 Jun 2026 17:18:45 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gWWW92QKjzlgy4t;
	Thu,  4 Jun 2026 17:18:44 +0000 (UTC)
Message-ID: <4ffe203b-0e55-493f-8a22-44a0d14bbb9f@acm.org>
Date: Thu, 4 Jun 2026 10:18:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] throtl/008: Add a test for the iocost cgroup
 controller
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20260603205007.2654971-1-bvanassche@acm.org>
 <aiESTpWx0-0l9Ppj@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aiESTpWx0-0l9Ppj@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/26 11:03 PM, Shin'ichiro Kawasaki wrote:
> The initialization part above has duplications with _set_up_throtl() in
> tests/throtl/rc. Is it considered to use _set_up_throtl()? I guess it will
> simplify this test case, and make it consisten with other test cases in the
> throtl group. It will also allow to run the test case for scsi_debug.

It's because I was not yet familiar with _set_up_throtl(). Anyway, I 
will use that function and post a new version. Thanks for the review!

Bart.

