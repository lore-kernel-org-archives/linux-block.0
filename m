Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC3313538
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185595; cv=none; b=bY5tpOoA7IE37mGuxa/eVPK5yooOs9vdKLg/k6pdBu0OPbphff2hSHmIUxdteUZDI8DxWKe5LZFbXs83OFBv/Yu+LX3iEQxolZwZ3AYEVUDIurOrl3xIN8Jo7VOSGIXaG5maZbNMlKWxIwx3wpEvy6KGQI71Ier21u65eAOkXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185595; c=relaxed/simple;
	bh=OmMLchAeUeySgwhNaGcYu4r3ZEqXxE+MViOzf2cqMVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iirtoexIzUkHX2imEX5ivLrLx8gmCLzmXJkW/L2rJ3PzWpQvxS616FjzRC1jv9A300rRbMblLzt3TOSATjhEVcmOGIFC+SY7rfY4hI9lVYPDYHWYOs4Zrt3mn512zUe+Tqy1gODAWeivOEhV2OE1mIiA6Y5lZz5xN3HmJ9JEJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dFwaQpX8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dFwaQpX8"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-92aee734585so195069539f.3
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762185592; x=1762790392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KVTIa+dOzj0V3NHrOXqsCxCiYIvaXVpSTfeWllBoew=;
        b=dFwaQpX8EUQUc+4KUj8ARxBrY3doGCtQPfHhwn2rD5BPjToob3JDfD5cbzzZuVePTJ
         XzzrD7/n8Lx5eqCkFol0gvFAgnPsSbDHKUryKhoKzpKtXC/oTTM17LZZGW1HIWzC+pYV
         19WpkrYAY8VTY+fd5N8dvTodrGkoUnbLGVdtnVx4jifY50z/Azy0Kk4ezYCuMVFAQkCW
         Fqs8aFzD0o1wXWdwW6/wM9HpBbxkZ9y38iTCwxI+XmM0Uuva90WlsJIoPe39UK9egaLf
         MRx7iMo09Q2vkUNaY4U8DNJEtuHZdNHK1k+hyPK1aOSDCE1PiD43Rfzy+9M+mFzGZ1bT
         0PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185592; x=1762790392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KVTIa+dOzj0V3NHrOXqsCxCiYIvaXVpSTfeWllBoew=;
        b=fuZxYz2Gv5GDqIQAF/jKYSrfgKel1wwCacsE8HBbJyakD7Uzi1GQ+S4GeGsZZ/lAe9
         I2azNPdac6ozKtKvW4UMTaIIwD83rbFLPUzuYMtDBjxY+IwphT31qy+mW4267UoSI6eY
         ez60s0l6iLNuFbe8w6/hM1jMi64KISl8dq/A7X/VFNYMuFBEodYCVebNrXqhCu9ZPUfG
         zVeqoC8FxWIw7NsEPbkseGxwR/wUJRRIQI4NfCWMDAz4UGdf2+iP+ynb/uxgs8Y/HCQ/
         QWYU6RQ5ino6izoYrfNthVxCOEDfcyhpqrZPXGf9t3E2V4zRyoG+ydOQpT0vCViCORE8
         eezA==
X-Gm-Message-State: AOJu0YxUnLl9h+0rBJw9aemoAHU0d7tQ1DXrCBdbMuAgn94jH0i6L4La
	1ghYvbemmS16vVgBbhfnv8+CeIEyfy/im5AOiCdOnkYbnK2OUtAh3KRElVtNxBUFo2A=
X-Gm-Gg: ASbGncvATcvANWfsPYStZx280VTB+S9E6kGMe+fNUkltWwquPOndypUeDqgP0NZO227
	2hnuPAkSSsNq9YA+9iXwB2agdfCUIV8zvGLLsYwayZQ3JO4aqVkyiecLiCl0eZaG0aiLLabxFmt
	ONzikMS45zODcFoOQV6KwJv5Q5dSXkU75TCtSzf62Ya2Glwxofk0SctZm3xu+/9z8z/9Y9vxZhi
	yV1VoUCNG7pqK3H60HWS6hHdlqK4Y4Qrj9XUpzJPkSIiBi6DA0bPRj5kD32lQSyWYpyjl0+gDKV
	uRO7cIhSVJqkqniPZHIRHdWZhwB6bDS2XoIUEyJpERtOGLysgdAxav4FtxvM1QaF4Hv5We+LEk4
	rT/1qLYBE5CSM3tnHMt/OVvu78ieSLxpPGyytpYDl16hxeiJeB0xs8kvN6s9xjjB1On76uMWevH
	DLLwavBoo=
X-Google-Smtp-Source: AGHT+IHeXwTU86jvQEounNr5wea3NvcMebFpU966CMiAJWXRdJYK+Hd/OBHUo1KPbvA9CtwHSCTOvA==
X-Received: by 2002:a05:6602:48e:b0:938:9f22:ed34 with SMTP id ca18e2360f4ac-94822a37960mr1887920539f.16.1762185592385;
        Mon, 03 Nov 2025 07:59:52 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7225ad8a9sm290152173.15.2025.11.03.07.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:59:50 -0800 (PST)
Message-ID: <d7b57146-9703-461d-97d3-232cba3f8191@kernel.dk>
Date: Mon, 3 Nov 2025 08:59:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] creds: add {scoped_}with_kernel_creds()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/25 4:12 PM, Christian Brauner wrote:
> Hey,
> 
> A few months ago I did work to make override_creds()/revert_creds()
> completely reference count free - mostly for the sake of
> overlayfs but it has been beneficial to everyone using this.
> 
> In a recent pull request from Jens that introduced another round of
> override_creds()/revert_creds() for nbd Linus asked whether we could
> avoide the prepare_kernel_creds() calls that duplicate the kernel
> credentials and then drop them again later.
> 
> Yes, we can actually. We can use the guard infrastructure to completely
> avoid the allocation and then also to never expose the temporary
> variable to hold the kernel credentials anywhere in the callers.
> 
> So add with_kernel_creds() and scoped_with_kernel_creds() for this
> purpose. Also take the opportunity to fixup the scoped_class() macro I
> introduced two cycles ago.
> 
> I've put this into kernel-6.19.cred now. Linus, not sure if you're
> paying attention but if you want you can give this a final look.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       cleanup: fix scoped_class()
>       cred: add kernel_cred() helper
>       cred: make init_cred static
>       cred: add {scoped_}with_kernel_creds
>       firmware: don't copy kernel creds
>       nbd: don't copy kernel creds
>       target: don't copy kernel creds
>       unix: don't copy creds
> 
>  drivers/base/firmware_loader/main.c   | 59 +++++++++++++++--------------------
>  drivers/block/nbd.c                   | 17 ++--------
>  drivers/target/target_core_configfs.c | 14 ++-------
>  include/linux/cleanup.h               | 15 ++++-----
>  include/linux/cred.h                  | 18 +++++++++++
>  include/linux/init_task.h             |  1 -
>  init/init_task.c                      | 27 ++++++++++++++++
>  kernel/cred.c                         | 27 ----------------
>  net/unix/af_unix.c                    | 17 +++-------
>  security/keys/process_keys.c          |  2 +-
>  10 files changed, 87 insertions(+), 110 deletions(-)

Looks good to me, and love diffstats like that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
