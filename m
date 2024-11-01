Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3013B7A3
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484742; cv=none; b=NAjd2Bs2TJLefvCs8w07oxWAh9mRfuXzmR2Iu2cuUe9/3BJZO8x08enX7qB2GRdCTPo9jKgXzeLbOhiPh9JmIFYdmTAGo5jjcW3OrlzkoNyvn4xAs9ZoaNSyHDS6nKpkQgskppnhN2RdOVXcOvjt9x40KwOInqo8tUqL8xaNVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484742; c=relaxed/simple;
	bh=A6Gr+1l/Tq8+o/JD6A7K76fXgZydYMDDaqb8IpNk3Wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sJauTeKyr4SZTzIpcAuRHSOZXGRgOt2k+r/adjuub0Xs4ckeCrwQ6XUkq9sY/zhV6blMRtlyRr8Kzshytx+hhLrVCc5S4owmiCitUVIkmz6XZA5kBPGstyBGxCz6/M6rtTbEFRoPzajUsY2+DuyQ3V5XG6v79uCMNZdkEBFjToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fOAi7Bkl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fOAi7Bkl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so25421995ad.1
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2024 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730484741; x=1731089541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gt/moaIyE3wSLk1/juTpY6EkHlkILkLb/Tep/ky47A=;
        b=fOAi7BklLxqPBBVCYgSx436EIELTXX4UItQLRDnTm1+w1hHLbip2vPoU2mczaHaWay
         fFaLc7jYIQKQi2oU6MIMvV6w1VGxUDpqlTTKoClzzthpx35DtIBec7DiixLIwwLQGcej
         s6jFCmZ4dwDeGGFQUQKl8DsDKBrTDYni31FX9lTtQS9X9Or4Cd25c3y7zDo4J4P5lWHA
         KIlbBbftJ//DgcwmGLJ9jXW4INL32EuoCMcK6hxOai6Ral4kjgYYdOtnnuwhKvb0OgGm
         GvjUCUjmdafeaNuwVgDby/nfhAxytAGbMdK37jrWhlEisl+7X3YTObm7k8POUMZjXzax
         uvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484741; x=1731089541;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gt/moaIyE3wSLk1/juTpY6EkHlkILkLb/Tep/ky47A=;
        b=MPezKRj2uauUd9rkZWkWsAAWjs1YUZE4ivP/C0jrBiJdxS/x282breB7+/Rw18hh7U
         5YgtaNDVTdZRiJPFySzmy2/WBM2f69VHKFmZueCdl68hGzgc6Pio9oJFe7sTkrsSEKjT
         oM0gs0DCJNOJolAhl9lZy1Qt0Saf9wdMgzo6YF7Snk26kHa/Kr24p7NfNFXt/SyoC2L1
         meAM717OQMC4zdMCufF0u8rg/jn/zP4TKZr3nnN+T8gtIlQCqLlNyYUlq1th12eyIP8H
         /tIOEI07gY7wcMvobIRH5hXP/5MXGW6jleh1ah5BYhca7TA9nA1UPPeOqYiFgSyjN9Vo
         H6ug==
X-Gm-Message-State: AOJu0YwBcG52jZ5waQ39mW48TKqWCxAs4swpclsZmU4LsNJrR7kwcGvk
	2S+1Df4TDUBVMrblR6yQ5MNId5ezlc+g45Yz5GCVN3YOA8JkR7w4Ev+Bm7KIMlw=
X-Google-Smtp-Source: AGHT+IGqQO5UqR7y7GCdouXnDrhnr15tAsqf2HaeFsOrZQ77ezOdBeSh6/iB8fpoTO55RCcnqU4aPg==
X-Received: by 2002:a17:90b:4d0a:b0:2e2:abab:c45b with SMTP id 98e67ed59e1d1-2e93c174ca9mr9474274a91.21.1730484740858;
        Fri, 01 Nov 2024 11:12:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbdfeeesm5178472a91.36.2024.11.01.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:12:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241101092215.422428-1-john.g.garry@oracle.com>
References: <20241101092215.422428-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] loop: Simplify discard granularity calc
Message-Id: <173048473998.576411.11705299934115966144.b4-ty@kernel.dk>
Date: Fri, 01 Nov 2024 12:12:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 01 Nov 2024 09:22:15 +0000, John Garry wrote:
> A bdev discard granularity is always at least SECTOR_SIZE, so don't check
> for a zero value.
> 
> 

Applied, thanks!

[1/1] loop: Simplify discard granularity calc
      (no commit info)

Best regards,
-- 
Jens Axboe



