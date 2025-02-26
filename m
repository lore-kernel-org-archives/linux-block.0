Received: from 002.mia.mailroute.net (002.mia.mailroute.net [199.89.3.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A521CA1B
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591523; cv=none; b=AWl2lUKkD6gzFU3KmXglfZqCkMivnK7cQaO6XKDkZ5oma1Lwp8EdThHJCDRxnA4adKmJ0ymnk2lO0M/QwE8E2LZ7E7IGxid7jHBL+zsPqejs7LtNy92GuPi043K3KymXTPWMgD/IOgOhMj1SGSDliJIrYQR/+W3D1oZjHkeSTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591523; c=relaxed/simple;
	bh=qrLt3Ls9tcWPuy4O9Jh4xnIfGfZ1fLXaAfp63LjQFOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJ7o1VOVCXIPHMYnDx1xA15a72/MaeortBDkgFrXexTUCe054+Zk02nS2PHRvJqMNdCjZYITFS3Ti2XJ4rEiDdEi8sQeOd8ww5cmymPJVWaENMqpnDXRICHa3LQBmTtRJmaGT1/fa+gzn8PMCH+vB2ebGZyCtl0PciZ4dXKFFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VBrfFVIA; arc=none smtp.client-ip=199.89.3.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VBrfFVIA"
Received: from localhost (localhost [127.0.0.1])
	by 002.mia.mailroute.net (Postfix) with ESMTP id 4Z31sr6xnszm95hg;
	Wed, 26 Feb 2025 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1740591519; x=1743183520; bh=4NMdp47hXJGEXgvTH2XqZThd
	pR+0sNkWHe9VUjjX3MY=; b=VBrfFVIA9YJ8Fyw5a0+5EcIZESNGb3Z5xBuFKEi/
	lGfnj2WK8AC6y5tI226sAep5WFlqyk+nFCcktCAFb0hjvuqgz4VqoXNsfea+VRJ3
	v3+hmLNxF4Zc36wH5bhTbEiZSUXu7HD1fhylj4cQhrQBty2vl4Zr12weIYRfen3G
	X6fVEN6ePz0UMQlqE2ublBcb0IPHCwxcuv4UryAOD0nQQ/f8un8jrim6HfdXbFKZ
	I3mmxVSTYr/hMr/uS274UD0Svr5KeFBIIOsovVV97YdM8MLTCk07/HD5gCTXWhRe
	PKtjYYO1/Ds5py5/YJioUmjDcP95HEjF5Hv8p860ilN03w==
X-Virus-Scanned: by MailRoute
Received: from 002.mia.mailroute.net ([127.0.0.1])
 by localhost (002.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hzREvqjL3MUA; Wed, 26 Feb 2025 17:38:39 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 002.mia.mailroute.net (Postfix) with ESMTPSA id 4Z31sp1GYQzm95hc;
	Wed, 26 Feb 2025 17:38:38 +0000 (UTC)
Message-ID: <253b6cf9-6f17-4a9f-afd8-27204b1e6093@acm.org>
Date: Wed, 26 Feb 2025 09:38:36 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Paul Bunyan <pbunyan@redhat.com>,
 Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
References: <20250225022141.2154581-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250225022141.2154581-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 6:21 PM, Ming Lei wrote:
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..9cf9a0099416 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -14,6 +14,7 @@
>   struct elevator_type;
>   
>   #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
> +#define	BLK_MIN_SEGMENT_SIZE	4096
>   
>   /* Max future timer expiry for timeouts */
>   #define BLK_MAX_TIMEOUT		(5 * HZ)

Hi Ming,

Would you agree with reducing BLK_MIN_SEGMENT_SIZE further, e.g. to 2048
or 1024? Although I'm not aware of any storage devices that need this
change, this change would make it possible to test the new code paths
introduced by this patch on systems with a 4 KiB page size. I wrote
blktests tests for the new code paths before I posted my patch series
"Support limits below the page size"
(https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).
The last two patches of that patch series are still needed to run these
blktests tests.

Thanks,

Bart.
