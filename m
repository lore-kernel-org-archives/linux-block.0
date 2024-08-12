Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32118733E
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480295; cv=none; b=eJ/5cgP+tozNy5aT2DVaQBAHx8altCq0+oLTAFjGb4KybC5La/7Lg7XrJiokOjRcLrzAoVlzJ9xwBUzgIOuPTStKYoEKfmEjUhxe1ZUROMm7BvPoR/tn2POm9W/RBGkIwXa49rEGCE8mtWxDKXIdOFlIv/C8B/t8VDd29b60Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480295; c=relaxed/simple;
	bh=vV42uFlNHjRhikigd8R5YeRbBMde/8oSv7wiwK70bMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rarkWiyU+J6CuufHSGeKcI4lb53g6vEhDgb2dSAlG4BzRDpYgaSG8COrLO8J8XBcF87j0EjeDeIPKwqgB+ymQaTRaoDnk+1u60WvSr9kbVGoagpiqw9JMA8ObAh6RgfqXlm+TQbpokD/BwkUoYVaVN1Ubi8tzNOywj8m/9rtuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sMo54D9L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sMo54D9L"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc53171e56so2693155ad.3
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723480293; x=1724085093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2UAaYeSFYZuqxhC5aYMcc0ucXXN9OuwyKenGborE1k=;
        b=sMo54D9LezfxwMhXmMkc934dYwmemM3zXy4dpYhgJXsg4hagUxlXG0rrs4MSm21XUH
         gW0Sm7eCa2VhnhX02bLPCUmYfHqURxSzENplnEOLQlHzUvssDl7/2ovKc4rb6CRYeO7f
         8JQblXCJsSWVOuTUJloud4pCU2N4mICUn1DKMDxbKjFeaAGN1wREiNgFuU6xpYRk76vF
         Z3bj6LPaD5eEvMvGohuusmH86oHZguoHHA2Jw/h8CuwDMPUfVvexYjSw6byS9z+9zHNA
         7LD26hx9on9Rk3+tk/XgPKrZ/T4wJp58rGDamnjZvBVy+ZrqIoLde4Z825+eOnZHtQtr
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480293; x=1724085093;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2UAaYeSFYZuqxhC5aYMcc0ucXXN9OuwyKenGborE1k=;
        b=T5o05orHz4orwf518y4ntwN3qgxFiJfh9bnTUjFRMPoGjWkOtCh1kmJS1a9K+PBgO+
         0kkf2th+7LYUZItsMsOy8tI+NL2tqYWQq/iMn10MQbdkVijwomN6D3oGHPVZ7wbz4bJ2
         jHuMDFZLOvgXvGH0q3cqNXSvJqtYEuTCJ0wXmwinP6mnU1n+R9E17L8DkH2MclEW2mN3
         1T59x8s1d7l8xaFNnCjTYBv1vuflGfx5btwwZpr8D026dDk3h8D0oILJdGd8rGfSzjiz
         YBcakN5NnrYjnf/CAa/nqThdXvs2ULZeIDz6PLuoR/h/sBTAJ1jEhbf61Fv9KtTIMz3m
         B7Iw==
X-Gm-Message-State: AOJu0YxYspKzvOHdg8KnyHrJ/RfH9gq0tstuUEGbATScNzz/WljCVl5H
	Sdey/9PklOkO/RKt14FGOanOwpIuVZRjTuTY/xpq3lrwLn1t94REuza2GKUJjmDcS1ldzMY2u1I
	B
X-Google-Smtp-Source: AGHT+IFItJVuiZ9trvnECd1Rb/2m30tH/qd+ElSTJLje9djjPwf97IPaxfdkD3VW/CI9gEt0KJVK4g==
X-Received: by 2002:a17:902:e748:b0:1fd:a0b9:2be6 with SMTP id d9443c01a7336-201ca120518mr6008725ad.2.1723480292451;
        Mon, 12 Aug 2024 09:31:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7e8bf8sm40070205ad.29.2024.08.12.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:31:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240812125733.126431-1-sth@linux.ibm.com>
References: <20240812125733.126431-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: fixes for data corruption and DMA
 alignment
Message-Id: <172348029070.92314.3161917624446152391.b4-ty@kernel.dk>
Date: Mon, 12 Aug 2024 10:31:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 14:57:31 +0200, Stefan Haberland wrote:
> please apply the following two patches that fix two rather severe issues.
> The first reverts a DMA alignment patch leading to errors with xfs and 512b
> blocksize DASDs.
> 
> The second patch fixes a possible data corruption for certain storage
> server errors.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Remove DMA alignment
      commit: 2a07bb64d80152701d507b1498237ed1b8d83866
[2/2] s390/dasd: fix error recovery leading to data corruption on ESE devices
      commit: 7db4042336580dfd75cb5faa82c12cd51098c90b

Best regards,
-- 
Jens Axboe



