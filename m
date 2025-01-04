Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0418E20
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735956972; cv=none; b=KBqu8WhPsYGoZQ3oB0cysQJ9SEZ+zE5gA1cJX0Z+qpz4IWo7/s9taSA7YUjsdPKgSXEaomiWgkP11TeXK7GUmQghRtE/nXMmCeltOUeZOLzipCo5FroOs8xmH6SCSYvk1oGyJDCV3UUNwn5eocY/qsvdXwfEcHCjCQxVIchnaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735956972; c=relaxed/simple;
	bh=5VN957REF2iFBjJUQXYrzO82dPHEiICFtCPGjgM+Cr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+5YRtefNOVzD1mKuYr/TQTpK2TZ9XW4AOc/3E7NZpqchq7CKfyAc7GJYGCHonmpQPhTpW03NHLDjrQ7akvvaYJd/BF8E4p66mzzusigq6/hCBccJVd8P7B7jpfLWb7MMDFsvLZt7O1kA6a15y21jlMbSry8FXeaNNVL3eCWnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mrx9emRG; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mrx9emRG"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YQ3vk6lLbzlff09;
	Sat,  4 Jan 2025 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1735956960; x=1738548961; bh=5VN957REF2iFBjJUQXYrzO82
	dPHEiICFtCPGjgM+Cr8=; b=Mrx9emRG4NyA7gWhnSSfdp3XWFqfGAljE9RulJud
	M9pl+SgugPd2q91KLh8bYB6S27gcnnSYzvUAXJe/TIM1rsBqpL/yN2ye1Phy1jSo
	sYSPMrhQqcyNdLod1Li2p4p9KWrC4oLRNVx+rmJE6QHj8+POm/yYa5Lys4MEPIwB
	B8MdOALgpm05z7FjZ4jIEtRUKajWteQf0AwOvuyAjz3RKeyecDub7vD7wqrOtdrR
	kIj2pmRWQz9edLEU9z6GR6BwDX0LcoENb/ehd7YNdmoeVQgjL4yQXWIJnwxRCqWa
	YeY8nfZyJUdN2EJM8SYtpjPUs8giFqEA3AYZlhu1qJG0qw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v4vCbZ6Ra12Y; Sat,  4 Jan 2025 02:16:00 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YQ3vd16sBzlff05;
	Sat,  4 Jan 2025 02:15:56 +0000 (UTC)
Message-ID: <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
Date: Fri, 3 Jan 2025 18:15:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org> <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org> <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/25 5:47 PM, Luis Chamberlain wrote:
> While that addresses a smaller segment then page size this still leaves
> open the question of if a dma segment can be larger than page size,
Hmm ... aren't max_segment_size values that are larger than the page
size supported since day one of the Linux kernel? Or are you perhaps
referring to Ming's multi-page bvec patch series that was merged about
six years ago?

Thanks,

Bart.
