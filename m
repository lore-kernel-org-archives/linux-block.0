Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2A15530C
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497590; cv=none; b=g5y/a+4Nxa+AJilEUYGiu7RhKd63PL8OD97RkCPSgAz/RHJ3VZj2fs4bdFeXkOifTps3wUR50JOCUoVoLguyW3m5+wZglyZVYJJZoiqptpEYqgcWjtcTc7y28PCl3kXt7L9WQckvsIgsn5sUyZn4l9TZDAV3mRr8uQfLpoXtuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497590; c=relaxed/simple;
	bh=p4nX3ZcDqoEl+B78Dq8q33s4thHwnx+DB+E4kI+ULu8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ldUg291ZxWbohYaSMZDxtek8IrifEQ9gt8UEOPEbf/VC9h5fkEh5D59T8InY0OOzb6dgUUd64YVYziG23hV+bTZL8xMh8u73dD3VNIsVYVODgsHnxxjJpsxVn/aWTP1BuTWdHQAKnsJfR/o4kZ8rSqb1rr0E+vVFxhhzs/4a2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KVs+zYC9; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KVs+zYC9"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfd5d34817so713311a34.1
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768497587; x=1769102387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mYTuIV/6Ug+Fe+lxhiO+8yLVP90UIG3Pn9G6JylJlE=;
        b=KVs+zYC9NC83jR+7EBqavgNDOJbZA4fWH4gqIUyoRb0IJTng4bMarqfg7W3LsHrYty
         Ao+0WdvY9Rd62RZxJPF1Kaa89cY328r8Sw/OOZE7AMeBKEI5+U+lqogp3sELTH3VT3E2
         ucPrlNy9K/Xk2a4RN/pfqHW5xpQbtzlNN/oJaHmSYadtcYePgGn8IdQiLp7Qt/iowxQz
         fhTGxJaXysAmd6M1ZHPtIZGxoni5JwvK+tuLxAKNEXe2MDP5L3sRO+aHyPGuwYNtmN5l
         cJy6RwC8F2WQ6mP0O31FwhL6vLaNHFQAIUp3S6nHmMnfAyReHjleL3fkgK3iwhK7gkvU
         nShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497587; x=1769102387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mYTuIV/6Ug+Fe+lxhiO+8yLVP90UIG3Pn9G6JylJlE=;
        b=GXCU94SOYD4Pa0dJMwfpcDOslvVTPfz2ZQ8UTLz/5ddbKUMwflL3Zxicvd64WFTPAZ
         U0kkqWMgTW2Y/uqIowm3L08/WEq8eQ5qdSw6zKZR8XFpOU3wXRbVuYRCIqsMKks1YJuQ
         h3h6Ydo8cc8MV1d27KN9qvjnQk164QkVqst3FJNX3OyHm/AxfRSoF98ZwMOwAhmUop3t
         ULAwnsJnKMRtjfdS3felHBLw6ANkatx1GxuH5Gx7pSHlw75SA4Ht3WPhnpEFW03ctHIO
         qw5Rft0aSZoDKFE1iNPq7kmE+zwQYBIx0rnnHTScnKvjCCChgXKIpi8kD1161b/M7UA6
         uiBw==
X-Gm-Message-State: AOJu0YyxnRCB5U2oD4hFF9WD2JL5UK22l5M64GLF5qZc4IZ87CRE5Pyh
	oyniNxPWjUbooEKvvB54b3iyV0GkezjEsPSd4fx/T/keZLo8FPhrDZgSZJfw34YV1KA1DZXhVUL
	J15HO
X-Gm-Gg: AY/fxX65Ia/EjBJQxuaI0eSk8h9RWo8y+XFr12ETwamXUde58hr6m4elSsF+w6IxURp
	jHEFWbw9BAwbodORSzpvfn2rWeWGf6VhYCHW/Ihd+6WoNOI+o5tCZUyORd5yGfFSMFeuWQlM8BA
	joi5g3glzSSNO++gHdNZm/ycz7FVw05eeHFbHrtAErb3dAON+1p5iCnbIg/HUZrBI8q8wtzdWPj
	49lCrSjLfp+RovNwJutAIGYZJ4r15t/MJ4X7e6Olt+ojBedVhmixpgCrcOzI2MOFCA5Qpni8x8l
	8v8vDb0qHwz5523+RNuu2yMpuRwgBTDz/o7SUHXgtT85KjBFDMypUzCY632iIKNpaU08K3mT+vC
	L6NQcDBb5Z8qSAqjQnB1fIXhhs32qitK/i8qCBn7FyIz68SaSDJlWgC18zKh+/cb0IFxXo0WjIT
	H4jg==
X-Received: by 2002:a05:6830:82e4:b0:7c6:8bfe:f5e with SMTP id 46e09a7af769-7cfdee802ecmr107655a34.32.1768497587133;
        Thu, 15 Jan 2026 09:19:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28f223sm33852a34.19.2026.01.15.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:19:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260106070057.1364551-1-dlemoal@kernel.org>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] Improve some comments
Message-Id: <176849758649.1067414.17799544307773071037.b4-ty@kernel.dk>
Date: Thu, 15 Jan 2026 10:19:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 16:00:55 +0900, Damien Le Moal wrote:
> Jens,
> 
> Here are a couple of patches to improve helper function comments.
> No functional changes.
> 
> This also gets rid of the "XXX" strings in the comments, which makes
> temporary coding easier as XXX is often used to marke places that need
> some more attention when developing.
> 
> [...]

Applied, thanks!

[1/2] block: fix blk_zone_cond_str() comment
      commit: 41ee77b75308354054f4fe03a05b8016a0d41573
[2/2] block: improve blk_op_str() comment
      commit: 5e35a24c96185e1be4c24a713e53a49e92ab925b

Best regards,
-- 
Jens Axboe



