Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4F18872A
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756786; cv=none; b=n2KklzwHcRQt5G9YvTCODHP0C5iOc4JbirBP+zpV6i4aGnn69S0Go0hOsVgx1tbAX6AsuyhOinePS6RZYwgpI2tgCUGwTfVglshOsVVDVr50Tg7e8sSafyYxNmZda7QTuP/q7io9tx7JvTv28viEX1bP3VJKrPjhaPrDuE+YUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756786; c=relaxed/simple;
	bh=MZ18A4gLjl2ofNFo8pVu+q9KoC0G2BHWLpsbcUhn5RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlA4/eXJDR0XuqSLKh9y6BeVo1Zzwk7a8lC6EH8oY47iTbVHqNLvM0wtHZ8dcYVd9mCHvVKJw31PbF8lqQ8VeQDyEDPLiM6bfK/+qk665Wv8PvMZy7ApAXqCSELIybWeZvO7EXlMiZcCF9o+mWBGOgED+1v1XWX+rTxfwa+0w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i7dn/dme; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i7dn/dme"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42e5d1025dcso15769865ab.2
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759756783; x=1760361583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yjlfu6wP14JG2qLbK/JxxY/6QM3hGKhTMIqs+UYsEc=;
        b=i7dn/dmeT+rbWjgi+kowpqT3H6eZYZRPRznyuwDZ9NNrIWQky0W3N8mRMiaBR3Xmd8
         39Gc7GeV1CTUQ70gZabBdDaDymvkPzKPR+ACH4DyHJmzGwLs84sOz2UjtJXcuNvICRFo
         sj5K7MySvId4hvx2qGHUufRgdqCZR0fqIA+gKlyEKbtMcbPx9KdvvTauul/UeLClRW9D
         ZeIjHTx867rg1MXji+jVZx9VeGZz9J85TpvXKti1iU2kM1Q0Lp9pGfjVoYzZzCr7wKhr
         /+UmWgHHOMs09XMIqbW5NZs6BweQywcsUyhuiJPWzrh5FQEBOdMbJpJblInYW0eHBMr9
         +yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756783; x=1760361583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yjlfu6wP14JG2qLbK/JxxY/6QM3hGKhTMIqs+UYsEc=;
        b=IcCe4fxIkt5yo5LKy3G1KfOMfWdNVX1ptFtne85n2Cj2OeYwEX59Bpjh9vIXhgOnAe
         UQ9mQbkmeRO7ErDDnGS1XN4XJV/8yFosK0Tw2dzyjAFKGdjlFvIJBoRqKtK+TXirHhsR
         o5PAQfZoZvsocC1Kwn5H8v8wRymGFrqpHWBacg05jXstFaqCe58kb9Mot6h0g8gj0M7L
         tTqajRSl4j/ZWhl8cTHXZYN5qty7wBVg4KZ56jzi9wQwQ4zEIB0vV3Zyhy+JhvuqEsYA
         fJ0rRXW4ehXg3oWKp+faIVEWOTYN/le82CDDNCtGjTlFV/eZOutNn/SIg7zDKiKScp2U
         IEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9IIoswxRdYrHhTEPsltrpceCaSLcIL6d+7sWrpFO74E+qWJSJZYwfOC9//nKV2sOc9TT+/DfZBaytzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz244RAgqnXxxLeIXEmAVw862PUoOof6wyfhMxm0FtFINbPzPS
	Z8H/gwsClWuOeeEfCSSOCchsdYBMr0iXedymYvPDHZ3edq8GSGQQ+X4f14cpRXvbDgA=
