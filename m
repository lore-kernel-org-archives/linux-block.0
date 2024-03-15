Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361C46425
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520073; cv=none; b=Gbs5No9wlfQW56f7lUMX/9UqYZ1o3vjoiI/AbvkuGSqrWwBS6pxH85Gl8oXRDKiXgxSFAuwKqv1N69n0okFNHdI9PNzfysTwna/j40nyA+m49+0C9j7hO3HsrHSdU4QqLFIUowWDLtanNjOFP832qo8yZEqCKdybOSVw5FQ8D8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520073; c=relaxed/simple;
	bh=Owm9W12k4cwRmZGRsXGbKwAh2e36L+48VeOS2yWxlvA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=heicShGkkXI1l7AkDjLuOFmweOP8UvRcIffDMCDQTJ0fPhhes2aeDk5X2dGXLp4rOod0q3J27NzKULc9QRQQanTG68awqOrxhPEL8AjRYARitzTn8yighPaJGqBSo7yUPp8VIaHoSybK20d5Ky1xj9aZ8oq9oqZD7ibTgKiQ1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ub/hJ3xU; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ub/hJ3xU"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3663903844bso3532415ab.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710520071; x=1711124871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxPl+IfPmAIFN4ebGEDXEol6JdOpXG5Ei+5Zkl2n5WM=;
        b=Ub/hJ3xUkF+ldobleM6YyY+Ni9fmv9E1CxJ4IPFASHA6swHanp8Kk1mek+75OViF90
         dvKxxNLTzs+Re0xNcrNjtsrs4fKAIeN/pUYWo28z3i+Kcj4CVoue4QfDa+djTWZJ2tKn
         0d3zWYmMf5ml8OoWboME7PttchWkuX9/wtEauCJWYyNkR5ccTj7SpHEkE4j7qBTJ7kFh
         uhcSXu7jhAp38+KVN37Ji/JZ2KMnlbMbKliZAnmnyqRtz7ezxdhCzImDvpHajkpCH+BB
         o3AVRGpd6XvfJE4o6kkJMgfBA7Kdk2XeIV02c1ifXVbeHE3idspUPLyIvSC2/c6O7IkP
         vnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520071; x=1711124871;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxPl+IfPmAIFN4ebGEDXEol6JdOpXG5Ei+5Zkl2n5WM=;
        b=oPGiQprQbqLPdk4YcJO/HAzKfmWykPadoJTH+QROVC+94WAjWywkpiGUJ5EN19pCok
         t/rzplfWnaZTAOQ36abiflU27s86yCMQD2uDjckAH1ss4pi0MYd5l6NXHpemyxQVtGCk
         zDH6a1SZYvy/6uxexSbQfmUooSJWpm6yPBm1pPxI+PLAjbYHu+RWqQtxSlcgFA0Hv+lV
         5qxmvsHbKGIl4ys4UntlEiFRmYgL22b7WYSo+wWVt8PABbgvf27PHcYmDCz8Dol0n6YK
         OZgooJdrSEB6c0sa69GixiL9JUC49bxYy9JtJfQMT3mlbsm0/DPqMUwyqtNCKVbOIRtL
         mUMw==
X-Gm-Message-State: AOJu0Yx6woG2YdKLeA0MBXHQ5fejkwbGq2MjRRw6FCPkSmWK0ojVLAey
	qlnHrEO11mbuDHoxyvsn00BOSjqP4xNCMD+W+95Ce9FyzJPTeE21bA6eUdQtdIg=
X-Google-Smtp-Source: AGHT+IF8xWEgjz4aEgsmi6V88eLgJoCTfJSDZaQ30pMgkIbaxDvfIYVaJFyK2T46SzElSkBCkgY9zw==
X-Received: by 2002:a6b:f801:0:b0:7cb:f105:57a5 with SMTP id o1-20020a6bf801000000b007cbf10557a5mr2508973ioh.1.1710520071049;
        Fri, 15 Mar 2024 09:27:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc12-20020a056638670c00b004775d1fd781sm269586jab.145.2024.03.15.09.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:27:50 -0700 (PDT)
Message-ID: <dfdfcafe-199f-4652-9e79-7fb0e7b2ab4f@kernel.dk>
Date: Fri, 15 Mar 2024 10:27:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] io_uring: get rid of intermediate aux cqe caches
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <0eb3f55722540a11b036d3c90771220eb082d65e.1710514702.git.asml.silence@gmail.com>
 <6e5d55a8-1860-468f-97f4-0bd355be369a@kernel.dk>
 <7a6b4d7f-8bbd-4259-b1f1-e026b5183350@gmail.com>
 <70e18e4c-6722-475d-818b-dc739d67f7e7@kernel.dk>
In-Reply-To: <70e18e4c-6722-475d-818b-dc739d67f7e7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 10:25 AM, Jens Axboe wrote:
> On 3/15/24 10:23 AM, Pavel Begunkov wrote:
>> On 3/15/24 16:20, Jens Axboe wrote:
>>> On 3/15/24 9:30 AM, Pavel Begunkov wrote:
>>>> io_post_aux_cqe(), which is used for multishot requests, delays
>>>> completions by putting CQEs into a temporary array for the purpose
>>>> completion lock/flush batching.
>>>>
>>>> DEFER_TASKRUN doesn't need any locking, so for it we can put completions
>>>> directly into the CQ and defer post completion handling with a flag.
>>>> That leaves !DEFER_TASKRUN, which is not that interesting / hot for
>>>> multishot requests, so have conditional locking with deferred flush
>>>> for them.
>>>
>>> This breaks the read-mshot test case, looking into what is going on
>>> there.
>>
>> I forgot to mention, yes it does, the test makes odd assumptions about
>> overflows, IIRC it expects that the kernel allows one and only one aux
>> CQE to be overflown. Let me double check
> 
> Yeah this is very possible, the overflow checking could be broken in
> there. I'll poke at it and report back.

It does, this should fix it:


diff --git a/test/read-mshot.c b/test/read-mshot.c
index 8fcb79857bf0..501ca69a98dc 100644
--- a/test/read-mshot.c
+++ b/test/read-mshot.c
@@ -236,7 +236,7 @@ static int test(int first_good, int async, int overflow)
 		}
 		if (!(cqe->flags & IORING_CQE_F_MORE)) {
 			/* we expect this on overflow */
-			if (overflow && (i - 1 == NR_OVERFLOW))
+			if (overflow && i >= NR_OVERFLOW)
 				break;
 			fprintf(stderr, "no more cqes\n");
 			return 1;

-- 
Jens Axboe

