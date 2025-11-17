Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AC2DF3CC
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397756; cv=none; b=Kq7bMzmsx31WeRNhoNaaUvty8+oh3CGjc2hnpMtHA66f8qxTy21jg/DYDlcdOfRJL/j4F1bXHKxMQrd+pDms9FjBQG7tzcqttPRheZgy2kCZZ0gTrxwbbrxV4JZbWkMlxkXVzEtReTXm6gdQMl53vbtzlFdOhxz/SmSStF9dUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397756; c=relaxed/simple;
	bh=pMxEm4NUjUGTpHRKv7d5LLStUvt+joOsQt6SvZeQ/aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KR8koxNCS46vPXrIknxAFae7fpQRA+ppc1qdjoNkMMhiDshCBlmKn6bTKezLxUXznrOmmZF8k04Jhe4JvXJeN9k/3Z2fWIlkogV3KMAVWE5PbVSFn1bvT8d5gc3QqU64koPt4X1Fo4PZ5FjgztItJeVo0PXCjQCQg4uYuCk7Z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RC6bobC4; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RC6bobC4"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9486d008fdbso200885039f.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763397753; x=1764002553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPLj/39ZpulhoDTDGoazpNeOK1ByBZpHBDDVSHE4zmc=;
        b=RC6bobC4+TovrvaGkyyJWnIYG9UfB2Q2nRY2/nVuq2FL1hwFL0YESAY7qDvSH+DKdg
         Yrpfw25/6XVrDtxSVSqQSLeiU7qSKAf0cZ2mO9ry+HTactxFvCZmb2sbzUBNLvOhsMEg
         i2mpQHBOqZfkBDBQ9xk6iwAKqQ4VPx8UiEHUwokBOwzHaaNEDXOPSAVWua8rNdu4OR+6
         MpV7Y/x9GZ1bM2AjRI/WuPc94cBkTR6xTMaUTtvz5LdIsHUkFnw3jkJVmIk9uzQQC6cZ
         wPw5bI/pIBkhFo0cTEptoscv3eVRhUl266rQ8JgD+HWQYMSbjFfUPrDJLJ1fXzoDigKo
         nceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397753; x=1764002553;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPLj/39ZpulhoDTDGoazpNeOK1ByBZpHBDDVSHE4zmc=;
        b=YTj5F8WvLrY2Uk7uJmVDtdHNic6TDdOdVIE+Dqcuzas928pacHcyUkSZTzKQneaTbE
         Elqa2kOGQU0XZGESQAd40+bIpP1heQiq01VTxyM9E2eUwFr+cG0W6AUPbxw5BT6Qto6Y
         /AWPHQGb28EB2ro0eXhmgXYqXQw+dJpoIp5xupiNBhP6z3CRxdVxSAiZhxTMdTqFblH/
         xzh9wHlmO3amLm0xqD7ovkSjQn2ha8Bceome1sBrAVMghrkulU0n5Kzqfyu7msAsK+ZH
         BqdUIwz64nnRsEktQQ0BDP2VqfpXRpisVw+mS4GXlCMVl8iIS/P8arpXBvIFQ6BHSY2d
         WvAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPQ9xQ3BPejmze9mo+Rwy08T+uTtz8x7DQuzLx5uNXE4hH5TpbCl01SiO16OeCjECAS8PvOwPMgHzCwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5t0p+YnVjHdm3PQaWMo/RLIT1uQ1jVOQ8nOpN/pIKLP3m0AL
	wYWc3V5+RiGCuO2yx9Gr9ytVXrDUza9KXOR4VF7aLhT5D9iN4iiURw/ADk+jPFBQQDo=
X-Gm-Gg: ASbGncvxVJt/BTiqeKN8sUr0qEDk2GRcKgwCLUvCIAKvFAH3YcOpJVcwl35E3OIrgDb
	P2+ual+n2iflV7grNAG90x1DrrktRXr8l6S/Ro5Cpp8uGiDPsjb1FM55bX5YjDxNSBfrP/2OkQU
	D6iJN0zNKIr5SeyA2mohRP7+XZRRR+kETXmIaIW9F6rs95Jx54S/lATmsW0EsRWrB69n8+HYr+l
	izI4ZtSZbwOITgKEWHM9wP0RbhH5puM22W+afdFdHwGdCPn4rzsR1B1u3B0XZHYo2AZsI5vaS2Y
	wsUO+UCkxzVErcRlBpomBcOZKLt/luS6cNK7vkCu1mctpyzjIlAD5cVvviAY8hd/eo5UZHPGW1l
	nKFaPjWi6QVFBcdKyMDYWX8NiuLvlu2Vewh+2pQd9yns1anySfDPBEzpkBbc+P/JDU2ceP1zv6O
	ihfQ==
X-Google-Smtp-Source: AGHT+IExXiO+QkYrKnmU03Fq6LXoF/sRtqr6FyMgEi0OFyE/Cj1hbgnilLpBLKEEKN9vWUKT3aE/kg==
X-Received: by 2002:a05:6638:9823:b0:5b7:d710:6632 with SMTP id 8926c6da1cb9f-5b7d7106816mr9931097173.11.1763397753282;
        Mon, 17 Nov 2025 08:42:33 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26e131sm4924100173.20.2025.11.17.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:42:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Khazhismel Kumykov <khazhy@chromium.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
In-Reply-To: <20251114235434.2168072-1-khazhy@google.com>
References: <20251114235434.2168072-1-khazhy@google.com>
Subject: Re: [PATCH v2 0/3] block/blk-throttle: Fix throttle slice time for
 SSDs
Message-Id: <176339775226.116629.17706508995359561190.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 09:42:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 15:54:31 -0800, Khazhismel Kumykov wrote:
> Since commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"),
> the throttle slice time differs between SSD and non-SSD devices. This
> causes test failures with slow throttle speeds on SSD devices.
> 
> The first patch in the series fixes the problem by restoring the throttle
> slice time to a fixed value, matching behavior seen prior to above
> mentioned revert. The remaining patches clean up unneeeded code after removing
> CONFIG_BLK_DEV_THROTTLING_LOW.
> 
> [...]

Applied, thanks!

[1/3] block/blk-throttle: Fix throttle slice time for SSDs
      commit: f76581f9f1d29e32e120b0242974ba266e79de58
[2/3] block/blk-throttle: drop unneeded blk_stat_enable_accounting
      commit: 20d0b359c73d15b25abea04066ef4cdbc6a8738d
[3/3] block/blk-throttle: Remove throtl_slice from struct throtl_data
      commit: 6483faa3938bfbd2c9f8ae090f647635f3bd2877

Best regards,
-- 
Jens Axboe



