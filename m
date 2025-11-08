Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DA1BCA1C
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762609216; cv=none; b=lJcw7mU7SCuxoVJXG9pxpruPXOrJwnOtty49nWEoc/5IV6lwBmtm0kKVyKXE+SrRAPwlcEI9x9/a6bcFvG65nddTrVVtAS6D/IE26Dr4x4cGyfYDsPnGgnUnrJU1KOMTMLheCHHcdJMCPvJncfRh00MI4H/zz5VOCZELHnCMzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762609216; c=relaxed/simple;
	bh=273VHuh3p/ntcPrXYgH3JgdfT+IV3y3JCMHzGqVXhKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVNv6Rv7OcLVnCaAnLNn/JRvJf2D7Zb+kYdRVs3zT6LWCeiZAVkf0bJj72dE1lKcP2XmO3EY3N2i6OWvPTYyOicRjVqz80h/lCdGRHUaQ/RPfMKwlSWNJ8qnWFGt1n2bIle8/cQiYuT8UWU3MJJGBjxyg/uF3Qvl5lz1tbl9b9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DYMH1XF3; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DYMH1XF3"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-880439c5704so13439196d6.1
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762609213; x=1763214013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2giZadMJBuuT3KA47dI/fWZ1tD3AsoNgXq1hGiRElGk=;
        b=DYMH1XF3HkOMB1JI/syWZ+yjudL++zGbGH4lGi+EiMsfzt2ioJROOoV8h+GtS+D5uH
         cjmKZL5CaLAnSyELS/Lzvcq3glGWkGG9yvtnakrIQK1D6XJpde364NPWxlWm3ihy766p
         7rlPmgynhRUq7BhV21O51hRpGz707GKhEWUYsQvTZXzwcJb7RPYggeGcw5W5A6s0CI3C
         I5AKUY+w/7pFyFOEt97Ukb/vMbBfzsnM+tlSEvKKHjeE3iWNvn4/nPf0nTbXFIIikm9T
         DNleOb8kR1Mi4Xn3+/cmSFaqdr2PDfxRr99uzRIx6N5tSIPgxQOiEIGrfeqziwfBvaam
         O4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762609213; x=1763214013;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2giZadMJBuuT3KA47dI/fWZ1tD3AsoNgXq1hGiRElGk=;
        b=mcltfYdhM+9K/C8fgCyVFJkRJ12NWdne887eiaJNjqMc0pIxC43LAruXFGB/M/bEXl
         B5/QDSNKL+k/ZgSyuthqAtzWSFtmYR1Yiqib9Lc5ydrvHDA3/5gAW6Tqo0wyOI6L+xnF
         dC9FR5ju0eumn4nPt8BH6dILsadb8MmZm1fFoNJdmIBmCmor+7vCJ9gYJdJgjUKAevhF
         lBMaV/3mSM2Mp65X5tVh24Rt0DeM3FVeVAmoJzV972LucfQtqRumGxvQlDy0roDx95Dj
         SmPI77n/BHBN8aCMsMeXltFp0F58VUUQkFIiE7JynQHQK7vmLLi20LgCGQKauziAocch
         vl/Q==
X-Gm-Message-State: AOJu0Yzv7l1Dt3LW8qPRtCgxoo5nQ+sabHdEm9H91Vonvpkgz2RroCzf
	SN0XUfO+I8/S/JTZaeyMJ2V8cDeFY60/yClHlyb8nM585Y7XE4FIJ0DxNu5IUJSEauo=
X-Gm-Gg: ASbGncsi+iyUe8bQWqYF5v2kIrwA8gh3lxPCezcRhru2Jj9wK9KjyCMyiGRTTrmTbW0
	956artFA3zlSK6e0YQmeSyJieDCB6x0PwvmwJuQ7GKoU+mWjEB+tuJLr0dtEb1zhPslqXWtw5yN
	R9Ytna7un5tC3S8+nZ8KewOTZOcFdcgOlG1D1ZlrBCHqfnVIByGrFqzmANZgPQFuA9e4EXNSvrg
	34NKRocljWvcvpekTd6emr5A4CmNxPaOPd1LRwxLgtON9+6X54c8ksNRKPbMrEwIe9Jb4L0brls
	WEsc0uRpNAaAVr3yQb1huhwj/nBxji0+EoMOzX5bLQ3eXBC71OM42VmhOLBavLYk0L2xIMxGeQg
	7IIWDOgDLBOmNvLkii/aTEIGbLnutQgZ0/NhsWuSEYeOdbjgqEhliyaT4ILeR5HSzLXbLU3OKLD
	La3zKIcA==
X-Google-Smtp-Source: AGHT+IEZDp/cTQkzh9cxMAh79OJkaYdzIACL6/dfy5lNuD3BuayrWignNj/jpDQd1nF/EBwlxeFaNg==
X-Received: by 2002:a05:6214:234f:b0:720:3cd9:1f7e with SMTP id 6a1803df08f44-882384c4c66mr24941386d6.0.1762609212990;
        Sat, 08 Nov 2025 05:40:12 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b290eesm14808676d6.34.2025.11.08.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 05:40:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108040614.3526634-1-csander@purestorage.com>
References: <20251108040614.3526634-1-csander@purestorage.com>
Subject: Re: [PATCH] block: clean up indentation in blk_rq_map_iter_init()
Message-Id: <176260921183.52069.2979400547946367939.b4-ty@kernel.dk>
Date: Sat, 08 Nov 2025 06:40:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 07 Nov 2025 21:06:13 -0700, Caleb Sander Mateos wrote:
> blk_rq_map_iter_init() has one line with 7 spaces of indentation and
> another that mixes 1 tab and 8 spaces. Convert both to tabs.
> 
> 

Applied, thanks!

[1/1] block: clean up indentation in blk_rq_map_iter_init()
      commit: 4cda40dce95a5b4ec0620a84f322472730d01f7a

Best regards,
-- 
Jens Axboe



