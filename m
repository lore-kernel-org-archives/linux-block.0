Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49311CA9F
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424319; cv=none; b=H0ghqVpXcc04DRCrI0RCKiv6geDWZPMMJIgwKQOdmbdeYS0FPzijOM8EDaaSOgBthDNsaI3ahC6UKz5YOlI+SDi/Gt42kS5MsxIthBH3872UlfNW09p6QWc4KLrWQhco/VQz5/JD514tVGt4mR0d5FJ+2OUr3wMJVCiVCLCltwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424319; c=relaxed/simple;
	bh=EzGq4CAIyuPivzAKnK9cT206XFZLx0RSCBYeBqadKqM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=CFa0nBUs+t319Eili1S++d8HoQHy+LQwGeBt0ZLXShsP+VqpJPhuwJmF+gq9q6rgd3H+aRtgRqVE9FclYvX2ml1LVTpNLYQ+RvHf85usRY9/PglUQkvDT7d7p8taXaHATE4iHZ46pZmh0RcLOCl1PeW4MDFYyS+z3NKfEb7Trf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uye0HLSl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uye0HLSl"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso96697739f.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424317; x=1706029117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lvta5bGdKwksZo0+l1KEGWg49E9lz3g/VdkEuYjFXQ=;
        b=uye0HLSl4kwVOhyvJrG2NsIqrZQDiceHim88KBTXa2ojTktbRP+DbmiwtTlFgo0hP1
         ceKPILk2f/F1WiSJurMv30O5jYCZjZR2Wi+6EWnc+SQYjR1ZkNFSNmewcmqdkzzpsSHr
         KXougct4jGsU7fYYnIB7I4ivSLJrdYyx0w8+25GgkSVgIZ54u8tv1au2l8i2dOAERNY4
         DSbxqKsUWp6Aet2nhaviCXRk8W2QGKIM8NHEVXuj71rtmtjEM/grKA+cKn+7fupa9ZvE
         mmFQuSz+kl5WS2JOo5FvUqN22uFsTgopGNQs175BxvNbKrZTaJSVicIozLfXPEg5limP
         K6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424317; x=1706029117;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lvta5bGdKwksZo0+l1KEGWg49E9lz3g/VdkEuYjFXQ=;
        b=nIBtLq8JRgJapgFclNwbwJMijUElh/xsCAbu+HG17hpg2peIvHzySBYUigw3egSPaD
         GGdlZtncnEU/D1Vr8y6jn145t+x+yxteoFcrhVVH5AIInBCbdQuuiAbUqeqkTnDEJ9Xd
         r8LVucGjfnzWNERXFstT9WRfJODmGcqZ9e+PchSBinQZxGNYjhjdZPHzGgBcqmTtO0LN
         ehffmjxAJej6HgwCir1SC8QZLa1iojPG3ghnrIHwl1qf40pElHMVpinrR8FVS3peze00
         3LkVpbTMKz0kLdWTvP2OST4BL+pitP/ChRFJj7UsyjVmWrW3J6k5Q/QElk+6NGq+S+M1
         a67w==
X-Gm-Message-State: AOJu0YzKn6zOxkEMbsw0fxViSnQxeoteHz63z7rtcycv1f5s6AJzsjuD
	5mKHgRVMP7hr5aHDMFYlOrA9CsAJy7cjdYBeSTiNit6QMJi5aA==
X-Google-Smtp-Source: AGHT+IEjtSTkxVzMVFADP/Qqq8E5bXQZvkvA2xVWQ+NExmQCm+K6BPI49WHSYQ9vpnvZdYbfmFl8uw==
X-Received: by 2002:a05:6602:14c7:b0:7be:edbc:629f with SMTP id b7-20020a05660214c700b007beedbc629fmr13678177iow.0.1705424317488;
        Tue, 16 Jan 2024 08:58:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r8-20020a056638100800b0046dfd35b042sm2995191jab.73.2024.01.16.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kemeng Shi <shikemeng@huaweicloud.com>
Cc: djeffery@redhat.com, ming.lei@redhat.com
In-Reply-To: <20240115145626.665562-1-shikemeng@huaweicloud.com>
References: <20240115145626.665562-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH] sbitmap: remove stale comment in sbq_calc_wake_batch
Message-Id: <170542431569.238046.5650778720274078505.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 09:58:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 15 Jan 2024 22:56:26 +0800, Kemeng Shi wrote:
> After commit 106397376c036 ("sbitmap: fix batching wakeup"), we may wake
> up more than one queue for each batch. Just remove stale comment that
> we wake up only one queue for each batch.
> 
> 

Applied, thanks!

[1/1] sbitmap: remove stale comment in sbq_calc_wake_batch
      commit: 5c7fa5c8ad79a1d7cc9f59636e2f99e8b5471248

Best regards,
-- 
Jens Axboe



