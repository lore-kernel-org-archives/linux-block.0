Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84777288A4
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721644; cv=none; b=hXhexYGZwowrgH4UGd5DorGgiOcF3p77keHWyJ+S1Viz6wbcjN3bKsdSeTqkdcNBv4HOrpnr4JIQtqgODczzSWF4hzltJ9L4XbbLxWHIsLftewqA3wcUoI/LnQoxEnALhZorzMvnxOEwOf12PJ4vwG4kI1VzJDxXtbqxWh/VUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721644; c=relaxed/simple;
	bh=s4hJ/eETSHvwAsgYgrIuj1UvGbW07MGrG89N90f3qTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+o9KDWkw4Jfr/BV4wDWZY7/zp8d05qUUOZll4AQdBha1qG7uCrv60vnMoY5Jp7APTfu33Ihb8SvuEjNd/ugqeuo80UDDRTJhkE3/W+o1nfj+z+A4Cs/NdGog2ur5JkJnboJRUUSH7n0Qw69lXjKfNhYa6A7lXMb2pQ83nLCc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=q5AEVIWA; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="q5AEVIWA"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjXp6jH5z6CmM6f;
	Thu, 11 Jul 2024 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721641; x=1723313642; bh=s4hJ/eETSHvwAsgYgrIuj1Uv
	GbW07MGrG89N90f3qTQ=; b=q5AEVIWAiE1dzNGTTruIlfq3Egscv9AgjztXi4LS
	HDaRiAmbK9MQRop0/msWU50Yy27vZcYSH1U772zoHiu/zjx1sqF+oBCaVm2WlRHY
	TN0efZGYnlqG3VwP3d1TP7VsW5UPC+Zk900ry+NyXFDTKt8hf2hCDi4wKmJFiKJJ
	TeEHPKoJ81Ba7ZAnL7sGXtaAnrp7Xzse5RHFYqf2KfGEiUxAJwvT7fb/xbueEO+C
	X3mQjGVACgKjDd8XeR9FwlHBCP6n/FfX/PMq6dGKmPIu3iNIA366ETr+EWkchAXG
	vEeRSAlt61P1tt4vbIiAIC2tlq2+WRYfN/WPj2cKwMSoVA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DznZEBIfrCyR; Thu, 11 Jul 2024 18:14:01 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjXn1YmLz6CmM6X;
	Thu, 11 Jul 2024 18:14:00 +0000 (UTC)
Message-ID: <49d4a7be-abb0-41e6-ac49-bfbaff18cc1d@acm.org>
Date: Thu, 11 Jul 2024 11:14:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] block: Simplify definition of RQF_NAME()
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-11-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-11-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Now that we have a bit index for RQF_x in __RQF_x, use __RQF_x to simplify
> the definition of RQF_NAME() by not using ilog2((__force u32()).

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
