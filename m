Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531513C918
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263355; cv=none; b=uRn8+k/nI56CA1CtzeAbjZEMrREruWC+lKnmbvDI5X9/bir2yvA5Qfv0aw2qi48osSM2worbdKI/W0bjWiC3KC0mN8jqL5/nmJxwrm3u/Us9B9JtD+5OFMM8gZJjrWCEcIMuwml6MGhK93zhMj5ndM5vPwwTj5/X+zbsj37A//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263355; c=relaxed/simple;
	bh=iPyI+bxGDzJdunWbBXAgEEG27s3hk51sj5ATRVEllRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VZpmBz2WkoeduOpq7WYU6jBY1yVou7zS5uaxaYlbRrx4h8YzBaTN3dS7eQQYcN8sq1MCuQjgLDaE+MHNRwiB9E7X8/QHlnlXWzVhO5j8inl+dFiX+DCkQByt9Xys3wZrkQwPch0pkwlUXNJdGOCXPK6APWeMy4WQ2Z+TJTrIVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P3L9MIqg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P3L9MIqg"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45efde72438so334147b6e.3
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770263354; x=1770868154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmIj1nXvjc7KrTt1sIa6RhdCvmInGqA14FaqO/L3jio=;
        b=P3L9MIqgAL98cnOx/lYZWRxe5tZ1DiHRV9hyE1YuB41Q5Zlq8E19or0bs3cSjoUgOB
         NhFuvXvG9StHyiYCLDOITs6/LNrcCL+wlVtHAAyob+2yCwBwwYE408cd5siO1GoDkCxl
         oOsUfHfryUztXGNPvKGzoYSMC8g4WS3G4odW4tUGzhyNIcb3xAFnhB0kzb88DNi177pD
         YP6jpxsGxqQioFJfUTcZP+s170tED5Qg9S5pzHqUCrfVY6MB2D7RsrBdkROvLjbxi2Kc
         zn25oM2SsKG2Q0lnS3aesScHII3vQd62gHE0enDQt5w5NX3DFXhbRxgJSpTQk3eR56I5
         mFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263354; x=1770868154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmIj1nXvjc7KrTt1sIa6RhdCvmInGqA14FaqO/L3jio=;
        b=AGjGcdQufZQS53eotcdE7KV7/ngAWpBArvgB2AzX38LM8/m2tFz/deWJRiaBKX4Qo9
         hQaovmYF9r8RHwA7HB8Tej5XgdeFMzdpW7aynpiTDU1cxR8KbbPNEtq+VuOMrZgLZLF8
         H60b3OqqhznNEgiA6aFVWNYx+k02ESbnzNPLKX/40lOR7+HOHWt/6g/qnAdLoTABGOr9
         ZWewdnXJLNEYQF3hJKTIltBpyysh9ZWHYS2m8huIygqll8Wo/Wz5OtfviEEhqVAnGzvf
         tPNG2HMfuQZ4yjCaKKxiw2o3gLddjBC+3wKRtgf90xsrldVC54rolAvAPD2L8Wu/K92S
         CS5A==
X-Gm-Message-State: AOJu0YyOXYiaCLjkVtgo4iuXU+kVMij5w2+oOvUnfdgFpocjbCXLxdtB
	NqHb7IF2c4P4LopRYZyvW6qzdubBZKweSwcuUr68tv8eLHmh9e4Uy7QivjEbrFD1YSroON7JWjd
	OhlWqA2I=
X-Gm-Gg: AZuq6aK12c+UZDZ639jLVuVtNP7a6GuirB554vZUtxNa2LlbhxwBWavnaNZrJQsadXD
	bZC8CFCQwisKdup7imfP5oc7Ss2yj1gReED0a8TXBsr+f/Khq2EWvAt3POMe4VDYg/uoHGGXztd
	Xa5NX4y/ModFyct7UeKFnvZQPh0HlgJ8KEM2U1Js1h54lqYHqnB+nqSvIMJrcaF2jdY4tXnOlO7
	0rE7KpnP2N+zKgJ+X2QNkChtN0v/FPUVnxmu/OLHGpptwGiul5fTv+kWYj5T7kS7QCxrS5y4zu1
	t1R38n+Mw+sXODDmvOkR4pOVEaj7gTlGEtlQWdOOcU7kbdTRNYUcHzQUmaurTQ5zf6RG9sJNV9d
	38UMjaz2ZjI9ntsWwzLv3mXAs2yIi1Rsyd2qm6S/FoFDp1LeByK/DCRbYg9yrUxuLPRFzixDqqL
	f8LAF/DjJMEvq2dgUl7s58hUwuncd/VsuxQhPXb4iI1MBJZUDCnVe5ZkAW0wm3MwEb
X-Received: by 2002:a05:6808:1407:b0:45c:7c9e:854f with SMTP id 5614622812f47-462d5ac3b09mr3312674b6e.58.1770263354251;
        Wed, 04 Feb 2026 19:49:14 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6608caasm2419841b6e.2.2026.02.04.19.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 19:49:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260201031044.99077-1-ming.lei@redhat.com>
References: <20260201031044.99077-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: organize test directories by test ID
Message-Id: <177026335303.38867.2536120561689520738.b4-ty@kernel.dk>
Date: Wed, 04 Feb 2026 20:49:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 01 Feb 2026 11:10:44 +0800, Ming Lei wrote:
> Set UBLK_TEST_DIR to ${TMPDIR:-./ublktest-dir}/${TID}.XXXXXX to create
> per-test subdirectories organized by test ID. This makes it easier to
> identify and debug specific test runs.
> 
> 

Applied, thanks!

[1/1] selftests: ublk: organize test directories by test ID
      commit: 5d3ae80b4dc43d1c49f5ab6e9835ae5fc9ac5d37

Best regards,
-- 
Jens Axboe



