Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE738D3E4
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810853; cv=none; b=J7nUCVf6j+qzibwX3oWdypquqQTeR9AHVfT22cILsnQeFH7SSM4AkzXMY4d1RPsTfQqwXOrT27va4JPwfLnkTvXyTrB8oXXlJ/B+27zGGeyOPoOSHos+sWy/RKtZ4XVRk9GvkJGO2SmoJjF22y8FurZR022RTv9t96R0CHG4eVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810853; c=relaxed/simple;
	bh=UwvhFRGfIjAPST39fDZ3QztI5XPHQtdJDtntLCLDrkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEFtlQ0cVMxVeCxbYEqmvEt/wFFDn6kZFAKKQgVExzCWwXHIHE8aizBP5fwqAtTT6NaBHfqUXWoAWTATUIZ8JYxznSzmdWEAxOpBzXoasAW1Q94zo3i6EjC/CFfYE8psTSzeRKgGiXhynQpFUiCbaaYtSU5hbBuHZjwWYkH6XlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=O80pavbn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="O80pavbn"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e603d0ee0aso2663804a34.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779810849; x=1780415649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZhEC9CknXyzU2320wcMqP/xC9qIrHuDUyaoAaM9rq4=;
        b=O80pavbnUPBhRrpJYadrsY7B/ZWix1tbTItSJKNsYPeBptP3BMzAxBA82f2v1cQc0Q
         EXxKUPRfrabOIuGgWcRU9UdMNdvuXgE+gUnbbo132y1FJzjsPyZtrdqykjkrSPxD73Pf
         nvJCnOv7MaEaok3nmEbj5aa8QfP8mylRc/TlJ7USRHb5S/oAzjhaMixVYp0Qq0/F6t36
         +MuFTBs2ORFSN92xNDsnMxb7KhTNMs7/njkzpumISkq80xFl6tBY+w6430fJswPt7nf2
         v53n5lKRlFw05JviPXrE0v6lUjkbeq3v3sLcl1WIAbbZhXkW1PjBkjfEVQPRkUQn08jf
         nvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779810849; x=1780415649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZhEC9CknXyzU2320wcMqP/xC9qIrHuDUyaoAaM9rq4=;
        b=HSh2wIoG2eKKOIYNztqgfKgmlEQQMoHbDarI2Tsa7NOXnrM8VJ/2Jhx4Glx7X7eqyy
         6qUAUu+KNr0m6hwxgo2Oq6zjrF1jX5K7TdJi7dkjVG1trVmYmeYEGL/4SgKt4586FzHM
         TSfc6DqVyYQw7A0VUYvt2ZCBoknoaS6SSUfDmTtVS5gbPnI6wa2q4MyUloDlSQ93Xs8A
         mbUMXof2Vaxd84b1RGfDY5w4Pj5MvFTtQRpDf2k1vwY/AJp5gj+nVOuOGrNY+Yt7Nn/M
         jtg8NgcyMRX91SQ44m0ZhPSQiTjZhKnxKqyunZazDq5BOSewCgEQiPeZJtGXzKj4to1d
         zsMw==
X-Gm-Message-State: AOJu0YylFaH0jf1F/LFIsjeGRxVmUBqXzOOc7fkW2CDBO34tSzN01ZvA
	lMxxFmrTPZB6DQPDvOxOKkmdS2ybV724iPykPLJNwWDu6Gd2lSvN04VYfIT4Bd7M0JhCKkwF3ye
	g5qgC
X-Gm-Gg: Acq92OFq/dmzo4c0sPEQBeqQSmdjQMXYn3vU7Ko4FQiF+tdg13Qv4WPUMg/jkvIIv9d
	lmlkFS8bDWTkRxGphTtXKUcos18gpouf8z3hNJTRPgxTc3oZvDwQ4uj1EEIZFG3h2qkTUt0lTJN
	cGmwTT0h52cf+NTYbZgERYh8S7lkIZkt9DT5T0QuxsDLJYLTXieDYIEaI6WhVwvZy3Mv/YUT+6u
	gFIYCs0EoWoP1YcVzxZyQ2Xa8PbJsHR3DY6Gprb0RyHu8j/Lhws0jtgM8krDAj7gpWg890l6JhO
	1LmdRXw3n5mDuUcGOOWggjGt2VFYMFXP5pgzYtPLiag9VW/jI0UFWdkGSH1WLMOLcDLbkJSfftz
	IeGqLyz5ln7K715pdLKkl60sy+/Kob/jSDCq8Eal9V4ooouUOhZfcGbNpE0AiACGRTb3KCMXNXs
	PjVwV0wCVIUK17ng1dxoPLyIJYmHyc+ypqe9Rlnl8oN++BtHpcn/iDBHKLHwvuCBT7jLhkiHtz6
	qmgZfBzarxNuHdVW7U=
X-Received: by 2002:a05:6830:2404:b0:7e3:9d19:1e47 with SMTP id 46e09a7af769-7e5fef3460dmr11665134a34.25.1779810849588;
        Tue, 26 May 2026 08:54:09 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm9560816a34.0.2026.05.26.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:54:08 -0700 (PDT)
Message-ID: <458c5c9c-8740-4079-8800-f30e074fafef@kernel.dk>
Date: Tue, 26 May 2026 09:54:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rename need_dispatch to cautious_dispatch in
 blk-mq sched
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260526131103.3105411-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260526131103.3105411-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 7:11 AM, Guixin Liu wrote:
> The local boolean in __blk_mq_sched_dispatch_requests() decides whether
> to fall back to the per-ctx round-robin path (blk_mq_do_dispatch_ctx())
> instead of the batch flush path (blk_mq_flush_busy_ctxs()).  The whole
> function is about dispatching anyway, so the name "need_dispatch" is
> not particularly informative and can mislead readers into thinking that
> a false value means "skip dispatching".
> 
> Rename it to "cautious_dispatch" to match the comment right above the
> check ("dequeue request one by one from sw queue if queue is busy")
> and to convey the actual intent: take the cautious, fair, one-at-a-time
> path either when we just drained hctx->dispatch (so the device has
> recently pushed back) or when the dispatch_busy EWMA still indicates
> congestion.  The fast batch path is only taken when neither signal
> suggests recent backpressure.

If we're going to do churn like that, it should at least be an
improvement. 'cautious_dispatch' tells the reader nothing about
what kind of behavior this modifies. 'piecemeal_dispatch' would
be much better, as it actually accurately describes what it
does.

-- 
Jens Axboe

