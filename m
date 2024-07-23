Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B5208A0
	for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741515; cv=none; b=hNZj9kSuTlvD1btQ7zX0Rw6vLmanqjMc1PK52X9g4A+9Lx5eEpUOT5Ls69kPXZnHtpBSs1dufa8TMdmM3Eg728uNHu4A1uADDORFYeoy/Ifv12Ortshzfc788SH3m2aRgcDA83J5ii3ywg094Em77JBChqwc2RtU6/TE9fgdqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741515; c=relaxed/simple;
	bh=eoif48013Js1xtPA5lsTxzXcyJyxuAULOwKbSvcGMVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iO3D47PrHAePGHHzk79T7CRy37rtoldO4PNpUqnyBiu3ll38sAD+xygZS7/7XxyDEjnIYSAZLUpyhGYJ4m+zzuLs9LM0HLFmS+VKbCLeWTAIvzh+5do5kYlSXJpd0PmGyLkRm/20Ptj76q8x+XvrCJIyKGgHEWkqUQJasR4heeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3KNadlyJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3KNadlyJ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a20ab5997eso46210a12.2
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721741513; x=1722346313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TZ5ldNvpgl0zGwq9TUJinN2tshm4DZksOkaoK0Hc9Y=;
        b=3KNadlyJQqiH37Vqb8R0SMSERCiCuav6tQ4u6/oANrskiJoIg8lVSJPOQxsEIAmskZ
         kw8jUedxUN2AQmsl5aWTj+ya6kgjNJBUtJ//LvvblIhnVZQG/oO/Xx25PgRPoNXP39G+
         M8n+NvK4uqxQ00fmkp/dYTCf2dLg+PAUqJqNHzDy3US7TJYJyF/u3YNJvCu5NrWhpCbM
         0s2/UiG4ynAN/9RgnKRMo0RoWrkXbooolSUfnuXzU90k28Zy9NuojZNDaZha0HYsFrut
         Az2IBt1W7znn588yp0LwiH3malR6WNfHhwjajIgQ5ipnhfGi3ReoZjFXBkZ6Zhowl4Oj
         KHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741513; x=1722346313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TZ5ldNvpgl0zGwq9TUJinN2tshm4DZksOkaoK0Hc9Y=;
        b=F8K1pSDoS4TZjH3qSWOIbXaqBgE7RUYPv6EQRx9aRP5BJTIY9auZ1DhMzH5lCSglEl
         BGqlvwfrPvQWrDHb91V0b3vrV/1TWE6O4H2zsEsuTC3ymTqlHkKpZxL9dhwKYknJ8WxX
         /wOLeaTtIMjXM6WcCmT62k1qZcW8J5+dkUG0xPgymcsoJcGAzG+oI/4ZydI2bWY9K5gO
         HKtDlSIYqKGAMatVpbLAm5+5pE6LQJhQt3+GqGWID9g+iO7F2FQBcyaINggbNG8PUva7
         Ry/AsoROx5xb47p9R/aIsNXkKCXSOElbM4dE75qUmon5eLipWLvmiiJCuQDgGNj2ouUU
         M5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVEIH55k1Oghue5Mlhc5SlGPvuOBTOgbqvUyJA5FoZyZLVqvDTNxvZBEv45uS6bQrp/CET3gpTPiE4X8xKv/9VT6FkcdfmkftX4rGo=
X-Gm-Message-State: AOJu0YwIK2GFEkL59R1AfMxjph7hUtM7oqOI80VNfByaBKPMYq9KpbeM
	TJfVrBE3uKuMTKjPAiZ0TFCHeQ55lDAJuU4G76XNJX2YEhRLaLLean+8uVX+Tp3DRV8O+WIz5SC
	Tp2s=
X-Google-Smtp-Source: AGHT+IHxt3qJcNFhOgTmuTSf/6MAoBV2NfVh2JCWLOLA/lZ1dp8b1Zzvb8z66ap7Hc0lElinVA352w==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr7749852b3a.3.1721741512980;
        Tue, 23 Jul 2024 06:31:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d14aa33f6sm4867744b3a.65.2024.07.23.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:31:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, Simon Horman <horms@kernel.org>
Cc: Andreas Gruenbacher <agruen@kernel.org>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
References: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
Subject: Re: [PATCH] drbd: Add peer_device to Kernel doc
Message-Id: <172174151190.171540.3359811072031639762.b4-ty@kernel.dk>
Date: Tue, 23 Jul 2024 07:31:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 23 Jul 2024 10:41:52 +0100, Simon Horman wrote:
> Add missing documentation of peer_device parameter to Kernel doc.
> 
> These parameters were added in commit 8164dd6c8ae1 ("drbd: Add peer
> device parameter to whole-bitmap I/O handlers")
> 
> Flagged by W=1 builds.
> 
> [...]

Applied, thanks!

[1/1] drbd: Add peer_device to Kernel doc
      commit: b8a4518b5c2d1164f9bb2e586733a658c5239adf

Best regards,
-- 
Jens Axboe



