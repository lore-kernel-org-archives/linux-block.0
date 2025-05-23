Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634529B0
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013550; cv=none; b=VWmbqMCegNYJWJ4R9926V8SkJ6sHNwYm011udLaGJjuNFV86136oPwszM1Ayo4fEsOPmssLtAHFDT9eP+4fs08BWrkLKw8zYFF8030Uq0W/vVLXGUaRzrPh6sE9QEjR3EAhPV3V8twgkWCT407hL5LVLN+5SOFDowxznsdWNkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013550; c=relaxed/simple;
	bh=LyF7JqFiKS+BuUXVk+WN8BIjhcFoTOf396PvgVQ7Pu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ahRNtK7v7D21hBGKTkp2Cqw+CeWGdZjVSAFZGCZpjNgJnSlQNRl7kJJZSf4ljEISZK+3+GzNpcawGgEv2SLBomLqfDHnK4sqB2oyBNeF/d4UXWic80VK04K+eKZH+jLqVXcS+5NN4wFddPlJ81IpasDKrtfiCVEbSii65B2ZJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0tAZ3Sdv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0tAZ3Sdv"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a052d7897so610612939f.0
        for <linux-block@vger.kernel.org>; Fri, 23 May 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748013547; x=1748618347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T6SuAVKbFnUVFhOsLRnpVJLJtk7lk8+HsrZWLh36og=;
        b=0tAZ3SdvFBeo76djR139/DagoXg4dJIMWyMgY8t1WMMc0PPWqqHBFXCECp9nIi9FxI
         8q7wiJAmOLZUeFzSdixw/oTgyCgiftaW5QuXQ8pynmexNMYCY7PfinhnGDTSuCbb6G1i
         F7Aq9gnuTI0Xe5VGY6XjLWNyTBNKb0K2OcVTUnruQzAF3kKwGC3ZjkscnvGfd9ZS/sF/
         hoIIgXmrXgls1R487t6LIDlQAHGssrhml6+qZ9e5qB9YnODsfqZ5nTA/+VjPK/SzbSot
         AjAsdj+0hrdLkpRGJFF1P5mPwhlLEkamCnwdr1pGHqGBKXl4ic0C4hBdgZP6azMitNtN
         5yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013547; x=1748618347;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T6SuAVKbFnUVFhOsLRnpVJLJtk7lk8+HsrZWLh36og=;
        b=nzqptHSvQczIHan5TowTz7lRa53viTLAIuJ7+e2jAeKRO/zonwWoezfac2ZGPuSlzH
         zwTJPvYfQGBsCt+nROpumh4bZx011HbP/VrpmZSzYZr7dhvsVgeQQJL3ICMaNv1vl7Fy
         Jo0yjirYNcy+3k13t2wjAK0svP9nS+UK24waKOmY7x03ef/2sHxxjy1OPgtOJlYsRA48
         +snjgOCyCc7+vxez3kgdWBetcBNX8uPyfi6ZyYDibAzA9fRBtWTMDN2JdZ4kbatgfcG+
         Zekz3l5G6tuXyz2MM1gFa4VJqvEXKqAz+JbTznuH9YY+K01Jxp/be94UglPzbxKKaLwS
         n/dQ==
X-Gm-Message-State: AOJu0YwqkCgoY1/N2fsMDTRA1BwlRmjmknMDFy8wQKmQWMm8l9PtMJ+l
	2hu+M7kVIHm9IMQ6x6SesF0Yc5d3m1l64j0nNypY23ro7vKb+TpWM+8kfRhfSpGFRuE=
X-Gm-Gg: ASbGncuocQASxsGHK0RMXrk2w6uq37QDWBJ+dUttc++z3kCd4Jsq1RptrTIFrADO2Zn
	LHiDNQkkKWtgHO2Mlzj7Vwc+OCPDPLarZkeQXl21NB54gkLdlPj8+rHCoMbtTzdjIfLcl72g5Rl
	D5HtCJXjPJvjj3sljD0teMANi2/RqNHINn3UFkIN2fdkyILbJpSJ/yA/BuVGZQ7J3aoyIA0nlgY
	daZIKMaMcoNQpj2XTfoBbV5SuvOKiNjdiapScQlDe/QMPyEFpt32hl02ghd/6Rew3t6QoGvX7Z3
	MspvmJtdXLjAICJywnzFiHglp4wH9NNBucKy98rPvA==
X-Google-Smtp-Source: AGHT+IGMkJJMLPdEFg6uRpbkU7uGtHnNW+I6GL0eTPNLOTq4jnVPfrefdbYMjGrfNrKUcbXS0ta7rA==
X-Received: by 2002:a05:6602:4802:b0:867:9af:812e with SMTP id ca18e2360f4ac-86a23199d6emr3417519939f.5.1748013546762;
        Fri, 23 May 2025 08:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5besm3615633173.13.2025.05.23.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:19:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, djwong@kernel.org, 
 ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
References: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
Subject: Re: [PATCH v2] traceevent/block: Add REQ_ATOMIC flag to block
 trace events
Message-Id: <174801354522.1277456.4481051172399472027.b4-ty@kernel.dk>
Date: Fri, 23 May 2025 09:19:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 22 May 2025 19:21:10 +0530, Ritesh Harjani (IBM) wrote:
> Filesystems like XFS can implement atomic write I/O using either
> REQ_ATOMIC flag set in the bio or via CoW operation. It will be useful
> if we have a flag in trace events to distinguish between the two. This
> patch adds char 'U' (Untorn writes) to rwbs field of the trace events
> if REQ_ATOMIC flag is set in the bio.
> 
> <W/ REQ_ATOMIC>
> =================
> xfs_io-4238    [009] .....  4148.126843: block_rq_issue: 259,0 WFSU 16384 () 768 + 32 none,0,0 [xfs_io]
> <idle>-0       [009] d.h1.  4148.129864: block_rq_complete: 259,0 WFSU () 768 + 32 none,0,0 [0]
> 
> [...]

Applied, thanks!

[1/1] traceevent/block: Add REQ_ATOMIC flag to block trace events
      commit: 927244f6efff6df5f8f2ab58c7d1eec9f90cc3f2

Best regards,
-- 
Jens Axboe



