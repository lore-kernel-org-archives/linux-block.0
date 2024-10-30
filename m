Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DA61FFE
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294646; cv=none; b=FaG+yhoUwVBt6+u44EXqTedT+Hq8adcJeuSFi9lK5oWT5bSInrslSaEHl0MliAx9hY/cUzLe6F7Hrv8rQycXN1O1ohNDHH9tLf0EbkGIi9f/6jmasu3cXQ8kWfxllTm9CqN8miJARK5JDUpBwUVSNyUTRZVgKDePXAQMPan3yzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294646; c=relaxed/simple;
	bh=J4tNvFsAU0oyy9UJe1JV0ODTjjbe3y8f/cZKSxCiCQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kDrmQNQI3ajZdcgRliMRZi5u5cNicbj/Bpfj6L6hsGJSGyLQhV9HrnKMHVDmzsGfJnxh27at++T0yQD8GFqNbUrEdOEjy+glrddiSSh9GidnvaZeU8zyBx7DWhruEmfo4X9VqjjCrVd3lWx9+VKWui61pRv4INnbg2xJXoVhKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W23MSUd+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W23MSUd+"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e30bffe3so19888155ab.3
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730294643; x=1730899443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuLcwxvg4aKVVQpXc9RHyDJ1aHCs6rFcVSR3V26kh/Q=;
        b=W23MSUd+DxIIZTU5mQ3ITNPmp1Y0AEPf52SXCt+tn0AsKGBFxZjiS1F4uDlFnDl/e1
         NejQJ8esUxSCD9UnSQld7ypILQCLg62biNmK0FnAtkIOcoGgMIxD2SmHBnRTYYongZCC
         IWAd9xttcDmSfK4odprRAmqogSBJx+qCWpSa+v0zpk5RlQlAgJ4+gV7veouuDbMfiZro
         037J8X/3PtisMoBNP6iqDJvtak/gysRc/KCkHVjkAC0w4dZFkInYTe/NR8NGqYMaf2p7
         WvVPlrZoq3jVLJfk2YPxvMwVFmv2LxTbHvicYe+wZhxo408CNUeJNIwGvl+RHOq3L1Pu
         /YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294643; x=1730899443;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuLcwxvg4aKVVQpXc9RHyDJ1aHCs6rFcVSR3V26kh/Q=;
        b=F50B6aKH76h3BTC0FUAu3PZZcVxlfMxI/4iYKNPiqUzybq6qOYqi1LRxSJ2mw9gTHE
         oM3rfGUa76NsGxTAnc+nd8GUFZhwRL3uGJZ2DPQVE4KCbzuxZM2MUSiXj07Lq2tbGMyr
         KSxNmhzdfQ17yuWpIBAH7ERnjJX9VLzeXEfWjlCY1Y6vz4TEIo/kfx0Wipl3r8tehyvf
         Hixni0gtGmV0iAmPWxuOfFg6krBc6URGaa7+fqoY15NWBUo3PQRCGehd5IzeRi/9nw4u
         IZmyLbUQsjzyiyrXascXq7eggZb+3Ee4dEaBur1geMhUX/QsbabLksCcaIb8DXpSEo0F
         hhOw==
X-Gm-Message-State: AOJu0Yyku3bWFMN2OYYIBjgdr1j6Rum3ZGi2UJ05QK4aveUCCp45vT59
	Nz4ZRkznjEjm2bs/xMbaUH4pj355il8t2PZRO9jXMWsDllwgArG+d8l+6XdWuo/0zhwnTNU2Xm+
	D
X-Google-Smtp-Source: AGHT+IFR/MjiFjAkiXS3+6bu1Wp8NyiD8RP57EybP/Y0iKTte8U3yjnanm2Sh/eZ2zuLlWhRpLDuVQ==
X-Received: by 2002:a05:6e02:1528:b0:3a3:b593:83a4 with SMTP id e9e14a558f8ab-3a4ed295bb6mr138461035ab.14.1730294643309;
        Wed, 30 Oct 2024 06:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a5e7c159c5sm943025ab.74.2024.10.30.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:24:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241030111900.3981223-1-john.g.garry@oracle.com>
References: <20241030111900.3981223-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] loop: Use bdev limit helpers for configuring discard
Message-Id: <173029464188.11526.7633767288761868544.b4-ty@kernel.dk>
Date: Wed, 30 Oct 2024 07:24:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Oct 2024 11:19:00 +0000, John Garry wrote:
> Instead of directly looking at the request_queue limits, use the bdev
> limits helpers, which is preferable.
> 
> 

Applied, thanks!

[1/1] loop: Use bdev limit helpers for configuring discard
      commit: 8d3fd059dd289e6c322e5741ad56794bcce699a2

Best regards,
-- 
Jens Axboe



