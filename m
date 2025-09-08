Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FC2EC543
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341514; cv=none; b=uKDgCvk3AlDVc/eikYN7u0QUVBtp/CwY4qh6D3fToNndErLROVLEz4rRDL82qyVeYV5lxxaIC/inz73JggGYiv53qwxalCc3Fnx6V7AInaFYi4uQyCZSXFWlqbVrGgiSvHn3ebatB0UMyvB+nFq1yYelgBSiTHGdiIOdsCz4uEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341514; c=relaxed/simple;
	bh=49N6VXEcb6CRiDTym7YEaVcGgy2IFaVW/XCBE/FWkb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KDiSyaB6qqODCKJe6YTsLU4+/Y6RbBUWroJYYGA4w0tpN4RWrua6i3dwGlu1BGTR/e0NuIR/XL/3VrZBXZ0DJ9dbg8EfwxYrv4PHqf1gn0VmewNwRfl8f8sRE4VTKnyB3COFS0LwihfCyrimasCIttggWMChEHpapJEtMHOkz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qhWQECUK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qhWQECUK"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso3453895a91.0
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757341511; x=1757946311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZzRU1g4sXXFvuEmKPSKN3MMa+/bBXJsTRHKt64W0Ro=;
        b=qhWQECUKJt5vaqeL8HkSLyl0BYwYSaP2U86J4QyTadwxnWT6rHG5WpipTiZs5VzZY1
         beWIZQyIByOKH5puHFkHnR8zG/Q0pqak1D4JqDqlAIJGBM9n7RfSagTFQiYmX8rvLWIm
         xj+kPKSnVwCdt61oIRf2GUuROFfuBL+FfT3g+p0hFCXyEWLhD9Ln6hUJwGZNeG1laTN9
         KM52W4ajhARdULivAWGIR7vcvfjFiYcEf6D2SIVN3HFiB8J6XxMBdRNlwMYD75YUbmSR
         UIKbHi7WivdX5DKssr/4RtAiYji4HkiEizd4AgSlfSJTYV+5VQ4V1Doelumf6qBYwkXg
         j6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341511; x=1757946311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZzRU1g4sXXFvuEmKPSKN3MMa+/bBXJsTRHKt64W0Ro=;
        b=iPm0HoOat7dWDhhQ4IKUwZPqGiQJI4yz9nFfTqe7gIh2rZuNGOmGthdsg6qhpG/4pd
         M6n1koMClq2CZN/2c0Fuh+Gvc6D5zfhXzIrrp4OztIomCMK+zB/54JObWWdI12B23EQW
         SQfVuaBFvE8RPbSEca1A85f1ckuUlJPRGQTbF2rsdqUlYfzomYbjYmqvJ5TAo60ow2za
         XmgsSE9zRBGloEbIe2WY7x9oCl6hG/DHgdEqFsL7qb9kLRXgC1c9Tp7logq2PGMYUWpG
         Mc1yRyHFYwab29MJATOUGECiL5F/9EVr39tXuxTVhLwJv/0fLpl9PgVxwsqXRggwSSGD
         DFyw==
X-Forwarded-Encrypted: i=1; AJvYcCX3gjsTXVo5oS75AWsnRgqABmZNBU83N1OiFEmDJSOTnV3m4ArCHNmIl5H+u+7xwa4FfRUgXFVlI5xFIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4Gz5kFJ+fOwsAPVZ1y0y2I6EJ5TRi68AR5xYrkNZ37jnFEWL
	rN8QdLL3HmLytHXbWSQsB20NFhm57oEO2LiSrT8AHObPsv1LIq2cB/myOxJWO5WwKrQ=
X-Gm-Gg: ASbGncuEnh1g0S0j1i+YeLarxkMq0L/uLlL0y9fhd+6miL0OnzA4yAiHQWsbAbLKzyS
	GGBPo93zrTjz59GV78sVnVf395cO0sFj0FO5499qFiGM+t5Je3a0Lmn85niw6nR1IF+IFU/duPy
	FeMa5QEWQHPA966S1RDZcFC+owv2OeXGM9Rl+iq0QFlZY03X9WXGN5zIU7/WOFvDCykQ2I+XzS6
	Mpoom8SDTRSseyyaWz53J+E0Nnu6L16pIA4Kc/iaB824iw6MNA6PZVnZNoif0u9e/wln+b3bB+8
	29jnVStGcciQa1JO8+pk6kcdYID58f4iBSO9Wg7ZSZ6AUJJ8W8Bct3mY40ppNMfFrjAF7q3+GGe
	bTiSoOYa0z1rb/i1tQ9O2lqUL8w==
X-Google-Smtp-Source: AGHT+IFlvk59BmFds07mYxDRPlCj7VecIAUwHvCl2d557Lh/Uv9Qv9QzR0mU35OFLy1w/BAmdDh4Yw==
X-Received: by 2002:a17:90b:2683:b0:327:fd85:6cd2 with SMTP id 98e67ed59e1d1-32d43f6112cmr11950251a91.24.1757341511572;
        Mon, 08 Sep 2025 07:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b92a671afsm5157308a91.5.2025.09.08.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:25:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Han Guangjiang <gj.han@foxmail.com>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com, 
 liangjie@lixiang.com
In-Reply-To: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
References: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
Subject: Re: [PATCH v3] blk-throttle: fix access race during throttle
 policy activation
Message-Id: <175734151062.534076.10128778772498989432.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:25:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 05 Sep 2025 18:24:11 +0800, Han Guangjiang wrote:
> On repeated cold boots we occasionally hit a NULL pointer crash in
> blk_should_throtl() when throttling is consulted before the throttle
> policy is fully enabled for the queue. Checking only q->td != NULL is
> insufficient during early initialization, so blkg_to_pd() for the
> throttle policy can still return NULL and blkg_to_tg() becomes NULL,
> which later gets dereferenced.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix access race during throttle policy activation
      commit: bd9fd5be6bc0836820500f68fff144609fbd85a9

Best regards,
-- 
Jens Axboe



