Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FD146A79
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722662; cv=none; b=nwIa66rtzmD1OqaR3DqHquy2LDM5w8NUOrNTrGVw6djXEr62cUti6XK8oAOHDUoLhgECtq4aVXCLp9Q11VEE/96yUicJ62tRmxyXJeZFHPV2oE5LIoDrDDpccb4onnxdkiOJ9MlVJA5ixKAwv1ngNx2415x0uZBMUj+ES6UNrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722662; c=relaxed/simple;
	bh=cH6VYHJbW5wvn7oR61iITJSFQQ+7MC/VGXwlFsZ3GMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l74xkTpqK0uLET6fhtSO46Aym+Lluf482DlWcNTU//CTF7Sn0t3XmF/RaOFNwzy+hXECPvJinzpYXfa7i3TtAtBgtleyMkLheSDZ05ceqlLHvvOluNC+YEiem2+bKnRvuH5MTNPluDOiHjOJECDhN+XhUVi9R958qTpzgc6cPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nMewHVQf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nMewHVQf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c8c50fdd9so9145485ad.0
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729722657; x=1730327457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgOedjYBe1YLDh9rDYer/CzVvBBrTLw5Uo8jiJN6AYI=;
        b=nMewHVQfv+gfrM8Sf5TkKzuEr3EiBpa2IaEpDMMbKLpYYynIdlO4o6YfnPtARU+pOx
         U/ClypNv6NPxqqjNs5LCXQRmYeWWF/7G4qzjQhWzC16otOdJtrZPbVfYkGpIWREmWyY6
         Gbgl79qI/Xsw1eACUMNjrZVeA8U28ZxyYdgMnOeJpT+hJ3TbQMWKgHvNeREcCFS5Huva
         nGvGG8ZnYZBlhV2cYH5udXZMWyJT5KNPOkG1+7FFyKow3T7HVkGVFjd0x+wzppEMsKLQ
         kn9dwDVyw075VcUSlX4qqyPoN5MBIDzou0K+FoUNHh7ixQjo7C132oUbWqSJxbZdCQtd
         EUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729722657; x=1730327457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgOedjYBe1YLDh9rDYer/CzVvBBrTLw5Uo8jiJN6AYI=;
        b=TtWwiQrFBMq+CzK3LwPArVjLpTbdQQmP3coG26d2k2ZnBZ7Xy95B1gmHQoYDwTPwbU
         YpJ+Am1dL7zx6SYr+MvnyYRG698pN88W0b+ZWIiekQZSKfZQOPKYqYTqJZwOG3Hrla5K
         8zpk1366ouE2RsB61AH7qNQnLFQdrDvtCm+4VBjya0QT3w0jwCxcgxBXZhR3yN7UxRrU
         NGI0KLIR85xMAFrtrmBQOSlE2oW1Vd7Nq3KhdpZwtmus6z1iIuUeFTUxMRGzw/TsGm9c
         Y6j4ik6qfvqlWw5TzxZgPvSHddx/AxboW8TZ42eHoUmduDKPCOvgrpeyA4pp90tCp1R1
         AWlw==
X-Gm-Message-State: AOJu0YwwI/GcLJB/syTTsKSMc26l+ZeLTQv6tgE9ppaZeLXd/ksrl1Yw
	jCXuw0eESfHZaih/tLvxbuDoiM31EAk1wtbPnLZmqZijxCYIe5A6kOfFs+6ZXa674ix1rfvTDAV
	X
X-Google-Smtp-Source: AGHT+IEXoJSTKxvFZtJEBo6yzJEdVAZ2Vr+HF4amF1qBCe79l7xftczrixaNv+g/nShHpxjJOdC+qQ==
X-Received: by 2002:a17:902:ec8e:b0:20f:ae7f:a433 with SMTP id d9443c01a7336-20fb88581f3mr151525ad.2.1729722657171;
        Wed, 23 Oct 2024 15:30:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f6645sm62050305ad.287.2024.10.23.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:30:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20241023202850.3469279-1-bvanassche@acm.org>
References: <20241023202850.3469279-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Unexport blk_mq_flush_busy_ctxs()
Message-Id: <172972265629.1157890.807789129544310490.b4-ty@kernel.dk>
Date: Wed, 23 Oct 2024 16:30:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Oct 2024 13:28:50 -0700, Bart Van Assche wrote:
> Commit a6088845c2bf ("block: kyber: make kyber more friendly with merging")
> removed the only blk_mq_flush_busy_ctxs() call from outside the block layer
> core. Hence unexport blk_mq_flush_busy_ctxs().
> 
> 

Applied, thanks!

[1/1] blk-mq: Unexport blk_mq_flush_busy_ctxs()
      commit: e203e20a8b2b67eb12f87aa3ee625cda5e686434

Best regards,
-- 
Jens Axboe



