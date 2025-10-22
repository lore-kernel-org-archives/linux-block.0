Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF0348468
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140397; cv=none; b=Moo0XO1MFV/AmDPJRY3Xx1SqPh1ZMfNhoalwA/wqMuym721NyWZC0AhNCIaV3exlN3+IPjykBjB0bI3GkP6Y32hWFro6FOEqJT3eHxBIWNqJYhjbwF+EivoxOwYl3eTj1/9jKQJms+0AV7v7BpfSfh0a5vLQzgivKJHuofqO2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140397; c=relaxed/simple;
	bh=tMTLlB2WNxj5abhVUPUVLHOZ8Sm3yINEJmcNvr78Sso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hnHDQvfw4aCJHNAcJQ06PRSuZDTrpFDJ9Tsafa0cXH8VBB02Z2rI+0yVW0SzyY50k/DoioIHJEQ0udnLgvM6PufaI1uG2hObbZvrwNb4MgZivYcCVByfjspr0qFtQgsk1Z2Iz+iiI30A69QYHik665IYuiZeRKPvnX3bANyoOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a9J0uPIh; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a9J0uPIh"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so51164239f.1
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761140394; x=1761745194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qdff1QQWTfCeG5VLrXmgGFz3QYopNzjLMHM5Al4uYw=;
        b=a9J0uPIhear6JnBGcsyuvYL6Cm15JNr7dDmIO8JluNgepdNSAwc0fedLeDQ5DcYNcX
         YSxCtSIVE+b0a4tm5SqIfKKwRZae8MbSNn98rvnMJu/oltowz+KzcjQw1HARWbAGSXZ5
         mWQ3OXb6I3D/pTI6myFcgl3JCwr3yRhWy6ytqW5Pwujy+LIOrUICceWH2JL10fIrIADF
         k2x9lVi9GS7NrSIAIl3R9byxbOSQWUf35ZPjSDQlsBCKrYKspqx+BLaAqBFdg2GSKmE/
         LY8wqto0jiofLgj3ox9JQ62kBUOP0m875wpIpYx/9tgR5oCw2/pcZRtGNJih0ILKr7Dh
         lKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140394; x=1761745194;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qdff1QQWTfCeG5VLrXmgGFz3QYopNzjLMHM5Al4uYw=;
        b=ij687Vw3n+nh59mIqC75p1vVaOygZqLVmuRCitFZsATShtqAGDzZCeQ4ZVCveNEbLM
         RPXtJqlQdznotB0IcU4zME8k/LNqMmC7UqIYFLsJ0f9OBEGcsjs+broQLLW//T9BrMaa
         jmuX1J5ZnT48vZ/zv5iAVHMxwmZmy9FZGjCe3GwuTH9UQjPEmP1F7625JaZqiYFnyj86
         xKn2x5FjOI3HampJv6d3U7FohYScm0DoGzPmEem2jz/OLk7NzojvfqUwkFrq8vSDTmEC
         6s8AA4m5uGCAwF8j6HFrbdji/5TyhX/Q9vOAp0R4JI7t8kZX5uHkRbLSqwRq4epcxlP9
         4Uyw==
X-Gm-Message-State: AOJu0YxZlUzmXu6GHj9kbPNasfkrFOiuMAf+t9TlAGlTp9+abCTiSB/4
	RwVaN8LZU/7BwoKi6jI8Fm+hJJ6gJ7G0IsPW1tLxj2b8gSrT7BD/NqPmj3oUdnkoxGhEcSIEeT/
	G9HfFAXM=
X-Gm-Gg: ASbGncv8Q9ia4dfDHkFfzABCDyfANPdpPUQ/iUbyX1wFsWbuJBcNTB28UTENWoLp8zg
	+MofRl+K8A8vIQAVDc/MpWYsrMv2TqArXm2uVObXsz6y62fCaKoYbfEaBpa3/FPhAJNQC3aYVPN
	R+MnsOWh1gtxmiXiu8lP/JvO2JNpfz1K6BuwMh3RitwPGpziDGwHSc/ideQBvb6RCU2GCtnjWMC
	WYtoRu8wv9FPOffdtmZekUEH9whdUvt8z037Qwon+YO6g0p6l8qpvGdydG1TCAjkYd4BSUygzHP
	hOtf1dy3Ns77LoPVPN/88gV6/HG5KKqT9WNbKPP7bMDOew5qr9ZKsKUGWdPCQF0pj8Hyi6An9Xb
	pLx1DbFPElLBbG6scNhzbwjVrlNFVJ/2+LP6BtZdL/tD7L0k+Az45NLJX2EU4ArMonDw=
X-Google-Smtp-Source: AGHT+IGajUKn5EvyfumXRaySHEjRIMqPmCXmVmG7Bdm9th/rjELKMFQrwFTY/NSoZnS0FaCJqH9/9A==
X-Received: by 2002:a05:6e02:160e:b0:422:a9aa:7ff4 with SMTP id e9e14a558f8ab-431d32be9c4mr41827295ab.11.1761140393878;
        Wed, 22 Oct 2025 06:39:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07ccc89sm54455965ab.40.2025.10.22.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:39:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, ming.lei@redhat.com, martin.petersen@oracle.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251020204715.3664483-1-kbusch@meta.com>
References: <20251020204715.3664483-1-kbusch@meta.com>
Subject: Re: [PATCHv2] block: rename min_segment_size
Message-Id: <176114039313.6778.10145705323225537448.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 07:39:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 20 Oct 2025 13:47:15 -0700, Keith Busch wrote:
> Despite its name, the block layer is fine with segments smaller that the
> "min_segment_size" limit. The value is an optimization limit indicating
> the largest segment that can be used without considering boundary
> limits. Smaller segments can take a fast path, so give it a name that
> reflects that: max_fast_segment_size.
> 
> 
> [...]

Applied, thanks!

[1/1] block: rename min_segment_size
      commit: 5c5028ee594ce5f907ca6ad1c32cca6a15098464

Best regards,
-- 
Jens Axboe



