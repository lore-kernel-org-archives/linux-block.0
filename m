Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57863101D8;
	Mon,  8 Jun 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956538; cv=none; b=bkMmddVELcXZNx09W2EHdypbrMoinPxTcTqQ2dGOBNXVD5J/0aPbIxe/2ZI/gQND+sirH/31jq3l3vXNIU7Bv2K2YMuAGFGivgXM1t6TfmQ+oma776QZZ8VX3QB/pVWTnXvglnvaqYksbkcvfc8IYIDxg/khBeMc/EcJgqHDZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956538; c=relaxed/simple;
	bh=NI7kIqJ0JDHO8c6kE8RZpGg2SY9/hT3h8+Fx19eN7lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9YaiLBifANt9ySXcfWXMX77pHrmJxuhqLTpVWQdyVnfncW23xXA5PhDk41aUJf8Ce2IPivkgwNbrAi88IT/CMC7gtS25zk+ePvsDEONYzqZ4kie8gbXm/xMIYJ2UuZwQlpTxx4QqvZgmXNLZUJi5vqOuCzEkMO18Rl/NJuACGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pvMZtQWx; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pvMZtQWx"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gZ5m56xTqz1XM0p0;
	Mon,  8 Jun 2026 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780956530; x=1783548531; bh=SjAXtcd79qVKmBUTGcBdNIte
	N01h2qsin0bEWHUuQho=; b=pvMZtQWxOhMbRgCBBz3wQVL/FHMgitTF3n2dch1Z
	ypse+qBaXHbX7L5k/XBaAGCzJY8eoxZSH7WkMyiK5MHJCb74RKIQO+T2nLGFkuls
	tai09QN/HujhIQWczZxD0wQWXuhq4pW8lWf3CExIB3+m6mqmlHpzGlAeNnUFe2Sc
	JJwAXrXsx3g2LuBIXCjlksiP+bGC+CGfpcgT/BD79uITzT+pAXSFQ5dzVvKYQcEB
	s3bZDGWdy54gZD+GIDPdeLTZKXjZyQdJYW0ZuecC4HnmNA+0Mk4eK056eiG1JZ29
	VvxlKSKqfFXwkglc+MZXv33+TtF/W0cnlv6EcN42eJDs7w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g2UZKBNNSb37; Mon,  8 Jun 2026 22:08:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gZ5m01FpZz1XM0ns;
	Mon,  8 Jun 2026 22:08:47 +0000 (UTC)
Message-ID: <3b276ff3-2065-4cd5-adcf-6664606d1eea@acm.org>
Date: Mon, 8 Jun 2026 15:08:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: add configurable error injection
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20260608051416.1205282-1-hch@lst.de>
 <20260608051416.1205282-5-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260608051416.1205282-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/26 10:14 PM, Christoph Hellwig wrote:
> +Configurable error injection allows injecting specific block layer status codes
> +for ranges of a block device.  Errors can be injected unconditionally, or with a

ranges -> sector ranges?

> +static void error_inject_removall(struct gendisk *disk)
 > +{

Is a letter "e" perhaps missing from the above function name? (remov -> 
remove)

Thanks,

Bart.
