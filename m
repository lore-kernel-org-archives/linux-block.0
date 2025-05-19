Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AA21170D;
	Mon, 19 May 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693373; cv=none; b=hfj4SoEkjLSNrB++d9cffVY/dDwe5vUPpdmQjrJzt9QRKtq8BOhHZcAq6lx7Ll2mut65IlrONQEwQp39ifqJaJQRshfb9q7mJvVNkmrJy/vuDOnT9WTNWTfQVnPTl4KyJOYBIWFfEJqm2fX1Gk7CaiNNwqkyDFHZpP7EEWMcOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693373; c=relaxed/simple;
	bh=ynWZ9U/Stu98w29qcCs5Czhp0vGYMgAXb4xL7qg717s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq7oyMJxhiWTjxzPfWzgth2N+iz7cMxvQzwK3/PmUxkEBWTuWYQNlmwezju/8vTxv5ZPOnX/2fq+q8Ah9APdd6qWe+A4NQ/+HavviaZZiKnPNXyLlbVET/9GhV6h4WCLeMLID34IyJgo1Q0d/2LLEowqALRTkUh/qSztFvDwrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=G81b6xEH; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="G81b6xEH"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b1XHt0HwGzlvq5M;
	Mon, 19 May 2025 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747693368; x=1750285369; bh=7SeaSXNzXsx6C8G74z3WNIqL
	qgcbUqD8/H90LRZkj8Q=; b=G81b6xEHcs/4Qtj5mDMMvDIZFjqtOLRe7Jgtkg5y
	pRa0A4tYAQIKe34If5ZScyuy2zB+mnBm+UDaVGOL7832WphqN3CtrVIUmbK/3e5t
	Q1sk3X+3CO691FFhN7XzZOvLLpVeRaA7f1NORbZtmPmRFRvG8HVyx4669SSDtUfq
	uL4tE0jPX2Hz7OWqsB3bRt05UV7D1FjxDDHKfhoe39BOc/yK/vLYA0WTkLjk0iGZ
	JhGL7nc26fN0qtRt8x3/jiiweG+rq6Xx8n8vSsMgUuvJI/TyXLsDuhIFlezlKs5z
	rLJzj3AMJPTmx4nv3HH8sp1qHOGLcArB1lnjgYR+BAR+eQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sH-U7Z1-Dz5b; Mon, 19 May 2025 22:22:48 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b1XHm1dtpzlvWhs;
	Mon, 19 May 2025 22:22:43 +0000 (UTC)
Message-ID: <77b43f78-916d-4b28-85dc-3ed5c36abfed@acm.org>
Date: Mon, 19 May 2025 15:22:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: Fix a deadlock related freezing zoned storage
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-3-bvanassche@acm.org> <20250516045124.GB12964@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250516045124.GB12964@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 9:51 PM, Christoph Hellwig wrote:
> On Wed, May 14, 2025 at 01:29:37PM -0700, Bart Van Assche wrote:
>> +/*
>> + * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has been
>> + * set because this causes blk_mq_freeze_queue() to deadlock if
>> + * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() for bios
>> + * on the plug list is not necessary since a q_usage_counter reference is held
>> + * while a bio is on the plug list.
>> + */
> 
> How do we end up with BIO_ZONE_WRITE_PLUGGING set here?  If that flag
> was set in a stacking driver we need to clear it before resubmitting
> the bio I think.

Hmm ... my understanding is that BIO_ZONE_WRITE_PLUGGING, if set, must
remain set until the bio has completed. Here is an example of code in
the bio completion path that tests this flag:

static inline void blk_zone_bio_endio(struct bio *bio)
{
	/*
	 * For write BIOs to zoned devices, signal the completion of the BIO so
	 * that the next write BIO can be submitted by zone write plugging.
	 */
	if (bio_zone_write_plugging(bio))
		blk_zone_write_plug_bio_endio(bio);
}

The bio_zone_write_plugging() definition is as follows:

static inline bool bio_zone_write_plugging(struct bio *bio)
{
	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
}

> Can you provide a null_blk based reproducer for your testcase to see
> what happens here?

My attempts so far to build a reproduce for the blktests framework have
been unsuccessful. This test script runs fine in the VM that I use for
kernel testing:

https://github.com/bvanassche/blktests/blob/master/tests/zbd/013

> Either way we can't just simply skip taking q_usage_count.

Why not? If BIO_ZONE_WRITE_PLUGGING is set, that guarantees that a
queue reference count is held and will remain held across the entire
disk->fops->submit_bio() invocation, isn't it? From
blk_zone_wplug_bio_work(), below the submit_bio_noacct_nocheck(bio)
call:

	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
		blk_queue_exit(bdev->bd_disk->queue);

Thanks,

Bart.
