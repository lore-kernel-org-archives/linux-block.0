Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA71B395F
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549370; cv=none; b=A/nAyK3kYkUPvqazO6/99O2ssLvsaeS8H2AGIfMGa9N/T6elUYivovhaeFkGjUkXHqaDPXJ0lytAGTIU5NIZZP2aJ2kuMDWizIZ5ZZxeyi2kO6+i+WWGYA73h1zoJrB0o3OopmrhFKov7JcH9cwYbOL1StaP1P6KeXgBtuMBKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549370; c=relaxed/simple;
	bh=3qfaGKvrmcZpSYyOs5ufvgBqAGe3QaXdrn6DVtKyQMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fdgcFlsR3I+MqTiY34bZQawoe1psKSZTs8+pN5QhFkJ+jw6LtnNZeAjkiQjNMYsa7EW6ADDQyQ56tiQV8iJldzIaL3s5ORo9l1PLQ/PkmqNjHiFUA0q+0W5/lWIXjlxZxNtVu3dM38Mku7u+SOzCVmwkWiMa8oYYFNZDxaX5q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vcbTVFYW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vcbTVFYW"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea53011deaso217905b6e.1
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732549366; x=1733154166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGQKLVi2g7XMVrzZl+9pMy5LJRBb15i9OHUSIDCOuTI=;
        b=vcbTVFYWp8fchIgwgtGpd9IatKNmj6O/LktO/kfdUXEzKYpfnY6p3/hVyhSt2Caxgq
         qafVODsvb4cNU/D4RpME4n4q3Q5eZsnBn0JGzk6EaDJNHsQTyohFd1U6UZTg0CxFPb6P
         vtCgJDd6WUPPFae2eR2AzeYmownjHoeUv2praGVm0Mq9vtAu6wCF1Hwg9uYe/xuRx+Yo
         UqhkCyU4YSjARf06lWVr+saPJdw+nmz6NsN15/2AJY7N5ToXPcwJHnKDZm26IHRvuij5
         D6XACd3JuY7biBDQ+iSBYg2ckbbS+UTlH7o4OxMfTK57Poxb5DflTcxdou5z6tlqr+tX
         I8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549366; x=1733154166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGQKLVi2g7XMVrzZl+9pMy5LJRBb15i9OHUSIDCOuTI=;
        b=Td4eAi/D3lee7Fe1+KeBFnQdeejIZXQhmUA3+NaDbE5EwgUNzDEqlsTsPsjib5K/fB
         3ztHmzfmdRwchkA5bzM+6ymfmosKX7NprbB9xZBf8bWQIL/HA9t69CPnT7Gn80xsvGPt
         TYupO9r49uysh/srj6nwMOV0aqJm+hg43YD9dv6V+Oyxo35Mv5SijtHdWh8/REO5VTKR
         gEOcigtZ8oQgehHczTM5Is9ZenM0zob8BsCYAqCyoVHIH+r+FQeHeV0GrNxV7nJgAWKr
         Zwwy/pvOioJdYw6X+cV0SGSP5pLvdhglAQLMMqVepviId0hZZU4WsrI0lSPiYUj+ajbY
         Hseg==
X-Gm-Message-State: AOJu0Yzkxzeuc1RXNs3Lc8frH9Ed7WVHxMLJU9XFLAXxR2jgWv0YyGuD
	oP+xYZSC1ryR00B8DkuEvjFhjBKZTJv3Q+Zieu/uzTRbVQ1YVpD/XQwyDNnmcyd9Y0k5KvChNSm
	wGDA=
X-Gm-Gg: ASbGnctU78IYnMWrDb1fFkQ2N/cwpRvt/GbdS4GRaUAbaLaU+HX+Mich4qYrP4uGqIw
	p8ZUHM3kEGz9iVMSXpCfr0nCTfLcyWTlPuj0C/5kkToE/uZi2uW72HuiK5cEBMqjC24riCIfJOO
	BNAcHegL4A8NBWp1dejKl7YQJZpoFBY66/bvdUQD9ghsvABz3VA7SW7vmReGpCyY1TSiHUGaEKW
	enVvzaNAH9MftIHwcUU9koV56IoRNmwaWniU256
X-Google-Smtp-Source: AGHT+IH17Mk8W5OEETM80r1GLFohk1Pyc8dyg2KyV4CpNWaEaBBrAwHRzAS/tBgVkQ2WITd3F+JA3Q==
X-Received: by 2002:a05:6808:4448:b0:3e8:1ed7:e6cf with SMTP id 5614622812f47-3e9157ab353mr14008449b6e.7.1732549365866;
        Mon, 25 Nov 2024 07:42:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e8adcdsm2326437b6e.20.2024.11.25.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:42:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241125100258.4172774-1-john.g.garry@oracle.com>
References: <20241125100258.4172774-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Remove extra part pointer NULLify in
 blk_rq_init()
Message-Id: <173254936500.18678.5955333216581652520.b4-ty@kernel.dk>
Date: Mon, 25 Nov 2024 08:42:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 25 Nov 2024 10:02:58 +0000, John Garry wrote:
> The rq->part pointer is already NULLified in the memset() call, so - like
> for other pointers in rq - don't re-NULLify.
> 
> 

Applied, thanks!

[1/1] block: Remove extra part pointer NULLify in blk_rq_init()
      commit: edc80c585772cac59ef780899269436a0823fe67

Best regards,
-- 
Jens Axboe



