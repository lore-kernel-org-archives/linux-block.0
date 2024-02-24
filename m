Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F34C634
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804140; cv=none; b=Ywi9v8YUS6dUlRQOueTNqdCL0Vsipzw6eaT0afSUauVJLIr/FfJEF/cRhYjU6Ay102EZglzuvH87APizdjdKdgdwGNeZ6GeOrwHi5beoIV2p+Z4tmeWDXlxwXsRnpEFBC7A0b5RPh5NcDUTlNeCoh6f5fFyGfMFZE1goYGWIh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804140; c=relaxed/simple;
	bh=o7Jjs3TaAPlouujgnP/cSfzC6OWeJ7UN9H1QdYLOBSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xvb1As4XfDhnumCH8o2YkqpohkygTQ46Rpdsp7ogi4HN3hQNRmyMAHj/VlI2gFOtgfP5kitp6MRTzm9WSj4lGoUekFCr2VIoRdnMcJlhwnp1Xwts3mnIO9h4yighniO5wAfgyqs8xwpr+DLx38F2o/cAkKxoPCS8GR4+Ivw5qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yE3DBTUM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yE3DBTUM"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d862e8b163so738159a12.1
        for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708804137; x=1709408937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUpB8lafalL38sJImqCa3LAl1ysZO9xWvK8Dx/nTsgQ=;
        b=yE3DBTUMjVDVD9OLGD9dLMXEk9MvPtZatr/oeyaLvoZGNkKpiDQan1vLZZZ0KnNpTO
         OBBGog7/tDJinexi2FtVS65v63BNPPJHOsGqKOFyJDEXdeDm4ljQRoYvtpB3Frwm27B9
         rBYEj92TOe1dsgCLyI5ZXL2Fpp5XUsBqPlvgBF52hQysz7NDT31eclF/vsB9P4HfgfBA
         qLGz80jc1/BunDiiwAYagcHWED97Nj2ihG2zdLO5+6k5j7QTc7adhA6SLdP7KlZBnHWU
         Imoo38Y5bM9S0hl64V/RTt4gW17HmD/aci6A9LPO+F8RKEXl1tpiiHIqdoJ+Na6WGifr
         U14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804137; x=1709408937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUpB8lafalL38sJImqCa3LAl1ysZO9xWvK8Dx/nTsgQ=;
        b=tDwqJjwS4XFqfvyrdQoTApcqbwht2DIzWBrJmc+R/UUeyZ9aH+X3EJslqllH+68KQC
         F3Yp6dejQCRIBo/TFoxPTJiunfYqGA+Ov4l/RS2nZxctsDlmh7C+1kOVKVTgDKq1QnLZ
         VDJl4KdLaB3+pjcnsrVGNS1XQPw/iwJK+aFqKtfBjRtM7xrRjsRr4FCW+fYci3pkBM2y
         Lxn+YgosSVUt+wLTsVXZgcd4K2EtI/hSqibdUsSq/cvDzyBJ+mcmT6WQROwQgl73Itou
         7WFaKhE9Eu181FEHh9WYkFEXm0R4jYzjPstnRSbu8oV1UM9XPNpbXA+W1ymlMDCdJynS
         oXPg==
X-Forwarded-Encrypted: i=1; AJvYcCV4RNjsaTkKoqY601sgFWm0yWppbErykucvoWPgXi/PYonXNBQdrE4fied2oPfVoXKrFfM0dZI8D8Wu3EMxB5rujhwlqI6sfRqmJFk=
X-Gm-Message-State: AOJu0Yxbh/WM5POjL6hoA/aZWHiQS59oARPQoXz0pn6/GGU8BJq3n55e
	EQ7z9Cgbc71vg8MFV+gmjxFZS+trsn1IzxHqK/7PFqCkU2IISl8FvRM5NpGnTvQ=
X-Google-Smtp-Source: AGHT+IFVUPzXTU160JAO8/8pMC3SuLnUckq25tDL2fnU6xkHvxBiLRbMM/oZSCdQET0JtNFc7OofYw==
X-Received: by 2002:a17:902:eb15:b0:1db:5b21:dcef with SMTP id l21-20020a170902eb1500b001db5b21dcefmr3556474plb.5.1708804137356;
        Sat, 24 Feb 2024 11:48:57 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7472:2249:6d10:d981:9c6f:5d24])
        by smtp.gmail.com with ESMTPSA id jk23-20020a170903331700b001dc35d22081sm1345691plb.50.2024.02.24.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 11:48:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20240223155749.2958009-1-qyousef@layalina.io>
References: <20240223155749.2958009-1-qyousef@layalina.io>
Subject: Re: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing
 IO
Message-Id: <170880413600.87395.3583257732140064720.b4-ty@kernel.dk>
Date: Sat, 24 Feb 2024 12:48:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 23 Feb 2024 15:57:47 +0000, Qais Yousef wrote:
> Due to recent changes in how topology is represented on asymmetric multi
> processing systems like big.LITTLE where all cpus share the last LLC, there is
> a performance regression as cpus with different compute capacities appear under
> the same LLC and we no longer send an IPI when the requester is running on
> a different cluster with different compute capacity.
> 
> Restore the old behavior by adding a new cpus_equal_capacity() function to help
> check for the new condition for these systems.
> 
> [...]

Applied, thanks!

[1/2] sched: Add a new function to compare if two cpus have the same capacity
      commit: b361c9027b4e4159e7bcca4eb64fd26507c19994
[2/2] block/blk-mq: Don't complete locally if capacities are different
      commit: af550e4c968294398fc76b075f12d51c76caf753

Best regards,
-- 
Jens Axboe



