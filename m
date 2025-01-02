Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E415381A
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849289; cv=none; b=kQ+MRd1y+4jcLt/GjkpMvOMyxy7bFq3B0/otDgKfxdIAYdP8cEBl4Nb2owsPOlwXjxvR0Mq3LLmAwg0P6ce+DdryMpczCZvPWdf8us8pMLAdc/S3EAVUGyuAoP5pbPfOudtXRx+meBycccFueHE1Hbtl1bgzRHI0qV6Re7JEETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849289; c=relaxed/simple;
	bh=JumWBb5nIHSGN61rQzsu1gRmzi4T+uNSFXoRYBYj53Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=or8O1/f1JvylpKRMpDyLr315nEy6IFpPMI35WbPGNIRJzVBQr4R/rsGi3M8j0G6uKnTXelERD2eFyTGwnBhw8bJ6zggjAZYHth+XcmJ3/2eOmqmi8A628xJGyKtLhTLBrS0wOAZ8urt54teaD9tgW7AWrrSY5Cgxfg6BXnGcxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qHDK7VA4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qHDK7VA4"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a817ee9936so45205415ab.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2025 12:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735849286; x=1736454086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQj7/TAqQGmaaELii8B7kPrdwSjsUh2j6xgXV6VdKdY=;
        b=qHDK7VA4ockM00b5c13KcAkaMitgJ9tYbbAqF1UoViUP+xJfznFYD+PVBKBFUmBIHr
         mrgsizP5hWsQeBh0PRbpWbPTn0dbYm6epqHv0oqrQ4HJuztvcobmsIrTIG4QHbBpWP8h
         W1k7xoWTZv8ONZ2Jt0qKXqS8S5WUpwVEtyiGO3Z/4DYHngiZ5UMqZYF5jIbM2DqLJKnR
         QsbRZlBSPSEP47mTPY92lnS7z9EBFLZcFi8JwMmAkUfNRTa8YnwOfPFrehAz0XVcq3jP
         XftTFu1po9BWfAncdS2OyUzlatHR0obOsYUrbiQ57Msk7smPuYrmHvD4sc+aZwRrhGKv
         Y4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849286; x=1736454086;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQj7/TAqQGmaaELii8B7kPrdwSjsUh2j6xgXV6VdKdY=;
        b=XADc310bNMSBtta5lTaPPEleNve8GkUrrOAA7+g54J/nRIRBCrv/g6m9zVTMxH3oGM
         tNTpB5HSb+NgYlV0NzAeGnSTQiAXA1/SyI6NeguPyH7i9TXvYcN+93Br+REiW5Tvp979
         8DQRjUpfx5H4gqbnA9a60uGeS1wmp4EVq2gP+7q4u1i0wX6E40x1n2pAQcjZ3+oxuqdl
         jphwRKtCv9brL4cB12n9phUWUa6Asgxou3mD2GxQKVeFjCgUf0N6s0wld7OOI4qLCxO5
         SzSt0PCB4VidIlnulA0xp0Dzu6v5l4Qw38OngG32ii/UShKLLlrxKwr8XDv6ZTaHs00e
         WgrA==
X-Gm-Message-State: AOJu0YwHELTsdiVUW5BYvX3QZVW+1t8OxfSFMY3wFYkz9f0ewDFAlJA9
	Pg2yuFCDGCFZl8T+QkLmaJBzF+p6WnCcLZPqkTmq+jG8b6toyXHGMdw472auDv7vw21yrOmlAGe
	0
X-Gm-Gg: ASbGncupXN08xBEI1TY/lz67pJVZ7L+EY5SDOGWDvNwd9iQYWzQ34gUITchQd+gv61Z
	tTC5K9KStQHgmu8as6NCAlmWaCZWoOI5UWZocTGvOYfe2TGsH3Z4XY7gKwJI1vxyRGpfm3P/ybV
	GIBe1hlZXUxEczduObQq8Ue+Iz/vkZIjCax/ygcHV40/4+RqEvXgnU3wEt0S2G4OOliuTO6FM9q
	yEZuVYmrfyKKxpNzL0OoU2Y3b9DKyFEEkeKv0St2tnesSKP
X-Google-Smtp-Source: AGHT+IHN8qPdx9jfG1C6BadYbkKtUzRgexy5nix41wzqz3UNkxA9QwAAEyfwZ+/vnXeye9/t+qyjew==
X-Received: by 2002:a05:6e02:2683:b0:3a7:e8df:3fde with SMTP id e9e14a558f8ab-3c2d25770eemr413873585ab.9.1735849286576;
        Thu, 02 Jan 2025 12:21:26 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e47d6cdcsm76674995ab.71.2025.01.02.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:21:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
References: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
Subject: Re: [PATCH 0/4] elevator: Enable const sysfs attributes
Message-Id: <173584928561.13542.14117952218838427844.b4-ty@kernel.dk>
Date: Thu, 02 Jan 2025 13:21:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-14bd6


On Thu, 02 Jan 2025 13:01:30 +0100, Thomas Weißschuh wrote:
> The elevator core does not need to modify the sysfs attributes added by
> the elevators. Move the attributes into read-only memory.
> 
> 

Applied, thanks!

[1/4] elevator: Enable const sysfs attributes
      commit: 044792cda05a97ae1da330771ec2140ae86439ec
[2/4] block: mq-deadline: Constify sysfs attributes
      commit: 8686e1dedac7190d2f148b23e4f1ac69d2e37d6b
[3/4] block, bfq: constify sysfs attributes
      commit: c40f9f6ac59f949b6cbf10903fa2aae76efffa20
[4/4] kyber: constify sysfs attributes
      commit: 00aab2f236f25f3dc3c88eee1b8ccb0cbcae3f99

Best regards,
-- 
Jens Axboe



