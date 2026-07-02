Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA547CC70
	for <linux-block@vger.kernel.org>; Thu,  2 Jul 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995323; cv=none; b=Bd1yyFfPTo86NPtTYgAb23dQOjEG3W6G/+AgHrDM+hdsVOKWJlztrToomSY00nxIA1jK5UyebxRZ3ucaJ/TuAEVyB9gnWqcy86PT8OW4WE6PbkpSc2U4P7Ie2DwHDpgAsCPsRKqrfs1gzx89vn16ElHH5tr8B1JshWWB3jCmn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995323; c=relaxed/simple;
	bh=ruYmtGd3FKJO9r+U3ejdHzLwnzkjaC9rxSO+Rb1MDMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VUOrzhx9YtZbjxjabY7aTLJabQEfE+oqv0o83UY0WRrLCO6Ct1q723cZSrR26s+HyIlAeeYpxBU9MkiQEmsXj/KudH/B0nGWERGDQfgpD0hyyCfGNfVUZWc7UeHpbN3UscVGkJw+snaPp5pxeZTkmKfWhpBhWQk2RszHR/NEs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PeVU59fr; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PeVU59fr"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a192afad7dso979299eaf.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782995321; x=1783600121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/mTbWKm6JkXqziF6Zm2uc3WYcekUTsmBhoLn827wYs=;
        b=PeVU59frIKU+vjfFvZWgLOg6su0VENJwM1QYP/LkL0m5SUUXT2PGDe1myCMnIOubJn
         NKn8jtftPWL6dF6kL5wCNIauWQKo7u/mnX+V50X6+y5+9GUXk+qjNrAZ1JkjtkcE94OZ
         +SjGkdYvC/lizOxdsvOOCuFffeeUSG3hkeMskK5WCkFUR26QGMCwzL89EYYF2P45gIFt
         53ZQh5tlFWbg3EKwNc42EXHBFXYOYeCKc/VkY82coIJ/6qTm3SWtcxk6J0Px1gOXWH9s
         OCdp1o4+YPVCAVlG9Q1dx1CBLCL7Dze1SHGfiMM8tok61ZzfJnaDADTCxRmXtqkidKSJ
         cxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995321; x=1783600121;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/mTbWKm6JkXqziF6Zm2uc3WYcekUTsmBhoLn827wYs=;
        b=KOWWnoVYLPIoVr3epL1t/R0OeQ/DWX2clr6lE8dJTkjTirjOrpwnOI8cJcLuOofWwZ
         1s+nKzkz1cq2FwEkQ0jMNaRh9zRqeOaImaPkFT7xDuYIqkIKRM33tWeUbYNwF5ZtXKVH
         NGWL4LHc2DpHRQnLyXFlte0aDkJ++3XgJ8gTY5YGv14d/t7o3/E2gbFxbAkNI0sMVNrq
         sodsHhZVox9Lvmg+XnR+NeH0u79+gsT+CkFVSqtA0Ln86bt0TpmpCW2rcsxGAPATziVd
         ONYrM/DJKH6p/z9DAGxqjx+w4lq2LJ4ttJuxj4VLMYCxmJF+EF5QCAFPvIBNHiVV47nH
         RB/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fjLxKcusMgU6jyxE14sTliuUv6m5tV70AcCxcVXx3v8ClDgdEo6SqzuDJC8N+rYkrJD3dLVzfwF2SYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYvz160I8h/l3g/rcBBhoHX7PgrDfzgshtCZezxKBg7oJGv/C
	TBtMUnk7aXd7LCE5Qir5E6UHldH9i4gPtcXfwTpjWWnFoccIZFYeaj0u7zbEhGi+IsQ=
X-Gm-Gg: AfdE7cn7cBNLu8bPaeV6XxoPY2llLwgAlR49a103nyPOOCXPPZx3LwworKn8FWlZJdr
	iBNpCWdUmiKLEz1zMjc9LThkFKN8EUGsdzFxyJun3Pk386NrdlFUT1WpLKg1aiBdZF9SuLbjXFG
	dkgVum1fIfONQAjtD2Azc4nAAee5iPrW+Ru//0zdyQBwDyEnaGyfdmav0QffQrdQNEVmy5yZALN
	QL6Zv04kqJtx9p6/+WmdGAHfabkiBwnaokxJ4HkSTxr8mNe15w9G2JUrPo6fYSogVjiY58mqT1k
	+rni3tdA8q6/QOjKJ/gc4adpR9Kt+jf0le8WmscediPGcQRXNgSQ/mvBrmyxeO4bsdDdmPsX5lV
	Eujf06PIStMlaGXm0MwATnJfm/Ws05ttQe15qtgO2oRQSz1NZCnJvZy/871op5nP/YxXIOon78I
	wfqa0W4WnnPk3VnfagQ54gFq3a+PFNA/w4Xz5+KAJYlhjLPUo7lNZB4oi1vSG9bM9GWw==
X-Received: by 2002:a05:6820:1a0a:b0:6a1:4e1d:5398 with SMTP id 006d021491bc7-6a30d745473mr2946928eaf.4.1782995321326;
        Thu, 02 Jul 2026 05:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe84efefsm2623259fac.2.2026.07.02.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:28:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com
In-Reply-To: <20260630211827.50475-1-alhouseenyousef@gmail.com>
References: <20260630211827.50475-1-alhouseenyousef@gmail.com>
Subject: Re: [PATCH] ublk: snapshot batch commands before preparing I/O
Message-Id: <178299532009.108615.15257400425085643970.b4-ty@b4>
Date: Thu, 02 Jul 2026 06:28:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 30 Jun 2026 23:18:27 +0200, Yousef Alhouseen wrote:
> The batch prepare path rereads its userspace element array when rolling
> back a partially prepared batch. Userspace can change an already
> processed tag before the second read, causing rollback to reject the
> replacement tag and leave earlier I/O slots prepared. The
> WARN_ON_ONCE() in the rollback path then fires.
> 
> Copy the bounded batch into kernel memory before changing any I/O state
> and use the same snapshot for preparation and rollback. Commit and fetch
> batches retain the existing chunked userspace walk.
> 
> [...]

Applied, thanks!

[1/1] ublk: snapshot batch commands before preparing I/O
      commit: f01f5275feb77bac9fefbbf7cc584fe0b3850a92

Best regards,
-- 
Jens Axboe



