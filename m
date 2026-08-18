Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCF37A481
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094875; cv=none; b=Ov8LTQL1hAide4KyCSs832C/EIB+5yGvt1mZmEZJrtIGMJF2Ld5vgitBLCGg0HfIHaNj3IC8YGyfgbGtQku/sTTg8DMSI8Gb2MwAG1TTG9mskTjaLG0TUHSCiozXV77B1iDS6ysqSUTBMP1pOsKHblYpfwR+HMzWkgLgCReoX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094875; c=relaxed/simple;
	bh=ElqOZrrmazFegmFdRSfRDr7lLm48JslKK6qBBMx9gH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AEpa+sQf2ElEsdXrelC+NDPXOhPPXctEFBulUmLnE31JTF3lUkAbJu2Cv6ouR9PTsWihB8BaZb1cBqkYXetUw+M5h+ByUAsdZ3F3OJ4il+JQMfqN0TP/Jv08XTjVOaUbA7jfGyAZj+gFdNYdAc9ofpnFeRFcn0hQlz9J6F1a4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=DepzYhk1; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="DepzYhk1"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ae8c4b9822so252144eaf.1
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787094870; x=1787699670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GP8XxMgqYpXsPqRzhVMiIrzOBi/JkxiwftNzVyPC/4=;
        b=DepzYhk1/oYRquEDGSn2/Tr6KOR9rks9OkRetfnzEt3L+hHVYfkB7zB8DCeooHAT1d
         +yDyfm8Lwk1jP5M0VpUXtOYrjnLTrYKTr4t+LhZx07a+3m6YxfE6uobuF6q54KwgnEgv
         s5YGnNA11gEyCj102q6pmwY0VeUl989y8O101hJQhTc0HS2osx9dHp5mVEz6WgjdLePZ
         QaRsS7BMtpP3a8gcKH2M4t7OyHlBW4XL8t57iUrmfjsgdVZmCkVdWevpWF4ZtfwnA3yL
         H6BH1op2lKp/udPc0R7y+DI6X+hd+I+tE/pWTvcYPWAe05zQEQs+/nJkRVTQn0c3udyw
         jDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787094870; x=1787699670;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GP8XxMgqYpXsPqRzhVMiIrzOBi/JkxiwftNzVyPC/4=;
        b=lUgCHl3rmD4Q/3+B/Zrc1C5GT1rAkKyeEnL0YHgycxLdQlv2P1V6Y5SATboic0rkxz
         SqfzP+UMNbDbFTKsB1L2ScCfoWZmyi5aylPPhIFRelxum5xXJPkgZzs0/NmqeFfBme9l
         XWzN3ySMTeWlPK3XE1VunAgdW66uS+59dRblX/TAPsSc5oqODc231lX4GjGIrsRJvi3c
         6kfTqCoO5CnMIaIUl2ek0hIBOrz0/GXrS7y1xc7OPxR8X+37n1QGWJXrkvRuEcofuYSL
         GEeeE4wRtWSDL8QiyRF0jSsI89wuhAE1tuQ+7564HDrRJjmwdDdGxQwdXz50Ocewb7rm
         jqFA==
X-Gm-Message-State: AOJu0YzRdSc6BvvABtsSGGRSgRnXKPLUvflLl5KfAFuHvoii3vFg/GtC
	b/TMK41nc5ZeBqtVDGpFm4uMAbUBpQzRUXhC03F0//uPhVQ7KMQOvmUg8cgN2LPoUgydMK9RNw+
	PW58vhUp0VA==
X-Gm-Gg: AR+sD11ug73+dRwUlvHNqfQ/gr53jfpZBijXlyYx750v5dMJpWO9S0rMhAwFgqudYN3
	wjY9JwQd6HBZiif2tW8VefY+GkZfQdbG1v9A6VWfQ6yRxRtVxw9HXDfwciIAbWFblIVoXttR1p1
	XOLajRA0GXd0i48zVdajeb/OgmbSgLbj3Bwgvubg9tg9hslHZ5KsMFqikWdCzt4aH3JCEVw2WQj
	2PvYYzPM45NDw5tyJdv6FNlGolK4moINN1r1PvEvyn9kHRT2METGAkWucnhwygsE2qqWyOFgfNo
	db7khJ4NenuzZ7tMD80Imptl6SVmUcIJ5+TNjEFIsDIgaPvUd6f4kbvZT8pGDWfNwPzppWwWIPy
	TUwXPUxE6cy0nbBtwK1wU4elESgPJenOnNHVLJgamcE8Fkh/iNI4SI5tCP9vSCrmrR9t79yM4hK
	2ZiKDRCaoWNqiMDX1qleXFlx3nPV5qNbeBenUyAcyeg0F//JrVNrTze3yOijaKDgjZwOt+2xQEF
	wZYZEEMCNh1HH+ERAqZvaXMKUU439q1OU6pMWDWNQ==
X-Received: by 2002:a05:6820:6aca:b0:69e:4d9d:5a5 with SMTP id 006d021491bc7-6b13c3c3123mr826330eaf.16.1787094870073;
        Tue, 18 Aug 2026 16:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22aea368sm4182681fac.5.2026.08.18.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:14:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Miklos Szeredi <mszeredi@redhat.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260818184134.384991-1-broonie@kernel.org>
References: <20260818184134.384991-1-broonie@kernel.org>
Subject: Re: [PATCH] io_uring: Add missing include for ITER_SOURCE and
 ITER_DEST
Message-Id: <178709486888.3609576.4614424590881952125.b4-ty@b4>
Date: Tue, 18 Aug 2026 17:14:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 18 Aug 2026 19:41:34 +0100, Mark Brown wrote:
> Fix IWYU issues:
> 
> /tmp/next/build/include/linux/io_uring_types.h:56:32: error: 'ITER_DEST'
> undeclared here (not in a function)
>    56 |         IO_BUF_DEST     = 1 << ITER_DEST,
>       |                                ^~~~~~~~~
> /tmp/next/build/include/linux/io_uring_types.h:57:32: error: 'ITER_SOURCE'
> undeclared here (not in a function)
>    57 |         IO_BUF_SOURCE   = 1 << ITER_SOURCE,
>       |                                ^~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] io_uring: Add missing include for ITER_SOURCE and ITER_DEST
      commit: 881dc9dd66d2367e7fe1be0f953a8837cb3b26a9

Best regards,
-- 
Jens Axboe



