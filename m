Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E4190666;
	Thu, 29 Aug 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929504; cv=none; b=gU8XRNipNEOP1nJPjTjwb9vEJEZaRZQGoTB0e7AdCAzYQGIix43GGFlLMU79tSP+k7IR51vwwfIR8+rbZ0MFQCFOEQpJgZFw4V1HOdFmustRc1m2dX8SL4IXrrm2jpn7dTWcsEs1SWqpC1lY52EL78U8PbxJyFYvirGWas4YRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929504; c=relaxed/simple;
	bh=bzNvFadF4wK+EOPytaj1niOLHgvsW2j3Enw0IwTHUpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AchsQ2iyiZ+HSVWrwhN72tv1J3wj6y1+ZzPKnS5iS0jcc8fT6Vbufq7LY36nlIz2O8ekn0yzEVrL0FX6+ok6wYop2SeXuVneSfGAUmR2cQip+J+tJl98Qnc39KZ8lmHgyfhxUizSWj51WRFLvQ6jSQQWvTqhTFF7cT8oIb2xlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=usgpqitR; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="usgpqitR"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WvdjB0SxTz6ClY9g;
	Thu, 29 Aug 2024 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724929500; x=1727521501; bh=bzNvFadF4wK+EOPytaj1niOL
	HgvsW2j3Enw0IwTHUpw=; b=usgpqitRk2QOeCA66RniM/QbUwPHR+E0uMPTln91
	ZdM1srArMaVXvXDNcgQH3q7DgS27PuZ38oWlkpyu1kgvasJqJXnXSvsvjqMs31k6
	6rqn7HiCW0LvGwHVZfBg73BeR0B03+vwxTVqtMmH83Lpb5wEklXsWITMwktnupgl
	8f6xrcsN91/2VoTXYSE8YfdW4992lmc50C98+iOftQO1WKdcKJdrweUzrjm7GFCa
	HDk06UijKTSHgmwA8nY+6G6u1mHuORIk9dNtg7qknmLrq00aNZrPP/WlAFnMwLA7
	Z7dUmcjLnWzizUnvhhY2ZttZhGxlHYIQG1z7OBla79dKXA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QyCQZHKppe7t; Thu, 29 Aug 2024 11:05:00 +0000 (UTC)
Received: from [172.16.58.82] (modemcable170.180-37-24.static.videotron.ca [24.37.180.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wvdj736Rcz6ClY9f;
	Thu, 29 Aug 2024 11:04:59 +0000 (UTC)
Message-ID: <517e19eb-010c-4509-bec3-c3f8316f2c0f@acm.org>
Date: Thu, 29 Aug 2024 07:04:57 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] block: CPU latency PM QoS tuning
To: Tero Kristo <tero.kristo@linux.intel.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 3:18 AM, Tero Kristo wrote:
> Any thoughts about the patches and the approach taken?

The optimal value for the PM QoS latency depends on the request size
and on the storage device characteristics. I think it would be better
if the latency value would be chosen automatically rather than
introducing yet another set of tunable sysfs parameters.

Thanks,

Bart.

