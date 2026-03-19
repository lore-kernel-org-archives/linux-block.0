Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60981391E75
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941954; cv=none; b=J7RfANdIT+XULSn8GZXF4S1AoVK9S+k29gSshN8gssn1HXdnLePtwlvKHc2AnQo0H23q/ajhSgYUpqONuqIZPWL5Qk6PFCDy1scgm4Jwa2esXo/NbpnXH89Rz4EBs19dZ6DqzfBMP4sLgW9+UtJ64Knvu6ZcN7IEOD3m9KWBjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941954; c=relaxed/simple;
	bh=QDL3G+W4MxqSqEX9M6mr8fifEWbh4rxP6OX32NsjZRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i+aiaFuKxi4BQeRqrTFFTG+BNLv02wxxywM2OTFFokzfZ2sINkZA63PzklhlZSAZH/e1dVQnceUiPpIz6c/s+3WudOdUEAFytbMllDCyxmp91HuO+OVSG2J/ZGTzvUItqdu8LNPlLEcTePJFhLCcHaM/7VDF+gExPDzvadmYZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hzYU80kQ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hzYU80kQ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d738fe814cso728358a34.3
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773941946; x=1774546746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yokKrrzIKLchH2dWQCsaIIGzoszKxTOlL174aQT4Xac=;
        b=hzYU80kQ55rAjPYIBJjYt2k7x/qcoaq98rydImdj0ntZ8xP+I5/hnqpgp6TNQCBfyW
         YTxABpXqLpMATAViAj0jel842tdTw57pNlFsYklpxZTUN3eYcYrQh8mK1phE5tqpqTil
         PdT+qulm2/2UfOQ6gF9t34M7z1O5Ard2aOQfqldHFlOV13jbr4n/DLJIB84hOkgrjo4B
         Jv/f8t/6PZrcSDYcG+du3D24KwDqgEJ5+xV1hywhXIKSp0bkWkTNeIwYUcNF+wLulpzz
         U+ZeOcp0NE5SrNf4TBg/rVzpw1U526a38X5zgbVF/a/0/EixJM7PapTyXey6b6Hzow0j
         ZOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941946; x=1774546746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yokKrrzIKLchH2dWQCsaIIGzoszKxTOlL174aQT4Xac=;
        b=pWBMCc8jHdJyj8t2tYkPinJmx+IU3XeXuAOIwkwqaU0l0ja/gg58fWsF++QykifuS0
         nQPg1Ls0DW7ZCXX5UGqzCCQldWyXeq0kYqqqlWgUT707hOMzYyXhCsmGG0iQsgqK+sqX
         pZisaf2AjNEwnNEMYzzRjrwHJBBYYfcEQ9BbWAJ+xM3+Qj5TVU8v4j5ChcL5vXKTTCFr
         TgNYd/zZwE4sESdK5qaCyxV1NXmdT62hevTsvQ316rCEz1QCFE2xjwKPo4SneoSgPXlP
         9X6CSN46tg9GBYQ/djGOuyUPLozQUCCJhOU1HFUE9aa192YiXD9RLj2UocrjvcPiR5It
         O+DA==
X-Gm-Message-State: AOJu0YwYtD3IF5nGo/YSoLCDNRH5ZOx9mFcYE6wvDmG7A1EHt0ElXKQz
	mCk3hv9yMJAo1MxlTwrOkKMxsZGJ+mc+NqE/FpdLBQN1qYfsbQEC8gcFXNjgqushI7zWZLJP/Js
	+OrrWGyo=
X-Gm-Gg: ATEYQzzGpB0bIIUz0C3bO3r0IteoMICHj+8lgDGFmiodGCwPdNoEV4/lRSTdDOFWRcA
	HRsT/nKc5X2FhPJ1yAIgmOzUweSbGj9lQ0XcK3o82jvwsL7wCJBJsuEYPBxtOcnAuDZf1egFlek
	OtYvo3CpV+H1WFAq5ugLPIkcfaco003UHmUW9KpdIfxIwGkt8K0D93Z2xAeUk66TRu5quCGcRfB
	VrVLJlwqBYGGjQTHulN8VVbkf1W2cx3C4Bv671iDFunVIr2SCN6/C3bvTI2vys2FJCd4y8o1OIF
	bI1dpaHHbiQ8O2BlWxKWVW2r/pKnq8VFfOgU7ShtS2PBAhUn8eXwS1aDMmB3AeWAgVrlEzZhDnE
	nPqAtAFAzRDAjHVblQ3lR6fyn4K75gIR4KjciUZoK1dwwIqd1bQ6pzz27EfZkB/BO67Ath/N82G
	T3ydTwN6+uWwXhveCKd1cywMB7/xeNbhLCqKITgEG2BFqJqMC6rvOW+7cEAXQ/eMKjy4TrDduVZ
	cg=
X-Received: by 2002:a05:6830:91b:b0:7d7:d4eb:b593 with SMTP id 46e09a7af769-7d7eb028ddemr23688a34.30.1773941945770;
        Thu, 19 Mar 2026 10:39:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eac1747csm73349a34.8.2026.03.19.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:39:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: fujita.tomonori@lab.ntt.co.jp, James.Bottomley@HansenPartnership.com, 
 martin.petersen@oracle.com, Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 bvanassche@acm.org
In-Reply-To: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
References: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH v8 0/3] bsg: add io_uring command support for SCSI
 passthrough
Message-Id: <177394194400.204924.4064617540444301186.b4-ty@kernel.dk>
Date: Thu, 19 Mar 2026 11:39:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 17 Mar 2026 15:22:23 +0800, Yang Xiuwei wrote:
> This series adds io_uring command support to the BSG SCSI passthrough path.
> 
> The goal is to allow userspace to submit SCSI passthrough commands via
> IORING_OP_URING_CMD, in addition to the existing sg_io interface.
> The io_uring path mirrors the existing BSG behaviour: it currently only
> supports BSG_PROTOCOL_SCSI + BSG_SUB_PROTOCOL_SCSI_CMD and does not
> support BIDI transfers.
> 
> [...]

Applied, thanks!

[1/3] bsg: add bsg_uring_cmd uapi structure
      commit: 7da9261bab0a82bdbc4aafd2ad4bc3529b7cb772
[2/3] bsg: add io_uring command support to generic layer
      commit: a1e97ce80d9f41d0bb83951d758ff6fe49f3de60
[3/3] scsi: bsg: add io_uring passthrough handler
      commit: 7b6d3255e7f8c6df2d21504c47808e3ce84649ac

Best regards,
-- 
Jens Axboe



