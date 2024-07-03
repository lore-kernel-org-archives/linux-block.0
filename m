Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687B22067
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719985604; cv=none; b=m/e0G8pxWqNFRleyZWjJWsrLNjUVhb8bMPqnWRcHBq1fLBOhARn36WuaTmQ7oL1ndahztH5Zz5Qgy6DMfChr+bZSEeKMmhnUVKZsWFnvEyUsdFBKfe3hyhEuuo7nG6pJURun5I18nXVZ5U2ifYE/g5qwVPDxBJy6IT06zaWXa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719985604; c=relaxed/simple;
	bh=8Q85iIG4kybj4IksJlwSaJ8xZkYrpEHTlKkEFMsI1lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4A4Ht0RKsZoZv9QO7E5d7aTC6eTG0eUGrZZm9Z+Ueb0284Kkq8rjjfAglQ7wR8uicmqV/75oReZERvcbMmxeqK8f29ZPuz9wjbxkoUr3k4TLTMbxngtmzk1r8qfZQUT7y8vSeRK7fgCTopvsaexAWpLBsDukD7DomgEuldO8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HT8EnYbz; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HT8EnYbz"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WDTLB4Gdcz6Cnv3Q;
	Wed,  3 Jul 2024 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719985601; x=1722577602; bh=8Q85iIG4kybj4IksJlwSaJ8x
	ZkYrpEHTlKkEFMsI1lk=; b=HT8EnYbz2nU7tt4HaxBB7x0qj0yiCbGdKCqaQRIl
	M7BMgWhSSxfTRRgALqR94SmaBdWfolViG1eqteMUvhJpEpq6JVMuxDiVHgjSdl+3
	rOZnLpj3YLDvEdIe+eYZuOJvjQ92k7XzB305SoiyNTYWkKpglInxBOJyTIRC9oZp
	sTlYPpiuaJqcyeoKdMDB9NDunJY0CL5VlhAnyV6P1tHdvbADBzDr0QxcHWiWZubV
	l49/4AiYLiz4EHpIWShZZmU16JLr2h8/bXgCDXg9NugFJN568EXVoGyAd89lhffB
	G1yyue7sfiycu/LggUiJuxtO722n+EKLus2DlX9dmqBipA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2ALc1iQiAPdF; Wed,  3 Jul 2024 05:46:41 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WDTL84Y8sz6Cnk9X;
	Wed,  3 Jul 2024 05:46:40 +0000 (UTC)
Message-ID: <a4c47014-04a3-4c37-9877-6aa90dc2fc95@acm.org>
Date: Tue, 2 Jul 2024 22:46:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove QUEUE_FLAG_STOPPED
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20240703051834.1771374-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240703051834.1771374-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 10:18 PM, Christoph Hellwig wrote:
> QUEUE_FLAG_STOPPED is entirely unused.

Is this perhaps the patch that removed all QUEUE_FLAG_STOPPED users?
a1ce35fa4985 ("block: remove dead elevator code")

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
