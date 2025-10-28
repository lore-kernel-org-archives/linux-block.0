Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852E24676A
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659788; cv=none; b=ciIUAjghpUK00wmUREit7Okkg1CTbwUQTKbDwBfi7Bhut1fqv627ybMDz5jPEQlevUXhexzXNWyblw0m53+wJrHsUIHayBUP/f/ymLBMtl0QiFPlTMSf24GOO4QREE/cbTDZMqtKKHNLY3HKipclxh+IBJZjKLWyqwxZzfqiLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659788; c=relaxed/simple;
	bh=Ot4LFi7LbWmwt0mguA3UZcXFThUWLrjK4CdZFD8cIbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sbWPIBIqbhcFcFJlqI9P2Yr2q3ZAxviYfoyEvrWMo5k+F9jkAxNuN6IMv18RTm+VMTbSsRb5b9XpTAb/d4GJHjopNl33YKXP2M9rFJUOEUeMazHzMtHTDIiJtE0WkLU170tXxGMyxRPI60fX9inW2aDj9cBsDYM+FysOKaofx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VAvlyFQ9; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VAvlyFQ9"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-945a4218f19so114699339f.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659786; x=1762264586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6wbtY81dSRy9MRbXywZEcg+tILFhq9XFH05X9o3f84=;
        b=VAvlyFQ9QQRCC425AO4NJAsc73DdyHCfXLA7v3qOhxD2Binv7rT4nf1djxCGLv7RfC
         Ltzfjaf+fcGdxLmgm6ncMsN8PIQAJ5WOsWRNyhkXVXk5dwWc3nnh7HOK5neY9nDxDhUO
         15dAR5CRKhJYiZctZ7/ji/hnfS702Ishkf2/0UYQ6cLEDnpil1loi20pURkjSMqZB9UP
         gjajbI1g0Fkv5gk1oVzZQmGe8g4zRi9RTj63uy0ZweJEY0kV2wVhaBIE2CFEPD5VFzsG
         icIb5fJo/HTKPRodfUHuNsFqHRIKv92m6SC1d3k+ha8Y9BTnIFxDchtc8y2dAa61aBoF
         VrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659786; x=1762264586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6wbtY81dSRy9MRbXywZEcg+tILFhq9XFH05X9o3f84=;
        b=v9GdWzBDNQU2wmDXQzoq/satuhaKS3zjehD0pFZX6WzznuXFQK6PzHz064Srvr55ak
         jVb3jvnXUCUQYIKohFYoGNz48jIh98X8ulT1+2ceF5q+HmN0lkNKg0OI6ug5ybeBaEC8
         1lcwLVooPDtG+iN5at4cj0bgIaiKBUWuMh1l4VedcWC7vdFDs1AYD7rndGJy9LyV6liY
         /6beKanIveqr7Ew9NU3ck1nVJzOvemoLnZU28K4XNN9okMAxfNvNQXFBn8Z5te/6Ietu
         vsXMNjXNL/KUUxxQ3thQHf5wBorn8NexdTLbcIIYkK3u4XV2mP1wS4LO7UtF1N5tjwSN
         +X3A==
X-Gm-Message-State: AOJu0YyKkaFSZmeqUNMtlkKUAIDptMDeN8Hr8mNWu7jJbFtirN/FBY0y
	JiEvxt8LE9pXHgkT3TYU++c021tWdL2NBwSY8TE6ZiGloWylRXKhr6y+QSPc8e9spGc=
X-Gm-Gg: ASbGnctmQNBhlCsZrStN4v/x80VQtL/+MFMeQFclyGNCGdNMd8+mH9U4lg0au9k5Ron
	Es4WBpTtLT7qfl2E68NZ43+zjUfknemwCV5f2TPs0gY1owrRY9Ahx4q3g82T59aZktaSrUvVPnk
	WqxnhKboOtTymLc6AIAdnoxPYj7/WkBRi74C0r9fXQmw2EM1fSpsK6BCk+du8xc3TGw1lxKuLML
	8TtkqEvqeQqNdXVkU0DnsfN42+aSbiWJlHfRxsRK2RpmQ73Ul3WOFCv+pG4nzAMPEGV1FbDPHZr
	yDC2CTJANebNunNGbcnSa3crC0r9xCJyWmI8tPOwl0Eb3o/iJaLvT+zn+Ij0VJnAFtpGW7/EBWe
	SEljwJITHs0qyAG0EInPUI9OflUsTfebL1QFNiBHOO5du0Y6OpkD9ZT9iHgwbxMJuyF0=
X-Google-Smtp-Source: AGHT+IHpi9fcig8I/C6rD2AJbhQFmZg/nFKgIfZMbtIO4JewhOuBYnH/9ejDEE9esj3af+RKBhxDGQ==
X-Received: by 2002:a05:6e02:1749:b0:431:d83a:9ca with SMTP id e9e14a558f8ab-43210421462mr40304595ab.12.1761659786327;
        Tue, 28 Oct 2025 06:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6714f2esm42905325ab.0.2025.10.28.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:56:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes.Thumshirn@wdc.com, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 martin.petersen@oracle.com, dlemoal@kernel.org, 
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
 syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
In-Reply-To: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
References: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] blktrace: use debug print to report dropped events
Message-Id: <176165978538.275475.690120789162912071.b4-ty@kernel.dk>
Date: Tue, 28 Oct 2025 07:56:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Oct 2025 19:46:19 -0700, Chaitanya Kulkarni wrote:
> The WARN_ON_ONCE introduced in
> commit f9ee38bbf70f ("blktrace: add block trace commands for zone operations")
> triggers kernel warnings when zone operations are traced with blktrace
> version 1. This can spam the kernel log during normal operation with
> zoned block devices when userspace is using the legacy blktrace
> protocol.
> 
> [...]

Applied, thanks!

[1/1] blktrace: use debug print to report dropped events
      commit: 4a0940bdcac260be1e3460e99464fa63d317c6a2

Best regards,
-- 
Jens Axboe



