Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98791226CF1
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430133; cv=none; b=pmeDfMYvu1hlk6Frsjz4dOKSMoSLugU91b1dMCAI2n2FTlHWLfS0wpKf729+mVNFZLYA+ISBsw9y18mQqBQ4XzN4ezauWFthuOjpX+EDLPsAHwfLjd4RZPB3E1//eHpyitGDwKvmDy36LBvU9uEXtMDWSXrVt+kvyIi1CsXN5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430133; c=relaxed/simple;
	bh=3Fh1PeZcco30ETILuBWIi2BGS8hfQiupvDbtZojNAI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CSiaH8cMYCqBYAvLkbd4H72Sg78locKmJEG9NeGdMhRzuTsEarROkMc2MqVOFeO51yUWEp65cZIr1AwC3oLYIsybz6+73Hek69gXX6FYBoPQWyYQNfNxyAC+hZcspsdl2ML3tHQf+fn7jlMAvfFb7JmtTx00MRQYkgqAAW2eAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yf8eRH1j; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yf8eRH1j"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-875acfc133dso154826439f.1
        for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752430129; x=1753034929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Krzd84YFeGI1CJREEpJPGfr83y5jJFYo85/fwPADo=;
        b=Yf8eRH1jNQsZJwGbZNnGR/omlvXdwxWhbdcpseABSs4CyEef4O1oWE1EeznJflUEUk
         yRKmKbF9AFeVmaEBlKm7gN4dotivim4pTDquAqGoHtFxv2jbModkZWxIvyNyFuuDKbGS
         U5UwRanUk0wMKh46ZDwLJYZaJBuFBabauWpjaLeDLpsg1g+W3JI/RfJAj+ooSmpZyUiJ
         lLgiI1HOASpNjNZp8TlU5izOSDhSiJ+5kuflzdLLp/YQcvTOvojoj9Q9gigMaGaUL+u/
         tbkGN/tOIxDs+x9WErXd03bbbQMhJEb/KDpSDy0UpyGzC72PhfaKMdUPvEgsUV7reNXP
         5uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752430129; x=1753034929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8Krzd84YFeGI1CJREEpJPGfr83y5jJFYo85/fwPADo=;
        b=C3dSUhiHnG5tyrVSTDxhY7jNPA965y2ppgvBcmmfqimGQ12CFVtuvhtWuJOVL7iUb7
         +XewZSmrtTbhEKkHEbrZS1I5trUaId/uFc9o/p1V2f0Qozi4Jlx4tWXzX1I0hT6YFec+
         OkiHCvKM6sj5QffsLz/T4QK86GLGki+fK8l4tLdjkOlbX8CtthjX77Nlm/SsB/rncHMv
         nUlfIaz9JmyPiCkad3eLsk5Gm8mqdgqvOdcAIsGQhLHsoBQZzd0oGcOOHEkge+PkGko2
         ugaD5CgvZCnUO2cQaGQ7Wkcw660L4AhQcrEkJfjSu2WlViit0oVmBn6dKVhNII6lNXeC
         3nVw==
X-Gm-Message-State: AOJu0YywkIiGVnNLA+1yCvuxnImSo2R4NFNa17ORx9nh8jAwWZAZRqHL
	YQhK/gr/lbGPd/L7baC6OAO6Sg7XzHhy9h0TWq92K0vWUbQf4kuXbo3M8YmEDjlI4rQmaBYqS1B
	eOEfE
X-Gm-Gg: ASbGncsOl+9on5Lf0dXDxmpjEKWkq04ezv3PVuPqUrshDG8Osa8PEKJul4lSQ0Dz08t
	p/BEHzFrF4DnjQeiFcZsSpp2McsnUwWv+tCtWw4S0AQecswvI+4de75hQU8OkTuleFVRaq00560
	TxUWtR7JL6l64aluo4Sw0ZfjM+46HopYZIjwS2iZ5B1v3omxI5hW1HeJN5ImR+gBLIV46h2EkLP
	z7pS9HW5kUqyQ2rgTvPSH8FriYHUTYjSEMU3AdPWA3/Te33VMrLGFHQyNXaYTvz1SXOHlVjl+xh
	gFbPe2DAuu0laHhNKFK7w7QRVZ8/XfyFI66Vj4rL99BsmMR85HEGmZ5Mz5lRdA8FY1tDL9xcaka
	eMgrYmCr/1MXBcA==
X-Google-Smtp-Source: AGHT+IF1WMbjMp82EFlXwjbKMLfCYoFk0+WZL2k8tVNfkD4nUJ+eQ3w67sNomw7XTErLdVrWCxToZg==
X-Received: by 2002:a05:6e02:3991:b0:3df:5309:e97f with SMTP id e9e14a558f8ab-3e25336832cmr121164335ab.22.1752430129280;
        Sun, 13 Jul 2025 11:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc683sm1671778173.107.2025.07.13.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 11:08:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: efremov@linux.com, Purva Yeshi <purvayeshi550@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250713070020.14530-1-purvayeshi550@gmail.com>
References: <20250713070020.14530-1-purvayeshi550@gmail.com>
Subject: Re: [PATCH v2] block: floppy: Fix uninitialized use of outparam
Message-Id: <175243012818.93872.4165824196717735145.b4-ty@kernel.dk>
Date: Sun, 13 Jul 2025 12:08:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 13 Jul 2025 12:30:20 +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
> uninitialized symbol 'outparam'.
> 
> Smatch may incorrectly warn about uninitialized use of 'outparam'
> in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
> its initialization. Initialize outparam to NULL to make this explicit
> and suppress the false positive.
> 
> [...]

Applied, thanks!

[1/1] block: floppy: Fix uninitialized use of outparam
      commit: cb1bdf0797acd79c53a899f72a06ab8c1ebc5bcb

Best regards,
-- 
Jens Axboe



