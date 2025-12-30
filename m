Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C147224AF0
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110569; cv=none; b=axYNQWPpPZm+vS63DUesS2qC29oyrh/MKM7Rp6OdU3TQ2YmJ3bencERsofKB4akLzOh1qs/SYPcqPdZR8DTTA8kB/8qqjOmKHWSZtz6sSwejz+or7Qs9RI/E10xpTcmabR+xF3npeek5D5PJR2ivejOa2nDiI6Vjjqtz8Oyuupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110569; c=relaxed/simple;
	bh=Xw6TO8h/kPeXMQ21igMPIJ59SDwm8QLsSUoqZglBoBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NIIBl6rzyOt7WX9fZRKq+25xFxNagfAmjXsEkyuvy6jsTJUTs3sPwAUuDR9gdGB6N1Hzej4kWCgO/G/6obyPgnYB2gNwc29ITUp7Is9eSOkMkrTbfejEGD5B9iUYJolBAaPv1jkjVzuhczs8/l1izIaJWa1EKnA9olTdL8PUeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b7QAS6hG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b7QAS6hG"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6d13986f8so8363737a34.0
        for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 08:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767110566; x=1767715366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nF06fY/Z52Z+Clk0d49datcv/n2O+xADnW0BhLtR+Y=;
        b=b7QAS6hGt1E+4PrcvzKWxJObxgYMQcL++KNOYRNZFRtLafNDM/BDZSfpqNtuUylYwW
         54nfXWqiMPdT9zAUo0DOVcbtR8HpWrIDOX9t/MLP1vt9AHjaIsPoPYmWBcYMNq20VlxP
         FQXBtQrZwN5rqnPZZ6heWT3lm5ndYeCG2mVUUf5Bx7sTA2TIj/v2/ptJ6dHiNZ+4Ch//
         vMHkhnwijbZqTv3sNgT9IeHp5FoXaO/TM/KwgiHDnbOgO3nBEEqJ0JpQuxrD/l8tYHat
         TwauFfxqPlUC8HQoVNug4CNQLBG+Wo/kGnQ4zaQtPcu/YHSvCGOD4t9S97TLRDB1SOvx
         izLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110566; x=1767715366;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nF06fY/Z52Z+Clk0d49datcv/n2O+xADnW0BhLtR+Y=;
        b=C5nshkvljusa82i6rTuVwNZFy03iOLbW/ITS6cCGwbaZ7nK8bPripCYi7WhC25PQch
         hUPYP2aK0LIQY9h20wZt1Bb89ykabAZCTQuM4iZ7KfVy5TbNk0mkYirSH5FyRUTrOczl
         gEW9lk8+4Gwi0+hXneEN55x4uaEAYFztptcyy2m3nBTvhJ+tDPqUuSih8QhuTpYbgyJK
         Hw7Ex1Y6BkpNMVjseZiJ63DCTC3pUSF5NpjwGCN0miVhCe3DE6CxXYMR4eCdEHdZ4Pi+
         vLuDh3W/Yxw3CRUC78gDIY1kftGTmiSmxe9ZWyfJ8UoKfVA943hBTQ0odA3yEq59pkZT
         o6rg==
X-Forwarded-Encrypted: i=1; AJvYcCUMcL5AEYm7jirRolfJ8N/rwgVyR0duprKM/P7F5df6rhDJsA/PsI4ThyizI4grjRGIvZwbGGgfWbLTpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQbhId1e6MVvgO6ADeCf2uwNFtaw4DObpr2VGl1t6qBm0d8hf
	VItD/VVwnYCrPW4ypwtyKU9dp1sJ0Ok745x95ZpB6brusNwh/DX2SLNYlJrTFvi0mq0=
X-Gm-Gg: AY/fxX55mphhlmZbq2b1gmLOKcYjVtHrmmC0Jzzk78vWVuj+sIBoiJZcvmwA3Qws+BB
	esBQEponENhk0mj4sCpzNdE4cSwQt1tPD6EH29jDJcEB+N/ZMzWaQc8zRDEzrxv6yrJxLw07dNc
	xDJDWn4BC5lyqG/EiB31UfmA6zlp1XRizuuZYBxXrek8WJF+6fq7kLWc/XElselOLJrET8sJYhq
	EAzzw1yRN2IqNGR3R6Ch40r5Usp82HTMfFjzTc2SwphNwUc/czxaiYbgaSaCCTIDUzmDnyR9GG2
	f62n5GFwrsPVTftqpPApWduQTkdH0epI/81UHHSUY8NGWWsht9igtB+JFmY0mbSRzdgNMOYDXKx
	hKZ3gnZDqUcyAYW2M0YGsKLzXbPhX2+5dckfP95iJ82PsxigRgw4hbPlcITvcC7gGqQNVJ2HSIT
	M3iMI=
X-Google-Smtp-Source: AGHT+IH0zzRE7zHifu5tv1rtpqUc/VKQnCmbhseAtXuWESK7KrUpxUmRxMQzTAEpNlHJkixRota+lQ==
X-Received: by 2002:a05:6808:1205:b0:450:b249:71bb with SMTP id 5614622812f47-457a292c5bdmr16339873b6e.19.1767110566337;
        Tue, 30 Dec 2025 08:02:46 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3f1761csm15918931b6e.22.2025.12.30.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:02:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251230-blk_mq_no_ctx_checking-v1-1-2168131383e6@oss.qualcomm.com>
References: <20251230-blk_mq_no_ctx_checking-v1-1-2168131383e6@oss.qualcomm.com>
Subject: Re: [PATCH] blk-mq: skip CPU offline notify on unmapped hctx
Message-Id: <176711056497.410043.6155561525733424852.b4-ty@kernel.dk>
Date: Tue, 30 Dec 2025 09:02:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 30 Dec 2025 17:17:05 +0800, Cong Zhang wrote:
> If an hctx has no software ctx mapped, blk_mq_map_swqueue() never
> allocates tags and leaves hctx->tags NULL. The CPU hotplug offline
> notifier can still run for that hctx, return early since hctx cannot
> hold any requests.
> 
> 

Applied, thanks!

[1/1] blk-mq: skip CPU offline notify on unmapped hctx
      commit: 10845a105bbcb030647a729f1716c2309da71d33

Best regards,
-- 
Jens Axboe



