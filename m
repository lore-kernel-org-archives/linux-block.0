Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6E2EE96F
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259339; cv=none; b=eTXhbudTMB9ko3KdxqMFDBaF4p6fnm/1xmkfjqwW+S08sxBihZ4TD2+d9VZOyHMiQ4EaWgZZutln+rbaBlZzsgh2fw6tCXD8i0RhdYOu7vG7W11G3L4lW5N/7/MJC+D9BkJNrmGambjtSaE8CSw03FS12GllN8DcExiyAUhZjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259339; c=relaxed/simple;
	bh=en0ps2JOFMLZPmwBi5IopTBVzZPZ6G/D7ZYPlkbTfi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/XlUQySAkNc9PHCPoIdmqsJwNCoCymQmLqXR5Dsmt1sJ7vH1sC34QV+rnzzIgCTezD7rpRlB0wseBb/PaX99zdTGTcJFExFDTRBRPfF4urA0cHDcIzufUNYW2B6STIYOCb95pYUCh+fvS3lH2e56D8mxAX7h+B6G9x0LENcfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tRCU2DxU; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tRCU2DxU"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so184144439f.1
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750259336; x=1750864136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw9CysehrDuTIMqER+G28fN4h7Pjw8YveKfzzHo0COI=;
        b=tRCU2DxUmFVhjFbiZpNUOtYujOwXtiG5dBi/DEjKR0xkW50FBEPO/24D85cm6SUpAm
         uJUi4M9BUbkiw50I0n9ABQ7Pgc3L0Mk7m29udIhTnjxM68hZZMgOMG9VMj70wqDxW615
         mQ54a5lxhXosNQ13fPdvOZVAOOKtL3q41dpL4Uo0z655ncj5gdSdMLb4cTfv/Yt6xHBM
         iqZTTTAltlVAMef8Vy/Itma1GUzcYnFTrqlHXV3ntzwx5MOS3qJtEU6MuDQJlfJM3Bwc
         ywf+TPwxPYd9IkfPOgbN7Y3d53O3IK2SWFUbvF1LBTMrqSB7QQeVVGgiTWULe9qd3zJR
         fNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259336; x=1750864136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw9CysehrDuTIMqER+G28fN4h7Pjw8YveKfzzHo0COI=;
        b=sLmimMg3n62ffi9H+bXBNgB8OW7Tyt1+8CjqRcoYa04yC/2b0CzByJMhqtjnMXNHko
         ADkars9uyLmZtPqBd687jZRJQoT5ja9izOh8mAxOJGqCx14JhppGXDn+ytNFiPDQu5cH
         Zqcznvxv/Xp9A99MgtVOGwnO+Ags2NbWLxPB/cI8dHQc8y/csEx/gAnow4QDFmPV/VFY
         NdJcdU0I8uutXv3wgvsKIq8nQISho5bLWObxpJxc61AllsG3WmDtCa/2T1YDQHyDIsQB
         sx5/6AY3FDcSvtxX98br/Cz6uU7Dh+r6z/0JjSZvi25vBgCr+1MCQwIsLDIw0GSNgTQ1
         072g==
X-Forwarded-Encrypted: i=1; AJvYcCVqCWBw8484Xl2pUqeMcYFd293eF4CDd7aGklSE+XcYCdlIMOxjDQ2nsiHadqufo5KrFVyJZAC4LaWhaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vrUR/G+0osI4W0GwOKl3277yvhuKRUnpP+z9ikiIKRhpXd7J
	IR62CIBOe5EGQJ94m1IVLcPH7SIB1iBnZwFkX2MBFg6ZQBFuAGuEko44G4gh6aSAG10=
X-Gm-Gg: ASbGncuoSuO3E467PuYOFjAmm5UKoAt6FutFqkW/JxBQ3tVEuvCnfmpFVQh7EPGdtK2
	lODvA1zg/vfvv5YFOpZyL+lCOPGZP9PzaWcM9AZOVkpZ+3MtUPBNfN2P0UCheYRJjBn43TLp2YX
	GrI2EHRW1clWn4SL6Xh8aIt7D4+qA1bJnCRLglxEH2ONYykemL90hf/bforJNBPfEijc61TonEr
	+ADIQXfF8QLpe1iX9z9KY/wqP4M/EL083W5pHWVsGhDED9hWME8M4UL0i7N7LuSfV2JOXxQ49CB
	FYkkzhixouMXUVztCgc8U8fkbyYq/A+zE2EKIckwHptN/ztr+PXYnNzZkA==
X-Google-Smtp-Source: AGHT+IEc0rZMYhxxAqXs4tJ+bbrGWCLZj5tXxtjm5IMhIACjwi2A8AGwAsngWju8yI+9+5vcu1+MhQ==
X-Received: by 2002:a05:6602:2c91:b0:874:e108:8e3a with SMTP id ca18e2360f4ac-875dedb51c8mr2092714639f.12.1750259336359;
        Wed, 18 Jun 2025 08:08:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d570ed57sm262369039f.1.2025.06.18.08.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:08:55 -0700 (PDT)
Message-ID: <79527b0e-4a04-4f77-b78f-ce7ec7a57546@kernel.dk>
Date: Wed, 18 Jun 2025 09:08:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: support asynchronous writeback
To: Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250618132622.3730219-1-richardycc@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250618132622.3730219-1-richardycc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 7:26 AM, Richard Chang wrote:
> This commit introduces asynchronous writeback to zram, improving the
> idle writeback speed.
> 
> Key changes include:
> 
> * Replacing `submit_bio_wait()` with `submit_bio()` to enable
>   non-blocking writeback operations.
> * Utilizing a dedicated kthread for post-writeback tasks, avoiding
>   potential lock contention in interrupt context.
> * Refactoring writeback-related code into a separate file `zram_wb.c`,
>   for better organization and maintainability.

This kind of laundry list is a clear sign that this should be a series
of patches, not one big patch.

-- 
Jens Axboe

