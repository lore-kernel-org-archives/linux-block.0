Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49BB656
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207296; cv=none; b=dChDkFqSua/YJP1btnvnjJumRIST7Rto4R52QiTwd9CR+DXd4wbPKRpU236l/ZmfDfWT7L3MHmRfu88lG7sdyoWKr5DWsz5ld0QMyGRYsn7TEu7G/elJ9m751g5R+HApqQY99zknH2YiUFBh8PlTT0ZSYf/z4l0rlvHVH7k6nJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207296; c=relaxed/simple;
	bh=pZ5j0OCgofAcVJSkS0ABDW/rDai0lKTL2CUKhAXf97E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVOsqU9SApeci+ghlcIwZfUYMTlXNQ8HEDDUuTOfK+LieiVAv3e0EM82nPrsgQktzMohkH3tFxHE6HWlFLeLDYsQwAQe903q2MzBIavb9N3e34EeovoliXYZM5kkKH6T6cwrQscjnjK0x6+EOfvnjJBgxH9Ta8XrJiBMbF0oS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pAs1yj72; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pAs1yj72"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJGZ51j58z6Cnk8t;
	Mon, 15 Apr 2024 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713207291; x=1715799292; bh=pZ5j0OCgofAcVJSkS0ABDW/r
	Dai0lKTL2CUKhAXf97E=; b=pAs1yj72hUDvUvhzSDfTHM160QVbTPauKZKEFHg+
	5GgB3F+PLbn0OExu9FeUhnjmer+6tphZfLsoblw5lLIWevdgsbNHzO5dYTn0EmsF
	X05D4NUMutLTLx0CVzmkF0KBewUknnmwL+zhTNuMzgugCtqQEZ77UDxzQUs5N4tn
	7RJ56jCjLIZ3eFnPCe+iy9B9nAmpKdEIKEbZ0ywT2st77NW2nhZt1hYZ6CTtpKQT
	DFhMvr1RT1Nh4M/jLkvlm2TlxPNS9I+n74DJ0MdrA+saggRVoaX05D4N8u8QEYgU
	cRyvBbHjg9zKgT6o+Wxy1AlRD5lLwzIQ72DCn/vFV4YylA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XNDDKV1Unsrn; Mon, 15 Apr 2024 18:54:51 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJGZ25VF0z6Cnk8m;
	Mon, 15 Apr 2024 18:54:50 +0000 (UTC)
Message-ID: <9d055d4a-9c6a-4217-b310-b2ac95224243@acm.org>
Date: Mon, 15 Apr 2024 11:54:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Improve IOPS by removing the fairness code
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240403212524.524952-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240403212524.524952-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 14:25, Bart Van Assche wrote:
> There is an algorithm in the block layer for maintaining fairness
> across queues that share a tag set. The sbitmap implementation has
> improved so much that we don't need the block layer fairness algorithm
> anymore and that we can rely on the sbitmap implementation to guarantee
> fairness.

Please help with reviewing this patch.

Thanks,

Bart.

