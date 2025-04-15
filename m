Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9218A6A9
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744563; cv=none; b=F0IrsBD4zDxjhqLow1N3a3gBETu+hu0ujMLC4FFeQ4dVWVn6li/tuU51wbnus7gUEBMPGyUPi8AfzXERYivXCDy8PFc2ycqkRjbPAd1UpUWWN5V6gPkQjIe47bWpoQHvVdOTtQJNId1a6pfgZ6uiyYTmJMDPEyau8m1PTFIHr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744563; c=relaxed/simple;
	bh=9LhhQK7SYYoB04N4KaGT0jYG3IqgAZMjCvvz8yGafZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZOEw9WiTYhInCWhphj12JxvwvWYyBeyWT6ncA7lr95weE5xAOsjdynX8C431N6kLM6F66ERnGKcT1PMuIHlarZFXZkP8sdV98ABaLgNydnPJXEWGb5jFaopVkWtWXL/Eillnt/v9GKSXZc3ZmYXR0KfxTa0FASV5ollD3dwi82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hQM8uGmf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hQM8uGmf"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d7f111e9e1so38741025ab.1
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744744560; x=1745349360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asgUBCNF1/3nLCqRhE9iKUJT9+CZgW2jKMxY6rpof5I=;
        b=hQM8uGmfyz4swHbASYgN+i4lx/0vQUFmxTVp9Xhtx5IkAKkj/ND1pauID0cwBnZLkB
         jGVHvwX76whYhJ8NKHlIg1yYYq0N+f9X1zu2uxkvWMYTGE5m+jkIL++iFUzcAcLBl+2x
         7xQksbzZpbJllk23ktXAJJaq06GcqMTxAyG+FeOz+hxfsm8+4r5KJOjUtDtgzqCyM4Hh
         g0BsrtMxmE/fOgTXrO9EhVCH8nMHZAy5zBqq4KHKQvs8qHClK/Sg/5pYS4aJIdqZiRZ6
         +69iBbcThAo3u9qbh/DIHZEdYdYHcyJeUVUXMvF5P0F+uDGPnxyXIn97C2rCHhKgg1VE
         qyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744560; x=1745349360;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asgUBCNF1/3nLCqRhE9iKUJT9+CZgW2jKMxY6rpof5I=;
        b=VN1ZpQ1BDMJyIHMm4NjAZOmsGINKtqhJLfWQqoAfx32L4gqLz/m6ldVgIROngObSgW
         0Opk0KfUvRcod18LcD+NelvfOHT0tIfbrAROnYsoQFbdBXRSW/hjHceA3SOeDhnlmwvs
         c75r3OnPV9FdP7L4qdcgM31BvoyJW+psvd2SXawdMzQ19GHmtu8oxK2Sl7e4kP1Qm10U
         6nE8yv48vRqtnKxTgAQ+zR7J9MiazaDyMV+I0gOF3PHQ/XBMgX14eDcwewsGoSmY0px/
         0hn38ReisGwvGwOoNu6XzOfWcbmDBwUkqzHNXedcBGLLHN3X4FBIUhb6nv80gKvE1157
         1zoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwUsliUoFZZzaMHa7XxOTJ44bBaU3GTxNrGKk9+gRwdnh8sI2KvBERotWIEsGzhqmjlkFOMi6SAk6U1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDituLhCGJI5fUIteqwz7rFYRd2QYF6WX3kqxSN0G+MKOaIdYV
	6pZktJ5oSGDSerOECPOrBxd8iyzzwHDvwGq/lz9Hd6c95RU+JWtyXF5jKdX09qY=
X-Gm-Gg: ASbGnctACwG32tFw3sZSIFPJKZWOYOAM2yHolrbrh88p6dGUadg1oJrt8CcFwY6nlXf
	DvxlkWxrKhHjIPtdl8DGsLcAezy5GPF6q2Dkkyzg/sr5//rLFDX20DFbPjd76hEeShGZjZakbHh
	33DJJMvuVLEKojqZ1A0VLXeJczOMlOSMRQ2qgG86AxnF0v165N1r8EXefz0BeuromSkbWe7vqu2
	5A3+gYtLevZUFVlSeG1nPeW52LWrESjAm5+Gotb0dz9B+3xgu6o+vnpJJpxrKUxImqSt5f1o82y
	jz4ah5qMEmbxOlV3+NmRV228oiAHT2wNHJKLlCedTo8=
X-Google-Smtp-Source: AGHT+IFJPt64kBMbP+3d+i4X9X/L5HM104ENBBE+s5Z3gjU9DWZ68WPXVZk2YmxhXWiQnU/bD44xZQ==
X-Received: by 2002:a05:6e02:339e:b0:3d6:d145:3002 with SMTP id e9e14a558f8ab-3d8125a9e0amr7085535ab.20.1744744559647;
        Tue, 15 Apr 2025 12:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d80b6b0392sm4898535ab.63.2025.04.15.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:15:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Martijn Coenen <maco@android.com>, Alyssa Ross <hi@alyssa.is>, 
 Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
 Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
References: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
Subject: Re: [PATCH v3] loop: LOOP_SET_FD: send uevents for partitions
Message-Id: <174474455866.197229.13564340998714651621.b4-ty@kernel.dk>
Date: Tue, 15 Apr 2025 13:15:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 15 Apr 2025 16:55:06 +0200, Thomas Weißschuh wrote:
> Remove the suppression of the uevents before scanning for partitions.
> The partitions inherit their suppression settings from their parent device,
> which lead to the uevents being dropped.
> 
> This is similar to the same changes for LOOP_CONFIGURE done in
> commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").
> 
> [...]

Applied, thanks!

[1/1] loop: LOOP_SET_FD: send uevents for partitions
      commit: 0dba7a05b9e47d8b546399117b0ddf2426dc6042

Best regards,
-- 
Jens Axboe