X-Gm-Gg: ASbGncvAxcK+h0yb6FWbIMTB8/QqhCRPYyvwM6DW6QLauzkN1bLrxUUdJl9W/OE70c/
	DcfREGOmDa4Jhut997IUqh24+OuTKVdr99yI0f7kCcyqL5Y1NKKMlSZ+rEVpxg2qiYNYmM+D91l
	GTnl8tmiCSPVhz7SQe7Seinpf8FSnKstzjqzpwZZ9X0q3zKrmZ41uZlNGEg1lrdO0C4wVYphDgd
	opD/bvKeqoreWBiNe4q/yF3lz0HpXMGKh2YaDHwxewBS2Bd+FN0e+pB+4c92HMgUq9GmE6xukIh
	NzJk9fX0kIgRSfVsHouIMSGw64LZsO0wuG9RaAB73LL4aEBFaiSxaUSyTfZDt8PRu4133QeV5O1
	Aw2hxRKI6V6/pF5JBDKR5ze7fNTX/RVV6N7IKJMx4gwb0
X-Google-Smtp-Source: AGHT+IHKeVryFAtYSIbEs3E1K0UFPxxx3iI1l+x8ykYI9cmgWxrUy0Vw2vbSc5wuuCkxsB1Ih5am5g==
X-Received: by 2002:a05:6e02:1c0c:b0:427:70e7:ea09 with SMTP id e9e14a558f8ab-42e7ad400aemr178502065ab.14.1759756782742;
        Mon, 06 Oct 2025 06:19:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42e7bd2f139sm41896385ab.8.2025.10.06.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:19:41 -0700 (PDT)
Message-ID: <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
Date: Mon, 6 Oct 2025 07:19:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>,
 "David S . Miller" <davem@davemloft.net>,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 sparclinux@vger.kernel.org
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 7:00 AM, John Paul Adrian Glaubitz wrote:
> Hi Jens,
> 
> On Mon, 2025-10-06 at 06:48 -0600, Jens Axboe wrote:
>> When you apply this patch and things work, how many times does it
>> generally spin where it would've failed before? It's a bit unnerving to
>> have a never ending spin loop for this, with udelay spinning in between
>> as well. Looking at vio_ldc_send() as well, that spins for potentially
>> 1000 loops of 1usec each, which would be 1ms. With the current limit of
>> 10 retries, the driver would end up doing udelays of:
>>
>> 1
>> 2
>> 4
>> 8
>> 16
>> 32
>> 64
>> 128
>> 128
>> 128
>>
>> which is 511 usec on top, for 10.5ms in total spinning time before
>> giving up. That is kind of mind boggling, that's an eternity.
> 
> The problem is that giving up can lead to filesystem corruption which
> is problem that was never observed before the change from what I know.

Yes, I get that.

> We have deployed a kernel with the change reverted on several LDOMs that
> are seeing heavy use such as cfarm202.cfarm.net and we have seen any system
> lock ups or similar.

I believe you. I'm just wondering how long you generally need to spin,
as per the question above: how many times does it generally spin where
it would've failed before?

>> Not that it's _really_ that important as this is a pretty niche driver,
>> but still pretty ugly... Does it work reliably with a limit of 100
>> spins? If things get truly stuck, spinning forever in that loop is not
>> going to help. In any case, your patch should have
> 
> Isn't it possible that the call to vio_ldc_send() will eventually succeed
> which is why there is no need to abort in __vdc_tx_trigger()?

Of course. Is it also possible that some conditions will lead it to
never succeed?

The nicer approach would be to have sunvdc punt retries back up to the
block stack, which would at least avoid a busy spin for the condition.
Rather than return BLK_STS_IOERR which terminates the request and
bubbles back the -EIO as per your log. IOW, if we've already spent
10.5ms in that busy loop as per the above rough calculation, perhaps
we'd be better off restarting the queue and hence this operation after a
small sleeping delay instead. That would seem a lot saner than hammering
on it.

> And unlike the change in adddc32d6fde ("sunvnet: Do not spin in an infinite
> loop when vio_ldc_send() returns EAGAIN"), we can't just drop data as this
> driver concerns a block device while the other driver concerns a network
> device. Dropping network packages is expected, dropping bytes from a block
> device driver is not.

Right, but we can sanely retry it rather than sit in a tight loop.
Something like the entirely untested below diff.

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
