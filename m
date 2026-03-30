Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C439DBE2
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900181; cv=none; b=qwvW572oU0TAllSVK7rrBYhwhlREtHKgXkpwGZsZAyD3jsWfWXjdCvXXU8mgms/gHGqo+WVqRYZw1lUuHYarPoMg+xYk41bog02jPSIl91QuiWdja22tzvd6TJOSP2FlZjzvTfvvCmYnr0xJz7YL+O5j9CkfTpCuJfN6petnYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900181; c=relaxed/simple;
	bh=Hw4JQfJQsNAJJxhhioKh7J5MFJGvbL42ySFItHY7zKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVlfhsgekPnc34tGmEQ/zhZq6j72g8McHyZcGt1oz1unLZDv6mZXFSj5v9IZO6LqNS588Hs6p1bsOMEDEtWCmoiSwp2AyUZJOlClbBjNul2bxX9wuQwNVsMkHsJIlPehcUFjKrbHFGApa0RZ3SwbMBWvLGKIMrmdkpgHWNNqSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D1jYBXqX; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D1jYBXqX"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fl1zl1cD5z1XM5kt;
	Mon, 30 Mar 2026 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774900176; x=1777492177; bh=LvQ5DqyAmTOwoewEG7uGd4o/
	w75iQ8ONt+MxXA2rIvg=; b=D1jYBXqXErp01F4YPqhVE1VnXucXQdqLYFeGB/fH
	sLn/aGNRpDE0EknOOhRwlPsOriSKiVz12YYe9Cc79/KbSzFYcefi6Bxc9TUjIE/D
	4mHIj385ynXD22dh/w0suK3ofN2C+NfBxA9SfFAk873kU1Aa46tzTlaTVHlOoH2Y
	mlT+RKBtmaBILOKUxdvizkq/3ek8hJdJOUWS8HeuMKDvXVZYEPkN5ulYDNI1TrVm
	rEsyS+g71uP6mmFNFuOpkJ9TruOhvSk84q534EtHr+Vy/7EH7MYeIFRLTiHzCwzc
	6LTeM2M2DrqDwrbuu6bB78PPGtLSPbfY4qCX82JDbVm6JQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3NsCct1S74U7; Mon, 30 Mar 2026 19:49:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fl1zg1N8Bz1XM5jn;
	Mon, 30 Mar 2026 19:49:34 +0000 (UTC)
Message-ID: <7fe454fa-d39b-4d2f-a238-297df2261cdd@acm.org>
Date: Mon, 30 Mar 2026 12:49:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] block: Reduce the minimum value for the maximum
 DMA segment size
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-5-bvanassche@acm.org> <ack5VqUS_gRuxodF@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ack5VqUS_gRuxodF@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/26 7:38 AM, Ming Lei wrote:
> On Fri, Mar 27, 2026 at 02:13:44PM -0700, Bart Van Assche wrote:
>> All block devices that are supported by the Linux kernel have a DMA engine
>> that supports DMA segments of 4 KiB or larger. Allow smaller DMA segment
>> sizes because these are useful for block layer testing. Reject values below
> 
> Can you share why/what it is useful just for test purpose?

Your commit 889c57066cee ("block: make segment size limit workable for >
4K PAGE_SIZE") adds support for devices with a maximum segment size
limit that is less than the virtual memory page size. With 
BLK_MIN_SEGMENT_SIZE == 4096, it is not possible to test the code paths
added by this commit if PAGE_SIZE == 4096. Allowing a segment size limit
that is less than 4096 bytes makes it possible to test the new code
paths on systems with PAGE_SIZE == 4096, e.g. an x86 VM.

>>   enum blk_default_limits {
>>   	BLK_MAX_SEGMENTS	= 128,
>>   	BLK_SAFE_MAX_SECTORS	= 255,
>> +	BLK_MIN_SEGMENT_SIZE	= 512,
>>   	BLK_MAX_SEGMENT_SIZE	= 65536,
>>   	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
> 
> This change actually becomes not consistent with previous patch, in which ->seg_boundary_mask
> can be 4095.

I will drop the previous patch.

Thanks,

Bart.
