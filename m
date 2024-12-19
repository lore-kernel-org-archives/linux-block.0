Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD119E99A
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628376; cv=none; b=Q6GuuKz5kDehOFsbbhctMXivEu0WDezU/quauL3/pwpRqIegjL9yd4GHsOjVEtgWV+gtpWxMv28CpdjkJDgCvWl5EWrfWCXV1XNqVaVtCsvU8kJmzojfSPxhXeGTPL9IVdum/Rw0wKFtwGhbDW2Lm5wI2ukQhgN92z/QmBo+3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628376; c=relaxed/simple;
	bh=oBCgeboPYE/wEXOQQHJimfHVm+CNHAbx8sLuezl/+yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQEIBkpbYlXD0VoeUh4DdsYRJjEBFjygnT78UWXjFKG/L2BJlxx/FNjRXLlvshsYQTLUQvia8BIUV5trYox5iDdfsBDCzA2hf5GBD3z+h897QIYRVVdP5hJrjww+noV6HaZSTMprUI9ZUaU8vDu6TTVHmhwM3tRtpt5sh9mJ3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KZeafH3v; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KZeafH3v"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YDcYy4pjJz6CmM6N;
	Thu, 19 Dec 2024 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734628372; x=1737220373; bh=vSTYFYNKVUZTdEXS0twhFZad
	q0hr9qkpG55o/7ZnsbY=; b=KZeafH3vxmqIcJduRsCY4drdjsdFE0JbWj6icrVn
	uBVuQmW2IsdOyf2VmDITf6qrzFj5b3jGGY30xvtZflVRcw8l6lXx8em8n59rcQht
	VYFt5knozOqtrW5a6MHXj2xt+ZgZrBXvZI5N/4FOTxliHzX60emtoa8B893Yei9/
	QPT05p22YgHngEtkOAXyYnZVzOtrN1YpVHCufNG/UpVUg1hSgnTQVgCJfYb98Hxv
	YmPEkxu4xBCHszSCR+e9qMVfFS1ShhFcpXNWLoPdNIOiyRAdNZ1GTcksai8QFyAP
	cuLBzUSmGV7cB/xcqeC8/LvrsJSakuwEbSQHHF/ECvS6xA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f8xKOwCHiPp9; Thu, 19 Dec 2024 17:12:52 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YDcYt5k1bz6CmM6L;
	Thu, 19 Dec 2024 17:12:49 +0000 (UTC)
Message-ID: <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
Date: Thu, 19 Dec 2024 09:12:48 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <20241219060029.GB19133@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241219060029.GB19133@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 10:00 PM, Christoph Hellwig wrote:
> If you rely on order.  If you are doing O_APPEND-style I/O on  zonefs or
> using a real file systems it's perfectly fine.

Using zone append operations defeats two of the advantages of zoned
storage. One of the advantages of zoned storage is that filesystems have
control over the layout of files on flash memory with regular writes.
That advantage is lost when using zone append operations because it is 
allowed to reorder these operations. Another advantage that is lost is
the reduction in size of the FTL translation table. When using zone
append operations, the filesystem has to store the offsets returned by
zone append operations somewhere. With regular writes this is not
necessary.

Bart.


