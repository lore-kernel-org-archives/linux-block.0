Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51D32ED5C
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635074; cv=none; b=hnpBUvwiQyJX06nASWYvPxQhuFK2wG38/PtfA4cStdq2sCpjUdkByvUlaoH9Ssy/H9rTRskbWmBjy/uH0OECpLMc1rIod6sTHjavb1KPbGeO8gF6OvK5eV0+7nrygi6gCupAtj7JEiJnEQqN7Kzp9SoC+2bUE8a5AyMdsVoKGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635074; c=relaxed/simple;
	bh=EnAwRtIlwBUDMWB22npAHi5k4xLWsYG4FrVUlP76SHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ws16kqOxOgw5RegGgfi75IDRstCfm0EqCaSzM8uuJyC/MxtysPgk3rUVAiMGVWZNUL/k+cmx+Kw+QS0NgeKa0Qo6w9GnnRC06wFXaP53CVR3Qbc5SF6zXx8xJqVeQvuV1FMfXrmcawlZzS0TMy8dDySDx4CF4HLavrdXIivV9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nWi5dsr+; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nWi5dsr+"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-42321c8b8f5so1547608fac.1
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777635071; x=1778239871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxPR8SrPdmEzJCIGf7lc2mEVw5dkavMakfuxT21ny8k=;
        b=nWi5dsr+MhWgWoE8fYE9mJGUdkTcS4F8GJWOmFPM8n/jfv0tSjPgDfpcCyahUO4i0p
         +oZDqmiprsk33K2BrAvGv7Dcs6us033lSwQfKHzt4CCV1Mi3T02TbUXkT2etg0P95QuM
         iSJkhjA5UHFFmYje0UDweX0fiKZTgyaA5oxXp8XM6LEJMZcgWapAVKPvyktDf83K1ZFj
         ezjoRbGAVXrSZiSRb0gkVGMK1bepduUDihxG6Ne8+IhWCkqoka/PnLO7SvbAcplFiQvl
         9U3eyAtBvYT4HsQMDtnijDRU8VfJ5dMlxHsUN8XRty7pjUJ+4IUgA8VO9gbMJ+nI1X78
         wivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777635071; x=1778239871;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KxPR8SrPdmEzJCIGf7lc2mEVw5dkavMakfuxT21ny8k=;
        b=Oa4F3MHNDLZiFD5y4+18jc1S7+C3jrznHL5ChRupXJxigXx72bbr5zQ+0bPwg0sjT1
         oBgE7JY5CTFcMlBZMlQX27WbZCXQu2wslu/bx8evBM9sgRFbgcA2uPexwN7Xsq1Cix/Z
         j0fBcre3eJYue+nwr1XcIqcTIyCMLdwpVmlNFeXR1uWEO4LXQly00UsvMqzpylR7E4sy
         yJ9/u9wJeR3saDDw957H7ZY8fQiXIJC2qQsshsC6n4a/qtByFxVhaQvyOK0atOibN1iO
         qgJESYKaPMgeNwlPhcR91aiwzagSQfiXJYUE17idXNf8a+/9SiT7FYi1fpguyMIWXRmz
         sYeg==
X-Gm-Message-State: AOJu0Yw7wrjMoUFUvsxvg3ZGGiX/YzItDDMdi9HMIsh73dh1Fwbkn0S+
	pwfyITdTwymEeBT8eEe6Ovg5+sY2Ch7XopA2VVBUTVH89bIlpMjE7/YkuTL767gkdv0=
X-Gm-Gg: AeBDiesQkGJTnKvu+38dkQN1QZ5e/YiGPvNGls5RwYZ/Yz6//Gsg3Wvof9DkdLnSYfo
	V/zB1vDoI6egTscG6crjhTkJcN6s1RFJJ2Rx8tUBSHxkFx3dcA95t6dI+/FkGmL+uKJatEhNLFr
	nfTIEm3oRYb284I0xb5hEH2Z0gjyIwGK2pAg+8VYZj/w9uD971hgtpdxrCADBbV5xNkjOrpIFec
	u8EQ2lFFb21HjV5TFL7Fpb8dlmk/teH55mARUpyuxY035FQCKRBQx3QHAiy4JdGvj8E65ZjMDOZ
	jAiObAVljFIkVNFrvT0AfNjY17LDNi8ZTTFM+CRMJOjWhY3n5LoA/B+JA9zqDvcPwLNMpww4HNn
	r+asT1nHYutcgYYzY+r1bsNeyS9KHrGeZjXwygVYk10/DQbn1ju5MvBB5BvwzdR8hyGJREKPXKI
	kZYBwjc7vvJF1hUxbR2v76MmKfBAo0/ix8maIGM+7AcMUBXDddm7YcJ7JO3V5mRsRWgT37MHknY
	UY1MGIF0gSSaco=
X-Received: by 2002:a05:6870:70a7:b0:42b:d272:9506 with SMTP id 586e51a60fabf-43438a53b2fmr2933580fac.7.1777635071373;
        Fri, 01 May 2026 04:31:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454cbc3c7sm2515077fac.12.2026.05.01.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:31:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260501112312.947327-1-tom.leiming@gmail.com>
References: <20260501112312.947327-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: don't issue uring_cmd from fallback task work
Message-Id: <177763506987.181772.6728415392389170664.b4-ty@b4>
Date: Fri, 01 May 2026 05:31:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 01 May 2026 19:23:12 +0800, Ming Lei wrote:
> When ublk_ch_uring_cmd_cb() runs as fallback task work (e.g., because
> the submitting task is exiting), the command should not be issued as
> current is a kworker, not the daemon task. This can cause io->task
> to capture the wrong task in __ublk_fetch(), leading to a task
> mismatch warning in ublk_uring_cmd_cancel_fn().
> 
> Check tw.cancel and return -ECANCELED instead of issuing the command
> from fallback context.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't issue uring_cmd from fallback task work
      commit: 845db023a8aeba8b14315a846dcfba31ee727fb1

Best regards,
-- 
Jens Axboe



