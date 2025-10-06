Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9912D6E52
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762759; cv=none; b=lrayASDovsKuKKUh5CmdE1K/N7FyhZodVfRT7SkMDLU23bmQb9qBV8+lRevBd5B6UqVqw2ThNGqpnCS4zCH/M8H+CYTRr2Nex4+Ua5yDcafO8lJl18vbtlGgPrZPRduMtjAsaUrCkixvcyG/O6AyAjMJugflgobCYTKU67kYZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762759; c=relaxed/simple;
	bh=0dLcgMm5cs77sPca5DljWXGBqHlbjzj5pMmNHaPy5gU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uRZeVJ1PdhpQORkDLKW2rDuyk5usgwWDpDVRc5pYVGf9Ao7Pht+hiKCrwGMh4FB/dmyaCM8n7C2kwnxJbkprstAiPIY+w4w17BhXzaUhAnPeu+kDz7bST9mji/QTWljtoCWkvZ1hRfT/yxyMelg4FCrRH0q73glV/np3UVuNbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rXMun0Of; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rXMun0Of"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92aee734485so215721339f.1
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759762756; x=1760367556; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdzy6k5xpB9JoJfTT/4U37qT0DEtwQMpcjKLplFFmQg=;
        b=rXMun0Of/YuaPa7cgSA3RY0kS+jCt0QkUIxaYapw7BmCmQAxnhPiVVxwx3WCRi88WY
         OZJaPyDpxx+6IsZN0WsD/xi1ssui1nuBWkQ2AHrPzziP7Rxv6dTsR+k0Ho/wyJt5osb7
         iy5qXAci761zHko7YGoEvuQ6nK4X1LyNJwmPuaVDziO32KhVHxlM/ojAVypAD37Au75z
         UM7fW4Ylk8K/nFcsF1IORuKpaQU5XyLF9yhbs2y9x2Wy0Pqp7rclaB07xA4tBGhBIk2z
         9xHdjZj1iSPmXmmyDu2hdQQpqt2y/tSqbBfc9VAm7fvyaHzbyPZw2vPnDJiZ+iOsAC9R
         B/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762756; x=1760367556;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdzy6k5xpB9JoJfTT/4U37qT0DEtwQMpcjKLplFFmQg=;
        b=WFc6FLz4OLnJg0YNFjLI1yQgKYyMSV/LEX0sNnwIFfOfkdb6QfqdTJgJuQFdQhMDLG
         jib0sf79VFbnaRyA/LaL2QYoRjZ0LrbCWQsamGz/7StL9htN1iuuCStS/MZjjQZH0oZZ
         Wi7Vnx3ZZ983dpAZ+KuS/hWijX6ybompTk2cpUS+JTQWx9F2bd/rvtYHgTJa9QnvvFIT
         w6HrlHTMKUQHwEZS+VItXoT0alnU6twwdjQTScsadC79G4SJvDRYgxuAqyN3nFvH5ozg
         ZPrHdQLotxRvYS0sq9dqHRRele+VAWnPsBd6Bp2KQbgPS3FgjslhtTTa1GM5Ph9e91yI
         333w==
X-Gm-Message-State: AOJu0Ywaeio3rWP04832fgo8lcw/0GzsWiaqNTcmhNQe0PiZG7h3oFAz
	DS6CHaAnEhHZT1Id2jACPJDdJtq3LSdo78iht3haV+qE4Hc3pJcRGETEsO4VIN2OBTIiFyQHTiP
	2F3EhNWE=
X-Gm-Gg: ASbGnctbcMWseg/Y1miltXKAzdcSZComIAz9hgyaka6rA9pu4Jok4tXgJ7dpI8Kkc+T
	2+SmEH0Gy6vc5Iiro3oudszFTCU45RQW7X/xNrh9SewQoijYKYcndIO7mL0SWiPxqnAFwi1b5Zh
	ERBd/03YTBFldti/A5xb4cRC0Y/iPCtqrIpz9/4jKnDI7f8Pj+POT9NnOAOemE4sbSssMqqEn8Z
	YHqXN+/mtV2LZvlnmWj6X5wwIIEmF2msu6BTMqeGL6mmHvgDAjydulqlh20+QyrzExNKa93jFNg
	DzH1/8upV5nN7QLJbZ3ZCUaFtraKzvtgvCuXx8XBvQQuGz/VlmvnKTBGWpjSF+4mCbKqZH4705b
	QW9j/gpsdDPoN4LV+ZMgPHHwkpAfuFsRqbq5TIy4IXreH
X-Google-Smtp-Source: AGHT+IFrok9wUKMC6cD0r5wbxg8B6Ok3sMF2SysG11bfeww1JXU6GIrHuwGFQ/8kKEf5WevbPwqaPA==
X-Received: by 2002:a05:6602:6c0b:b0:912:5455:f0b0 with SMTP id ca18e2360f4ac-93b96a4c255mr1729888439f.9.1759762755911;
        Mon, 06 Oct 2025 07:59:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81c1easm488052639f.1.2025.10.06.07.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:59:15 -0700 (PDT)
Message-ID: <418310b3-2b77-4534-b2fd-27dcc11e333c@kernel.dk>
Date: Mon, 6 Oct 2025 08:59:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sunvdc: fix -EIO issue due to lack of retries
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

John reports that since commit:

a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN")

users of Linux inside Solaris ldom see occasional -EIO errors because
the request send loop now times out. The current loop does 10 retries,
and inside vio_ldc_send() a further 1000 1usec retries are done as well.
Even with 10.5 msec of busy loop retries that's apparently not enough to
always succeed.

Rather than introduce continued busy looping, requeue the request and
have the delayed queue kicking retry the request after another 10ms.
This obviously isn't ideal, but there's seemingly no way to wait for
this type of event. And if 10ms of busy looping was not enough to make
progress, then presumably this is an edge condition and we just need to
guarantee to make forward progress at some later point in time. That's
more suitably done through letting the CPU tend to other work, rather
than sitting in a tight loop retrying.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/all/20251006100226.4246-2-glaubitz@physik.fu-berlin.de/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Caveat: 100% untested, not even compiled. Sending out on John's behest.

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index db1fe9772a4d..aa49dffb1b53 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -539,6 +539,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct vdc_port *port = hctx->queue->queuedata;
 	struct vio_dring_state *dr;
 	unsigned long flags;
+	int ret;
 
 	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 
@@ -560,7 +561,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_DEV_RESOURCE;
 	}
 
-	if (__send_request(bd->rq) < 0) {
+	ret = __send_request(bd->rq);
+	if (ret == -EAGAIN) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		/* already spun for 10msec, defer 10msec and retry */
+		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
+		return BLK_STS_DEV_RESOURCE;
+	} else if (ret < 0) {
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 		return BLK_STS_IOERR;
 	}

-- 
Jens Axboe

