Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573429993A
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430732; cv=none; b=FjPzOQlSeQbHv3Ik22JXI2lk25keb8PZRd8mnyu7HW7Iq0Zj9sARcmzMiMdNUorYFG5PvtIYFYWlhKWs/KVa5AU+kx6imXVtAosEkfb8z7MugpzAl2kz1vlUrE37F7p2sbyyBzWds4M/I3rX980S1RQKK/uFtIggtGSbIZJMhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430732; c=relaxed/simple;
	bh=101D41jmWYkV+zFsW3b7QLgwgu/houCEVy2LvkK9l8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iaLf9KQvLnd0viS3Ifxs02imV0n6wtam3cWU/z1LiJia5X28wpa1EsD4oVZ/S9j2xLOUgdPUh6RWSEyYXWHQUzRQouN9h8ytlCoKCdctoF9zoydtSY5sLzYcVYMirpq35YuK6kO6GDx0rtUXkfnh53w93kaIa3JI9JQzMt1xVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zZuzExnM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zZuzExnM"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso15574965ab.1
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430729; x=1758035529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFJzjlzQQCyCcPFb5G6GjNX4A5H/YmeDr19NbkN72Dg=;
        b=zZuzExnMVl77VNm0dx0EDb5HfbKbSqCjwuneFTOHv5V6Fu45ylzw1SOFNAqHQXN5zD
         i5pd2DIGvSyoTQAl9GObJUFjJptI3OJ9peiduRf7WRL2DRWypxpoBZlP7Ulsm0Ii/Ugh
         dpUlIYNGG5rq8oGu3eeWMjVkkw+H3jdfNHbh9HLUHmxd0fdghsp88Sgzxz6uN3yMnHHh
         pb0DBcmFUgN6CN8FzCe8Bo3h2DKN5rtJsc15UvBePAB59wU//5BRZWE2STtWtrkDsxk5
         HsJcaDLxummjrp9iihMA7PFKLIEuQVGfu526aItdFAaQ0VIdSiJMLJn8s7ojB1SjDd9P
         hTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430729; x=1758035529;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFJzjlzQQCyCcPFb5G6GjNX4A5H/YmeDr19NbkN72Dg=;
        b=aFSD4zH41OMteK9C3ZNNCYqHZeeLo4YK0kV17sCLdE+CmEh/EyS0kM56XX4lK7+vcr
         eTaWPiD2Z/2KfqAaqWNrLRc9gCadGzrVSihOjEKWtWjqYnJLyCZHUPj8dyJP2b+wDgWF
         Bxjh3Xk/zbyY7izWd2bZWUQdJH5n6YPEDHQU0fusrzeJXlbONrg17WmhJmzwq5eJtE3j
         KyZ3/p+4HgDHLly6/F/XJsBdX9U9UVlp5EigrCpjDgzyXGZ0jGSa2Mi1kQ8bnFT/f9BH
         wqiSm7DBg52xrXodOFrLZDyTEbyol0/CdYOcHx+iX08CanLNgEe9WArqvif+V6OpPb55
         lzTw==
X-Forwarded-Encrypted: i=1; AJvYcCVUae1AS4MoGAoP2aTPqQOUvpYUW90F7y3BCtmQvs3cE3QYG4lolOFUxQ+P4do4UGhqJOHsdWRU1pPuNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUs2G5HsiYfhSRx7iPmrHNIBmeCc62TuEGmLNDt3GZpPxDRyhb
	L4vfZUI2LwMgI3JziJ+zcsUmloXaGeXs/gBav7U5rtLko4UnbYIIe8E29CkpTDgGv3c=
X-Gm-Gg: ASbGnctNMG8XZ4QnmJBVoYlVcN8bsr1VI+Sn++20X53Zp6ec5brwItyj+2S0d0kLO7M
	UuF9OUgGZnAXPAXPk5R+SziMyZL3RfRwHLZQj2JHrAvaUIIOk9+Usc/Rbgcojr2wKAKlSLXk4fF
	97zkK/46vI6BfDS1rY37TvuCwS3l2hfK86Wy744EHY+A4sy/ybVJ8p4ZK7NgfHdQpQ/5BLnkpe3
	8NeqzuNL0ctcND3FxdvKhb5fSH7FOVxp+iuCXtB8BluKSKNhk841X0URLJW2l9YdV9+yXPVnVX6
	XVG7oaA/XFsEZF3LeQo8iVDcokztye7GWwa+k7FRne4LASA863QVnkk7USQmN5YZxkt18FaLSZ1
	WU6ap2nh6BFhy0g==
X-Google-Smtp-Source: AGHT+IFgqzt/9I3VONQyoxVxbosvYBwChRjjNvp98cCppEYVcKSCDkzbvqVGEoph44lNL5D4uJ8LAQ==
X-Received: by 2002:a05:6e02:1fe2:b0:411:2f0a:edfc with SMTP id e9e14a558f8ab-4112f0af257mr31296945ab.6.1757430729112;
        Tue, 09 Sep 2025 08:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51020b6d937sm7590679173.80.2025.09.09.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:12:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>
In-Reply-To: <20250905085141.93357-1-marco.crivellari@suse.com>
References: <20250905085141.93357-1-marco.crivellari@suse.com>
Subject: Re: [PATCH 0/3] block: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-Id: <175743072839.109608.9014903338772554601.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 09:12:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 05 Sep 2025 10:51:38 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied, thanks!

[1/3] drivers/block: replace use of system_wq with system_percpu_wq
      commit: 51723bf92679427bba09a76fc13e1b0a93b680bc
[2/3] drivers/block: replace use of system_unbound_wq with system_dfl_wq
      commit: 456cefcb312d90d12dbcf7eaf6b3f7cfae6f622b
[3/3] drivers/block: WQ_PERCPU added to alloc_workqueue users
      commit: d7b1cdc9108f46f47a0899597d6fa270f64dd98c

Best regards,
-- 
Jens Axboe



