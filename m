Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C09342CAE
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255698; cv=none; b=Q2KzjX+mBMYwXqTiP9tpe/9HS9jvy6Nh1uIGUPW53QPYjSE7ghqeCbNptTTHJc8rMgYYXaqmPpl8bc7jMblPIKwdemtF/y0QFFDlYAVDTHiblx2bO/wT6YF3Gn/NrdC1dfAz/ohTR4FO5WbxTYURX8vYGBOOuWATOpEADVElfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255698; c=relaxed/simple;
	bh=jdBASKD9lMDiJtKhXSiHOYYjOEbLobJXcA4yT0Z0Mis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iBqKP6dUnyqecjijcmUO0DKV1LyUFmkHf2SA07c7s5gKHM8nieWNtVaxqtAgzc7ylZc7PFhNO2rahbBt/1ZHV5jIU0b4TJq9dBAd7nv+ncux57wl1GYlmJ73Ks/zvwStuvLfkolj+mVIT8faacg5W2K6q5GZwNEBwb51m1xgv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yyXhJnmx; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yyXhJnmx"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so3527239fac.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768255689; x=1768860489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5I/1jHxPAZ3pgLtnbFiVNwtyG1ff/Sbz+9adztID6I=;
        b=yyXhJnmxMkrPKCFAGt/an1N4KlMc4qOVZ2I3l7SCn54ki5n6MSsNJ/FI9CIYrBiymR
         nRy/ntIRGXykvypszLSXwtp1O6TbRvZwF4XwCgPBCtIaZmApGc5HyKB4y3U3ZZ6meHHh
         w8Y8l2wzB0zLNpFEyYzvXA+BR8fc2kAsQ2Rn4iRGEyL9pFDBirfU47/667EDm20f3X0U
         MyKEltrMtY45P4fwODqiEU+ZtaOcFKtka/M52WZ3JiXleKGjfLNwR5hsB+87WJnXk4Vl
         2F3smn9amZs8UJVOhqZWR/KaSLZMX+68yUahVKSWjurKGiqYk8Zf2BoJOVFMsP16Bbor
         XVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768255689; x=1768860489;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5I/1jHxPAZ3pgLtnbFiVNwtyG1ff/Sbz+9adztID6I=;
        b=i+OSH2HOf0CywtGQAcK3JchKcT/ZsbinhTxztA2Q15d+Yy1jjkGgCEUq2GThtiAelr
         ypPsoxgtzib+UM9uK1R+BSXMVJKSj2w8tixyZ+GXI9ySvlTXyiZylv2e5933QixiPlRw
         gLFwij8cxiNhHTFLQ0uiFzeyz8jqYw6jAfQJPYwiVVRGQ3bRxP6d511wxSaUvMc9MT47
         r59Lj3nCOHJDqdSEF2vjJo3jIQFHnoMutrwTR5PTgukbDILtY3/rEmPJSg6X71ewOPib
         D8tOTaZ5ue0AqMDfT/Ho7N7RCMx4U/bZSX9BTiw5/qkKPKJNiiFh1LrvG9pIG+1qOOTo
         yjsA==
X-Forwarded-Encrypted: i=1; AJvYcCWewvclCbakNYXLd5FWN1k/VEEoh0yj2xEGO6sqrZKmykB9t71lSKlvYMwNYVbzfYgrj2U+YewKtvfjxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1ft2WynK78hJaQIH13b08GeIr9nVy4fCTT890RJZI/f089BA
	HlLZHeyK8jbIrFqJXJTLoZNKUg3O33V+NtcV5vGchQRQLStPziW7npyPwtBO5Gw+TvU=
X-Gm-Gg: AY/fxX7R78F1W0tKw6X0mS98l7D7645E6ZM2L6ZDzBYkPm1sIO01EGsZ+BpLmGI+58f
	U6XNStcyQv2k47aVSUAnslnIpNUfWHQieWABrOeHWIVK3nrOami4DPS3HL9hepKcMAHZT9ztgg9
	n9J4d2Ps3UIVr3KoUFjU2VaRfQZdP4SrlY06/Ym1xbNpuhOUcbMszQXcXn6XJ2AKciFiAwvbmi/
	4DXvNf2/RlJfIqZfYGNIrODa7aQl6hl23TWcHdFkfWYBxW0YgsZ9rw/8vzkodfQsiuo9s+QZUGb
	1Yr5aCQOKWd0iMzI7CVeewMuKV97+o/sQPNuPsTROg02eMiJZ82LtmlQwjq9PoBSLA6gFhWM5H/
	1PdGJ94f3TemhqkK6yWVhKL6WlrNWNC4vq30TpqdfIBxkJcEgi5rfLiuFhv5RSFXrEr1vgitfKw
	Eavg==
X-Google-Smtp-Source: AGHT+IFY+uciVOteGdPT4Z1KiEDCcCnSwBecW80lqXBKFJUP0APJx6N8fsJUaLpYbpG8dl7kWS2Cog==
X-Received: by 2002:a05:6820:602:b0:65f:6c62:eef9 with SMTP id 006d021491bc7-65f6c62f3e5mr4471924eaf.3.1768255688999;
        Mon, 12 Jan 2026 14:08:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5072427sm12634274fac.12.2026.01.12.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:08:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 csander@purestorage.com, alex@zazolabs.com, Yoav Cohen <yoav@nvidia.com>
Cc: jholzman@nvidia.com, omril@nvidia.com, Yoav Cohen <yoav@example.com>
In-Reply-To: <20260112220502.9141-1-yoav@nvidia.com>
References: <20260112220502.9141-1-yoav@nvidia.com>
Subject: Re: [PATCH v7 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Message-Id: <176825568804.298609.12168636576651293389.b4-ty@kernel.dk>
Date: Mon, 12 Jan 2026 15:08:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Tue, 13 Jan 2026 00:04:59 +0200, Yoav Cohen wrote:
> Changes since v2:
>  - Address Ming Lei’s comments in patch 2:
>    - Add a feature flag and some minor comments.
>  - Patch 1 unchanged, keeps Reviewed-by
> 
> Changes since v3:
>  - Address Caleb's comments in patch 2
>    - add to kublk.c
>    - add to auto features
>    - set feature flag to 17
> 
> [...]

Applied, thanks!

[1/3] ublk: make ublk_ctrl_stop_dev return void
      commit: 9e386f49fa269298490b303c423c6af4645f184e
[2/3] ublk: add UBLK_CMD_TRY_STOP_DEV command
      commit: 93ada1b3da398b492c45429cef1a1c9651d5c7ba
[3/3] selftests: ublk: add stop command with --safe option
      commit: 65955a0993a0a9536263fea2eaae8aed496dcc9c

Best regards,
-- 
Jens Axboe



