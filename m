Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EAEA3
	for <linux-block@vger.kernel.org>; Sat, 20 Jan 2024 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709594; cv=none; b=P6rsIXzSivQhSbaTcCVqr5/J9gqpxvHOBmYVsfWiH7XuHEuVlGzhMbXgho0AzV1yYbZuArtgs+zMn8pIxwb/Rt0nz4pVdz5TrYm8l2EFnfH7M1HPMIzCerMC2gfoy7bYaK3G0GxMLns8SrM6HlWyKASjM+m2v8RGCGRO6zuZpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709594; c=relaxed/simple;
	bh=Om5pA1oAx6jwdfWxyZlOPs6Qt2CDYz5up/btxrLpciM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mgsW5o+UNfWva3mrx9qERk6ZtcHZjJguiKqCIj3hq5CVFXIWccVVYI4nCQbwLwa8Orz8+bwRmfrr/kqyfdfLqKGSphivUPPcudk0h5dx39RGqCuYMCp24HjVwbuflCb3BzLN70+1w5dLzWctM8gCbIkDSJGF6MeDYV3e7+MhUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UIVTUwCJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UIVTUwCJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so249376a12.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705709591; x=1706314391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgySmpOsqmxiCev4K3vAEeL4RRNgneTlfNKaog8g/a4=;
        b=UIVTUwCJTXprVM3fPdY75FSj8bYJUDG8oResEFF9RaIcAeaObTY+rrINA7JpzpbdFP
         SmQEL5XeuCCQgJm74/nTbSoeOSsyb0JmmObc1upB2XHitjypcZpCzAeR8gN+3Zpd+YU8
         CLmwUmw9wufpzsjruPZi7bZuk1HGSS9/0t7qMgoZj/NgPFC/Qvodk0toNdZ1RQkvwkOr
         Y19jt+fTdKW5dywop39I71UhW+hno2OnVVpDOc2qXAp63Vw8a3iGTgGyWmBG4sxDeaaD
         EbX2pAcA5g2/t8+6r7Djog8UUN/pKf8/HzD/L2feglkL6hPcMhH9XMASVdIKmx9DCnGo
         w9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705709591; x=1706314391;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgySmpOsqmxiCev4K3vAEeL4RRNgneTlfNKaog8g/a4=;
        b=fWBcU2NYCB4sXx11SBgJvqMDPWFSqQXK7URj5uoWAnypMwLZ3iTK6EgyCpnMuI0/c9
         ENNnDhLhn9g6/ty9kHUaqZPvP9sp+k3C9xd06KbH+ST0Yj4erfEQx+oVcxl992idXoyV
         /BFTNqXPBISy8EO5kpzt68SJerdPpsz4dp1fVm1ANjnvFanb3R4pS7iIIbLpy6hO4J4k
         cL4JQo2dB0/YDU2VfBAB761A3dXYd/rM6z3LIWGf0cJdC1E7zGWvNcXem+VAcrrDfbeJ
         hI6bJakERVUIxjhvmlhHqIn7Gf2cSEvX4x4ILfR6PoJx/kIaiD3pLrCqM3BZthmAeAzB
         FmnQ==
X-Gm-Message-State: AOJu0YyuE2FowQXJYPK1W5i0y00bVozLhDXGR1B71qop39cDXcDOWmYR
	ImujI9IgxzJUU93xvoqAdxTZD8PHTK6UoUE39enbqwZXn4okIcEDfazy06OFzu79ktkH+/rcegb
	aJsk=
X-Google-Smtp-Source: AGHT+IGm/3Gnpmrk3CIrU2YZVLPU4hZOLw/5zG0XxJ4g5ya+7q/r8w4jzz8dZtwEg1esonssfCsSIA==
X-Received: by 2002:a17:902:c386:b0:1d3:f790:e0c6 with SMTP id g6-20020a170902c38600b001d3f790e0c6mr1354155plg.2.1705709591464;
        Fri, 19 Jan 2024 16:13:11 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id kk12-20020a170903070c00b001d717e6001csm2199114plb.144.2024.01.19.16.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:13:10 -0800 (PST)
Message-ID: <4d8ae6d7-7b9b-4f96-9bbe-5fc5d7a2060a@kernel.dk>
Date: Fri, 19 Jan 2024 17:13:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-4-axboe@kernel.dk>
 <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
 <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
In-Reply-To: <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 5:05 PM, Jens Axboe wrote:
> On 1/19/24 4:16 PM, Bart Van Assche wrote:
>> On 1/19/24 08:02, Jens Axboe wrote:
>>> If we attempt to insert a list of requests, but someone else is already
>>> running an insertion, then fallback to queueing that list internally and
>>> let the existing inserter finish the operation. The current inserter
>>> will either see and flush this list, of if it ends before we're done
>>> doing our bucket insert, then we'll flush it and insert ourselves.
>>>
>>> This reduces contention on the dd->lock, which protects any request
>>> insertion or dispatch, by having a backup point to insert into which
>>> will either be flushed immediately or by an existing inserter. As the
>>> alternative is to just keep spinning on the dd->lock, it's very easy
>>> to get into a situation where multiple processes are trying to do IO
>>> and all sit and spin on this lock.
>>
>> With this alternative patch I achieve 20% higher IOPS than with patch
>> 3/4 of this series for 1..4 CPU cores (null_blk + fio in an x86 VM):
> 
> Performance aside, I think this is a much better approach rather than
> mine. Haven't tested yet, but I think this instead of my patch 3 and the
> other patches and this should further drastically cut down on the
> overhead. Can you send a "proper" patch and I'll just replace the one
> that I have?

I'd probably just fold in this incremental, as I think it cleans it up.

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 88991a791c56..977c512465ca 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -599,10 +599,21 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	return NULL;
 }
 
+static void __dd_do_insert(struct request_queue *q, blk_insert_t flags,
+			   struct list_head *list, struct list_head *free)
+{
+	while (!list_empty(list)) {
+		struct request *rq;
+
+		rq = list_first_entry(list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		dd_insert_request(q, rq, flags, free);
+	}
+}
+
 static void dd_do_insert(struct request_queue *q, struct list_head *free)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	struct request *rq;
 	LIST_HEAD(at_head);
 	LIST_HEAD(at_tail);
 
@@ -611,16 +622,8 @@ static void dd_do_insert(struct request_queue *q, struct list_head *free)
 	list_splice_init(&dd->at_tail, &at_tail);
 	spin_unlock(&dd->insert_lock);
 
-	while (!list_empty(&at_head)) {
-		rq = list_first_entry(&at_head, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(q, rq, BLK_MQ_INSERT_AT_HEAD, free);
-	}
-	while (!list_empty(&at_tail)) {
-		rq = list_first_entry(&at_tail, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		dd_insert_request(q, rq, 0, free);
-	}
+	__dd_do_insert(q, BLK_MQ_INSERT_AT_HEAD, &at_head, free);
+	__dd_do_insert(q, 0, &at_tail, free);
 }
 
 /*

-- 
Jens Axboe

