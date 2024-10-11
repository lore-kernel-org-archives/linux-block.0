Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E71A00DF
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666713; cv=none; b=aBC46AyZfbV6XuOAgtL+resgy9LxoSD+Wyw3DxnAj2EmI5bSdGmcE0Zd20qQvi4+ERL4EEQnExJbTmaiiWYnngmK+SWhqm6EQXo5y8nQhI60rsPkzmYkcCQ8GL98LWU/Toe6JwblEZUfQICGkQKhOy4Mydh2/MxAd1PDG2r52nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666713; c=relaxed/simple;
	bh=8dDA8zUCA0ufN6YZTUcwbyZZD9nq429HiprCNeDaAes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtHKGoG5aWjMxAD5mWzM0l6PaD+Nb/RxAqnD5IpOq2zQzTwr0tHb4/+rfMiwDAWp3S9JjTSopl/4eAiIn8SUIYEB2qIGBjpjwfmHHrY/TfbPwa56KKe5CUiMYp2bPnfTvTx61nYuFeVL9qsc0bgw3zXuudNmqSnuI23N+UdmfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1yOUQ1E8; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1yOUQ1E8"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so7404945ab.0
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666711; x=1729271511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl1i78brjGAuvA9ZnmYYUqyA41KtOxW10zwshpfXTuw=;
        b=1yOUQ1E8VaMunbMkHorpGpgShRb0elV/cmDOQRIO3/i/HIo+sWFqnTIRAvNuwU3reI
         liq/tklUbAvJqS5aUvibP69tORMTP6swIxdCoVbErlUrR6iltDG9gGYGD5SAAkqaid+Y
         nUeNMP1JKTud1uLzfNgGAWyp5j9m4nmiO1uGGRPoRISmDjumk5xXO7e/0I5NmE+ADdTT
         V6L2yVdBPX2Wu1mRt9Jy6hCmkLcHdrDuXqh67LtNO6IQ34tCYrOvTC7QQq+N+iruktuk
         Xxo2uw/wObtowoF5K6Hc9YAI0Nabrhs/0Xb/xvnjQ9F5qUvZJRgbTQZnjw+TsND/zqJl
         gspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666711; x=1729271511;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl1i78brjGAuvA9ZnmYYUqyA41KtOxW10zwshpfXTuw=;
        b=l/E3OASDEiSO+59R7WXUTNag6MTk+/9sr2UT9LtyZyq7lhQStiCggcrBqq+IBztmxy
         zCjhf9O/XDplNeT7a//M47hZ0DaFC3yXLDuBRlZMbOxdbfK4Gf4KFercWfH2lzDXQ/4L
         Ij18avmCA2vsvQXic0lHj0JPo6VR9JnGuh/v1OUgtA+RARG6KaDRd4xgHCBBrC9xKRXU
         Jzan/nAYrh54bdFPhDUJSnyYLyAJd7LDNDsuQVMQEnL7dYwjHHkjPmfrVeQKQeEz5TIE
         /h0W3VVe1ctTEpfeHXsomsP7BUPBY4xOxjC1Xh7I3diWaL3baDCb71Uh1GO9CIWh7mJH
         RSDw==
X-Forwarded-Encrypted: i=1; AJvYcCUECn0nlZYPM1jvqJ0VhAqWLJj/iQLk7DdQQYRMC3q0BKhsOX/LV9/fr69X2t8pjme5SJthwyrOZ35Zew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEtY1BEgdcrCTkm7Nl298FCOf04BJODaJs1uGEhjHd1dmZpYP
	28bVIKOfa+5+I1WdW1/19j8RjSqnbzUveBdRBeb0yT61MImoiEhrnz6m/bfj85xGv2djVdkTml7
	wzyA=
X-Google-Smtp-Source: AGHT+IEZWvr7qBTTjS/tuenU1bjvPDfbBSeZfkqk0imNClzLRq7tKeY/fBnJcfKDU9r03JNOKR3aTA==
X-Received: by 2002:a05:6e02:1809:b0:3a3:b593:83a4 with SMTP id e9e14a558f8ab-3a3b5f9e4e3mr26348695ab.14.1728666710924;
        Fri, 11 Oct 2024 10:11:50 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241011170122.3880087-1-leitao@debian.org>
References: <20241011170122.3880087-1-leitao@debian.org>
Subject: Re: [PATCH v3] elevator: do not request_module if elevator exists
Message-Id: <172866670924.255755.8635464713478237933.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Oct 2024 10:01:21 -0700, Breno Leitao wrote:
> Whenever an I/O elevator is changed, the system attempts to load a
> module for the new elevator. This occurs regardless of whether the
> elevator is already loaded or built directly into the kernel. This
> behavior introduces unnecessary overhead and potential issues.
> 
> This makes the operation slower, and more error-prone. For instance,
> making the problem fixed by [1] visible for users that doesn't even rely
> on modules being available through modules.
> 
> [...]

Applied, thanks!

[1/1] elevator: do not request_module if elevator exists
      commit: b4ff6e93bfd0093ce3ffc7322e89fbaa8300488f

Best regards,
-- 
Jens Axboe



