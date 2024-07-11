Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB912288A4
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721761; cv=none; b=mLWDl4PVbB/ezC/AO//Z4dZrYzKCQKYc+smivqGwYbL3y/vSEv4qCVEIM6A5r3Tjv4FU9p9CklpCMkkwTui1UynBdQ/GuN+JYy8ktIT+BDUzsTnc6kXOleLcw6zQ4n9KVbM3wptODyAS0a0JV/20tHtb2+7GK0aqw3DkBRtwbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721761; c=relaxed/simple;
	bh=4KMmeTTvr4nDQIyFAr5q9RFZRu9ejqNCvkma+Tcth7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYl/TRsDijwdzMMkvz6KqnJtc8qodOkdVRehYrX4R7bGqHprZT73+7/LmiDONgudjnN1lVb0tsuZk4dI1p9gpiwvRLCZlVA8ZpA9OkKZP1h+nyrg9EJ8e9vOtSeP2ex+Sr/RQodwhL8a5gMY2EjJsCvnTprrpmVoxVn7CZqN/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=t35vJjyE; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="t35vJjyE"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjb32ZN7z6CmM6f;
	Thu, 11 Jul 2024 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721757; x=1723313758; bh=4KMmeTTvr4nDQIyFAr5q9RFZ
	Ru9ejqNCvkma+Tcth7s=; b=t35vJjyEZSU829Km7QWEN/iOfQJKlANV6hWmuZAk
	G40WarOP+WwSfIJ0m7GovT6NusBzu0PfMb29lB3les3LzxyCA3vRVeYC6G4P1/AC
	tggwvvKctba/7QThtADHrGCvTQLjU8C9Q4MLr072XGexVXR1KuqraUvFVenohbUm
	M6awc3FTt5X+D2iqOO5cvfkf6KlP+jAcKzz1ElG6Llmrgz5WrW1Ytk66SGSocU9+
	UEGso+lb9VwSAq0piSM5VeWtuPe+i+nuSAD6mohPyDWmeC1ks8wmcUlqwnmdlO0/
	uBB3x5p9Jc+unWRmi8DUcglOfHdhPd9dUGlrSU8CIcNTgw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n7HVw8SnSuZQ; Thu, 11 Jul 2024 18:15:57 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjb12Dxxz6CmM6X;
	Thu, 11 Jul 2024 18:15:57 +0000 (UTC)
Message-ID: <4b4b9e62-bf25-4c29-b946-2dfd16b6641e@acm.org>
Date: Thu, 11 Jul 2024 11:15:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] block: Catch possible entries missing from
 cmd_flag_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-9-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-9-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
> in cmd_flag_name[].

Please leave out the word "also" from the description since it's
confusing. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
