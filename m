Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B901425CCC
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306578; cv=none; b=Dqnqiy9f7LtvWmVxUxe0mtfT+U8NNAlae/QMAKZlhHXQlH5AbW9mN9C0cOSfDJWgNrgD9WoOzt+L+ajhMoLkGmi3TuR0hcCBUjnFfOtNP46wbPRTUOb66ygM5kSVJfLPU865PTlYHbVJJNFuERftrJg1T0brI8dDMqnPj8Wb0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306578; c=relaxed/simple;
	bh=ZwyHw6bkNsfFcskhksV6+jRbhaGw//ajazxUPgML7WM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ewx0kvEozOQXGe6pv+NyESxcOwvhID8u9PoCW4TVGbV178YD1C3s1vv4KKUGkoBgr5DQZkBYZIf9/t0GpOJ+tT8Wl1Hjy+/TX7sr3gxbYpgbVTTMExUMm9vsbDXkBKliP1f2VEKr8Z815aHtcsMl+121FvF5+kISOap++GLwPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ml6yBnwq; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ml6yBnwq"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-66314fa03c9so652930eaf.2
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306577; x=1770911377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qnl17Hshf4NxOoeZ53fLK3zTuUbmcFiz8jbD8yT0iE=;
        b=Ml6yBnwqW9+r+dXE/rmGI0ItmzFmgK44UwyHRqubUMj9zdN30FoG7HfphzzTZKQ+MN
         mx7+b7+D4FE3pmrR7ipe4SA4PIiaIu74RAyJEr4IEcpQNrExnKxRTD+sgRRtwllibcmr
         b1kfkd98CYCp1dSHaDpcQah55ZZoGMisAFdafscW3mvUwrQwne14/Hetj0FKWKERJ415
         GpXuXnI1PDgCEDFS7VARNsoH0RIIHrr83Ulfd6pP3Y4X4Elx1ZbAy/Tvd3m2NQj2L2Q3
         AYo1f+mczojFraMzl3aCSNhBKcPS662PVTSU3IrflBYoaEY1Ncq6uXa8mZcQuIE0Iix7
         0sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306577; x=1770911377;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qnl17Hshf4NxOoeZ53fLK3zTuUbmcFiz8jbD8yT0iE=;
        b=RR38BVO8irVS6nel/K1ez4MhG9ah69zSaAuO5XwP7zj8C5PIZl1BTpiqlsNKjDF50S
         Z//mWGt/S9pl9OZzU5krujmJ3IJuV+bnzBQNSQ7YyKw5/UpBfsb+YvZJaGC50b7PNBvV
         ANSWpawlxNHyDOrv36YV/xPPf4wP1MGyVNGrfFgg304aIoqPeMIl2AXH6uGA+NHMTrqt
         m4/85X9FX8Cs4p2ISqC5ne6fI6ZUHsymWMt6zbm+J+qhElRdOmI15UT6dOOlLzdK1rjs
         GFmBUW86lvM5VfW1YjajsRCaSiGMcvuSfRLBSD5Az/ZS5daLyOY3fEdRO1I7ejF2YhCh
         xsAw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/GjhA1aZRYfWCoYXmkC9b5ftygE/GTlyi3YuFc+6q+Knbvr2zdyUZXt9NyU2GppMBadwnlMiTuf+fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzyHAoeEWoMq92peLs0aENWOoGssSeTGRtMbaKk4OLu8sAwSC
	GgktPwntKieg/awFUwKxLsya6efYo18vEzVBVz5+u4gI4+K4STMSh5Swn1pqeVK5cUTMe8oCYg9
	OCCACA3A=
X-Gm-Gg: AZuq6aKZS0tf2rbTbNGy99UuD+clDaGFGieyRKb1RY0UpMrfClZn9dvwJ4WwmKlr6ai
	x/qVV+TIhVqw4lUdjIc2KrR53n2g6IJQvvjjQRStjIgXNJTpmUhd5tcbCUJ8pWJvbjZ11iMUArc
	NmErcC0CPpyXqKY/CMluLs8w/d/6MdqFxEQmW9aQeudLw5K1jLH3BZsBhatCEuITCQLaZqZbQKm
	/nSkNVlxljEND+mMdFqiMmjgnyYbdWqBjtIflVum6wX5rZLHTB2iCMRokpvdDKtt4g7AMO4oBPk
	+du4Q4S7Zo6FRMaUW3kXxZOMmCnk9ty5AGfyW69DpP2jLvXeMciyBHwNZvBYnkasI7N6g8ZitnI
	oAM+4/X8/9MGdlhqE0GddNlATcgffLX2U5Xcq0efAxLzCN91wmxIa12/kJAq6DNGEe5sU6XlNNl
	db0KpQPGpnwfcvB1cRkH4airW4SlOY5RIbZkyNeeizcTIhXlv657PK43ZtE6Et3KXgQFHvIw==
X-Received: by 2002:a4a:e844:0:b0:662:c6ea:ceb3 with SMTP id 006d021491bc7-66a20882561mr2731806eaf.33.1770306576893;
        Thu, 05 Feb 2026 07:49:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a54426935sm3979005fac.12.2026.02.05.07.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:49:36 -0800 (PST)
Message-ID: <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
Date: Thu, 5 Feb 2026 08:49:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Content-Language: en-US
In-Reply-To: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 8:47 AM, Jens Axboe wrote:
> On 2/5/26 8:38 AM, Keith Busch wrote:
>> Hi Jens,
>>
>> Some late fixes for nvme that should go in this release. One for a pci
>> regression that causes a kernel panic during certain dma conditions. The
>> other fixes a vulnerability in the tcp target.
>>
>> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
>>
>>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
>>
>> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
>>
>>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
>>
>> ----------------------------------------------------------------
>> nvme fixes for Linux 6.19
>>
>>  - Fix NULL pointer access setting up dma mappings (Keith)
>>  - Fix invalid memory access from malformed TCP PDU (YunJe)
>>
>> ----------------------------------------------------------------
>> Keith Busch (1):
>>       nvme-pci: handle changing device dma map requirements
> 
> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> will trigger a compiler warning...

Actually this is only true in the 7.0 based branches. Should be fine
for 6.19, I'll add a commit for the 7.0 merge.

-- 
Jens Axboe

