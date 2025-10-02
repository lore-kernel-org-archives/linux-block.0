Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FB13C8E8
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440436; cv=none; b=NgnBnPUHeatnPSh9U5vDY8QsfwoNtjEcvv1+FxLJKgRT4tHWlDq2Fg8DmzORbSeR+Er1/4hPzpdzUQ1OkAjr2silI+xffn3/CexMF23IVbwishNGO1bi4MjHDezKQBRLtNqBquRuF7ZBs1+MHxFdXMWqm+rdXMBegoY6weQLKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440436; c=relaxed/simple;
	bh=KmY2Xi1NF6SDwK564ejY9ttxqcQo9DMaKBxSnm8s1Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inKwUesROMzceBI/qgRtCWX5qunhuwklhowJBXtVP2hDwyuNRO+0vWbJ+BCGwz93pDpRgtxIoJmwAo93uakBrNoabDJdoTUtaXT8EGHAmBh8EFHv02dgJWuomnj/ONKHEMYOEcE5moAAaP6DJCECptRveWNbmspfGT7Yy8zY6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z3yOlx5S; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z3yOlx5S"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-428fabe2175so5649695ab.0
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440429; x=1760045229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+0Omx3Aw6Oe9Sj7rxnSGR619M3i1DKj3Yy9f6zCKUQ=;
        b=z3yOlx5S34ab2E0UNSC7JO/FkuZre/J0c7kyxDGPVx35hMcIdeZqC+JxOs0fLsjTth
         +IHRehInFZJi61kOobfVQbIR8h9924aDAXNbsZribOrJlVBxZHCEdd2TA6uUMmiXOhY7
         5BmZ/tVTxtsFc2Om7QDl2L6G5O2NPshaNDUFxHIw/9mFcT9ndJLGI4+4A6Lw+F9lQXJD
         itUYYpVHEEbTLET7LrTKfbv1SU+4F4BY201B9MCiP9phZ1JTRs/j9bqEbOFWNPDfkCWR
         HKGg1joqNI8Tq69ig7aNlBQ3cDPGxwqdbMztp442zhNhgdMtRocnpH8fTmAGyTlzICG/
         aq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440429; x=1760045229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+0Omx3Aw6Oe9Sj7rxnSGR619M3i1DKj3Yy9f6zCKUQ=;
        b=iRs8MDmdX9PIjEk/zT3NNsDzxdQkIMWgYCr4VZms7x7nYIgMBTfJ980jEQcdxmBFEJ
         hGmT/xXqIUnV7Ghv+Sp1UOtVYreUvP8eifndIF4cdbYzBXfhTwX/7Q1mjFjJXTG4t0Ug
         EfOVfhIngf/uwpJiCaytFpt+TgiN6nQa3qVCB6kSeknM7occOLPgfaJTSdbFHF2aUyzC
         kqnHimfn/BgHotEIRZyc3I6uxjD2g777L6nj39ao5kTEodk/va9/JC5xONqTFoCXFznj
         thqkf41bd61IDKJGJSJQsnSe/UFO1XIN34eOM9GpTX3xvUbHBE9cTr+ZIehwf1sScdC5
         NYRQ==
X-Gm-Message-State: AOJu0Yzf9K48i8oMvXL54Tdcc7YkY32r8LLzH8+297ryuz4qoKFZIoox
	7VOkRwlX1JkyR9g+6EHhVTEzu3lbUqdzI3/jFejtRG2BExcLku1yL6a+ClvCy5Kl02o=
X-Gm-Gg: ASbGncufGFRw+YNBe8I+OrMI44iUSMTMbq7lRLZV5Lez4asCsSXZQ8xcyHrdBFUV1Tg
	uDFXnZ3ox1u+qOR0bIKdYHyNPORTstzo/KxOAZLRc5fv06Z4bwpQjmCmxXlfPOucL2O52lCS7gf
	SkkTCMQ790nJpS8hK75Ygn8s/mRJrmaGtnRUWY8YRrwufFvxdnB2TIgxoNr6jIxGKAM2ApCzgqM
	oDmCgFbBLkfGRSrjmEwuUTwHMalg8qrIq5D6HsZnsolJ0m93VnrE9yCdZb9igGGzgmyT3HV2MxZ
	l1nFNMGVnK7cKkyyve1lfW50gm2LYHUWwDkcAB8HF1LlZ/d5UkZDb1jMEZij0uODoHmNqbNF/5e
	nLI9WV07Oz5T82x7zG7JFHVfArHSNO7tdsSTsb6KHHs6Z
X-Google-Smtp-Source: AGHT+IGhqd6Z53c32AZqu1NEKDE2nlxWfrpFbaZI+/ZfB1uxj7scJTwTPcWlWpTCix7Xy2FOBx6deQ==
X-Received: by 2002:a05:6e02:3a04:b0:42d:84ec:b5da with SMTP id e9e14a558f8ab-42e7ad16f9cmr10307325ab.10.1759440429017;
        Thu, 02 Oct 2025 14:27:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea31448sm1215916173.29.2025.10.02.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:27:08 -0700 (PDT)
Message-ID: <ad0f4a85-d7cc-4f47-b469-6903168c062a@kernel.dk>
Date: Thu, 2 Oct 2025 15:27:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block/mq-deadline: adjust the timeout period of
 the per_prio->dispatch
To: chengkaitao <pilgrimtao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>, Damien Le Moal <dlemoal@kernel.org>
References: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 8:38 PM, chengkaitao wrote:
> From: chengkaitao <chengkaitao@kylinos.cn>
> 
> Reference function started_after()
> Before modification:
> 	Timeout for dispatch{read}: 9.5s
> 	started_after - 0.5s < latest_start - 10s
> 	9.5s < latest_start - started_after
> 
> 	Timeout for dispatch{write}: 5s
> 	started_after - 5s < latest_start - 10s
> 	5s < latest_start - started_after
> 
> At this point, write requests have higher priority than read requests.
> 
> After modification:
> 	Timeout for dispatch{read/write}: 5s
> 	prio_aging_expire / 2 < latest_start - started_after
> 
> Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
> ---
>  block/mq-deadline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b9b7cdf1d3c9..f311168f8dfe 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
> +				- dd->prio_aging_expire / 2;
>  	} else {
>  		deadline_add_rq_rb(per_prio, rq);
>  

Adding Damien as he's worked on mq-deadline the most recently.

-- 
Jens Axboe

