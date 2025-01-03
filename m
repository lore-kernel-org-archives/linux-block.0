Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1831BD9C2
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942370; cv=none; b=sdnxkir77wUMvZVDHVZ3ydie48upPxFTWsgVEFEpo4aL+VjZGc6BGctj6bV7jFs/Pra4lwQb+TITieB1I0dCu+Ksmkmnu2+OVk85pBBT72Xw8f7YQYu+9xz+T3UQPi0iuc0ZZ1P3fWRKRFLiv4Pnq1F9Hh99OCpVMpFyXIoI0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942370; c=relaxed/simple;
	bh=Hhx6nnjmWQQ5H9KEPn0rSMjUwALg95RecFhahughkO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Owzz7y3Cb3oGG7AfXKTZuVYv3o6go5n4Mnukod2mv3Bzl+2Qnf1+V90ADpsvr+45bUP9HNc22N3+M28+Ad2Y1N2xdgiM60Q7atW55yGzp0RhWRrZqjxGUyedcTyyZ+qERE1bdVd/RRHsaNSVLeSAg6+6pXcqOUN/Z+UaGk57GNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ex36IbkI; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ex36IbkI"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YPyVy38grz6ClbJ9;
	Fri,  3 Jan 2025 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1735942359; x=1738534360; bh=Hhx6nnjmWQQ5H9KEPn0rSMjU
	wALg95RecFhahughkO4=; b=Ex36IbkIiLduhzw9mKP/LkPM+1IjQQfELyDe/CRb
	txS5W8gsGvSYacp8fCHOohtsvLDg1r62f5/V6LzECw6Gda0IpRIcAwA9rGDeNcNk
	mEklOhoxYLfVv5jVORBK85SRWqvnB3llErEhr4MZpuznCIet/mRu/XOX1St/mnz4
	oU+Mp83PPDUZ+ig8LkNhDTcuqz13/LzOXmcNHs+QFya5qyg4F4b/c577+o+neBZj
	K6KQW58RZ5I+t/LnhP3hrc1bETava3iErZCArJjYEFQ8jfdIQYZG5IyvkseCK3Uo
	Ndljx02SHZ2NCP6jUenf34UeTmc2ruT/F4f0iZS3gEFGLQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G430Tf08iSU1; Fri,  3 Jan 2025 22:12:39 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YPyVs21Tqz6ClY9Q;
	Fri,  3 Jan 2025 22:12:36 +0000 (UTC)
Message-ID: <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
Date: Fri, 3 Jan 2025 14:12:36 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org> <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org> <Z3dFBQIiik6FWLut@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z3dFBQIiik6FWLut@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/2/25 6:01 PM, Ming Lei wrote:
> But why does DMA segment size have to be >= PAGE_SIZE(4KB, 64KB)?

 From the description of patch 5/8 of my patch series: "If the segment
size is smaller than the page size there may be multiple segments per
bvec even if a bvec only contains a single page." The current block
layer implementation is based on the assumption that a single page
fits in a single DMA segment. Please take a look at patch 5/8 of my
patch series.

> From the link, you have storage controllers with DMA segment size which
> is less than 4K, which may never get supported by linux kernel.

As mentioned in the cover letter of that patch series, I came up with
that patch series to support a DMA controller with max_segment_size of
4 KiB on a system with a PAGE_SIZE of 16 KiB.

Thanks,

Bart.
