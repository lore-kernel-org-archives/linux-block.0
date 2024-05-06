Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE744C7C
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011528; cv=none; b=BlQsInJ5C7HQl5f9DgWIq+rKoqlJaHK4WlWux8+vJuudqShgR3pPpOCAB0UORkBwZxH7F1J0D07BhVGroF4Yrd0MBnP5u2/jGG/3bXjitwb+iytCRRoCX/lhwTsG9yqgX1GVnQN4jQObOa9ZW+mzNMqUy8jxIKk68n8ARpm/UnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011528; c=relaxed/simple;
	bh=JWQ6JU/qKYrXCVJfVNtwTgUa5Jsp7oKfKk/p7WMo3vY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o36W7ZbiJ+LAdKWes/vHU2saZGH2NwFkehuEa1RSvrCU7e0U7dlpqAND8unyJzcN8jIoPrkJvNkmP1aRsReuZzZPChQlaUkuZeD7pCzTbJfXYzjPnc4jfYUJzEJbvkn396rScfbQNsk7uqBHYjT9ORz2rTdIz6KIlaA7LdXqwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NB/wxohg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NB/wxohg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b432ae7dabso617234a91.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715011524; x=1715616324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqgsKGKEjOP+8cTBfx+57kyIy1gghvDRZoiroY4Tlpo=;
        b=NB/wxohg7meljfEU18WlYqqGm0SZlWzNfhAECeKXTOz4GHk8BUeLN8hDkO9hZHPSKX
         j6112RcuOuuf6e+Hy1NAPifgIlZSN4s7HLYC7mD/XtP74fGEIy2zoURYcA88+cxBm5Va
         gs2FVUNV9BjL/LE5ZvZFgbVEpVNwbHGy5lY4ttkXldmjfGzzLks/Hr60UcqzTG3fsPxg
         HLqmsm8o5b0MmJ4/Mz4rVvyR7r4SfE9eQrEUhN0YeYaxHlcowO09hpKv3kWsCS1PHfnw
         Io2P5ZL0Or87/v9YW+MT0GaZzu07QQ0n35C49EKOB8H+2XqGgD0l4egHYa3mXyMvgvbr
         HTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011524; x=1715616324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqgsKGKEjOP+8cTBfx+57kyIy1gghvDRZoiroY4Tlpo=;
        b=Vtu91hi0L7zg4TdNC/voZkkTVXTH+4gxuaMaG+iiyRNCw/ZO1zHs4j3Dxt9RQYluqh
         dJSYya3ssZTrO8h0zl+KjdUUGRjb731BtvUFVP9BFpnFCYSSdIt1f7OLi5DkBd8F8yYW
         /kYJf1N2vxvqc847mrKv5jQeW+USfMXdo2AtkTaOr6s1bSjL0QQ3UPGpUAW9RfRdB7F1
         Fl3z+qG/dhxYt/eLPMXx4+D3Wer7bqZh4asNqr6pCvvsMvspEkoEKRMGjpK3h2yKHGPZ
         nyI6pbI4bZQhyzfS03SHY1q6aEarZsTaWFGBhy1vi7E6V7q8R6O+y/YYdIRvE/yZlN83
         1cZQ==
X-Gm-Message-State: AOJu0YwvK5S824X0Hol9xhfvORygWudgqGYH/mTOzKH96KMim1yDnDak
	BTjtNdZNW14IgxnQmDS4rzxnrxOwxhzCYhBvSbsfwwxpcOH9Qzt9J9u1fTJpET4=
X-Google-Smtp-Source: AGHT+IG2hlc49RHI3zMljMIqX+EhEu6ghTpZbNBLlf1tnZqG3tuQo5wMsQyN05ItvkdowERVV5ZkMw==
X-Received: by 2002:a05:6a21:3382:b0:1af:93b0:efff with SMTP id yy2-20020a056a21338200b001af93b0efffmr8504428pzb.2.1715011524318;
        Mon, 06 May 2024 09:05:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ta5-20020a17090b4ec500b002b2cada0c6fsm10224920pjb.26.2024.05.06.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:05:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20240506075538.6064-1-yanjun.zhu@linux.dev>
References: <20240506075538.6064-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 1/1] null_blk: Fix the WARNING: modpost: missing
 MODULE_DESCRIPTION()
Message-Id: <171501152346.64697.1966888577507903336.b4-ty@kernel.dk>
Date: Mon, 06 May 2024 10:05:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 06 May 2024 09:55:38 +0200, Zhu Yanjun wrote:
> No functional changes intended.
> 
> 

Applied, thanks!

[1/1] null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()
      commit: 9e6727f824edcdb8fdd3e6e8a0862eb49546e1cd

Best regards,
-- 
Jens Axboe



