Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3740B6DE
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898011; cv=none; b=SYrjWJpT4WntCw0iHCcrx0QOjsEzGnY+b4r4vVK1Fr8+Swc69stbmK62BQg/rOYaolhhqRZCypwM0jC0gAl6u3ZXe0y9apnX23mgQelVPHEuaT3vreSMnVEm2P9D9pmuTSdJsiKH7Joggy276TjdQUyG7AGrROBb4lmz3X/173M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898011; c=relaxed/simple;
	bh=fwkxSqx7ty2JQSbgYGjXCJheNp4aXVJfNCMAJtiBUtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnoWxVLdMLicCBhbiCyyJQ+hJ0Ie3EmBDwD7cFmhB6D4Q2xOLzouvxRgOlyOFIz5eSLGWTettd/26wOU5Z5SKy9NsmL5FmSvAeuVtn2VIbzQk/CqhbOa18Z8GDxFhGjn9C8jv0syLTAKhv1erujTz8spaAXVvsG94OutI2r8/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=O1aMiL1o; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="O1aMiL1o"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de4be15125so11373872a34.0
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779898008; x=1780502808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDewevQlsNX9Nf5an4WdPkqFyUO5oYIAKU8piRx5pII=;
        b=O1aMiL1oIFen2XoIfw6SCJALa8Ot1OyXMqMDB/oU7qEd7xqcpJcmD2Obpa7Xhf18Wb
         Tv/hwDlI7f60fJZz3LA5WSK4ha8sHBqy0Kfvy69FTonSDHkqHImBe3jY7r5kUGVV69g6
         DhgWZzngjuvHdU+DNARaOlOBOOyKC+yJ6iCMDZXnpaxkUD82iSBKl0+T6BjDJfWzZiQg
         6B27azfpAuiutURWisO1EMMtvonRee30OHl5YFyTxvXi+wBdj4rE79r/FP+yG15cxFY8
         kseLG06/4whit0X1Jj2asavVTSHHe2CqrCILfrcIu8BMz8zsF0kxznceQwGoyP4Yuqbv
         9JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898008; x=1780502808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDewevQlsNX9Nf5an4WdPkqFyUO5oYIAKU8piRx5pII=;
        b=hIN9mRXvNs6OZ6EGLcT4qc4oCyeHOGEEHNX5AOH3aHPdEDjvwUR6hUgeYVJWoKeMqG
         FksAG08wLGj6MS3bKo3HLxU/2UTb1eVyqzw/E2gj4U7LBUYS+J6R+0O3yEBg2/OBKrx+
         zOllOhQ9BhdJk4MyGoudLto4h2pJ28HWWrVyIRSSetNjsMawjylKvc2QZ6IQTyiYU5Kl
         pArJnphK6JNj8+v/fZ5BYy0HtMLJ/1w7lDbEo1vs6+pnOVcBNNlJI9ymZDZmgOiYYCxf
         0juc90EWqqjRxmc2qLexKm0j5hh5xLCoh8DFGu62UD8coWM4VL9hKYI2GNxaeCz6tK2m
         hLqw==
X-Forwarded-Encrypted: i=1; AFNElJ9on6Kf1RSo4WWyT4qyv2qmGD0EVUXa5U6B0mOdQyTpZvEEzjy4MMuWPtCWhRgSEBvIRx9C+ZHG8z3AHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AmIXroOy8z545BE2lBb59xZUbGRjco90BrDqww43tlxRqEpR
	5oBtOcdhLeI0ii8txegbtKo6PSjeNKBjmyj0sPq0LWW2EU18gEttYUhHBtF3Adn6Jkk=
X-Gm-Gg: Acq92OEN7qo+oJoLUYPZkRjQVBtwEc+VCDHv8/UMZXOTtxMHGQRmrxvaQV3cgdaM3Ht
	Y2G+vg6NtAsrwNwOIBvlH9iEJ3yqYAtsL1pEjW/19oIblynFB+zJjNmexd7WXdt67hVVAubPPWj
	hKqLOM2qXrrsa+521O8uLiTLptmEzvi/dw/aqX+Govisnt+y2prT98gp7yAE+IbYJ/ejia5YOQE
	v7UTejLwYBO6CGhPMmS/v0ZpePGoAnK6SYVf2gaow+YH3Ao6PQYN5vRb0S0kzDbbVKaZeMGZuV0
	MpUjoG7wfRw+6CTw/qanTv6uP77GkvVc2FaHrvsQl48daJQLsHXNjcs+PWbzteAUXq+2BnWNFu/
	tI/5h1uyYPRLdlj+1B4dXMKJkkBlizek8B5k5Ycei6PVbpwy00VP+ZGiBPlATIQpuEFvjV6SSt4
	kObm7XD5T3QymQNm6Mo0cuCD8aHgoiK9ctjTQme8ipwoqAlkTUijvTzPf2gzQnM8fvFO6jsf4pS
	EuqMyQtGrouGyI5k3o=
X-Received: by 2002:a05:6830:6682:b0:7dc:dd58:50a1 with SMTP id 46e09a7af769-7e5fee5ef73mr15600883a34.15.1779898007969;
        Wed, 27 May 2026 09:06:47 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459bf7sm11606383a34.1.2026.05.27.09.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:06:45 -0700 (PDT)
Message-ID: <ee931505-64a2-411d-8607-3db8912b70c4@kernel.dk>
Date: Wed, 27 May 2026 10:06:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: bsg: copy uring_cmd payload to prevent double-fetch
 from shared SQE
To: Rahul Chandelkar <rc@rexion.ai>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260527105931.3950913-1-rc@rexion.ai>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260527105931.3950913-1-rc@rexion.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 4:59 AM, Rahul Chandelkar wrote:
> scsi_bsg_uring_cmd() and scsi_bsg_map_user_buffer() read bsg_uring_cmd
> fields directly from the shared mmap'd io_uring submission ring via
> io_uring_sqe128_cmd().  On the inline execution path, io_uring has not
> yet copied the SQE to kernel memory, so a concurrent userspace thread
> can modify fields between reads.
> 
> cmd->request_len is read for the bounds check, for the cmd_len
> assignment, and for the copy_from_user length.  A racing thread can
> change request_len between the bounds check (passes with <= 32) and
> copy_from_user (uses the enlarged value), overflowing the 32-byte
> scmd->cmnd[] buffer into subsequent struct scsi_cmnd fields.
> 
> scsi_bsg_map_user_buffer() independently re-derives its cmd pointer
> from the same shared SQE, re-reading dout_xfer_len, din_xfer_len,
> dout_xferp, and din_xferp, enabling direction confusion and buffer
> length races.
> 
> Copy struct bsg_uring_cmd to a stack-local variable before use in both
> functions.  The pointer variable 'cmd' is redirected to the local copy
> so the rest of each function is unchanged.
> 
> Tested with KASAN on QEMU (virtio-scsi, 2 vCPUs).  Without this fix,
> a two-thread race produces:
> 
>   BUG: KASAN: wild-memory-access in scsi_queue_rq+0x4a3/0x58a0
>   Write of size 96 at addr dead000000001000 by task poc/67
>   Call Trace:
>    kasan_report+0xce/0x100
>    __asan_memset+0x23/0x50
>    scsi_queue_rq+0x4a3/0x58a0
>    scsi_bsg_uring_cmd+0x942/0x1570
>    io_uring_cmd+0x2f6/0x950
>    io_issue_sqe+0xe5/0x22d0

I don't think this is the right way to fix it, ->sqe should've been
stable upfront if this ends up happening. Can you share your poc with
me? Your trace has been trimmed down way too much to be useful.

-- 
Jens Axboe
