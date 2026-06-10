Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1712C21E8
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111789; cv=none; b=dnJ+4h1eNG/8goH8c7epOjX0RWchspyP0o8Me+Uj2/ExESqLV018FmqDHU7OMNd+X13ROtjtg8o//lDRGtC5E2Ie2a8P8iLXTH5jQI1kZUkOv2StCjfLEcNYXL/0SmLFTGTbeF0W4m49iY5pW46GT2Ln7Z17jRRzFpc9fCI8OgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111789; c=relaxed/simple;
	bh=2HJAYbdKVUMuetzViHjt+DE3c7FCAOCxRvpEqFNRkm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5P44pBi8MDPzmQg+jl5O97GNPwfAdFik8Kqz+kI79FWiakJ57jq7vuGuKE/GcPg9y9m1tXBldygD8VobXPxMQ1OXAq7s4hlXAL0viWFdx3yCDTCNcKGGvp7PgpNP1/zJL/uuMJKx10kINDmtW+pyWxWmuqvyXwP0Cz8Ve3o0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZBudK8sW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZBudK8sW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbC9l5MRQzlfdvh;
	Wed, 10 Jun 2026 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781111784; x=1783703785; bh=wmCgffaXPtNsWoqtqq6Mrgfd
	zXQr/xR8gbh/QbDb3lc=; b=ZBudK8sW1uvGAhGLLOiC70hJo0wU7Zgkc4qkoXv2
	2ESrkC6X71silJQV5mxuE8WkE34H1Hv2vqSZr/e8miILtz4DDB8ymYQinERaeEKc
	GckqQ2ML6mkm8p5uWHgrWN5EAH77oVIRWHAK3ZFCuulAbihwfw3fFofiwPyASFvk
	EMApRqwfNFxts0eTxuUWit8oBKq7B07Eqd296ATT2SbG8tBRT2HqLk0S08ZqSHii
	CZLOvO6mJ0nvM87j4+E32vIrCPsGaHZ3/UdW2XtoZWbq+Bl3c+5vaa+uyi5LdST9
	DEyXot3cwWkY2qe68WZ50CuLFYOLmR+9wYTVSdgD0a8bvg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2Z3SIjXZLm6e; Wed, 10 Jun 2026 17:16:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbC9f2SSTzlfdds;
	Wed, 10 Jun 2026 17:16:22 +0000 (UTC)
Message-ID: <ba18cfd5-0a52-4e2e-85a1-a9f0a20ff957@acm.org>
Date: Wed, 10 Jun 2026 10:16:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] nbd: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <josef@toxicpanda.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <5361809d027e772503ca3cc458aaebdf06792e3b.1781042470.git.bvanassche@acm.org>
 <4c8438e3-2415-43c9-ba6a-27321070c58e@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4c8438e3-2415-43c9-ba6a-27321070c58e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 1:02 AM, Nilay Shroff wrote:
> Above changes are good, however I see nbd also uses @nbd_index_mutex
> which guards @nbd_index_idr. So should we also annotate @nbd_index_idr
> using __guarded_by(&nbd_index_mutex)?

How about adding these changes as an additional patch?

Thanks,

Bart.

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 345e4b73009d..b9e0ad0b3ca0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -49,8 +49,8 @@
  #define CREATE_TRACE_POINTS
  #include <trace/events/nbd.h>

-static DEFINE_IDR(nbd_index_idr);
  static DEFINE_MUTEX(nbd_index_mutex);
+static __guarded_by(&nbd_index_mutex) DEFINE_IDR(nbd_index_idr);
  static struct workqueue_struct *nbd_del_wq;
  static int nbd_total_devices = 0;

@@ -2739,7 +2739,9 @@ static void __exit nbd_cleanup(void)
  	/* Also wait for nbd_dev_remove_work() completes */
  	destroy_workqueue(nbd_del_wq);

-	idr_destroy(&nbd_index_idr);
+	scoped_guard(mutex_init, &nbd_index_mutex)
+		idr_destroy(&nbd_index_idr);
+
  	unregister_blkdev(NBD_MAJOR, "nbd");
  }


