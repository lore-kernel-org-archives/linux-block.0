Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F33329362
	for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019572; cv=none; b=i6uOsXGXIBHrHaG0FiP8Q4xzT7FG8W/+MH94RcxSEvrkkX9DDnDuco5il4SeT0UjYt+lctv0aSNdzK1Qe/kWHIAUS0yFQxnntYjOx9Wrz2dY+3h8uj6j1+nFr+CvcDKWjfqsdBiVcBHi1lJO9ZudS/U7Cm90ZV7YhZaCVrHpslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019572; c=relaxed/simple;
	bh=eYzsru+bku07yETMcWJRBqXUhjPu0f02de93xwZ0yB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vdhptc+TvAa/cuJhTQa7GBAJp/XllIlcIYXJfaBwgOqKgIYppvyG2N84hx7BOUHAi9QeLYs4OKjk5p8g+qQ0z10rEBxB5Ngv3CiskdzvUIly9DDxaX1P5UenEofC+C+0L6q1OL5CUksB0TlgKeJw04qiKkoSrcDQyKYtT/QdOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xt4YjpGB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xt4YjpGB"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c76f65feb5so6795225a34.0
        for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767019568; x=1767624368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC7TZE7O7U+YRmSai6UHmi34/MmquyrcfkOwjbyIkU4=;
        b=Xt4YjpGB4u6HWWbTPivDqDjAkUT1fMl5VYPAm12efwQLO07AxHxNkNZPI6iDk6KCZd
         5ocnNugkxwoyH93ObRMhtaCm5Yl+Pdq75H69i1etiNHwKdiAf/LDGAW2OKwe500Nmmt/
         fiqQgKmQ8eOQ2XF4sre134AyrZyA32fCs+GAhdicDR4hZkIcA3C8YdcvnCQrOJZu9o2J
         bMb9uNUhSPVwey4uo3/5Mj7+ChvEeyB8i/iiyjrdygbmUY1ngT0gFmXF9kS/lAVUKS4v
         xJAchqr+vpbNIA5oDuU6h5nN5tMlYPx6n0fJh2mizxfGIjarTqFdZ4Ga2Of738sEofAM
         mhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767019568; x=1767624368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FC7TZE7O7U+YRmSai6UHmi34/MmquyrcfkOwjbyIkU4=;
        b=P9ymJDCZe980dKU5PFpmsw1q3yHmOzcEzJEG6msY+/Hs5mNoI0GYIAs37ME05uq8WU
         RjjGZsK48O4F56j5R2vJrEFwenkHtDWLgeGakekvwHaP0WzxTpxzUQTvY23scoaYOMvq
         lXznBExaqiT/+Y2FMMVMuzHfo1OM3LtqmJ7e69550fek9CefkPZb1atgayP4qSb6gYl1
         LVMsiRMloJulgLMsmL7lRYlJuGbvLgrACPDTC9KhB5lS/SFtuncUBt8bLD8WZgTEV1l7
         RSLRjLwza9wp96nFfVsgHQzGOFuiOUASocFLUKt1P7eE3kiSgwdBEN5T8W6KfF9JyZU7
         MI3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMMgAC11dGNyeOqZ/yoax6be90LkV/B1KoxSJGT5HIWlFAcjc/RT8RK3Dky4qtStDvG9q5hk5mTsEVdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCZkA4tXlo2ux9n9FRcSTzSG3xoEoHtr8nHrxgs8bDLCXCqHn
	eYwImD/X8tM77nCJ3qQzp5yA9xplFJZEM8ryQ812vx1Giy77uiSkUAj5402yINWLFmUesd6rp5O
	CTkKP
X-Gm-Gg: AY/fxX76EMTXPuvnKTbg/M4uwV8q2KDvrzQGvV21A5iGKvVeLiTYzkzvivF81z7C2zr
	oSu+qkK+DKRBZJrkfA25PtYDmXNnMB78qlLjIdT1PFCyJ5I6O5S/zpYk8fKQsTiQ5P9swDwDL18
	xpWMRG+IWxHNTTAVa6CePYjOYeS6fSOxsKoRws5Le8gbv95t/1NYRCWg+GNeJgKcFcnEhsfgNfY
	IcmkAwHcy2mwDORyF+8DJFkld/JPh0ra2lbtFc9HD5rzXmNOUIwBv7lAJ/yYcPUGvrzrItfRV2R
	HIUAlsKINmxLZi5HMB2A4vzTCipIiKsTJWTJg302wk3LZxWrIKk/SePKZ197rLXt83QRkdpmbD5
	L6RE3DX2hZHoFwja8w1uQSdAYx4hGCf/dmaRSycQQZN8p0Lwcq63Cvouvmusarqcorch/+y2FjJ
	793FE4XhjREsSwDo/36bI=
X-Google-Smtp-Source: AGHT+IEbC1IKkUJvfsPzUJyg2XlI58zdKn52Djko0ChIFRLc/RZW2DNiDZc964inOeVIJJHiEmEJaQ==
X-Received: by 2002:a05:6830:71a8:b0:7c7:7adb:e0c5 with SMTP id 46e09a7af769-7cc66a289d8mr14228209a34.25.1767019568407;
        Mon, 29 Dec 2025 06:46:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66727e11sm21050013a34.3.2025.12.29.06.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 06:46:07 -0800 (PST)
Message-ID: <fe0e33d0-3787-42a2-ae05-88b50a3659b0@kernel.dk>
Date: Mon, 29 Dec 2025 07:46:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Heap info leak in BSG reply_len handling (bsg-lib.c)
To: Cork <c0rk3d@proton.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0fvb44qiSfIUN9GLgzoLAA6TumtVVQ2P3JAJATl03GPwzRsvnKvTB0v-8uKCM0EFxepn3crpzwH-WhdgzR-gGVfOrqTVLlfemAUmAafeewQ=@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0fvb44qiSfIUN9GLgzoLAA6TumtVVQ2P3JAJATl03GPwzRsvnKvTB0v-8uKCM0EFxepn3crpzwH-WhdgzR-gGVfOrqTVLlfemAUmAafeewQ=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 7:14 AM, Cork wrote:
> Hi,
> 
>   There's an information leak in the BSG transport layer where copy_to_user can read beyond the allocated reply buffer.
> 
>   Issue:
>   - job->reply is allocated as 96 bytes (SCSI_SENSE_BUFFERSIZE) in bsg_init_rq()
>   - Several drivers set job->reply_len to values exceeding 96 bytes:
>     - bfad_bsg.c:3188: job->reply_len = job->reply_payload.payload_len;
>     - bfad_bsg.c:3534: job->reply_len = drv_fcxp->rsp_len;
>   - At bsg-lib.c:116-118, no bounds check exists:
>   int len = min(hdr->max_response_len, job->reply_len);
>   copy_to_user(uptr64(hdr->response), job->reply, len);
> 
>   If a driver sets reply_len > 96 and user provides large max_response_len, kernel heap memory beyond the reply buffer is leaked to userspace.
> 
>   Impact: Information leak (requires CAP_SYS_RAWIO)
> 
>   Suggested fix: Add bounds check before copy_to_user:
>   int len = min_t(unsigned int, hdr->max_response_len,
>                   min(job->reply_len, SCSI_SENSE_BUFFERSIZE));

Just send a fix to the linux-block mailing list, thanks.

-- 
Jens Axboe

