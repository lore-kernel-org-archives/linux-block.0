Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECD1B6D15
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495539; cv=none; b=VK/NZ/Dfl9Ubwzo+xFsCwyquRjo9YCuyOsMlBnlpJ6OPwifeurLSPaPb7dkeA4tgHXAuyOOg3QeMa1I9Ipb2bKILXqkVnwVxxt8YBC3BVV5Kj5pPi/0wuKy+nNFC+zZl7IxgabaelzRjUiJfx6VloLNPa+8b1nKUGkTy3pfEYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495539; c=relaxed/simple;
	bh=JfG52D89QWZAVVUADl1+dHplolSOIaSuY3VYCvywk3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htDucP4kM7Bq6vWDNgRTORjeTAYph+dYZDbWYv+DKXtqvp0h6cGMoEoneFL9IzX1kEA7d7nxIhP5JRFAMxhTGjxapUITIesS20g5t1JbkT4d6u+o0X9t4oH9Afnp3LEgM/2JvwC7cCx8C5OGesRLp+8cbpMjCaQ2oKQCdcnzRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=udRnxF8f; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="udRnxF8f"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Yd0vj2thSzlfq18;
	Tue, 21 Jan 2025 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1737495534; x=1740087535; bh=m5cxGpaYtiizZjhCeniN9OQt
	VM8gzrk2EdaiJXVr5Zs=; b=udRnxF8fKBvXXnfe6taRHDICyIJN3T/79hFB6N4z
	mXcBdT6RJIZrm9Xwb2WfZtoD64yofM7fOaFDIkiRR3ezd/sMlmBKfwImFTwHuvht
	UzkAQgKQxJU6SCCOi25fhmD+ODEagHnfA57YQdHm64S8wFsVrYZUImQxwzP3F4N4
	wm3Evjw/1I0bVE2js0nXHniiyAMy15vGE67+WlkmqcKrcGTYpqhiZkCUeVKsFz2R
	VaR5J8MJCoVEwlNbksyDmVEno0fykUI23ktYNNdr2gnNQoOabalA/nZEeWmH1M5Y
	23x29quT4xfL2nHb4OJ85Y6rCL9LAl7jYGpkyxBr4+cgvQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tZzNbqNDHqTn; Tue, 21 Jan 2025 21:38:54 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Yd0vc58yWzlfq10;
	Tue, 21 Jan 2025 21:38:52 +0000 (UTC)
Message-ID: <785fd5c7-e0a2-47f7-a7b0-f10c24142dfa@acm.org>
Date: Tue, 21 Jan 2025 13:38:51 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/14] dm-linear: Report to the block layer that the
 write order is preserved
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <20250115224649.3973718-3-bvanassche@acm.org>
 <b0717657-8ecd-0fcf-4ca1-eb9f91ad01cf@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b0717657-8ecd-0fcf-4ca1-eb9f91ad01cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/25 10:04 AM, Mikulas Patocka wrote:
> What if you have multiple linear targets in a table? Then, the write order
> would not be preserved.

If dm-linear is used on top of zoned storage, shouldn't each target
involve a whole number of zones? Doesn't this mean that dm-linear will
preserve the write order per zone?

> How is write pipelining supposed to work with suspend/resume? dm doesn't
> preserve the order of writes in case of suspend.

That's an interesting question. I expect that the following will happen
upon resume if zoned writes would have been reordered by dm-linear:
* The block device reports one or more unaligned write errors.
* For the zones for which an unaligned write error has been reported,
   the flag BLK_ZONE_WPLUG_ERROR is set (see also patch 07/14 in this
   series).
* Further zoned writes are postponed for the BLK_ZONE_WPLUG_ERROR zones
   until all pending zoned writes have completed.
* Once all pending zoned writes have completed for a
   BLK_ZONE_WPLUG_ERROR zone, these are resubmitted. This happens in LBA
   order.
* The resubmitted writes will succeed unless the submitter (e.g. a
   filesystem) left a gap between the zoned writes. If the submitter
   does not follow the zoned block device specification, the zoned
   writes will be retried until the number of retries has been exhausted.
   Block devices are expected to set the number of retries to a small
   positive number.

Thanks,

Bart.




