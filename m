Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1164D
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863180; cv=none; b=Y+xslNkL+YcxW9jXpuo4J8iaZRMJjQKmSY9Ach5AcMRSN6wc7QZceZHKCk/DUSIR1VD6D8zPKLpxTipvgyoKIDcyYMC9m0yA6QHdetnxNl+J7rAv13je6ay83BYJHQPvp3p14qMIn8esNud/48slZuadeUm19LBUQVy7Uea7WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863180; c=relaxed/simple;
	bh=2l7vIW7MlFqOm62xy+0XdOKLf6cGvjpmto8KE6LTN3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9uBqclizSF0IoTSzmoXsAqZlHUppj5VH9vRuREMlnjWE9XCo08/mDnVOZGdd2+DEdfX6JFI8fYDnfYY6dOXkByQSL+0fPp+Q9+KL3q9TQTFF7Bi0w36pUMjO/qjiqyTdlWXQjhMl6AiZ2j0oksynLyCrXKTNCYK4Z9Ed5EU3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=flbgryDM; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="flbgryDM"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xjr3M2JJ7zlgMVt;
	Wed,  6 Nov 2024 03:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730863021; x=1733455022; bh=kdpsjDTInNT67pg6rcoWYfIw
	UDb/y/wdqOWHsy1wY0s=; b=flbgryDMQm54brAO+u3Nb9/bK5GLyGBvtNQj0PtY
	F+tvnWkvaGgn4WLKJB+4Ux5yZnPA6tKRhnWn/7RX39hAF57P7YBf84bYE27aFINC
	3Iuljzvn+fbWPx9PB/EDGk6+yF8MrJ38A+O1pAz06Ke4ndpkzzZUsx2oH+bKQuKX
	bcg+5YvEl+wdXerLoAFr319EjYW+9LbscCd3JK5tL/nelxf6UFyIFKAzlvopEeHe
	GKNHpTduha6ZPYSW26966uQtaRWg1dY1tUcWivsZ+ANFanm1u1mL29zZuqAwpbkd
	RT55U0MqW5LbddfZEKpaJfLIVg8QLq/gelQTSgTLlo3U4A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T_qT-eNPvRPQ; Wed,  6 Nov 2024 03:17:01 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xjr3J1nr9zlgTWM;
	Wed,  6 Nov 2024 03:16:59 +0000 (UTC)
Message-ID: <ce0d9452-8eac-49e1-97c6-c0e9c9ee6d2b@acm.org>
Date: Tue, 5 Nov 2024 19:16:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix the initial value of wp_offset for npo2
 zone size
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org
References: <20241106000216.1633346-1-weilongping@oppo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241106000216.1633346-1-weilongping@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/24 4:02 PM, LongPing Wei wrote:
> The zone size of Zoned UFS may be not power of 2.
> It should be better to get wp_offset by bdev_offset_from_zone_start
>   instead of open-coding it.

Hi LongPing,

As Christoph already explained, only zone sizes that are a power of 2
are supported by the Linux kernel. Hence, patches that mention npo2
zone size support in the patch description probably will be ignored.

I'm wondering if this patch would become acceptable if the description
would be changed into something like "Call bdev_offset_from_zone_start()
instead of open-coding it."

Thanks,

Bart.
