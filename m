Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87992505A8
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283310; cv=none; b=mfRqQkA0Nbk0RvM7LEX+RPsWUbGiMffZOMkrWRrnVZbi41Uug1VoyaZP8hvpx18o/RI51gC38z3F34ctEVis41fflnEom7AkQWSCC4Y1r/UM8RzpOnRAFZ/d1bbamqB9mI6EmX84ngKw9TvrgDqxNYmkYAeAjfcEMrbKJnp2McY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283310; c=relaxed/simple;
	bh=q+Hs2SHkHkF6zcWiQ6yaGSdhUHx4qOoQaWem7F2T1U8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FcKwutmeW0TJrwi9Gn/aA9M8t8N/gpWqoRfxd37ReOaiSEQ672hFUQswSMWmPo2/2X+IHV1F+qyl2luTn3yL66l4rPWdbj67w2iDXfU1DS4wlQiLmRu7JXzkdmTeEHTQS7xfLmn2Ma0TcWtlru910C71UqHlb2M00yEFgLtllPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D24ok9dW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D24ok9dW"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so146903239f.2
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739283306; x=1739888106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdzkzP8yo0lOt6RBy7UoV+VarQja9k3vyWPk7H80DfA=;
        b=D24ok9dWjBtn4w2E3l5wdlHRbynsl5OL2TfrhJJZaVwPWTw3DhsKyMPprUN4QJXrvI
         +GpR2BJZIovOsGyRMZYL4mPFS75ytZHKIZfKdltQILcEJcsQGM/B+AZptOY6nCpHqE4d
         0qNvyhlJXntvOOAgbNWu3TtAc2Kj1H7CRf0AZDdTZztKkXFENNKDS2tBer3dqLyrOvRq
         EPaG7yDzTM2JtMcb4+eh7ZJAUBIZWo20VG327imkQddSRTajinYP3KR1S9pxvrfx1Tgy
         TCtPppym29H2LVj9TpDeO8M6Jq3AK722obFuloXr7DMnn0NEk3Om5k/yx8net+Xeb5y3
         7BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739283306; x=1739888106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdzkzP8yo0lOt6RBy7UoV+VarQja9k3vyWPk7H80DfA=;
        b=DcLHPy4BeDhCzZR2+eNHYIbLTMlr0Np4HKDbQH5e4sgSuhGq0DV1zeS6jomK3jdvoT
         DvDl3l/JMZ2e/M4JoUy/+NzkltXFfewXE353DkwiH+ZJC97TWNa4+jmnrzpm846FhaIG
         +xfwkg1Ah5eOkEOBKx4zbAv53VrsP1Ca58eXjtxSj+kgYfmr8XYYZeqKLndpbRXpTBb9
         z/A1B5iwBk0lx6Cc89GtVRgDBJ0VsK1YYoJPVyTnaFgVmAvNeByaU/VAb6Qygfgp4/GC
         ij/jLw12cJMYFrVJqdju3dyH8n967a7aMutYjt5vTl9e8MJObTK90KE27OUEw2lWQb4H
         C66A==
X-Forwarded-Encrypted: i=1; AJvYcCUW6oT7NuzUiw8xPz7vhHEPZT0vuOpycMu6+vGdHH9oEeb1CfTConBlWz9QtGqGA70EbDVE6yUXO7qY6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+QEE+kkEm6MpmqrDW2DR86G7eFTQKca+r2zdCMSyX5hu8TtB
	ppwGDcuYcD7PhnuDpXt//+x0JDPHHp1vIOxQlBdfGnmSLHKi1E3fn9ZLqXSm55Q=
X-Gm-Gg: ASbGncuuhnXy0YdWy/YeMsUN2ZozrUoFuMt743kLD5LKEyqeSY7s2X4ihRPsU95tVwj
	mblTjZCjokvWzSV3k3XUd/PJvDMAolhjo1l3CXipIsnwne5T2WmwL30j0cKHTCgfTqVWt9sSPUI
	Jae3wzpzJ1aWZS+YdDEELKZ9eZNJdQpoxpy9szj43HTQRX+JdVMJLcYedYCdvBVd76tzYxGBjQi
	IxNDrhZTUBpObjRPP5HgwVBJwBxz0XX+Dy7foI74PaSypKatnN9mItjDruX+b/xDfUk4uhdeAzS
	jPOcUQ==
X-Google-Smtp-Source: AGHT+IFKIGv8EDPyy/7bp1zDbh55ZpYoXpz+ZdE0e8eOPJfgRxWp3vIJRcSq5Rk09f6YtFHhhvtzeA==
X-Received: by 2002:a05:6e02:214b:b0:3cf:b3ab:584d with SMTP id e9e14a558f8ab-3d13de9fc27mr131337185ab.13.1739283306581;
        Tue, 11 Feb 2025 06:15:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d14f21094dsm18094365ab.67.2025.02.11.06.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:15:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Dan Schatzberg <schatzberg.dan@gmail.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>, 
 steve.kang@unisoc.com, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
In-Reply-To: <20250207091942.3966756-1-zhaoyang.huang@unisoc.com>
References: <20250207091942.3966756-1-zhaoyang.huang@unisoc.com>
Subject: Re: [PATCH] driver: block: release the lo_work_lock before
 queue_work
Message-Id: <173928330541.90490.11671067114197076767.b4-ty@kernel.dk>
Date: Tue, 11 Feb 2025 07:15:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 07 Feb 2025 17:19:42 +0800, zhaoyang.huang wrote:
> queue_work could spin on wq->cpu_pwq->pool->lock which could lead to
> concurrent loop_process_work failed on lo_work_lock contention and
> increase the request latency. Remove this combination by moving the
> lock release ahead of queue_work.
> 
> 

Applied, thanks!

[1/1] driver: block: release the lo_work_lock before queue_work
      commit: 3bee991f2b68175c828dc3f9c26367fe1827319a

Best regards,
-- 
Jens Axboe



