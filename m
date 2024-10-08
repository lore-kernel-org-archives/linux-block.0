Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98111DE4FC
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400449; cv=none; b=TaZgRNmDKViHjlqJrLhw6eG29x83XHruI1ROt8FWGWgOBb+RQ2gBAjDE7sVU1et88SsIW1BseOgQY8PT3PeOG4a3Jw+Ot5Z08n63Sn7FRSIXYkDpDmnAmqAmuD8dDqpwxTNmWvLBKg7DI3cCuLl8/Sak5jtrWl0oEc+98CA0T7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400449; c=relaxed/simple;
	bh=+RBeccNF54Oyb9OZCGBEuaZVGC5uRYeWsUsB0zlMSj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Py2/AvLJqIHMV+l01P6P/cXh6m1rVx2a80nB60QKqpXr0M7P8ZoSqzxVSPKy5V1+mQbshGwhaOpUXdb9nTNxefFv0WD2toMjpchTZSqMbZlkoAdI1mZQfUx4BADbTaEGPPxzcviwGqbB0oBYkVcpUnMiL70m2MtyaUwLRMI6lf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2TTpDQL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2TTpDQL"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27e1f62e30eso3115570fac.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728400446; x=1729005246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9unpiJCmaM/90BIThnIApTXc7RW1tNCFD+q7FeSDSU=;
        b=U2TTpDQLr7lRIPeGZeTBYfftm68oXR12aX5kQCPiK2JYaWP44nP7xlKt+8WVBgBU52
         9aMG6knEs/cHBhr37dN2cahbLUfdLld5wf0shwOptPMwAbSDTWQUs1O0R+ERS5JLvx7J
         lN8Y571qXIOijMbQFd4G4q+d+NBKNcA7gSI00A1NpM0teOZNKbYfsqav5pjZlMX/aYnf
         i7OsFbhBOR3N5qLYPVvEWHNbkmd94Ww47gFOyS1J7Lr7HrkCpCVeCQZSHoAk2OrpID7J
         B57sQodfKJVGxdxbgFSs1tjogKh5RTf1nfWNC4fJ67hSOAN5/I53Xj75cHCakCqfLIlp
         d94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400446; x=1729005246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9unpiJCmaM/90BIThnIApTXc7RW1tNCFD+q7FeSDSU=;
        b=AnNnCcRu9ZoVg1AHsM8UQsDOB8qhLVgPbkzqahxkXCRwUVgWzf8OFbjXvelKA3yPeX
         mLqXCW8kokvYsyXVjlO3vhMIbu8KAEt6vqR/nCCrxDt/lsWfmgTvUwETzNnsNJgP3ujI
         +bHJ2nN8ZuiJU0JKIM/YBPf+ab9/gq/sGq5RJbzDAemd9e/CMdgyaYXsacCZRmr+TVxL
         7kYcNMoHl87kby2RNaWwV9uPnR3VbqBqoL9SKh5p9Tc8OmQEXQPNmxg7vTOhKwyGoDDu
         c7UQj4dBA02qCzIUFJV6i1+wOXFOk6U9BQO4870Lb9d/BkPQIvxwQOblx9DQrSe98nOP
         VtNw==
X-Gm-Message-State: AOJu0YyXM0WKAnGoPhTtHNVw9AGkPS5NyZ9LCVpM1myIeLwMxXWT8w9I
	fAr/TPtoYl5nlpvPl7M9DlrYYj6TU1TSiaRcZrR8gCiyJ+SOs6OqyX2yb7UdywjeJP66SvShTY8
	AZfE=
X-Google-Smtp-Source: AGHT+IGQp8oawiSk///+k6L8FedBDQ4FI1tKggdewW0vHRrgMWOym1S89gmStWTP+W03dFRHRMl/FQ==
X-Received: by 2002:a05:6e02:1d84:b0:3a3:637f:1012 with SMTP id e9e14a558f8ab-3a38af7899bmr30255855ab.12.1728400076614;
        Tue, 08 Oct 2024 08:07:56 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db84c47434sm1071055173.43.2024.10.08.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:07:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20241007182419.3263186-1-ushankar@purestorage.com>
References: <20241007182419.3263186-1-ushankar@purestorage.com>
Subject: Re: [PATCH v4 0/5] ublk: support device recovery without I/O
 queueing
Message-Id: <172840007574.12645.10207244713759182674.b4-ty@kernel.dk>
Date: Tue, 08 Oct 2024 09:07:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 12:24:13 -0600, Uday Shankar wrote:
> ublk currently supports the following behaviors on ublk server exit:
> 
> A: outstanding I/Os get errors, subsequently issued I/Os get errors
> B: outstanding I/Os get errors, subsequently issued I/Os queue
> C: outstanding I/Os get reissued, subsequently issued I/Os queue
> 
> and the following behaviors for recovery of preexisting block devices by
> a future incarnation of the ublk server:
> 
> [...]

Applied, thanks!

[1/5] ublk: check recovery flags for validity
      commit: 0a4f884510c68ac48d853a1d89ddb5c2f0a2db39
[2/5] ublk: refactor recovery configuration flag helpers
      commit: 20f2939cbcc5a1792b71130bad626b19345a23d1
[3/5] ublk: merge stop_work and quiesce_work
      commit: dbe142123bd713eeadb129f66a1357d0719ec853
[4/5] ublk: support device recovery without I/O queueing
      commit: 4aef53b1cd32f61ee2bd67c764c2bf299358e740
[5/5] Documentation: ublk: document UBLK_F_USER_RECOVERY_FAIL_IO
      commit: a463281eb2796a63000e0d528c1b712fdad452d0

Best regards,
-- 
Jens Axboe



