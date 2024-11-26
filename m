Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF226194080
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633218; cv=none; b=J+hsPoU76gIu4WR0eIY49Op3gkWRFKyyoyaRwGNKZxU3UTYj8FvcPHDOXH5Fwpflau3V1aWXRHYcypBaYVa75xZHeqKokAjFIjUOi4ru0YlmV0IajZ226tRUNGJew9/PXL3KRKP9Fm69F4x9tE25jqNpcPrVhOxaZDXEen2KkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633218; c=relaxed/simple;
	bh=vQc64H6dus9+6n4KaTboQCph3sU1AA4scCmq/mg+L8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OHSBN5xNlEQup9ZMUYWUO7Li/xYeBTfOzs4CfWYA9dYbKK0EGqSGAEQwjoYo69upDeqAeYnzUgkbWspWfS/iDnjjJAoTP+vh3+k5Ou5zQzoBNPiCBpVDIiREtVA85DJNcy9BA8Gdmlp/H/quZIOOyOra+kaS7PdBh3z+yfMVVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X+suDjdc; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X+suDjdc"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-296b0d23303so2651850fac.2
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732633213; x=1733238013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HVdWHwCrCprNwEZK0DLtygibNRWURNhiUZjHNm92dk=;
        b=X+suDjdcIw7V6zzOlHdZ5aMs4ecK3u6lLjdqc2O0bhn811fHhXNxD9dtk1lPKOAeMS
         kFmBaxLrFp9fqfwMAyvFCS0+AJE00Nd/tOl02FuER4+FSfMZb9el/6pn7XJBx1PTUxWe
         Yg2D6Fhz+e6IwVBr/leukSzMeQnOQ/wdWSB9D0xdkCx2ImbZDJrO4ucGPod6Mclep+KN
         X/Ttta3Itrw9COf7JWqkDu+Kh30X7xaNXsFsJZo6KP5AxO7PNEwB3CNcL4KqTTMuzopJ
         d6DjFTb6y81ZzHPLPp4e+Qxf0PisjUVfH49Qo216KUdblF5RlXgYw2DKvOF7VzzLfabq
         sfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633213; x=1733238013;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HVdWHwCrCprNwEZK0DLtygibNRWURNhiUZjHNm92dk=;
        b=QkDH5zD1g7zja0j5CtQnnLqCo3RlYhTUGEK2YO2Zkv9zx7JgEygWBwdLZnaGLqq7BV
         DAxaEeBSZAOVWdUKvO6hKt2YXHdsLEf1oWtSA7S01sm1+r0NjnyflkQNeP0dCdKxJjKB
         igxUxUJMcGAIj23RChNb0O5MwGGLcXaFr2j50qL5WC4w0J1Ms/HOfYAcyg6wcGcVLZ5V
         eTJ6QU4lCMLfDJh2HPNAXxASyyc1pGj7lBXbCTVh3GU74T8N7cmE5UuVEFiYjX2EksX0
         h21ELEMDjeNs53SGgkCm1MGSZKPj1QSRqmjjp3tW0dtNWjovp9DsEevyRVGWDqUpL4k/
         WnOQ==
X-Gm-Message-State: AOJu0YzY0M+ty3hv13mAF5SiEVu8Y+/htowoVD+FNbjFgWsXNTyHIHVt
	FFGQhmbMM5YlFN5GlCNy958763Z/l8oL8mUpdx2L4LXDvkaP1fWbxD1iiM/bYZKBd9gLXXUfYme
	aQk0=
X-Gm-Gg: ASbGncsz25vd/+AmGaDP6NCB6zJjOpHTOxuoYcLjUVQeIyTQx48sEU9x6a7btYzw1yk
	25dwyuX7lMVg0A2ua8hWflGLUPXfnvGQwJ6fKhgwRkP4ZFbY7dKGaJG8frxHqzbHTo2LUC6ZNw5
	NKfchANkCzEuYr1dSsC3hyyyojBl/y2Y9fEnd4Ni1k5wYo3/Ehrucp9hQpENwglH1yJt0kJGA+O
	gexQFhGA50TiJiPOEcYscAsGOnXjds3rg9XUhMy
X-Google-Smtp-Source: AGHT+IHNtupxhiJ2S77yknA6gGpG85EQIZXF+wyv0NRunoW9EE2Sm0J0z7wgyqh0YlLsWUoEHmvtDg==
X-Received: by 2002:a05:6870:a104:b0:270:1352:6c10 with SMTP id 586e51a60fabf-29720e7b034mr13929501fac.37.1732633212573;
        Tue, 26 Nov 2024 07:00:12 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d56cfdfsm3998512fac.5.2024.11.26.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 07:00:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, 
 Chris Bainbridge <chris.bainbridge@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20241126102136.619067-1-hch@lst.de>
References: <20241126102136.619067-1-hch@lst.de>
Subject: Re: [PATCH] mq-deadline: don't call req_get_ioprio from the I/O
 completion handler
Message-Id: <173263321174.43959.4593607425854902492.b4-ty@kernel.dk>
Date: Tue, 26 Nov 2024 08:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 26 Nov 2024 11:21:36 +0100, Christoph Hellwig wrote:
> req_get_ioprio looks at req->bio to find the I/O priority, which is not
> set when completing bios that the driver fully iterated through.
> 
> Stash away the dd_per_prio in the elevator private data instead of looking
> it up again to optimize the code a bit while fixing the regression from
> removing the per-request ioprio value.
> 
> [...]

Applied, thanks!

[1/1] mq-deadline: don't call req_get_ioprio from the I/O completion handler
      commit: 1b0cab327e060ccf397ae634a34c84dd1d4d2bb2

Best regards,
-- 
Jens Axboe



