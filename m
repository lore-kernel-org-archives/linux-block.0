Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4642DC779;
	Fri, 31 Oct 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925692; cv=none; b=XRJq75BZspnMv2T+TUiUhDAgbqC9XXC8yZn7ozSEMhJrpfcGH5x9nga3EtjWLXY1hrUM0Nr48RzLadpIgnFBe9rwkvFQUmMv6whKH2lDdoDfC+kd3ONJ7yXk+tbz6os+i5YNGEb9/idNrR8WBEjxcrI6z1S71QXLts/NNlFXyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925692; c=relaxed/simple;
	bh=oJaKAE5jic3cd5cWJijaVQo8BjqDkj3yyxeDbdeMFmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSzUT1xZ1rLE92eXIeqsnuKjjNMpsgCNG39U+b2nGzck/V9R4UOb5JabBVigUrN7gwUz8fwfXRFqI6YXR8ZSKQdQYqokucgK1jDoOpR3NfQx9A436MozTBmovGVH/I1irqgHCHlkbQid9p+F4IVvZ8eCAEbGRzX5gBkkM16KyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GYpp5DA7; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GYpp5DA7"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cylkK276tzltP1C;
	Fri, 31 Oct 2025 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761925687; x=1764517688; bh=l36Iwd+m+YGHOEKAFhLVj7QZ
	Uydl/74HASoRe/Qelsw=; b=GYpp5DA7S1G3hwubTn4w0dDqtvcP+LIRFaokl8FR
	dPeygjnmrzlfDPzNRYfO3d8h4paoShXQbvn9shy/S8WAmoCeBbEh2U7+Lab24jvi
	zxnPTDUvKib1HkNGmjbnrKAI0zoOx+G2YSvT5bRusK3BiNVnY/BGr/lw5pP0mXkX
	i0yadtn3COoplh+39Uq4XREUXh9MfgtDEpW8Y3YlFrbDOhSQm37Fs9gBTfnuOoV4
	nZs+n8wcNLui7H7rCN9asV0lRss32X+Ir/RgLas9VnybaTdUApfvfhgIKNU0Wpp8
	4/QO+OYd0QFfB5imJQX3naokn5fVr/rclL+lISavRnrBZw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id m00CDwvzkrbA; Fri, 31 Oct 2025 15:48:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cylk83dnnzlvm7Q;
	Fri, 31 Oct 2025 15:47:59 +0000 (UTC)
Message-ID: <fb04975c-55bd-44a3-b4a6-fae8ef7b89a6@acm.org>
Date: Fri, 31 Oct 2025 08:47:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store
 callbacks
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
 <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 5:39 AM, Nilay Shroff wrote:
> On 10/30/25 10:54 PM, Bart Van Assche wrote:
>> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
>> calls from the store callbacks that do not strictly need these callbacks.
>> This patch may cause a small delay in applying the new settings.
>>
>> This patch affects the following sysfs attributes:
>> * io_poll_delay
>> * io_timeout
>> * nomerges
>> * read_ahead_kb
>> * rq_affinity
> 
> I see that io_timeout, nomerges and rq_affinity are all accessed
> during I/O hotpath. So IMO for these attributes we still need to
> freeze the queue before updating those parameters. The io_timeout
> and nomerges are accessed during I/O submission and rq_affinity
> is accessed during I/O completion.

Yes, several of the parameters affected by my patch are used in the
hot path. But changing these parameters while I/O is in progress can't
cause an I/O error. That's why I don't think that the queue needs to be
frozen while these parameters are modified.

Bart.


