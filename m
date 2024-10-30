Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370401EF094
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296189; cv=none; b=Fwl1+55PRBx8fnoiD6jDHPX/+DcO6UiMIffpIGPtaBM+gye0JJEYRUTj5XHGBE0LoHcm1jWhPM4vHqUdpPh893oXdcCJi1Ht7vA6gn4++kR6VxZ1o35j6tJyxQcxk+5j3Qxubrau3QOoc2yoJCvMOGCZ3YAkejwqHLu8ZjqOJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296189; c=relaxed/simple;
	bh=3BYU2ds4z4+5PHSTJV/1reuANUbhDLoHvwkjINQKcME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JzZm18T9avGgxPFbvAnyYtZQ/3w1x6mUjXwsihyoqiKBz1hekBkHeM9By5pyH47hTLCfW5AmpO55YvfklJODTxi1XnWLXF1rrWo2220o+aq6krUNxEhcukLYJ4vYVD6FNBL8ncl5Zfq+5oQKFYui3jsXXpDxUZHdrvXTYTGhcf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VGcDR8P5; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VGcDR8P5"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83abcfb9fd4so246104639f.3
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730296186; x=1730900986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYsdZYXwwUxJFu3sXtGLMhZDvIX9hIriU8h8aCKckQU=;
        b=VGcDR8P50XtE4w6Crzy5Cn7kup4/iqlVtSQB8/Mx3j01noxwtaL3KN55ZCNo4SS8+Q
         a2BPaNv0/0h/K/+x3/r2csKbUmtwxp1BvuyREjM6T5IGe/VToWtEo4dxpay32NE+bk+N
         AWdfGGxUhPSeOm7t2qJzbaUlZH+S5/YjIJ06mRQCNaeCeCTp4VyvOtOd/cAxn1jdQCT9
         9kLJV33AwEo2HidAsil3aYlaVIO9tyyikLrpKNfSk0vJzTkf/7IC7Ek5E6kzHMgUA0+q
         s7NI+hDEJgBWQppDzJQAqoX3o7I7Q36b/1ptt2QS5zobPSyXwfqnbj3XxBUdCwzZWNxf
         mfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296186; x=1730900986;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYsdZYXwwUxJFu3sXtGLMhZDvIX9hIriU8h8aCKckQU=;
        b=r4q4EBFH/DUoLRyM14GNEn5Wcxw8dpGxDNlfxzpUzAPF1alesoFWmLlHvcFIyiMZyS
         OGr/12uZ450pNE+t8qb0sCisYLWJSBaoyPbQJ803v73EMFa1faPfuBY0OKZZXIVeWFgh
         /3Mnxgzmocw1lzDqQgauotKo+aWL44VoOAT9nEjxYd4u631SRjxBL0xhysPdqbJ3rOUU
         7ZXJuLyLOl8xVRERzYdmpLjm3Tbu37lez0Kyb+yDc33Md+p5PvUrW1nmDknsqgedN4o9
         trLbrdN4HNuwQ3x4/WBbyu7tiZr372jPqxZBhPumqoMNUhuxvqWNH0hsFNVs6wfBbts1
         Ob8A==
X-Forwarded-Encrypted: i=1; AJvYcCX3lWhhsuBEenpvWbQRK9fpmMVmKJni0pKsrYTTb71nLb1HIvQTPClELzKcAgt1lsiPL6rnFmixLm4FKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpKHiTWUqP4rtsrZUO9Xi+Q6vHr3hKBWZ38hv95DvCcY3j+xO
	vGG8zb24hNGI46KtqFTP5pF3tC2E92rYAZgbcl5VkF5llw+9tY0gvi46um0Me4w=
X-Google-Smtp-Source: AGHT+IEDeF+Wj5cyoCVhRSF0C5y84+ToOKN38nwGUehJA5QZqpsqahOdauATyckQYVxiKmvLAf2skQ==
X-Received: by 2002:a05:6602:486:b0:83a:a82b:f861 with SMTP id ca18e2360f4ac-83b1c5f409bmr1752181339f.16.1730296186325;
        Wed, 30 Oct 2024 06:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc7278223esm2910818173.128.2024.10.30.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:49:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: anuj20.g@samsung.com, martin.petersen@oracle.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
References: <20241016201309.1090320-1-kbusch@meta.com>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-Id: <173029618536.13614.10643805204229304867.b4-ty@kernel.dk>
Date: Wed, 30 Oct 2024 07:49:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 13:13:09 -0700, Keith Busch wrote:
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.
> 
> 

Applied, thanks!

[1/1] blk-integrity: remove seed for user mapped buffers
      commit: 133008e84b99e4f5f8cf3d8b768c995732df9406

Best regards,
-- 
Jens Axboe



