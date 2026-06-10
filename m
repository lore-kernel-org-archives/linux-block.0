Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F4348C62
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111646; cv=none; b=gDQiCh6Nqmhi7vxRNx79JJSBYTvqAWtdrEDbloi40rn2V5Os4NfxepJU7ETMr5tfILQmGW69Xrvbs280utqJR00sRwkhX1VA6NQ3t9WKAK/2MNzCQ0UJGndIvdTeuvz0gTND8rGfXyKIFmmJ2PiSaleV1ePHDDFt3AOR622ZA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111646; c=relaxed/simple;
	bh=lwEx6jOj839U9OkTQ1VWwQOUy/RhX3pb+CBeV6IEA1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZFjZf7GPhiUf5xRf65RqfGv4AwHEmo3PB75lxwmgA+CTnc6EDLWR80feySo/6aAV2jlSKn/K/Wx1wU9FXQn80xa/G+OPXg9zvXo7mdTZTRz9z/naSqFxyFqo/bOc5/nfoTtcGDplneBhEFNWtKp/k33jZXazFovomSqsNDlfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uprOrHSa; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uprOrHSa"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbC706pDPz1XLyhT;
	Wed, 10 Jun 2026 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781111641; x=1783703642; bh=innLA0hSRUytZDeOSxDsoTLO
	AyIgJJdGrVid/+VX4Yo=; b=uprOrHSadRoS6myuZAesWM0nIzu9MOqts+rRDL5t
	K/F9XhZ7OabQxIHW5ajk6QMo4pJ61pR+NSXygaOYtkgdLcflRAK8TiMmyck4i3Kd
	rcyFl1HDLFUBYg0zoe0o3oiVOD8lBnb1avAvBGtqfN4+QOkTfQY/AIYo5mAqcMH0
	aLV4x1den8G1SCzdDz8UBbI2vy1zNqyKKcd31GigShH8zNZH5JaZSD59lrPtmeC+
	CwQSjBIbn2IPwjzXOTXBGJTZBGlzx9F5Q5z3ScT0WbbmeXfeu4TDUM02XrZKEIDc
	v5j338ynUvU9G5VGh9PodR/4zXdT0yaNbl0UN+2cYAesbw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4RXd8xe46b8O; Wed, 10 Jun 2026 17:14:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbC6v4j4Pz1XLyhf;
	Wed, 10 Jun 2026 17:13:59 +0000 (UTC)
Message-ID: <63ffdebb-24f2-4842-8e65-53045d74dace@acm.org>
Date: Wed, 10 Jun 2026 10:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/27] loop: Add lock context annotations
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <1391f73ea3af981cd2e76b56cdfe47b5bb56ffa0.1781042470.git.bvanassche@acm.org>
 <c71180a3-c049-490f-a8ab-b3faa9714de1@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c71180a3-c049-490f-a8ab-b3faa9714de1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 2:21 AM, Nilay Shroff wrote:
> One thing I noticed while looking through the loop driver is that it 
> also defines
> @loop_ctl_mutex, which protects @loop_index_idr. It might be worth 
> annotating
> @loop_index_idr with `__guarded_by(&loop_ctl_mutex) as well so that 
> Clang can
> validate accesses to the IDR against the corresponding locking 
> requirements.

I'm considering to add the changes below as an additional patch:


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ff7eff102c5a..30a2b2696368 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,8 +90,8 @@ struct loop_cmd {
  #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
  #define LOOP_DEFAULT_HW_Q_DEPTH 128

-static DEFINE_IDR(loop_index_idr);
  static DEFINE_MUTEX(loop_ctl_mutex);
+static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
  static DEFINE_MUTEX(loop_validate_mutex);

  /**
@@ -2326,6 +2326,8 @@ static void __exit loop_exit(void)
  	struct loop_device *lo;
  	int id;

+	guard(mutex_init)(&loop_ctl_mutex);
+
  	unregister_blkdev(LOOP_MAJOR, "loop");
  	misc_deregister(&loop_misc);


