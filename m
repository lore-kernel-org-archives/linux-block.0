Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6401E5B91
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979325; cv=none; b=hO+zAVAQGWGsHrlMOKrDARhNZFAleyHr1TL/iIR2lLY2/H15QtmuXKn/BrMxgOFbTKOJ6EWqru8XGHvD4GDKR7UEGNZsBvoEYnTwobhNK5TgCmCjBd0WDiQsBPZNG3fP4kEAQGxqKUJEfaWxbl/ZxknJ4TxGlZiqrnkzydtD35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979325; c=relaxed/simple;
	bh=rqTW5HwcZ+dwXigL/98XwRjaKoVhBs+GZHOd+k4MCCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kFNuKnAYYWp8LHEDR7iI06uS0BbtdZq+rh8SmPWBu052gNzCoRMA212Qbptr1S9kFkJjIosfr4JLaTEO0h2Fwsf9v4onw3kjQbPZo6DEBKq9bC+Qdfn5K3MWu3Wpd1BbuXIP8b1pNEvbPv22WAh9rf+T93zhLwjvpSb1JSjtqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KFc7ehhB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KFc7ehhB"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e059b14cb1so23976245ab.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751979322; x=1752584122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz+3g8Gk738iBxfQpYL75vI8bUAIduK+IwHHVtiU6pk=;
        b=KFc7ehhBbCkqOja0KAmJkAiruh9az8BmpouUw81foJYp+Q8emMi9O5u+IsoS4DOR7z
         1XZezSvkti59SdpI3hUOWVMxkz1us7+k9plwQ3aq4WhuKC43qc4KBEDNheycC6YmIDwh
         2amLLMe1dH7MopB6yTOIJkHr30t//eFAnzQSvIjO/qYI4GRoN6EM3/uqp491lpY1FrBQ
         1Y7gjeHTBbIJra9VOQfhfHd2eFTx/5I+/iDJQ0UCZpRV4p5nfvZuKR7bCb/E1Qqm70o0
         9FjWTmwNaFHdJljrd9hm7LDR5DrvjVgAdpZTDFoxIlO6QL/kiNMsN7ECBX42wPt8qmX+
         4uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979322; x=1752584122;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz+3g8Gk738iBxfQpYL75vI8bUAIduK+IwHHVtiU6pk=;
        b=JKYfymaCzR6HeypzbUBUMs+CMRafkiXGwzx0BZUzd9ZLJ7PdnQjQ5+Gl/EM794gBJf
         6eI2C/B83T1amotEoi+BDpu9maToYTKPN7aSpUAIiEnqmH628KrWeoqvSgvmj5OHl9Gt
         9JrGUkNkHctyQGGPtNiWtd6tfvbW1nutR+kMIanaf+khikBw5ypAHROqKhMhdR4T/NEc
         qnXr4spyh5H5fDCDR+k5r5+cbHT15liw44CuOXa4H64DRlWVUiTxDQHt3i1+XIn+6jmr
         de9TEuUxYVDy0FXuqH98hCS9FqXDOloZIGLGo81455rirC5jgD6Trjj4hdUdqv/DernA
         6vzA==
X-Forwarded-Encrypted: i=1; AJvYcCUU+Tivl6zNz/1D+W95Cx4HLMvAY1axi/jTm5WLCKh1GRiuRAGaWPK4frpd3NiYmBAoJ/ffcgyvNRQEqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NAV5iCa4vOoSImMdXTHm0OAiqHOiw/IUCye4wQs5D9Y0PCFB
	mfb3x7zH/qQa56DofKC6YMan7uCdRBA4rJa7k+q/0rpNHwMypGvquO8QQ7qptiP6oCxQ9vV5Wy+
	6Tw45
X-Gm-Gg: ASbGncvSgsM0/Jj8/ygGsCV8TSPN8qozOYHlW3LOcH8sAEsestcV75vBXUJWrHf1N23
	17vxmEc/u6YsMtV1Ubd3SA7vd9sliG0OqagvFZ0CRf59hpA8Hvhr50+cBj/ONWFX52Q4DGFG/4d
	HYoWqWRJjYfUWj0j3/VJGm/kPx5ykED1gw0W4pvRkZcqzCLy+618SvZtFidNEH2kz9qJ507Bi/F
	kJeNwFt7kLJmM4rqrR1tJzVZ/zalMsRTehUw7XwlHkwT1DxGo5ZL7aqTS1wjFo7DLuFdYII5rwn
	ZeIUTI3DekJdhfmiq/zIyIoOKW8oWoau71ktZB8R4R4XPeJF+JcSaQ==
X-Google-Smtp-Source: AGHT+IHHn2y2EQ9dCWVmGRtV4imCt3ZhSYyqOZi1I3uvvpjvD3LZWZEaCWognCUlw5l1BMS8tkglJg==
X-Received: by 2002:a05:6e02:1a47:b0:3dd:bb60:4600 with SMTP id e9e14a558f8ab-3e154fcddfemr24652925ab.5.1751979321972;
        Tue, 08 Jul 2025 05:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0fe221071sm32286865ab.44.2025.07.08.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:55:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>
Cc: ben.copeland@linaro.org, leon@kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>
References: <20250707125223.3022531-1-hch@lst.de>
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-Id: <175197932094.1079793.8874503109418666370.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 06:55:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Mon, 07 Jul 2025 14:52:23 +0200, Christoph Hellwig wrote:
> The current version of the blk_rq_dma_map support in nvme-pci tries to
> reconstruct the DMA mappings from the on the wire descriptors if they
> are needed for unmapping.  While this is not the case for the direct
> mapping fast path and the IOVA path, it is needed for the non-IOVA slow
> path, e.g. when using the interconnect is not dma coherent, when using
> swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.
> 
> [...]

Applied, thanks!

[1/1] nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping
      commit: b8b7570a7ec872f2a27b775c4f8710ca8a357adf

Best regards,
-- 
Jens Axboe



