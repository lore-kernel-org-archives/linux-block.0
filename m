Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8F33DF
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119946; cv=none; b=T5Uxj7VU4IieOaV4Sk0nF4yD4OnacsUGAU8LUpRHpEhDbNNtrUdqAWgpm/ymYicFyUU3EinmdDDngVMUlQovekhk1BjV7IgH8/fQ3MrW1gUGjC+PCh0CqlCN40V18u223snyoh8Dogd+boMcWLbD/KUMVxNbNtHEfjSoBqQNcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119946; c=relaxed/simple;
	bh=TjIl2/33bs6RwTfiYeZL8n4d3JkXGlZVTl/oNecoK0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IyCZYNbHgVHHof+fnLWo8/M+HyaqZYYfJDHsQym/wDRBnTZobdyhDR1fjWv4PrGRh00V7m1qYHD8Dm/45gBlaaMfPszMiEM0zct7Hpnjnl9pVEDa06unNsBl7HUoY4FFY3N+hsAl+cFaKCpjlRO7pUZrPWN810FnLPT/MMdTWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rRTTSiI7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rRTTSiI7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70248a0a420so3400b3a.1
        for <linux-block@vger.kernel.org>; Thu, 30 May 2024 18:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717119943; x=1717724743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxgHarzDtgbT8/ObYTgg1m1M6VzyS5V0Ao63Wtq4STU=;
        b=rRTTSiI7u53wQKiX0lG8yYtwmhCJwwVWjjJl0/fgPIcT6PjhFvCRX2vR52q4DaxI2O
         xdRmc27c0OLptW2rm7/Fkz33Wi1giXuzmHjDWGIsx9W/xYVBmvKKS2LHK3ftgLlrfSDc
         rR8FcQnrO1MHtG69vxlg3eVIF3Ikq3a3otscx7CcrdjruVBPdcXSLo34DYpnGt241g7p
         obcxBjxZaBnmW2WIg4FYA0LAFBtX5Fs3p3bj/m/J7M1wPkIJvZ+Y+u/+DG6qBFBr8Z6b
         6353esA4txlPVlkS/CmVzQg645+GHjqZ1i8hWTLZjSnuo8wCQNkm7ACT5O5dJxQW/5ed
         9htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717119943; x=1717724743;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxgHarzDtgbT8/ObYTgg1m1M6VzyS5V0Ao63Wtq4STU=;
        b=FAjvQzzHIrnsCLu55/LNSTgBuTubaJv45TKshkoVxlnqHMLOdOSYKiepaIh2kcZvSh
         BufmctNQ2nW2s0BNsbX6hAaE6/tkqTpYx8cPOJhtNGD00TYdHzIa1S9eXvlc8BR6rTUg
         tBiviEZS+2W7ObTESLy35MXEZpTF8u8Mt/5QUVss2MDgEaBXU0DaeZcEaipQU0ta1Ku3
         zfEnDe/8tWadqQZPg9r6Fcajf3NjPmYWYtPmbasafdQMUOX9fBdAIMuSPDHY8yTaFTkT
         JwgswTkmnJdgyJIoXSX9CtY8wbgWkquA8aj4EQpK/sqjpDtKG3lw4CVjkzCsvLrvQJLL
         Nccg==
X-Forwarded-Encrypted: i=1; AJvYcCWXrrehldRpyUsgs1cWRd0Y2h1RAb9yZ37u745eRfJq19/xeppFaS2TqB4Gv1BDwbqSToW/hmOhU3240vKi2Xw0QoyhAUtR0vpAGts=
X-Gm-Message-State: AOJu0YzrDByaLeFREqGQESCDH4hL6sV59edfM1Kpc55EbjC06Q7GlUTT
	2cu5P0Z44c+kVZlEGxN0jPhAdgNw0EJ1NSU4cqdoi8o822NSFH85JHnXO3DPFuM=
X-Google-Smtp-Source: AGHT+IEYopcm3XTog2VzN012UH39SJ41KEHhDRmBEvl2J2WnDc6b7TxZOlgRFb2wNcHYmLVQs6ieKA==
X-Received: by 2002:a62:e116:0:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-70247899e76mr542825b3a.2.1717119943064;
        Thu, 30 May 2024 18:45:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb359sm376354b3a.5.2024.05.30.18.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 18:45:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Justin Forbes <jforbes@redhat.com>
In-Reply-To: <20240530134547.970075-1-longman@redhat.com>
References: <20240530134547.970075-1-longman@redhat.com>
Subject: Re: [PATCH] blk-throttle: Fix incorrect display of io.max
Message-Id: <171711994168.606218.16094424745811206145.b4-ty@kernel.dk>
Date: Thu, 30 May 2024 19:45:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 30 May 2024 09:45:47 -0400, Waiman Long wrote:
> Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> attempts to revert the code change introduced by commit cd5ab1b0fcb4
> ("blk-throttle: add .low interface").  However, it leaves behind the
> bps_conf[] and iops_conf[] fields in the throtl_grp structure which
> aren't set anywhere in the new blk-throttle.c code but are still being
> used by tg_prfill_limit() to display the limits in io.max. Now io.max
> always displays the following values if a block queue is used:
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Fix incorrect display of io.max
      commit: 0a751df4566c86e5a24f2a03290dad3d0f215692

Best regards,
-- 
Jens Axboe



