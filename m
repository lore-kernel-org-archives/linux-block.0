Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500EB313E0A
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978358; cv=none; b=lY+WCy65xmCnwXH2fhcWsHGCIUlnBrP2X3Vev9wozJKT0sir95WcPRzeaJVaEB0S6QYJ4h5beUzJ+9Z7jXK6cconvG0xLSeqVtsJiJiuoeyWwUFmTwpvkMghpBwCigEVF12r1XkaKHLR95FMYAQc2Qmh5slCYIQw8gmZFkb3zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978358; c=relaxed/simple;
	bh=h4psjA+4m5Yd0xvfxXbO+b9oxRofaNODIGIPOWNQOjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhhLSFcUadEZ8Nr3UzVrGGrJTbhnTimrsDTNM/xsIVp6bNtOcxBLumoTww2BU/r5+Gzvtcuqd7VqtoNTdiN7Ev7uE+GHho9JzR08Y15qgEMJLC8WLNUpzemqrH9xvrlLrBXo7k+UFcYCDm8vZQqRqw/dUebHlvvgL8vyR0g05+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IAMe1lZz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IAMe1lZz"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso27095785ab.2
        for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760978353; x=1761583153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxMaJn1oMU5F/nUr+F+IuKEyn6pUCEn8SKXf5r6k4ks=;
        b=IAMe1lZz+c00NgTT3srXZfIUfZbhWM3AAFOkymx74Loa0H+yx2vJn9ZH3CTr9rMjiJ
         gtpeN6iCD/8ubtpMNU0uVaRC7Vq233dl5KG06uRIM3KTnsJh4PBgDkb/zYCqDfsy1nC5
         ZwjrNcunvXhiWpZV2pjZRx4DeuKe0YFcMmDqARs7F9d4ylL3y6/IBQY+4M+YR26mBhM+
         avHIpD7LKU9pBU3A+TV3A+rK5cosMvJ8XS04c8SAkM+GdODlOBmZBYa+S5XgP0MY3knX
         BUX4Tpnq2QGzOi+8+/Xq2CDkDCDbLc8n4vGDSSrMjAy+4xsP+r8BL1EowyTrBE6VCO+d
         8DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978353; x=1761583153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxMaJn1oMU5F/nUr+F+IuKEyn6pUCEn8SKXf5r6k4ks=;
        b=sdMBGyCnRXSTgTq57RE3hUdSN3oYZR4jUFCGicTbHhxufkiTRJp90AuxFOQlESzW7D
         Rz3WaWUM2+fTCxMB1rW8alvpy9+iuiq+7X/pnuNTmW/rcp+ZsTzgIOaiSsQKJ05deo/m
         gQliKi/iMOiNJHAcjum5I/WADzw3kGlQabT5AIVqApzCJEkjn413Cm0jIEb4uXuJdWt6
         DWJjyV06QSz1C6pokkrF1h7PCqU68atZ5BsiVRtAMeq+bIncwdqtXs+lNnJl4fhu9sx9
         i0tBkKyI3fp1mkGYal2FXssnAEZpjEqdnMWTI+yT7rbwrhFsS9zKzznKU9xpPTU7fvBm
         IiYA==
X-Gm-Message-State: AOJu0Yw6+I/wT2+4CA4/uXVFqnpvHuBwlofJF08FAAsbI05WAm9ljZZ+
	xnkD8Di7YFlXOD4Tyntkciwi4biZgOYLpPKRH5nMraAc2wTnOaLyOY3ZgbEwo2TzDfwxVMhkBzA
	hEKE1aXM=
X-Gm-Gg: ASbGncsNCYLvgEgvNOUjmkg+3BpiYgahSf7qopMosoz+cCrHtt+ad0KuUOFD/rfKPRj
	cA2fI0IOFZG0SoLUVtJ8dMehbEoiPXuWunPyURmDSBD1bhzxniG5JoC+DL/m0TavM3Hg0FghU6P
	Gkbf8fQ6nkDFSFhscX22hqANQSRniJndpl2ECuwPMjc+1STE0PjVhISVU6JoCEai5ESS94S0tYx
	H51i3Q5g03v0k3FDJI+K/Hx0mv2dFrOEKaf8HCxECMUNY7qfHL0pJK5E307y1ckA5tb8NpwismB
	TAC0euZS99QNzygmjh3+9fgv07smfUjTX+w6vCm3Oo7yB5VDmTJA1TJ59CM6K8b/rrn/isBs5Ae
	dX6WGDvWTN5e8O2eGd8u5+8i4YKieS4kKeHK9+3LIfxbC9zVG1j/SrerNEpbWTkgHwHSuDWo1U9
	Z3Tw==
X-Google-Smtp-Source: AGHT+IFW26MRpxaoSVeHKWJk5WnecJwW3fQuafM/KT8lBR3W1vBSFYWv7g9d2DXyZbjSs0gxMJQgNQ==
X-Received: by 2002:a05:6e02:1fe8:b0:430:c403:97ea with SMTP id e9e14a558f8ab-430c524fbb3mr205255725ab.2.1760978353191;
        Mon, 20 Oct 2025 09:39:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07ce09fsm32052445ab.39.2025.10.20.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:39:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
References: <20251018213831.260055-1-mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] blk-mq: use struct_size() in kmalloc()
Message-Id: <176097835143.28490.789079417051480319.b4-ty@kernel.dk>
Date: Mon, 20 Oct 2025 10:39:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 18 Oct 2025 22:38:13 +0100, Mehdi Ben Hadj Khelifa wrote:
> Change struct size calculation to use struct_size()
> to align with new recommended practices[1] which quotes:
> "Another common case to avoid is calculating the size of a structure with
> a trailing array of others structures, as in:
> 
> header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
>                  GFP_KERNEL);
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use struct_size() in kmalloc()
      commit: e5a82249d88c7063c4ac998704b0ae5784013976

Best regards,
-- 
Jens Axboe



