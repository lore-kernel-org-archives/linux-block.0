Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA5155307
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751901; cv=none; b=kWKA0bynP0ikK80rN0LEgoYBq6gEEi/Z2aPLQbmCiswdoULYg3LuDYfv4fJJdDYKYmFeqZfSu8OaGSdj5pmaQE69m5Ymbsxucs5714UYzfs1Iu97AoaalsNk3br0Ysl5wCEJr3m13VosEpJ96L9RjcYKpxpF1bKs4tbVFsu481M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751901; c=relaxed/simple;
	bh=1j/nVkGN8MpSHqLitlu07rdKEK5vrv4/7bOda2FWRuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YuqQSbWQJ5clswceaRaFyA2ku+0e45BeKzGYfXyk6N2lQBM52mznbVSPfbFUhOCM6SOE0gkri6tnYtvlKXJKZnLLhmtS4ICmm0kMQg+FCxIYxt7QbK2Xx3CdFCX6Y74FGrKEGxrwQr8TPN0E4EJEz+3YKCtxg+KP1KytYbU2pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e0ri/EJl; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e0ri/EJl"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7dec82cc833so23760139f.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714751898; x=1715356698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IlB+4lrY4mbdOBx+Y/AvUZTSJ+/RHyMsVvlAgNIvx0=;
        b=e0ri/EJlnB/gD2RdRbXNbHSYzHqF1x4tl20TZV77O5BGRLWjiXlFaZMQcFuSOHybhD
         PMH/77mstK6BCta7IIf9XFI73a3JRMm0npS4DvuCcfv0klklwMvQFCFIYhn8POmdTmCR
         WSGffuGFxTKVuxacpffjesQBKsKfIQyKLHP7tcSV9mFuiztWMKygUr2yvLp/hM4ljCIt
         PmGx6AVUU+GnI1kRK72ZMLk6/LZaovG1ArruKIzbhooO4iAMsHwRWHb0IU49eIOll7pL
         T0uNeEiYJS//62YSio5q9goNPffvLo361hoBTy7hz9yTJ71n1TR34C6A8O5eaWIgQOQk
         L2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751898; x=1715356698;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IlB+4lrY4mbdOBx+Y/AvUZTSJ+/RHyMsVvlAgNIvx0=;
        b=w1HjxWrZFK/evNJxTQy9WvVJUhePM66K2scGbrVHwGBCLPezCea2I+BsLBef1I8C0p
         rKpL3oe5XCCFy5O70i+JoZS464VAy8QFqSs6eEP91qQSdzE7W4VuBMb5mPEAN+u+/CUO
         W5VIHRFeEqT3sB7nWGRQZbNUfrEWvd/ZNivgy3RLaEm8vNWheFWODMd8+UmCzaRoa8VL
         5rEMQZGG2Q9Rgi9iiiPj01sMbEdh91fJu4+9T03Zc4yurCveWNEgvUVNzgTRIOZRodcX
         5gKQCfFQmULvG8OYEYeVbjPgU+6Zs3a5YOBgU1cBZ8WCXwzum/XPuL6jaPvytJJbhz0L
         QJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGYgQjM9K9jE7KeqJToc7hAwYZFuV1g1mDhLr/gbdkV36C5QR6negVNbVYQxBjUbDoOg0xmy4eQC3kFRb/LbSBuU9o0ctnyR2ZfC4=
X-Gm-Message-State: AOJu0YyfGcMu+wtRi5KHxSpp7zZySRb/qh1GQbGltdoffC2VcHt4Z8Pe
	1ihLA+aWiNxm9cbfF6gZVY7JhXNx1TxISdPzLh+L9r5rrLNjYLocE87nRWO6K0o=
X-Google-Smtp-Source: AGHT+IEhq3fMW12MtXv3TpRGKSpVUfgQa6i8Otwhc4OhnFURqdARaxV4bBxz/TUbONpIQSUgDIca0w==
X-Received: by 2002:a05:6e02:1b0a:b0:36b:2a68:d7ee with SMTP id i10-20020a056e021b0a00b0036b2a68d7eemr3462066ilv.1.1714751898387;
        Fri, 03 May 2024 08:58:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ck9-20020a056e02370900b0036c4c9bb39fsm139184ilb.59.2024.05.03.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:58:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: yang.yang29@zte.com, justinstitt@google.com, xu.panda@zte.com.cn, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Naohiro Aota <naota@elisp.net>
In-Reply-To: <20240421074005.565-1-musashino.open@gmail.com>
References: <20240421074005.565-1-musashino.open@gmail.com>
Subject: Re: [PATCH] block: fix and simplify blkdevparts= cmdline parsing
Message-Id: <171475189763.53050.4004560606440063491.b4-ty@kernel.dk>
Date: Fri, 03 May 2024 09:58:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 21 Apr 2024 16:39:52 +0900, INAGAKI Hiroshi wrote:
> Fix the cmdline parsing of the "blkdevparts=" parameter using strsep(),
> which makes the code simpler.
> 
> Before commit 146afeb235cc ("block: use strscpy() to instead of
> strncpy()"), we used a strncpy() to copy a block device name and partition
> names. The commit simply replaced a strncpy() and NULL termination with
> a strscpy(). It did not update calculations of length passed to strscpy().
> While the length passed to strncpy() is just a length of valid characters
> without NULL termination ('\0'), strscpy() takes it as a length of the
> destination buffer, including a NULL termination.
> 
> [...]

Applied, thanks!

[1/1] block: fix and simplify blkdevparts= cmdline parsing
      commit: bc2e07dfd2c49aaa4b52302cf7b55cf94e025f79

Best regards,
-- 
Jens Axboe



