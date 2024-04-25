Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7415252B
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076118; cv=none; b=Ryz5ijWDcuyYPgsi+XBNIgBJgkagCKuPrfFH/o+6TV5S3Ve6VZAgGiLX0/U0PGvRwz2FIPoOyWouXIINlvMdw/+F/tacGf9/KrMxvOZsVWJ52KDAfEMRUzi5dnioJoRmC6T6RUNjpY0BK5wTnhrohWbk+8aGH4uaYPGgrCa5mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076118; c=relaxed/simple;
	bh=S/UzxDEsvkfODTdSGf9tp1AXm62+vPQUyORnTgzdGZk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z/CJdjoNcYco3bN/z71Lc+5WB151NKOjNx4MMfJ4zF2lwzp74OkaYzmkI0ZJalZgF0BtiIcv0nL/1aicBteGIow9E9q/4Tav+y3PzEaptWl+YZd8w5nWfTx2oLxKSxbkzLDDtoN0v6fR8fswF6TlWv4BwEHOi4UE1v9Fs0ezdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LXfMbbiZ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LXfMbbiZ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d9a64f140dso13461039f.1
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714076115; x=1714680915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cetwwHYdXokgn1fmuZmV5ph3gywL1gPmKfP7fkXvIw=;
        b=LXfMbbiZyHoix5DcWlK3uw7z6uYlyDni6LqiG5DGVzmiQMhevsqnOREmRXx3yOHy0V
         MdjmW0zzFLLhRWUCYHGRgmYdcO98JhUaP1qTVcBYTm9uEgmnAbk4zo6WoGIemEFiRczj
         JGpaE0uhoDkzoIOhzrycOFlO3hznlvtrbjhPVpGpi/QwLdhyCD1qFzQFtS8kmVTFcYdo
         i9AVxvMdx2mCCxFzNA+kX8zQiNjC/K/y74UU4158cfaKReT5p0cD6pY8Enw4EvU//t1y
         3GWCaZXJp+ukmU0pqZNsnh3aQlemy2OjIRxW/Uj9nly8Q4GF1yHtNe2NbRJ0sirQHwCQ
         GKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714076115; x=1714680915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cetwwHYdXokgn1fmuZmV5ph3gywL1gPmKfP7fkXvIw=;
        b=k92lCWP5F3UQ3bj+E5VU+V2Lzx/DqyLzSMU+xf140Zkq2rfTqwBFPrO4WTyBFBIRwZ
         1KuaFBUWFpk5xLHfo7/+gX6X13raKvGk6ehiXtSEbuVvMJqhJbtJUOpsQDAYCCEppn/g
         nZMm5wbCLueq9v2OYJ7yQwRD7RNL5gU0N99k+Oi48hOmpqxSFY53dbnwZBKcBz+hWKc6
         F0veUtjgI9nQ3bFVdcz+5UvGdSOnl2wW1Sz5ezh1g/t+anGJ1RdfD+0P8VCt2jxunjpP
         ktDdGGusZc5G+hmCbSZUowjV1ze1AwCE7hChK9wsddNukf/0alOzGfamJUiWwXq6jH11
         RUyA==
X-Forwarded-Encrypted: i=1; AJvYcCXbtPSQ3rcdZt1esapiXeI2KP/lHV1quKCELIsbNAhhymtrY+wOwhtWuqzjB9RFq01XrlAKtAzaUJvP6eLW2rkxcgkcD/FfE2q++QA=
X-Gm-Message-State: AOJu0YzCPpro0OPXNInSERAiYGMfkf7MIHcFhmH4D9TY1Q00CC73gJRG
	8yFgvpI/PHO8acgJh5vL66c9wRnC3ftzcmsJy27m6GnZ1twbSSYt9xz4HT94zR0=
X-Google-Smtp-Source: AGHT+IEwYPPeQFE59/qDy5XHf2zywGaJ+rSWMtwxS/xy4NLxguqQWwR0+ke5QLraSa+gBi+j5lR7Yw==
X-Received: by 2002:a6b:4f1a:0:b0:7da:352c:1421 with SMTP id d26-20020a6b4f1a000000b007da352c1421mr878433iob.1.1714076114746;
        Thu, 25 Apr 2024 13:15:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dp32-20020a0566381ca000b00482f2cefbecsm5135316jab.60.2024.04.25.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:15:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, linux-block@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240425171635.4227-1-yanjun.zhu@linux.dev>
References: <20240425171635.4227-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 1/1] null_blk: Fix missing mutex_destroy() at module
 removal
Message-Id: <171407611398.195605.8013382139189750064.b4-ty@kernel.dk>
Date: Thu, 25 Apr 2024 14:15:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 25 Apr 2024 19:16:35 +0200, Zhu Yanjun wrote:
> When a mutex lock is not used any more, the function mutex_destroy
> should be called to mark the mutex lock uninitialized.
> 
> 

Applied, thanks!

[1/1] null_blk: Fix missing mutex_destroy() at module removal
      commit: 07d1b99825f40f9c0d93e6b99d79a08d0717bac1

Best regards,
-- 
Jens Axboe



