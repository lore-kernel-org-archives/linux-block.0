Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC422417F0
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659790; cv=none; b=rt5DmF62q/KlNeLwXUtHGLwE0ROZ9jabnwZ7/9dm7EMl2Y/KrroY/73GSfV2vmhX0qEpOvzfTd/5rJLO2D5rHzbR5J57KyJFkWc/ssiL9CJMZbcZ2afA11EBg239fwMDGQwkplvc5+H5Cvu0rxXUGq1HWOofEGSfws3ul7grlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659790; c=relaxed/simple;
	bh=3yX0PMRRsPge/Jf2DkXrzdJzwEPUlKMjqZfym+bpR10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JDiq+S6iDl7Y5UlxI0IGigK4m4ZAn4jLBo1vicRDjmrpHdWgKhOqPNUmgfofTEX12KCWxEW/sXm1Hr3vgCm8OjMzsSYBpnVD3Uu++EEHxi6lFIEO8nalJEEnV5bnBQB00elHmhDhPxJb20FaTwqwmMYarl13OeH1jyNP5IBo4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cEArvhSN; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cEArvhSN"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-938de0df471so584836839f.2
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659788; x=1762264588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS7aVHySoC26X2g400yNRMWOdQPkG+s0cofDF7UbIHY=;
        b=cEArvhSN5eWbF2JynGm7N3q+pTQwKOz3+hxp5EKFw6LEiSzNh5RjkgUh2x+RQ7r7TJ
         rY5+/Bd6BABEi6LtOuncgm2zegbdv0vAj3/1vm+wKQItZRshrPe63RUckHkIWmsHnL+p
         zwZ3tl/T0NWrFpeDVb3MDpjo0xEQZNnC26GWFfR5zXu02aDdfsRSCoib8If4+BVtVPlg
         jmqcmMH7VYztdByzFAexJUvN1WF3mfyj5ZVE2rExf4+AOg7s/AzQW5+Ak7nNrWT2nD3b
         LRlygnx21eOnOETbRQgq2IB2lDx7+d3srbLOI8HUZOBso2/zDHKD7jVPhns0LA7dqCer
         foJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659788; x=1762264588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS7aVHySoC26X2g400yNRMWOdQPkG+s0cofDF7UbIHY=;
        b=smczSyo3iYZb5adrLDnl6kZdvMLeRp9EhzYuarWjWIA6aO8avxNIqMjJYx7McbQ+7u
         gd+jg+q8AVNX7GBSMh49U4OIpCCxE2pbqQLc/evfCEKtbuDkEfURp1cOuvGcI4jxxJWL
         9nlrVWM2x8bnacwfw6JgZ6lcBDRSvoISIh+Cd5vxhSawpo8LVbgLqiykv1H9i8vTBA08
         v8/+lwjUynRkEcABxF5ODEVsJtsKMLa+PKsWFV+sXchl+v7XNVU/NnTlX8qp7FKFkbov
         barYsHQ6dYHSWjlN/pr1MSgq3oYLycD07qP3E0Msg6Zhmdal6RbjfAytK+Q9VmwLIvg+
         YKWA==
X-Forwarded-Encrypted: i=1; AJvYcCVorKNPdZ1U6mGCqmom8dmCcr8J0wNJdnoWupLOzGz92svhVGDy7wuH2Uk+6tO/XMgrvpZp3ygmF1n/Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxl7QSWs/dxKmOTZg99PqmSv6mWrOAClaRPam8AgvYT+JOVl1E
	wavUUHyR9K801NHoxPVK4m2lirF33l4FOLAXGfQoy4vc70ikbm+/wtdNCHbRaOYA07A=
X-Gm-Gg: ASbGnctagcaCNa4jlUayGjVC0QXBUPjm9rbwyncOyKTwSXw/Fs4DvAkIAadqTiVmfi+
	lV13w4IoPt9Ne2hzsNR4TmuEOHh3sH4ZpaU+KDx7vOHYo4eNQ5OQDXdO3LteO0fiB768A+evhmT
	gEbOvnTPNWMr/mkPFlva6h7nA3lenow4rT/lUGhP3eqeEmBlJ1+wMRltkZFh+kKMtObIRbZkhtQ
	+ZBSsl5m1QoCb3DxynMTRld5PvWdzQpF3k+HxHrx7UBpimy8atrdG7hFG5ThljyNU+d+emrBo73
	q2kVRKU8kB50NgDjQBmEF1XlgQXPdcqkQaysDklHpkPC5gu7Szjbro5WLXdueCFhfZKKots6ZtP
	Yk63mkePq7dzg4ON7woOjS4YIFmxFXKL8vODOEIJczHQ0zannBUJ+rERq2zRFhLr3/NJvZDpbmd
	RrgQ==
X-Google-Smtp-Source: AGHT+IEdc4xGrJXWc3tHAJipq3aqm80R5GD7jsg6lZLjvrViIKttEM81bBaIDX6JIfhx3esdcT1a0A==
X-Received: by 2002:a05:6e02:1fce:b0:431:d721:266d with SMTP id e9e14a558f8ab-4320f87863cmr51014765ab.31.1761659787946;
        Tue, 28 Oct 2025 06:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6714f2esm42905325ab.0.2025.10.28.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:56:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: johannes.thumshirn@wdc.com, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: dlemoal@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, martin.petersen@oracle.com, 
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251028055042.2948-1-ckulkarnilinux@gmail.com>
References: <20251028055042.2948-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] blktrace: for ftrace use correct trace format ver
Message-Id: <176165978646.275475.8893961838089059417.b4-ty@kernel.dk>
Date: Tue, 28 Oct 2025 07:56:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Oct 2025 22:50:42 -0700, Chaitanya Kulkarni wrote:
> The ftrace blktrace path allocates buffers and writes trace events but
> was using the wrong recording function. After
> commit 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2"),
> the ftrace interface was moved to use blk_io_trace2 format, but
> __blk_add_trace() still called record_blktrace_event() which writes in
> blk_io_trace (v1) format.
> 
> [...]

Applied, thanks!

[1/1] blktrace: for ftrace use correct trace format ver
      commit: e48886b9d668d80be24e37345bd0904e9138473c

Best regards,
-- 
Jens Axboe



