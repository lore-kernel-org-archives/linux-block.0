Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA342356D9
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569706; cv=none; b=FoH+y+c0wez83yArotyYPiMQ4VTneYTfotlxmK4STgeZHdxPRVoJIgesMMNByNu3Ut+sNXR0k/ze3d0KtO8U4G6bAYwJt7NO/Enu044dvMmxv1apd1e6dtYDT67/jiem6fMBxLljNYVqI9GzDKHc+uQzkm3Lq4oxodOFXOZZZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569706; c=relaxed/simple;
	bh=O9Voi/RWYUfSWWfDQZc/hD2r8yWPb9rMLJvZyIFedV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CFr5Z/e2mnpalxktzS6sAFdckePj5VU4KEByhtpCol1E749QYoNws2at5T+xedEc4W38mtnFMLXQfG6pr8vmcCkaIV/OWAtHpdOH0tZpGWb9vqsvb0aWmGIgNGgxjYibcugvTrk1XwJFdcVDMnDTiO1naESaQwwtUUj3ZYCnTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZHqZxOs/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZHqZxOs/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd202ef81so1279451b3a.3
        for <linux-block@vger.kernel.org>; Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754569703; x=1755174503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=ZHqZxOs/AiAkWI6LkUNKp42AG0GgvoTSp69d/zVZJ/sIvzp0wfKN2IH4+n3EvufF9j
         cZGU+mKxFH/t8/BFBjmh5sdd5j97WcT4GxGKVb9FXIqRrBp75li4SyuFOutwPvg7ck9A
         PdobNBC/sLDwBd3sPF2ZaIfwRSxgFDpbeUL0k1+uKfJckr1D9Ty72uayPZWs7n599GNb
         ah7UIn6oro7sPfWbGTTwOByEQkrDFADJd5IPGqq5CodJ2bjCqLvteluVIkGt58eAS6OZ
         jvaDkMqc228vvfy+5CRx7wBomUCCRp3U3uDRrCnOfZbHd1WWgiU79InYFEwYAf3rHeQp
         TLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569703; x=1755174503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=BEZ0fnouWJ04y+5I8dt+s250xQmBUeTT+2aNEtMVNOJUcqlP5lyYLQ63wWh7dZbngc
         jStENSsd4BAs6216gPiDcgQuP0D2rqM+kTJp0HY9gVEX9BNMacZ7VcCx0aK5RLcBDOma
         D+F9MEHgqfxKTMr+Um99p2krxSNkOfXXGjtU+TQsG2prLnNPX+xqJHCC1tXiyPr7FE4+
         ezDea+gxvbz5yfIF/f3L6q9AT5eeCJtVw+X/THsU8P2u/Q/QKvPztBqK3P3DL0UMvjBQ
         rkEAdjYyr6+bef4vJIe6IvBK2ouYbtMDdRdMbUAUr5q2cEHOtsTk5rEFAWbbbUA2QHVJ
         braQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9fS6bLkfRf/L1iw7QSrnfU1MrLTSKUJOHsuQz1T0GetH+mDS9ae4VTOj8TRGuitLFhwWyPPEuq2XJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0x8yTpImTOueNiUkOzMCRw7rNnnydkAvvcTJl9+WBWrGiGQL
	C7My+Z25S9N6jZoxJrwEbEJpees0kdAI1fHvAwy0bUALRz/JXgfvb8ZjeUAkUOoOJIg=
X-Gm-Gg: ASbGncugUsiFw7M1Gu52WP4AFioOVr5DLTcn6AJqSjQoHr6dhNqKXsmgT+WVl1T1SkC
	k/IfPMxnO3HlVTGSGFvcHkWpNZ3CZRnhoiDvcK7FmwJgNfBZOXhntX8cDC4u7iGLfFVVTizYXkd
	fo9jmDXYrywumBxxWH1DTNhvLT2MHIgqIilF6P4W+pZGV1ukY+f7SWJiGYTBluuCEJqsHJ/t+Kx
	HGWz1PxdTTvO7wlHYK8+WOzNlWfYOHfhE1xMNBhuOCO3SS+YeqJk5PqcEC1aBdXqtBLPEnPG0bj
	VolKZIMEmvdOtSDPZ5aqnu5FVoTATgFadAq0yzguwHzpxD25aQGwSWerU4SJ76JUnR0/Hi5qGTR
	TIMh2SAwditMC/8w=
X-Google-Smtp-Source: AGHT+IFZflKqpkXCxCNuCXe0IkTo0oWflze6NE8a1yQ9TivWCEJGMOIfgjBBvn4BOsd6MO76MkWDPw==
X-Received: by 2002:a05:6a20:a11e:b0:239:1fad:a3c4 with SMTP id adf61e73a8af0-24031252cdbmr10058825637.16.1754569703349;
        Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm2710016b3a.23.2025.08.07.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:28:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Keith Busch <kbusch@kernel.org>, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
 Maurizio Lombardi <mlombard@redhat.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Message-Id: <175456970208.305227.5090103339122864119.b4-ty@kernel.dk>
Date: Thu, 07 Aug 2025 06:28:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 06 Aug 2025 22:35:07 -0700, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmet: exit debugfs after discovery subsystem exits
      commit: 80f21806b8e34ae1e24c0fc6a0f0dfd9b055e130

Best regards,
-- 
Jens Axboe



