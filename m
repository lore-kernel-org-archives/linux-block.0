Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFF1F09B3
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671022; cv=none; b=PyjlimHGRmpRFKZcWFBRTx+ug1eSyiuMBVaxdjyscdNbEiCRtkxwVD+hn5pxYDA286K+gl1iITlfYlhHKjJyDazmpDGmCQJ1E0+Bp6RfAObfHhOcvT3LTgICLtXVq2NbII6N3nYnXVe2wUipyP1lJb8lxeVTWHUQT2AJIOL0NOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671022; c=relaxed/simple;
	bh=ToCX1PMgNFGjBuB+DrAAA/69P0Ovrsbnqcx12WMjJMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQo89CHXAljQWNGE9ZeNlrHvSwwUg61lLBYOANY2WyAvVZJ/5KUDefYkX/Cg74sNqFO/oT2R6eVGKNeT0tds2jS/1zzJpID8hNpBeINdop0rv9+tNodrmMooSGNUXz0ERtCiOmMa8FyZPhY8NwyryElBV6vA7RfVLSmcCToyPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Dpzb88A4; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Dpzb88A4"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bHbgb4lBbzlgqTs;
	Wed, 11 Jun 2025 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749671017; x=1752263018; bh=NGmem5epDC6IbZvU+zJ6cdwp
	W6TETAEcpYIV6cntyLQ=; b=Dpzb88A4VXgI8w8cFCN4qiye7uml62WSaFO/+khL
	EYX9/CIiDb0HPo2kl67zKto/FGQcjW9fQMaecc0AbaFg63kDci08xt2bSy2C0rwD
	t5xReZQUUpPqdn2nf4v8pE93QaMeCI5Eoc5H58autuO0UYPxdwUTVU5KyiXcfjws
	m0ZxPcfKbV3G/Yh+sLKj5j4OlUCwxkWJQYhea233JlJIohxdo5tgS1PTxonR0pjx
	W7cRVAY5lOou9qmKiMAqRfdaQP75lo2Vrp8JZY4zpAjYI/AlvWkN+cZcOeLCkHA+
	kLpL5aygDMMg9MqSZklPtqXePuHkRGbiz1+uwW1Wnl68KA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GPPfoqWm9TS9; Wed, 11 Jun 2025 19:43:37 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bHbgR3BJFzlgqV8;
	Wed, 11 Jun 2025 19:43:30 +0000 (UTC)
Message-ID: <42af0af1-8e9d-4da7-b3da-b48152c6604f@acm.org>
Date: Wed, 11 Jun 2025 12:43:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <20250611034031.GA2704@lst.de> <20250611042148.GC1484147@sol>
 <1853d37f-b7b1-4266-b47f-8c2063f36b7d@acm.org> <20250611181551.GB1254@sol>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611181551.GB1254@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/25 11:15 AM, Eric Biggers wrote:
> Well, again it needs to work on any block device.  If the encryption might just
> not be done and plaintext ends up on-disk, then blk-crypto-fallback would be
> unsafe to use.
> 
> It would be preferable to have blk-crypto-fallback continue to be handled in the
> block layer so that drivers don't need to worry about it.

This concern could be addressed by introducing a new flag in struct
block_device_operations or struct queue_limits - a flag that indicates
that bio_split_to_limits() will be called by the block driver. If that
flag is set, blk_crypto_bio_prep() can be called from
bio_submit_split(). If that flag is not set, blk_crypto_bio_prep()
should be called from __submit_bio(). The latter behavior is is the
current behavior for the upstream kernel.

Thanks,

Bart.
