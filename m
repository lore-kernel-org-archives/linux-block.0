Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6093C4B93
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976891; cv=none; b=I5lV0h4ReJLxph0LK6NBUdBVPPUed+S8htKqx3elmjoryDf7Qpex8/0dPM5SNIMtLdkDSM81GNmeaexCLB17mXAT7sWJaVcTGXsO2ghoH+iv6dFu7lqfi93LalIbTz8qX5KVhFHVFaXsF/QdpNo7wk+e8PTgDI1PW/1Gx0tjDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976891; c=relaxed/simple;
	bh=Nmu/bwhuhhc0BFEyg/da6XQlY+/wz+/Vt2kWbJv1RgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=envWAKpqhwEHZG+1602stwCI2mVgK/PQ05e/q/ivGXZrchZnWBu7YFkE/UrDM4AdhOA5rQRR5JvbjpgKvze2XST2aKMdkfRglsF6GMUx8PK9eh+NY5geDFblL/7XMCzZBJzQSB+iIzEsKvUNpui1q1Ze3T1RynZZ4fYLDDfgNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IFD+T6uh; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IFD+T6uh"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43a86d544c2so5982540fac.0
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779976887; x=1780581687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT/caR/tb1ol4uoE/D77zt5k26i8eBSQ0KViv4fc7co=;
        b=IFD+T6uhpENmpatJsU1eU7RRiJLWMl51RL3aJkOZMXryGNfoT2HiHAiodO/aoBnei0
         ciHlAMU6u+1Vj6JB+LekWQUYybFDA+SWU9g8BAiNwx8iMsMi21nHwtcopOSqL30REayI
         zU7ZPwUb8+eXCKdJyU+8CFlLuuHQU2Q0U4AehqzLV7gv2S1RqMUkoUFwT6Eu0VCYkOR1
         ek9Wlj/oEuVeo9zEWQQW4Je9XvAyvzcThrZlFsaT5HKg84uvsNZY+qaKaIiOcdBbSYzk
         ykh4+89tiaQqB2pSLJ6JFueBF2w/Sc721MW9Qxq+zHtElBHtJ3K5XrmnuDvDw+em8dyX
         rRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976887; x=1780581687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NT/caR/tb1ol4uoE/D77zt5k26i8eBSQ0KViv4fc7co=;
        b=Dyu+bNi9OYxmMpKQ7L1ZDGih03Gz/GfH7INcH4e+qR5ooDFt+EKlmVC6+fUo0APj8c
         WFNEdJFIIITpen8Y3jHwpByQj+cVwM0FubSOnDzv2FZNoXMJcaxZMpmUfN050jbQ0v8S
         BtgfPQx8UNs+iHdt0ahJ+Xrn1qpTLSRRg2M3vTgg0uoOsrABcMcZRMR0xsGv9ayafZc6
         ATeeE8nTeOrqBnRD+1aD1nqCMn2KRoCDiFWnhcQEbWz9NEcteUcM9Gh/1li3+PIc+UHL
         S1Ls1A/tCkw7YBDjKl1z0eUwdOjjJ16D4sPicSSjLzdfL8NNAE7k1ZAsrdMX3+hP0GKg
         7N0A==
X-Gm-Message-State: AOJu0YywqXlSZREVoRHaNTRmT3YH0NpkJiv6E/QuqtOzXDdWkah6fxxn
	oMW+h+cnEDqWu/BO9ATfb/PKK6mc1wQW2jxnKBOVRW0v30+IdMD+N3sMdsYe3tXC0gI=
X-Gm-Gg: Acq92OHEr29DEBTa8y1dj+ttR/4n9FpQtx2M0Se2dpEItiIcNSZgeKvggSyvU59CYua
	HQu+7HHoesNojW8qETanVFrxYejzv7++89trk2zYPvwvRUHbCjb28FM200daFpEdWq/kUoqdqDd
	lmXPJEJdrfor+8V6KgPjBh8ZjLy4wBfD3+ybfGTlwd0kQI9BF64Eqc7kf5gVTFuijEcvUrmZedV
	7PwbMdD9oRqwceFqyAAM5lf8DKp+qQ7YJy6LMbBycJxsSoyjrnZ1OvKH0wxZFGpFS8IqHs5EaTX
	nYmw9VZHkfEiy7tvM63BhGPs4OHMfKYMAgLmjUG86vNiFBYQ9FPIbl+VgmcphMU1ZmfVFFfYskT
	f8nrA3D7hbqeP5CHFMmWt0GZBQLTP4CIdfkI0/4TEsp+6afyawQDeePJVUS7Vgpc8nAGGahiPNp
	4gEkjYL3dR0FW5fX3GuPePrT2CHFlNWfwYN8/VelrOz8GXKE4FUSiX4Km0IO8B4R5R23lwLH+Gf
	8Bh7AyNJExbwQ==
X-Received: by 2002:a05:6870:e126:b0:43b:8753:fd65 with SMTP id 586e51a60fabf-43b875475a4mr13626748fac.14.1779976886871;
        Thu, 28 May 2026 07:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17356278fac.12.2026.05.28.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:01:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260527150646.2349405-1-hch@lst.de>
References: <20260527150646.2349405-1-hch@lst.de>
Subject: Re: [PATCH] block: mark biovec_init_pool static
Message-Id: <177997688561.93541.10121058312801520995.b4-ty@b4>
Date: Thu, 28 May 2026 08:01:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 17:06:46 +0200, Christoph Hellwig wrote:
> 


Applied, thanks!

[1/1] block: mark biovec_init_pool static
      commit: 353c85082a82fa6d78cbb3821749d5982ffed9f4

Best regards,
-- 
Jens Axboe



