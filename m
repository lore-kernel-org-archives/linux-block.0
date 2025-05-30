Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA02356BE
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620809; cv=none; b=jchC4KSJQZ35ZVo7KsctyOVTYJOIiHBuryiOLBWPmAa4LH5p+dCNkAKu8eG7XRDFC5mZyINnK81lfR3BW4oS07IRKx77zt1AjMlLysspOcd1tz9cPDDTwgZbZjxtSxHrulMWqc+XnU+9RhERwLhV4QgOcMdfS2l9H/NLL8BzfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620809; c=relaxed/simple;
	bh=vMerEnHK0j4SdTUnQ2pq2j3Ou5KZxG3vCiiPCHTF9uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mW9gqDMOY7+l/lClIFHN1BawEYPSvflsem/GC2QO1S0Gi1umbN3VKPFaxs3OCybmn9R6wm3AWdelt8o9ceF1825+Olz82HoVxYvoh0hQPsXJofvAaXQ5SGTzTUASCP6k5esOGzIrqtslcX/wzKxzDaN4oVlBsNOlTMDTyQJi1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BUUj8NL2; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BUUj8NL2"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b87HB52vmzlxh2y;
	Fri, 30 May 2025 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748620805; x=1751212806; bh=NhVofTVzH1dhyRoVgGusEB2Z
	3L0gEdAB0vIw2DyDISo=; b=BUUj8NL2dlBkWIhKTWjnF+30VKcOV8ZdD5Rzrvms
	kaBPrGp7qM5f5rY2z+q4XeiyhAWIWOQ08Sdq7jeI8Jmtmpv1sia33yyNqwr3wApJ
	YdKD2mEb54u+tcYP5asZn98Kz2bC3zuxHnuG2+CMn0nyZ67WZDqNo/uspDaYsO9m
	fatE0RaGPzU4P7W86H7fr4/ECqTWtZhVkoNo0/beuixscINmnB2QYq1eOQ0pbFdc
	22plsCe3sUaMi772EcGV+7Bj9dCHD+7YS3cFjZJ9MsrGybI4OXXdbho1xXrZ0TTe
	ICPwqKVvQOqAzrS0hOhd+MsuzPn5A5U3PfSU6oycp80N2w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CyQCU_ok77L3; Fri, 30 May 2025 16:00:05 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b87H81lMSzlv4VX;
	Fri, 30 May 2025 16:00:02 +0000 (UTC)
Message-ID: <8f14de0a-951a-4724-9ec9-92f73e65f3da@acm.org>
Date: Fri, 30 May 2025 09:00:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests RFC 2/2] check: abort test run when a test case
 exits by "set -e" error-checking
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
 <20250530075425.2045768-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250530075425.2045768-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/25 12:54 AM, Shin'ichiro Kawasaki wrote:
> +	if grep --quiet "set -e" "tests/${TEST_NAME}"; then
> +		ERR_EXIT=1
> +	fi

This is fragile. Please don't do this. My opinion is that test scripts
should declare it explicitly if they exit if something unexpected has
been encountered rather than trying to derive this with grep.

Thanks,

Bart.
