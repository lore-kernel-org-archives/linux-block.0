Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8B36B05F
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342666; cv=none; b=n5JtxZsxkkif+yjbLRb8+W5mGfGb3FrNcrgieOu1wBGQshY+kjwpV+9bPRazfXsoGcoZOR4Gh8MOYGK2qvqB6bI69Hw3Y4FiYy1Fuqk7WvTm1kjKWM+6LXpUTctY0jdz9HpHXqZL9vgk+NaDas/ZZv3c3D+8AlDncUEBL8lh2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342666; c=relaxed/simple;
	bh=6xJwD16IDJRZDQYHif+SFrdSoYC07tw5lE7UhNAkGMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UO+FSIZkedrdzAQvhYF4pMhR3L7dSP8R0ATd0AXLx7d6pl8HomgKIS8BwhWyT6tTVNX78mc2o0K1SdAEwYm2IvxBpm08+l733DQcSY7YNnRwNBAVIbsZpdQ2PmghHG1Pg8jU5KALDDwDPBuJXjawgA5L0s44dRmAxLmlxW8MtBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zJpJ9j6H; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zJpJ9j6H"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4638e238094so1936823b6e.3
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771342664; x=1771947464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tci0PLQEn0PJVJPz0FvG5ueLsMUUWMKAN2gZo/UYijU=;
        b=zJpJ9j6HJy20ywEe08SaAGe4bm5FHVmn5ZIjpAMUVV4ZyUTht6SW/BI9nEzJd7ic77
         DitBg64hL0VnoNcE63zoRPpnzJ3vIKwUDu9BLrSA4PT/4nZ6zzjosc2VHC+Bz0FNbNQ6
         xtITuN5bVza+HjW6o9XrHhK7Ao7ugGGo+9Tfx8GHCtipHYTW+1OT5rX4R/RAcPB1kJ3V
         1HQD04fpUmwCJv3kUB8D7CyNCxKNz0+Ly1+p9RyJgjuc95HlpVX+jH3wzWCvTXJz5tpR
         TIA/u13Vhau3XzKXSMiG6zmnL2hKD9iEvdy5W1aZjPSrecaXTnmjtSzEna2iLxiI/pWf
         k0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342664; x=1771947464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tci0PLQEn0PJVJPz0FvG5ueLsMUUWMKAN2gZo/UYijU=;
        b=pgHLJiRjffcR4MVH+74K8STi4/F+qVHFPYNJ+HjfAmhv2316kyk9fLELO9KAiaxxiv
         4TrbXmr1gFX09QsTS8aw0JKdAb9jxj5OBe0dvAQmhrOBQZBKTkhZHA3VFq1qI3w0CCPV
         rAGZLQSXRMjTfJVd9MyzCzXCLLUNd1RYkXGnfUQUO2S5fGjP8yllnAVOTP2Wo2/kKdKy
         FPoF3pafmyRs+ajYn+HjXp/OzNvTD5hjuVCe62l/bi0HkMjJTdMPWl8KLdkjlyrhR0Hc
         3YFD/9tWqILLX7czWncYlzX6ukZWg5iw29Ke9jx1LxAQM5p8NEm08dEfQCOQTYu+/leX
         sBxg==
X-Forwarded-Encrypted: i=1; AJvYcCXd2O+dg/6TWtnXXNBNSa/AkJGluQ7CdYaHD/R9FdTnvkyf43HiJdZ0yDBDyDP6PkQv9Xrb0jyoJeXAtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHU30WvBJntedIIBQqc0YTggMFqCPLJ8v4C8pD4WN49dEEdVX
	DdITthX2MFV/jS+15DjV1lvwmFkaK1fkvSqki8zJWtSb16CM81j93nDqMbdWuyidhjQ=
X-Gm-Gg: AZuq6aJetKfK2jAK+62GEnnhDBXcUt3N/vbH3zFz2kjQEDl3Zyz8Eq3yQbpQMr6TSfp
	dCrAldQJklGo17QF1R76pUWHNqQ+C52JsTGXKGpHZe8TUnc8SS03P6nkLecBY1VSC27cdutqwZr
	1VplKO9zjEIOwC67/u0ljyjYfhBfFEK6WO3Puj8mDyiRbs/7MhCIkQUWsVIg25YfFX5kQXB6N+9
	RufR2thMb2fRDBcUI0fTNLdsSXoJ1LPdZXCIjmGZpc+5/JqbcjqTHyEMucaUOTZWVIu1Ca2s5D2
	fxL66rgKV9DF4v8+Sxx/EbjQSdfNYvb0YPCqDvTDcHHkNhR4CoyFBUQ35QVDbRcAjdDMj/ZuZG9
	Y6szC0/3fJvpgnLKVu5IDO/ozP2HIs/uVSabBijKUOSWIR9vwQOuWkopfnp+0wN3KFUAnb57Ujm
	heaxD2iAefE2p7cUHoqrmCiZuM19A08qAnnwfJ4aS3sJSdBL/gktl2a1ocFXrVis83hW6b4i23P
	XA4
X-Received: by 2002:a05:6808:2445:b0:450:5e3a:6f1a with SMTP id 5614622812f47-463b3f655e2mr6138488b6e.20.1771342663817;
        Tue, 17 Feb 2026 07:37:43 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f18df8a64sm9718229fac.14.2026.02.17.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:37:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, ming.lei@redhat.com, hch@lst.de, 
 Yu Kuai <yukuai@fnnas.com>
Cc: yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, kbusch@kernel.org, 
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>
References: <20260214054350.2322436-1-yukuai@fnnas.com>
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-Id: <177134266269.373694.2745476582847973429.b4-ty@kernel.dk>
Date: Tue, 17 Feb 2026 08:37:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 14 Feb 2026 13:43:50 +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use NOIO context to prevent deadlock during debugfs creation
      (no commit info)

Best regards,
-- 
Jens Axboe



