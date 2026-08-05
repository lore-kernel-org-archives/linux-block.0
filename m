Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48218FDDE
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933169; cv=none; b=O53lDM0+oyaBDgq5QT9KkQ2wFA4azT2kMCBtbbIPhNw9/qR0Z5FofO4WLegBJJUKmMSWDNsWTB3/r2Q36m1w8McP13hWsoZc4TdiueMmAaY0GeFnHdkGoeSM7Ax/oNjOnTOBZqcPiZGtSJbjXUpUf0kTrKFPImWUO3FGlQ7mPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933169; c=relaxed/simple;
	bh=oEqCrBUULOOY/ZiaofrSvncuUWIxfn8H+BJSyY8nC9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qjP09G455MEaTjEOVw3wEVUHWrtwcghntHwgV+4Ba8GE3TaG32OAi4g6vK9DtKlT1noktagzCOPq8dYFSsU3zVM3mYFHWYy3tUI3p5KKodLa8huICnCM1EkUf6DD9YanIvL35r/uJrt++zrOWJMTk5bGo2KNBixJRFDc0X76La8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=k6dF1b6p; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="k6dF1b6p"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6acb63301acso703189eaf.0
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785933166; x=1786537966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5HS6afxPeOr3O6XnC1tqGdcH6TkzlrKwwT53qowax0=;
        b=k6dF1b6pojwJ+ka4ETpZjZmuA43i5UGyw71C73qsyKYG4G68JAaGx+K0gl0vyYDwnf
         6XuVEa8kwV56P2iYXA414axUA+1Us7sefWZGSLvjC1U231bBY7vWTbboKqhYTe0XY/Yv
         KmjHC8jfr9/l5GZcm9B7d2RU0nsL8DeamLWUNMj85C+GhPBYC38qwW8I5W+qhJchZaRL
         beJFxdTWQCmvsxAC8UMqa83yWnrhlSLYR2LtslvArYD5VUe9gdvI4n/cIhrdQJdHzGF8
         ugF9a0l26OT4MlPWQkVeqa3HFT7EIsZqmVnlOP1xkcJTfjBwcvKHf8RbHjgboA6UzQ+p
         RAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785933166; x=1786537966;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5HS6afxPeOr3O6XnC1tqGdcH6TkzlrKwwT53qowax0=;
        b=Y/dZDCVXm/crq+Tl5VPQxDfvtQ0dNTuyVUjBcDr8iS98ZKAPEIm2KFzN5BACT+CQX2
         zV/xdFisr7I9Ls8lvo/CYPw/EXgyGrMvoEEOtNWsP5QeGClNWqAXXf2dkgNmn+a5j5US
         zT1MFCi6qIhmmMUIkF0ufxEVNhD2hLgi8HOZcGStluBfu9TgJdrq+ouVXzI6Adiw9Edf
         Kes1p26depTkbIJebAbfyGZhPXoDFlFTXlxyTLXvUqU2edbsd5I3rJMJCq0Cue0ZOanM
         kOyma0HVOQXa+QAne6cFP4NrhxdkTfVBHBooPb/lSQorszdYgnswGmf1w51Gz2SnFkad
         QqoA==
X-Gm-Message-State: AOJu0YwcwIbM1dV4d7ByRj8vwDFYRc8vTV/ifqew9GdLaVJP35HJPUkm
	VbsEVjw3RK68sXitmOmlEiUbDgBtMRVZ6KEfmfrJy8qlOOg4mj8mRDe20F4r3pi88Y4=
X-Gm-Gg: AR+sD12KJl/LWrnP0HyMWUguE2pPf3XWzjWxQzti8tyHUCz8RNUPZUp44UngWavPjX8
	oLBZv2pC4/17fl3T3iaaCaOP2FEVj4lxDaRcGECHoNctxQ+fOZ0O4YGF/Cw96inHLTKTTz/NJp0
	5YKd1CvSf1jBktKkFrd/tsfdbJBXmrFSs//Ad2ikTNt8ximaRMALp6vmlEUiMGtBsllcQuqhl8l
	i9bYjLzGRh/duZZ2p7cMlB+CrxYVTcBhMf0+97abJSTVWSdcxq4REiAyaO7oZbNqPKi13NLJkk1
	/BMNTu8CVEU74m8+0shOskFuTkkgO3KGS//Sq1UND1wvMJsOLx+GVGFOeWL8/74fcJJF4zzhosk
	2LmUl6nNWWdbdu8asCiv2sxfP1oKIHG2kxV0G8YQIO/jAtZJLVjkd7Bth4KQoxMTQNmuzDh9gXW
	vI3A1y5yLcpHO+Dww0BF8NxKTC4E2GtLG0e/FmUie22Ec0ezXvKpTQaWAZcnD3IWH2T03dB7C0G
	2C7wiRdQgqY4D36WrX7MooWZIT3fTRkYa9Y4WqtUZQTAslnjWd4
