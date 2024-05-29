Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C7215CD6E
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018738; cv=none; b=kaXq43to0kvxwCLaHdStHHe8+XMO0oCwjxDjWUEa+mqTC18MbhHjSybFa3INYl/x/Hj7wZFTAyhBbeDueVLpyqYFec6X48LdY21OlBTRFBoc5RAla4ESNBHPfiD6+qkhCwueHBZcQrUeyVeFIizcAMnitYVS30EFzyIGBh2ji2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018738; c=relaxed/simple;
	bh=Zqe1KEJHB3rwoYKx/3KGVm/S7L7gvPYh3VlZ7RK87JU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tgwKgPTvgYctXZ3TgIfA36WVGM9EoFAeEYumhjGjEJClPP+d9TksU578UcGYUQ90l1VE4p36ddZ13D32e1ubNsdoQQxHPRvLcTnmwW7vYVtAAJlfoTxjGErGTnfvkOF3dHtu7o4UA3cYep0aHbAaakwn5Gv9cxI4juHlm1M4rqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bt3x9727; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bt3x9727"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e252b2cfd8so8342339f.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2024 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717018736; x=1717623536; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zqe1KEJHB3rwoYKx/3KGVm/S7L7gvPYh3VlZ7RK87JU=;
        b=Bt3x9727YHiHvu5R7lfs06yzGkSoSIWkKgMsziLDXwJJz3hfSIZlPe0WLClE1ksIlc
         RyADHC6KN4ROENdIc9OOiYNh9po+P/KYfTNWm6hnA9aSVOeUootpnwRLCE6Q+e7jsJra
         wVYUTd1U9HBp+mpIf8q+5/iXj6pN5zARbM30E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717018736; x=1717623536;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zqe1KEJHB3rwoYKx/3KGVm/S7L7gvPYh3VlZ7RK87JU=;
        b=FAcH49UfX1EdjV2cvqKEs08py37aLdf4SF5YH26H0eJ6BrcNOB/tXlrE6Gg6h18eIE
         UmbUa5VD4SnjGRI3YbPzimaKf0QVaR2M76+zp+p4DuyEkg/Sgm9+e46KqYWv73f9eygX
         Cu67RkcdtAaq0r+lTcB2cm3xCUanqO1E07+LtsBZXbF5pfC7nGt0AnueOy3y0RY2kAfs
         I8l4Mjwn0LaR3Ebx3wo2i41o50BFUG++kL86eJgJUPVjHMJhsSA7j1MTz76VaDndf4uj
         yLnpyNVhW2Xqka1ti95btRvcRiVedf14shsQ2T+Rr00FAELI7nTUYHc8QBQP86MdDFev
         JZaQ==
X-Gm-Message-State: AOJu0YyjWwXeqOAQnuIZTQLHBO0qnegNcpta6TiCHtHjpEn+lslEvT1T
	MU32lhj89eUTdW1XRmrKlgGc8SUFOZMtroQsnEy400PnVuBBOyf70FIFCUZkf8xdf+vfbfm0q7m
	kC2U5YgYnwcCAaWPlWJK89yjvcLj6uN/gqD4FlVIdWFfPF2qlZA==
X-Google-Smtp-Source: AGHT+IEWKG4MCy5fUCHJbLbMir3CUlKH6NmIeMT3866YbgqpLAurX3mhGss+tTmswXqloRFxApysTs4/bITnav/5mEE=
X-Received: by 2002:a05:6602:2c94:b0:7e2:1e0:3352 with SMTP id
 ca18e2360f4ac-7eaf5d3baffmr25445139f.9.1717018735846; Wed, 29 May 2024
 14:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniil Lunev <dlunev@chromium.org>
Date: Thu, 30 May 2024 07:38:45 +1000
Message-ID: <CAONX=-ecX6D42pz+i2YLKg_B4GfSnPE61YpuNjH43Rk8pWDoow@mail.gmail.com>
Subject: [RFC] Imposing minimum response latency via blk-throttle
To: Linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I have an idea of adding a blk-throttle tunable for cgroups to make it
impose a minimum response latency for an IO by extending the
blk-throttle mechanism to delay reporting to the request completion of
IOs that are completed sooner than a set target. I wanted to get
preliminary feedback if there are any objections against the idea and
what would be possible alternatives in case this extension of
blk-throttle is not suitable.

I did consider using/extending dm-delay or writing a new dm-target,
but that would limit applicability since the dm-layer doesn't
pass-through partitions and would require alteration of a system's
layout to accommodate the throttling.

The motivation for the proposal is the following. I lately started
experimenting with using blk-throttle mechanisms to simulate slower
drives. That simulation helps understanding the sensitivity of complex
heterogeneous workloads - which are infeasible to analyze analytically
- to the performance of the underlying storage hardware. I found that
blk-throttle is a low overhead mechanism to artificially reduce
throughput (though the lack of an ability to specify a combined
read+write limit is a hurdle, which I also want to address) and get
somewhat representative results. But throttling BW and IOPS can not
cover cases of small synchronous IOs done in critical sections - which
are latency sensitive. Thus I am on a lookout for a simple mechanism
to impose system wide latency throttling to simulate latency
degradation without the need to alter the storage layout of the
system.

I believe there are more possible use cases for the mechanism, alas I
can only speculate about those.

Looking forward to hearing your opinion on the matter!
Thanks,

-- Daniil Lunev
