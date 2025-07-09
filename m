Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87B2E6104
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075469; cv=none; b=uvGTXYOkL3XxecCNDEPjB/OWDi9BiKMo8tATdECVBKrn8IscEXjkYVtE6+ATogSWwBMUK1/TWMJCKfN/4fRoS0YafffoakpUoBq54SW9mLW+P2c0mxFGQrB1J6OXsodEP8YtlfNCmkHKgzOooFnF0icTTTUzsqpLvpP2P0nWAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075469; c=relaxed/simple;
	bh=glnWsXpdEmEEn7PrD6cNdsFKAXQl2zDL2s0F6DdSlY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DopTcvPpOYqdBY5Bi5vc2ID+bE9AVXOwVtnszzbe0fxlILpyLdiYW8NQQP+B+DVkTSrlv5k20iQEHVc7sibGL1EvrzaRogJ19VvA9SIoUXVWUyN1L0Es2/r76hGoE9kHj3Io3Ryr/rELUyvs4LWypYk+R8N86F3aKYli6HMyUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=t6NFkSqn; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="t6NFkSqn"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bchtz0h26zlgqVY;
	Wed,  9 Jul 2025 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752075465; x=1754667466; bh=/645jc88U882HQrwNTJJivqo
	ZvwFN/adtZx9ASyGZGg=; b=t6NFkSqnFrRFkkyA6AhnfLPjdsLVX61ZsMT2iOXd
	uwBhs+d3h5cQ1pSJ4oyUIf9YAwyJlo7PHh9/JGKvF2Huv6Ke2fWcnO4xdwfXWuoT
	PDoFbQ1FsWwsf36sqjRNIwixjRL4qwL3LJSx1RDb+T8brlywzxKs1k72S8FFs0mp
	CY+2bhxwjHY31ofSVNxL1nE6k+7noo5RGg0wJvdOytGZ2ZbI2AtsvEQtwLI/a2tJ
	4FGKP1vy8TfLHuBFh9k3/bbMwKdXoHBni/9RQ89jWNLnlUQIRAydNhAXyA26pOnv
	Q/plk8fw+XaLBSZKC59S0ShZllKekQGySjpp6vV90xouiA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wNVK7NvhFs0Z; Wed,  9 Jul 2025 15:37:45 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bchtq6wbczlgqV9;
	Wed,  9 Jul 2025 15:37:38 +0000 (UTC)
Message-ID: <ca6a5406-21cc-4faa-8943-b0eb5630d500@acm.org>
Date: Wed, 9 Jul 2025 08:37:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: add tracepoint for blkdev_zone_mgmt
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-5-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250709114704.70831-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 4:47 AM, Johannes Thumshirn wrote:
> +	TP_printk("%d,%d %s %llu + %llu",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
> +		  (unsigned long long)__entry->sector,
> +		  __entry->nr_sectors)

sector_t is a synonym for u64. u64 is defined as unsigned long in
include/uapi/asm-generic/int-l64.h and is defined as unsigned long long
in include/uapi/asm-generic/int-ll64.h. Kernel code always includes
the int-ll64.h header file. In other words, I think the above cast is
superfluous for all CPU architectures supported by the Linux kernel.

Thanks,

Bart.
