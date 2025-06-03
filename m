Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDF1CD1F
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993116; cv=none; b=hP3RgXuoccdfc1FEaG1x6a5kFJ97muXYGhBqhq4CdXvAGX7hgRjUB+qA4NuOaHsybhxBTl+GALIT1fBPsfEvLRRObP/+h++ggNt9ELmI7/CE4HrshvqUwwm8h/boQ1sgNNWSaYrfEqTNNTHckAUsL14BCaJ4baEfalFeQqyaSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993116; c=relaxed/simple;
	bh=KQ+VBF+EF5t66C4iFr31+Lk91wtjwmv/wjeZI+gaLvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qrA1uHP7JuFhkaqvm9oSwT/1PqrQZfCbKoUBfh5uVfKxEUKgCMMeWXvtl0nR4IaUQlPrjNlOjveXyO6oosG5XysKr55PTadG38tKU8DxgDzbDJT/rxXIxi8OH+524Rg1mXzqbpHz+1q0fG6V1Eeh5tb7aXbqDgmRn9W/aDPKIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HiFJ+gm+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HiFJ+gm+"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddb635bc2bso6270915ab.2
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748993113; x=1749597913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yboyOMbplNgi54N39N5akjwfXKLUkiSmR/x7R2MbmU=;
        b=HiFJ+gm+N/wzL8LcMbalSZHpdQJquOEyBmJ+Mz10/Z/pNLQICflF4N0bV9qrT5dB8P
         fIfF9pBsVTy0uC9YGTcpnQYrTEERrIvI9cTVeL6ZLP0JRpjJOXy1YOSxRuMAC95yfl1P
         k1U3AuuI9kIc47ABNcYLPBDwibspyOBjhbiqkbMpWpths9wMPsiSfpS26IXjW5G+Ytzx
         3xJBUp09F3wd3DfEIs9U28J9O0Rs4a25U3Dr4EntyxaZfeAP9gFsLqipB9lKr5IFoP30
         0LAvGfSo84XRxaVPTyGXfR9fz32o3GF2h/QVi8Il4JtmErM/pCiCUV1uT9yxFOVhtHRI
         8UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993113; x=1749597913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yboyOMbplNgi54N39N5akjwfXKLUkiSmR/x7R2MbmU=;
        b=xCyCSBhesvZ919ZHizrj81+aQgDedl+ePoGMADRAzk8P9av2ktpN3Vrc8+Jc+b75QB
         e35IlAOL4qYNLcrEr9ZEP/pJu92Ip9Q/CnzkHAi8MbZO7XvnyXDsX7hUbPIiSYx3Co5/
         hjcxO+d3Hp35bc7NnyJFmGsaCfi5CzQDebE/UAnmU3ID/vzu6kqtMM1T+NTFkh7M9NdA
         G2+S1E5El5+MuptMSsoQNu97dJp9VuZw+rUbaPjEHobkAHH1erNDWzopv4Vn0og3CAPs
         UBjIjecF+ZnsCwXh222Ybt+nvkxudLSBy41HS8KXHXrROQ5+lCqlF0C/BP0vYlNZj2n0
         57Vg==
X-Gm-Message-State: AOJu0YzUeciaoRSJ7z7ySBnX6fYUxqjfZzV+ccQXbc+w0vaMwBWRdHqC
	zDE3fkY4vwjCMa3B6Ew5cMiJSLGhkRjqDGtztiKiLhBV9JYawnwjJ+13u8XZQPde/Ak=
X-Gm-Gg: ASbGncsaDXdycigPFHOTEc+41II0RYU66IuWwY8iYFcwOA+QWRr+6rCSxJJUsFuf9Qa
	pqzY+LKNluMN2ammzrxHtQZuRENsPLl6E95AtBjMbhVYjOTDk9q13iMhsi5P+TwUgposA5wBW+Z
	avJA1TweBzFzAEbCGcIeiaFzpo3jLMiu9MCThHaMOay4Q2bxuKQt/VySIMGCh/sJh2YbOO8f2nY
	JFwVnoAzT6Jqte/Scczn3Wc3MVCAx43GWrwUj/uficodcUAqWcwbJUxX8yjnHdbXRvZBhmG6RKQ
	DtOt4BRHAR+8U61fXlCzpAwABMokkMh2V6qYnbYQizI=
X-Google-Smtp-Source: AGHT+IE9SwcWRqxEEsC0C5HiQ8CdoP4BK0Ec0+JiFLIWV3fqAQXLJKu9aWafoilbzO1K8gOZRuUIXA==
X-Received: by 2002:a05:6e02:19c9:b0:3d8:2023:d048 with SMTP id e9e14a558f8ab-3ddbedc9af7mr8527065ab.22.1748993112791;
        Tue, 03 Jun 2025 16:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935a7a99sm30553075ab.65.2025.06.03.16.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:25:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603184752.1185676-1-csander@purestorage.com>
References: <20250603184752.1185676-1-csander@purestorage.com>
Subject: Re: [PATCH] block: flip iter directions in
 blk_rq_integrity_map_user()
Message-Id: <174899311161.69432.2589188657564739038.b4-ty@kernel.dk>
Date: Tue, 03 Jun 2025 17:25:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 03 Jun 2025 12:47:51 -0600, Caleb Sander Mateos wrote:
> blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
> write-direction operations and ITER_SOURCE for read-direction ones.
> This is backwards; writes use the user buffer as a source for metadata
> and reads use it as a destination. Switch to the rq_data_dir() helper,
> which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).
> 
> 
> [...]

Applied, thanks!

[1/1] block: flip iter directions in blk_rq_integrity_map_user()
      commit: 43a67dd812c5d3de163c0b6971046b4a4b633d3f

Best regards,
-- 
Jens Axboe



