Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69D16DEC3
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901051; cv=none; b=WwepYZY5xI/uSONUXHjgWMr1aZvL1xWoSm3PswH38I47URA5DrYez2kigOhg1LHzf5+cXR8RfeAYRSw65lNGbdpYEqnamLNpgF6g0xY91g+soRuyxGl9+5Jw2l19AFQs4hK+cqO5a7lyB+zw43RxExK1XnAGYKpcbwEI9Fnz1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901051; c=relaxed/simple;
	bh=yLXEm1c42e6C5TSq6c3jBGbb3fPTE8uHjV+RDOiqHso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D6niZUA+0rTLmZ2KGYu8xT/Q6PrgFe0VrXHyx8JWFojy/TTApCBpS6sCVXRYWYCgIpkNXmME7jNUgCxXvxPoZwEUQ0Mr7pmVDNtwDU+04rqy8v1EKeU/fHfH3g47/OURRAfNBrdjkvBNxpu+NHuxZRNh/ma4Kn8RzTI+mwClKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CoAPvequ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CoAPvequ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f347e8f6acso374815ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 May 2024 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716901048; x=1717505848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeEpsyiS3b8raPxgZdh+Wek4BUXAmeaBtOvZqJZBf0E=;
        b=CoAPvequTJOVgrC79J3OQ4aD63NSG2z6NeAlLpwgkysMOc0UTNDL5ail3JODRqIGo6
         +g+MJtk3uSqghjDD8MGlAsLYrvZ9QKcWYJSTeCUmJrO62EAjOH0lzFvEgTO/Zv1AXofr
         eAwAWBRovt10Fnil3bChDnYvSduhNLokYJUPRd0GAyBb62vhyJJjLGTMcnXzmFaoVJBB
         txYsWCTCeri7LZ1pXyafkP4Qp/BLXktJDeGz06hyXSde/FDkmTZDoPKNEpho/YjIZgzx
         SiE0ojX7v5Qx4s0sGgmlWcNreX/n01tpY1sAbgZARBgS6tkd8eupfwAkIOab6/7lBfAz
         GVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901048; x=1717505848;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeEpsyiS3b8raPxgZdh+Wek4BUXAmeaBtOvZqJZBf0E=;
        b=pBKcHehDfnpKCCnQObV3b3alYdhthkkiz2RQMqw9GNGSjaLxSB5cn6Hdpa1uRiPmc7
         nrr9tNpRpR52LkvCwo4stB80cpcXt7vI/YD7DPbLfUaZaHUWyN8L3MQw8vB3RobqJQrT
         wR2FcN95ppLsAlz1rPyoa5++Ka+WpNPPpwh+2qzHV8wseJnvLExgTZXin7yuqRBRjcFz
         Oo+cGDZNNZUGFXylwdBQGAmztHGzK/OErKxMuCV6S/Tmer+ekQ2tLzWICXbx9WHttN0j
         mn39pFqv32KaG8u1iWUMsvRBUz0tOUgL2EDzxaFrVr8v/VA5xHfIZCeZjsWiOx8yz6he
         e5Qw==
X-Gm-Message-State: AOJu0Ywv6A1pmRec1hinyUJPPLHDf/T7WjQB2rAcFcYwG+QBg2PUfPdp
	KtNDgM2MHRRlyj5vATXX2k2N3qNIxVM9UeTEsRsferidFJz38u5dlnYIiP+yMOshnBr7qYG0tzK
	8
X-Google-Smtp-Source: AGHT+IEDT5wjyQdIWxBFy7iDmEP048k5ary7ucllsQ2C76rJTpb2NNS/f9uwl2ddLYm3BPA1HtYt5Q==
X-Received: by 2002:a17:902:f688:b0:1f3:358:cc30 with SMTP id d9443c01a7336-1f4486d1fbamr136086695ad.2.1716901048527;
        Tue, 28 May 2024 05:57:28 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967ac0sm79255505ad.180.2024.05.28.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:57:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
In-Reply-To: <20240528120914.28705-1-colyli@suse.de>
References: <20240528120914.28705-1-colyli@suse.de>
Subject: Re: [PATCH 0/3] bcache-6.10 20240528
Message-Id: <171690104653.274292.6349743072736147377.b4-ty@kernel.dk>
Date: Tue, 28 May 2024 06:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 28 May 2024 20:09:11 +0800, Coly Li wrote:
> This series is just for the patch from Dongsheng Yang, due to more
> testing needed, it comes after the first wave.
> 
> Dongsheng's patch helps to improve the latency of cache space
> allocation. This patch has been shipped in product more than one year
> by his team. Robert Pang from Google introduces this patch has been
> tested inside Google with quite extended hardware configurations. Eric
> Wheeler also deploys this patch in his production for 1+ months.
> 
> [...]

Applied, thanks!

[1/3] bcache: allow allocator to invalidate bucket in gc
      commit: a14a68b76954e73031ca6399abace17dcb77c17a
[2/3] bcache: call force_wake_up_gc() if necessary in check_should_bypass()
      commit: 05356938a4be356adde4eab4425c6822f3c7d706
[3/3] bcache: code cleanup in __bch_bucket_alloc_set()
      commit: 74d4ce92e08d5669d66fd890403724faa4286c21

Best regards,
-- 
Jens Axboe



