Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF29BDB0
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872909; cv=none; b=IVInF4c9g8QNyADyKxSvRFCxmmJJ+In/01vJcz1zAL/mpr1hIoKeVKAFMcbvohGTWrKAdqjpta7KLhtbLIN59cFHkLZ2HEyhUBxBXlph6Yx991kvYiNGkxUwVuXUgxp83wbjeD7pYNWy4ujnbTOTFTX6/FcOGtsPnjboxLJrW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872909; c=relaxed/simple;
	bh=Pc086ujvScE2BI9hiMALfAHgXYz5Z656q27m00hb3To=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VjVRuV0Au8JdtpV1pOxtQSYkDrBRQdtPkXG7lRhzI5Hv6mIQ1F6/jVnEGy/EueqrVt0BF4OPCnGs5IWg7r4Yic0WAWLc6hIVlHmImqqp/P6vFXmsPgjPvBRD/4ccCZ6zwzHJoJlIishaJNPsoIcgfoBjWVA4MHePI7JioJJvRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zw4y/LOE; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zw4y/LOE"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-43323851d03so16479985ab.0
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762872904; x=1763477704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd60/KfMSWtIeVZjWzA7tGiHeUAva3B/1z//rOpfIQw=;
        b=zw4y/LOE287jm6K6HVPtVkEOlEeIcCJRNRUEjwlkMdRAnc/su6+SQ/zIOK4hndN5B2
         fb+4DGpQH7D+V3yq5dhHsZ78w5xQ38SLm/3rJ+hwfAf3pxZnuc9NmmqfFp4x/WA4G7BJ
         Vqt9Xaa0zCkxGK+UpwHMc32hhvZteXjl6r4b7gT2mPFtY2UilHHk3gP8o17oi05ay+nF
         sqkYR+ASvcqAn7CVJI+adySa7hHCS+S50TM+2dlno/ErCtFK+HCki0a0JpPzKpq9oG8G
         oIew/J9HAx823uccYExYzF/JIuJV5A1PGDlkJONBmGzkmzkBXyaajvm/MC9CaxdenNxe
         PyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872904; x=1763477704;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd60/KfMSWtIeVZjWzA7tGiHeUAva3B/1z//rOpfIQw=;
        b=Y7gYttyNgWA86ansy8cgm4tIWVo3cwhEoNUv6P/pQN/GyYJvYdAkZYoxU4Q+grhVKE
         MfNobSFFMUV6Dk5ji76unYkSDnKXdWLIA+u6YG1tRZXqdoomtgB3f7lODW+UZvIBZfsA
         n6VXaGSf1L0yf6AAXN7ihKmwLbkh3VO1aogxbiHG8HYyueeny2Sqo8gFXW4rSDvo2IJX
         AnLgnE9eP5TW49XYjMAz3sAbZLXR22LmCxA4VTqh4YmPhqcMNZIewBfd3vSasn40or2r
         TkpeuB9zw7hPLIEUTTW/a7OXPZRjI/EoZac8+QuWpwcQvdzhY0PO4J+0tVUQ7vfSz8zA
         7aUA==
X-Gm-Message-State: AOJu0YzeJcw0IoxVbKtN9E2FPW7XBNxW5OmrHR7kdFFXQcgHbJnAtI1o
	aFLr8xD0RQpVdOc7TZYbusxO16byX+Gfsqz2Vg4XpPB1hEU+tjouxPSj+pRX/i9RSEk=
X-Gm-Gg: ASbGncu/l9OLcTy4y5tqV/J0x1X2DzggR9kq8fzdyTlgaMV8fj/N4V7p0HZZgB5mUyQ
	vYmPOAmLhTtrOT3rvf8FBlSnPTjm2zfFsS8cWEg2l9pO0bo12QBxpPKHMvtZ3NR53g6eISgsgyJ
	bOmL3jUH4Eq/4+3lvv9v3h3uAdBy68rgHlI3VZlUPvQvMAc7yoSnbBl+tEYiMocd2fFsuIC74dM
	qZWeAiCKX+ByvHyU3VqgMOHgmRIjNryQug0n5DK6tRDnW9f456oU9aC6EeX0+hUdSLc1DsBHPKC
	jLlFnFQtrD8D/pam6ADrJc/HWQdhMzuuk7wJgiPYBMQAtnlgXPgcBmoaSyDAvm1cK9s4VEKDT3X
	jrr9Wr4zHipJ6P5xvZQUdK6UroC0Ds1mvPBdVDHOCVAD5Qroe71d06IU1tzK3UN8YwlbGPwTIsW
	dCqp4=
X-Google-Smtp-Source: AGHT+IFMYYVFn/FWFoI4cBgTrfFiY+nGqvc8CTHosZF05Ixu1TUPMtPgPExq2cQbx0wbLmmkWOTIQQ==
X-Received: by 2002:a05:6e02:17ca:b0:433:5a9d:dac6 with SMTP id e9e14a558f8ab-43367e7166fmr180713905ab.27.1762872904081;
        Tue, 11 Nov 2025 06:55:04 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43380302872sm26311045ab.32.2025.11.11.06.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:55:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, zhengqixing@huawei.com
In-Reply-To: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
References: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH] nbd: defer config unlock in nbd_genl_connect
Message-Id: <176287290263.173215.8003110522218932458.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:55:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 10 Nov 2025 20:49:20 +0800, Zheng Qixing wrote:
> There is one use-after-free warning when running NBD_CMD_CONNECT and
> NBD_CLEAR_SOCK:
> 
> nbd_genl_connect
>   nbd_alloc_and_init_config // config_refs=1
>   nbd_start_device // config_refs=2
>   set NBD_RT_HAS_CONFIG_REF			open nbd // config_refs=3
>   recv_work done // config_refs=2
> 						NBD_CLEAR_SOCK // config_refs=1
> 						close nbd // config_refs=0
>   refcount_inc -> uaf
> 
> [...]

Applied, thanks!

[1/1] nbd: defer config unlock in nbd_genl_connect
      commit: 1649714b930f9ea6233ce0810ba885999da3b5d4

Best regards,
-- 
Jens Axboe



