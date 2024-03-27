Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049712F58C
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556957; cv=none; b=Q2I+GRlXWIgwF/RkesYzZnb/5vHCYjD3jOU0+cHiRwjaatOmiihZVsa7V946J7VgTuBMklIoOT15ZenAWVkQQji6N943exnBzroqFB/NHBHdwSxwp33LDA3DGIicqgSYpaYt/PQPdbBORqGiXJn1nQzWChxFWkIQq0JOOhHVjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556957; c=relaxed/simple;
	bh=yzKmcrqxgFemQy0dfPuenWcZqlVFJ9u4XKYFhp7r5LY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t9Wko1lC/+JUqrbl7lz2xB4+AcTryK19hOGsnhkAOv3S8CBJSR5cHPvH6EbyPuj/8oAbnbhyvcbjK9U6Den2ovJ88SWogussr/uuPOESgZjY4tDoopP4Sfr/2x3V/AudkRWz1ILhgUx8N2UQgKY4mORjTHhvgHCjz6MvUGZQDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uHMkgmZu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uHMkgmZu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ea7eff5f3cso14851b3a.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711556955; x=1712161755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IzTyaxEwSLWGHKB2lU+u54hh5UjrFpDvHA1AagdmQE=;
        b=uHMkgmZuhhtr8pcRQrcqTsPkNXHFyXjmLwy3tk9brIfmMokyWTJ4oJUM7TI7hgra4O
         JmcEt1uGsfR8v+o0EuCBPZ7X0UVmURugb4yx1lYma8z2/8zoAwVqRqeR+MDYGg+k9pnc
         21Fvizd/7BM5aGcHngVjwYHKEkEdKx+vfzwAgsxH1J7E616NDE8sYoe7/MDSuKN0TEPN
         Y2dvFEaLD0mJ0na0V7G7C7s2JuRcVyMisVsUiSq1g1o+BIGpQgXCicawPBfNXFjQ//MJ
         yhvuDJWWgBgG0s7XoTtuIVRHv+rQNBT3muj7l9ws8a7wWW53K5BUdLmtMla4lATsYCxy
         lMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556955; x=1712161755;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IzTyaxEwSLWGHKB2lU+u54hh5UjrFpDvHA1AagdmQE=;
        b=MJX7VixRo/zPQl1DbyejMQYKxn9XA8XkKmMa72N4aasMDojdMFkfGO65m/JN6EcRGi
         XlYvoLQgTn2jKqJuyXqaapRLk+ln1X2oSmuGQh4f8z5WCsGQsBCDlBs/ByrMPQew/C8T
         vzjG0LLhDojVw2CrNa23zDfJspvBzuiEnvtFERzSnLDv7D8VMX+B5mcx75iH359VPEAK
         YR8ZVKFQlcX28dr+JNVp7BhxpHmhKK7LBJdY9D+u1f11Sppx1uDWqL7xUfzA4MMKprCK
         LfRyQLwGKQ6vQRcdIYuDWidJQSRzZQoSXv9eTIEw8bXzM2ZfR1EcM93ook5DFXN7s9MC
         7rKQ==
X-Gm-Message-State: AOJu0YzT6JYHdvtE9ZgYyeaGVioIPungJYpwMM2CQkZwfFybOixNEcEM
	XEBmwazrNnRNsHod0cJEnJA7QizJTdqAHt+HhDY+Nlr/Oml9FHksdJxPoiGFZDY=
X-Google-Smtp-Source: AGHT+IHvHfOO2nxh6smPSQiUPrNZXci7ylhmNv/x9FGT5+lxx/s6twPlVStZdyUHvqtrVAv5Cqk6KQ==
X-Received: by 2002:a05:6a00:1828:b0:6ea:b9a1:63c6 with SMTP id y40-20020a056a00182800b006eab9a163c6mr368591pfa.1.1711556955165;
        Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:5ff4])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79829000000b006ea75a0e223sm7998068pfl.110.2024.03.27.09.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:29:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, 
 Juri Lelli <juri.lelli@redhat.com>, Andrew Theurer <atheurer@redhat.com>, 
 Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
In-Reply-To: <20240322021244.1056223-1-ming.lei@redhat.com>
References: <20240322021244.1056223-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5] blk-mq: don't schedule block kworker on isolated
 CPUs
Message-Id: <171155695404.507853.16905998627647073688.b4-ty@kernel.dk>
Date: Wed, 27 Mar 2024 10:29:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 22 Mar 2024 10:12:44 +0800, Ming Lei wrote:
> Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
> for specific task, and it isn't expected to let block IO disturb these CPUs.
> blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
> CPUs is run for blk-mq kworker, long block IO latency can be caused.
> 
> Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
> WQ, the responsibility is on user because CPU is specified as WQ API
> parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
> and queue_work_on(cpu).
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't schedule block kworker on isolated CPUs
      commit: 5f27f3d892743312fce237958a4194859ef93d69

Best regards,
-- 
Jens Axboe



