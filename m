Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378A23535F
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341270; cv=none; b=XYC4xfHTa86W1xbG5H0NKeuKVHVFrBMNnyocDiSrWol0Q1XBQsO7Zd+YIFMWDRR2CIs7trSKSeymUxh9WK+a6/ChOQYImBg54hqBboD21JhFzVDqveEMTWcmaezG6LQp/aCUT9rWatKZwB4xR5qH8VkkNEw8rTF8Vj1uW4FN5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341270; c=relaxed/simple;
	bh=cWEfIDHwJYDhFgJbRysAPdWs9e+uJ/RHH9hEmHbkoTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xgzb5s0FWvQMdPxy8SEa4cezNMEOn+aciBzAPslFcCF2+i1V6smiOj+k+5bZXcMSnh+h/SobzlSyjJesn4hyQZW/rjOP/0ehDFWQQqNhFcMeUnONr7DuriLxA7fsppZfvPLtb5N3UVeDnK1CJw78W9CQlJTqAD3i4Wgq2SeNtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JIiY4qrn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JIiY4qrn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d710d8so11945925ad.1
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750341267; x=1750946067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqs+YfKtln9vD3KwJec2Ah0ksuEpyAOCllGv5MMU2kw=;
        b=JIiY4qrn+HhoAsVHYJQ6uE6YjbnX+lhmwB+oibe44hDdJAExitRe0x8BglvQNE9VjM
         We+Bj9oCyC/4y3CkD2wVZ+9Y57p3FaLeWOmmpoBwD/6GHbmSZdbxLNH5JyL4OsXWT0Xu
         cqvgIxNkNUnLPzlzdA16mHOfPDUXXITnYBy5WyotVNLUolPEa/QjG03bN5wsA+gSuMhq
         FVw3J4RtHv/NZkd5W6mgWEkrlPMJ061opDAAGBDfyM06jWt30vqPQH+pdh8D+sUe9mL4
         6L5iS2TtCrsAbgCNd8Pep3/u2BJJysUgG3kt4HrnnnQ8vCWBNGApBvnhW9VejAETbsww
         /NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341267; x=1750946067;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqs+YfKtln9vD3KwJec2Ah0ksuEpyAOCllGv5MMU2kw=;
        b=Mka1MkvtmdfBKJqJf9+UlxMQ+mVVN2Jzlk+8ULpAqVti+KZihFlJpmH80doefaMerg
         tJGhXdBNQll6bKKi1VxDCbRxE0Rlr8BMHsN3pGTpYm1htV/hNEtk4SU7zvTXzwYw1W0U
         HpJN48UZkSSuiOGVoqDedYnPHa9BXPiu+tuct4rrr7BGi5KYkq5kCtEVJeBX+ARgkwG1
         daxV0EgKhCVkbEbq6lOL9f7NijH4JbXmg6zijmG6hbezvBd8Vyj5ZBcYZA9A3qsUQv6W
         eHSqaQIEpdqd6h08SNwVuqoA/9DRzBRlAxHblZTnL/gKoIXfSgkao1rzsgMirv+6WXc9
         SXYA==
X-Gm-Message-State: AOJu0Yy6A0DhldTN/JWVga7epeJdQg8ScziiFOZygIFlwJABjo5AQpMu
	tsi4UhddN29S+H2utjUOkeZLN+IgmKtZVS89yVK20ZI3MrsrAxwrKQ8XHvTTP2EAM5M=
X-Gm-Gg: ASbGncumwUowpIGpTY/ZEIEUyHk+5EAoINMAvuK9kyETN9lDUNRe7BWR+1M/LVjitNY
	N+jMy5KXRXlO6okiwq8heHQzo4J1a4aUijBdAY5Dlaru0hbksAiECJmH8ra5e8/cYCf5MfMccaR
	wYgr4JNtUF8aDtpF7zYR767uFV8y2lOy40ICevHyNrxYSbTIbpuWDkujjahQcwFyMODDeoWCCpu
	XtiVAu9B/MNhlNpZpyEst8HcfqLzkETc2Ggjkj32Eg09SjdrjWphHTFjoVuC0mrcmqjrM8sd37h
	PxmW+/WIzI2kAs45A62z4anArEqdi2WLsU32FwT1aSVCX5Bq5tAqglpz+fw=
X-Google-Smtp-Source: AGHT+IG35LMtNv1pEuzxYHLxYMGmd1fgHrCldT54dGU1nocGeZtXIR4HWNzSb7bMyIjU1Pnn2Mk0xA==
X-Received: by 2002:a17:902:d58d:b0:234:8ec1:4ad3 with SMTP id d9443c01a7336-2366b3f8354mr354746275ad.40.1750341267462;
        Thu, 19 Jun 2025 06:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:4914:28d6:b267:8795:894b:2061])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7815esm120279135ad.118.2025.06.19.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:54:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: ming.lei@redhat.com
In-Reply-To: <20250619021031.181340-1-ronniesahlberg@gmail.com>
References: <20250619021031.181340-1-ronniesahlberg@gmail.com>
Subject: Re: [PATCH] ublk: santizize the arguments from userspace when
 adding a device
Message-Id: <175034126635.1539150.798310031823689804.b4-ty@kernel.dk>
Date: Thu, 19 Jun 2025 07:54:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 19 Jun 2025 12:10:31 +1000, Ronnie Sahlberg wrote:
> Sanity check the values for queue depth and number of queues
> we get from userspace when adding a device.
> 
> 

Applied, thanks!

[1/1] ublk: santizize the arguments from userspace when adding a device
      commit: 8c8472855884355caf3d8e0c50adf825f83454b2

Best regards,
-- 
Jens Axboe