X-Received: by 2002:a05:6820:4b01:b0:6ac:a658:b952 with SMTP id 006d021491bc7-6ae965b624cmr2073364eaf.2.1785933165662;
        Wed, 05 Aug 2026 05:32:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d524d3sm2647355eaf.6.2026.08.05.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:32:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Subject: Re: [PATCH 00/19] s390/dasd: ESE Performance improvements
Message-Id: <178593316400.1788337.13989014782442395023.b4-ty@b4>
Date: Wed, 05 Aug 2026 06:32:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 05 Aug 2026 13:15:53 +0200, Stefan Haberland wrote:
> please apply the patch series for the upcoming merge window.
> It applies onto your for-next branch.
> 
> The series significantly improves the performance and overall usability of
> Extent Space Efficient (ESE, aka thin provisioned) DASD devices.
> 
> On a freshly provisioned ESE volume I get the following throughput
> improvements, depending on workload and setup:
> 
> [...]

Applied, thanks!

[01/19] s390/dasd: Do not complete a failed ESE read as successful
        commit: cddb447c62466f3076938ce120028d7b591f9f37
[02/19] s390/dasd: Propagate partial completion length across ERP recovery
        commit: 6fb5ba2e7e43173a3761e46f091070a8185efa14
[03/19] s390/dasd: Guard sysfs discipline callbacks against unallocated private data
        commit: 2a1780f9fc2493bd34c418a0be6fc58943afcecf
[04/19] s390/dasd: Snapshot intrc before freeing the request block
        commit: dc3e3f7306cb74066f231251602b1be5aaec7bd8
[05/19] s390/dasd: Optimize max blocks per request for track alignment
        commit: e647f351da2c6601a3e280b5c3477421e981ca73
[06/19] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
        commit: feea12d1cd8110aac009df32d3c6cd1daf117f95
[07/19] s390/dasd: Add defines for the Extended Address Volume track address
        commit: 1edac73fa2e9e8cadf19d59a49d64c681e4e45a3
[08/19] s390/dasd: Add infrastructure for ESE full-track write
        commit: 9cebfced13249fb02061dbee8a29cf91ba364519
[09/19] s390/dasd: Add range-based format-track collision detection
        commit: 05697849292011dc828b3651c159cfe694d1b5ef
[10/19] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
        commit: 44f9bf47987ec25a90d46d171b8df847d773f033
[11/19] s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
        commit: 123ec1e9cb4200308ad1535c84a4cf2f81904517
[12/19] s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
        commit: 791d257a21ba5241ce723a6c17f395aa0d419982
[13/19] s390/dasd: Add full_track_bias to control fulltrack write mode
        commit: 42849375e9280f2ccf492ced782e9591910d6b47
[14/19] s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
        commit: 4e304b2e56f09bce314ffeb4d4033ef7b8776c30
[15/19] s390/dasd: Stamp a format label into newly formatted volumes
        commit: 7d206efdc2f29240cfd815ffebfa958e2295a63e
[16/19] s390/dasd: Detect ESE volumes from the on-disk format label
        commit: 268e40548da2758851b6962a0a4ed2ab241ddbe9
[17/19] s390/dasd: Report ESE capability and format mode at device online
        commit: 6c1be943fdb6f8557596f5164ea48ae65cd0c1df
[18/19] s390/dasd: Re-enable discard support for ESE volumes
        commit: 04ea1579bc7707366de1d642115ad3b65c6171e1
[19/19] s390/dasd: Read cached unit address and LSS in the CCW build path
        commit: a600051da14b4cacc7b00685c967f40b0425ef5b

Best regards,
-- 
Jens Axboe



