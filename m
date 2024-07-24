Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E31598E9;
	Wed, 24 Jul 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832639; cv=none; b=FAhj8BFv+xhL7ACZmBaa3jXHff3d7aurDFhQdaWNRSAFiIs3SmK/XEVZPJ/ou6OpDFlTZkhvUOwzryRNmzQRCsWEdaRClcMo7HpyZAHZ58GBG2SCGO8FUUjoIKOJeyS8IE5R0G2yAjLW1E8fZ2kP7xG6NTdoIGVrJd+iO1ahNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832639; c=relaxed/simple;
	bh=jOGTzTdQVB5/qbIe7ofKpdZ/PWJW/4td8jdzzKGPwaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLu2ulYU1UNOQ356tQz8ZYMkUegpAi8mvc7t0knBRM0/Wla+JsKelhPp0HeKVUKlBaZlU42lorHPMQJN2D4oVB/Tvn6Nyz/yNXv8aRrNOsZnoDSu4leB5b+nb0UADfm56HcqhbOwV4pfuDtMKfMXjUk0X+1fJ6Dcfdr3G8AbMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FmEhpE6o; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FmEhpE6o"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WTcPz18kpzlgVnf;
	Wed, 24 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721832629; x=1724424630; bh=Zl17srkXpDy2Cr34v6tLu3GN
	MAVzui7YC4ec6xNe5wY=; b=FmEhpE6oBUFmxciYre+qsYsBXxE2xAWuJL6D9oJk
	hSifrUf3UNsTF4qRQs4KZCN5vGq7fl6jwSJTGA6GLkceT/q7k57zOEgneJiEq67p
	HeeFgXighhGGbgNM+Tn0eUy6sfhC+kJBQk5q8xkNYJkL9tPl3Oa261w5xLNtF2Pz
	xRyjAZsWJbuuqFCXyAo9mCmtoLLdVMc6oOrSa47KlXhm7w2RMmFzDsV60RGTfTSj
	L9RdMcf5m7evoPf6rX8yDHc9GiyoKxfzVkXMCy5F30vYKlYTTOpVXrdGtdDCloO6
	5bYk338naZluk12gHrid45+kQlTvzjXF/BDbnneoRpLpnw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yDu4CgvRXDRw; Wed, 24 Jul 2024 14:50:29 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WTcPw3CCVzlgTGW;
	Wed, 24 Jul 2024 14:50:28 +0000 (UTC)
Message-ID: <74654397-dc74-41ec-b527-f1bf634fb509@acm.org>
Date: Wed, 24 Jul 2024 07:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bvanassche:block-for-next] [sbitmap] e992c326a3:
 BUG:workqueue_lockup-pool
To: YangYang <yang.yang@vivo.com>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <202407241556.b0171c94-lkp@intel.com>
 <a32c39f1-ff9d-4a57-9d6b-063adf53602c@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a32c39f1-ff9d-4a57-9d6b-063adf53602c@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 2:29 AM, YangYang wrote:
> The patch in above branch is different from:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=72d04bdcf3f7d7e07d82f9757946f68802a7270a
> 
> return (READ_ONCE(map->word) & word_mask) == word_mask;
> should be
> return (READ_ONCE(map->word) & word_mask) != word_mask;

Hi Yang,

Thanks for having taken a look. That branch should not have been
published so I deleted it.

Thanks,

Bart.
