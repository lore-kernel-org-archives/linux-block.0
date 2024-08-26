Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6806199E9E
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703229; cv=none; b=l9lBw/6cJoG1Mkbftz0nHwu+vrkqts7Y4WjZJDmLWdHB3GtUTr4Q15b12VOa1ZCx0P111F6oqy8P566lYnp8u6sNkmly3SKeYk8rh/F1K7By5+rJCFw3LWftM+FbXdO+WzpfuzsKBTMYumdBPYGQYR5MX+y2uPtdHH15jaVsNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703229; c=relaxed/simple;
	bh=dWd5qv6eBqkAl29vi+ZlXsW/zewDNUzH8lPaDyWvxkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rR4G/3/scN3sVy+27vkbYK2DMc2CK4Xr922RjeMmwQuKSW+r3XSQipxuXxTALAB712I0NmNqu4RTQnq2C46SDGfu8YP887vC+q7wZcE7/jjvrdOycDTs571UPiwsGR6agbeEQUhSSQUZ24FZCcLWbRGw75PpWcgKdc+MTas+22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Opd4iwsJ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Opd4iwsJ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d37d9767dso16712985ab.3
        for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724703225; x=1725308025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IudeqtVAq8N+IIPnbH3rPVPQhvZk+3E2+WjQQtP0t1c=;
        b=Opd4iwsJdBchTwYeG4GURQNo1OtuoLUux/3KwpliLmLv6r12HiAl3dQHrnToFweDvh
         ObYr1fyKBhnhF1BTPn6E7WE1PVJXlmgwoU1zq7GYejcBEo5GXVhQn1LzuoOcpE13ojDy
         hxDqMiOvJdamdxwDebrYeP1dUBhYM3yPALtG273aOl78WjC3u9kmPgsV4fe2Esl2uUeU
         7Tiu4hLiwBPMwYolXMDsgGCtQI724km9rnooUgPfxqr39/IDMfYw3ctBydOAaHT9Hn/h
         PbPdjXTy/PRVHd+z9KqcohRH/zVcdElnMHLNjRa5U5pH1G9GKg5XLfSVs1X5dp9JD7hJ
         En6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703225; x=1725308025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IudeqtVAq8N+IIPnbH3rPVPQhvZk+3E2+WjQQtP0t1c=;
        b=gp5+K/Q/rAKz13Lf3GGYT7du9Qz6YigAS/USKglvY/UnAmf48iyXNnGXyGqHkkCjOF
         mRkIWMoEGxYNYF6zQGQeA3AAmTI6tNQNLKraK12TPXjJORWlN2XjhNG2pKzdimP0h7gO
         00QWkTWs6v+y4vJgtqWIt9mmST6EDZ3T/Bsu4WZJ9q2kADopBATJiWeS7h8VnHWlXdIT
         lgtDpwVKhIXmeI+URc5k21krCzrNd3YUczcoYvvj9GGO/4n5N2+qJLmUao1y1GN08bCo
         yXlxuPsZhh5uxsQOH+L0FLZkXHgiy2R5CLzFhrXjN1N4VXCxuCBUakFC/1XBaUSq2wsR
         IwGA==
X-Forwarded-Encrypted: i=1; AJvYcCVRav5W2ro3p3R/hMjR52KUFxE6w8H6DdkTGntwgrpJVWDWF2I5ksCfT5leuZve/N8S/WSqU/ZlnElvXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jFxVqOo+SWvKz92FXoXZWHkrZNXJQ/7SUjCjEjZIoSGarhxb
	mmtbTmvCEmPBbPrp5RfvR7FZJC+gJM0XqZ85o8fLRhm+d1v/dWaWgwKyXKZyykBsIfSKpDwelW/
	e
X-Google-Smtp-Source: AGHT+IHAFmJILxeAH8CPDsKKgho4CjhO/zttTxjz1xDlDIe16dflTQ7KHxmp24dTv/r+d7RYkXtOlw==
X-Received: by 2002:a92:cda3:0:b0:39b:3387:515b with SMTP id e9e14a558f8ab-39e63dd8e0dmr10459335ab.1.1724703225554;
        Mon, 26 Aug 2024 13:13:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f5ca7csm2361772173.63.2024.08.26.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:13:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, Konstantin Ovsepian <ovs@ovs.to>
Cc: leitao@debian.org, ovs@meta.com
In-Reply-To: <20240822154137.2627818-1-ovs@ovs.to>
References: <20240822154137.2627818-1-ovs@ovs.to>
Subject: Re: [PATCH] blk_iocost: fix more out of bound shifts
Message-Id: <172470322478.220079.4635873970554219426.b4-ty@kernel.dk>
Date: Mon, 26 Aug 2024 14:13:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 22 Aug 2024 08:41:36 -0700, Konstantin Ovsepian wrote:
> Recently running UBSAN caught few out of bound shifts in the
> ioc_forgive_debts() function:
> 
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2142:38
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> UBSAN: shift-out-of-bounds in block/blk-iocost.c:2144:30
> shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
> long')
> ...
> Call Trace:
> <IRQ>
> dump_stack_lvl+0xca/0x130
> __ubsan_handle_shift_out_of_bounds+0x22c/0x280
> ? __lock_acquire+0x6441/0x7c10
> ioc_timer_fn+0x6cec/0x7750
> ? blk_iocost_init+0x720/0x720
> ? call_timer_fn+0x5d/0x470
> call_timer_fn+0xfa/0x470
> ? blk_iocost_init+0x720/0x720
> __run_timer_base+0x519/0x700
> ...
> 
> [...]

Applied, thanks!

[1/1] blk_iocost: fix more out of bound shifts
      commit: 9bce8005ec0dcb23a58300e8522fe4a31da606fa

Best regards,
-- 
Jens Axboe



