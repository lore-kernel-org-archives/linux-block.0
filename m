Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDB2066CB
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041150; cv=none; b=eIlebqvYdnOvjLy+OZNnMuBZPnM9kPAI6TSI2FQLCbNgx31fHI565ZIyphS3PsH8XLK1hl+jFyDq1+upLeBRH2glZ5M7Vt/8QyQDhaBlPUz5ITWjJbL6DLtVgo0dEcqBr7/k6onBKniXmk2SYmcF32CYVpbXsFlP9Zw57OZKRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041150; c=relaxed/simple;
	bh=DFqjpApIq0E3LRt2i9SEVTb8BqfAnxn+Rdbdz36Ek0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtGMTfgY8DftsXMJ9OOHhPl0dax6XSrM9pCr8r6Lagjjdb4MKhLCefzQbsJITcrylbLkS6WyteftdYtY78Nu4l0kMpNv+e5p/ESXioy0AHJtsNm1jNxgMv3/KUbD8aCiYS2PNQQIyobZunTZerZpr1AhpMS7Z2E7bewpQoIAEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p/bq2h/o; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p/bq2h/o"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZWYcq50LWzm1Hbv;
	Mon,  7 Apr 2025 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1744041145; x=1746633146; bh=oxvfkoktGok/Tj8yNFuiqz5n
	ymZiR4HzCdd9/8a13b4=; b=p/bq2h/oyn3YhPR9Avw3KgPwhX7fOjlTQxDLy87i
	Lvq3NB3pAb5v+B6278kf7bhbB4ILbrrXofcauEJH6P3UEgqmRb0X2qaWM5LlvPpw
	vwE+LxRK14AUAZ3m972Np4MhpnwUkSPS58LjYKDnH+FtdQ0koYAHO8C4iiPahT2t
	1iN16w6/2z4OuNC9S8Mp98RGmKofKWhru8NAsqd624u7zBlc2vBoD1gFhwc2U7jS
	IMUrKokmfpmz2jjInkoVJoJ+/Ueeo2QIggCm8193H8NNENlwEzflzLNuIYDmA9MM
	QRDo4ZK3FouV9sx8iwWUnS9FnX/jnpCKh+cP26Sfd2kIVQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Xe_ks9NQxyHZ; Mon,  7 Apr 2025 15:52:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZWYcd104Jzm0djP;
	Mon,  7 Apr 2025 15:52:15 +0000 (UTC)
Message-ID: <e65d2884-a021-44e2-b3cc-9e9badad56e7@acm.org>
Date: Mon, 7 Apr 2025 08:52:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bio segment constraints
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Cc: Sean Anderson <seanga2@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <Z_N5nxLDOBb5NDAM@infradead.org> <Z_PXONJyuv4Z8ATr@kbusch-mbp>
 <Z_PaW2QS3OXTXHSO@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z_PaW2QS3OXTXHSO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 6:59 AM, Christoph Hellwig wrote:
> On Mon, Apr 07, 2025 at 02:46:32PM +0100, Keith Busch wrote:
>> O_DIRECT only requires each user iovec be a multiple of the logical
>> block size with the address aligned to the dma_alignment. If the
>> dma_alignment is smaller than the logical block size, then this could
>> create bvec segments that are smaller. For nvme where we have 4-byte
>> dma alignment, you could have the first segment be the last 4 bytes of a
>> page, then the remaing 508 bytes from a different page in the next
>> segment.
> 
> Oh, right - with a smaller dma alignment this can actually happen.

Some time ago I added src/discontiguous-io.cpp to the blktests project
to trigger this scenario. This test program submits an SG_IO request
with multiple 4 byte segments. Maybe this test program should be
modified such that it uses O_DIRECT instead of SG_IO.

Bart.
