Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B803EF640
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982558; cv=none; b=jXtAZMDA6ny6iz5BHHivOAlDXRyphQxn7grsIPscKxghHC8O+fR1VLPlNIgEj6EdWQ1zMv4YJzpOTwA5q7DkFoP3g4P51+aB/49aOG7RFP80XubdlshH+eN6K3hLKNjHqwjq2Dq+AoGl8xSIm4OO+IS9PSVHC7IT41CrmS1tfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982558; c=relaxed/simple;
	bh=Va9dYgrot8s9yZMtR6YZXVmrWVjDF1jAefBAb/V98EM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L1gOtkx5xyUdpbzdM6a5LfaSZF5caagoWcq51JZ0twjRP/w810z/1+g+o0xgFEFVqMx1WhqzOWPkRIHf653flnWnklq1ZSCu/2kuC+NMEaarRbndoCs6dKTWPPo5S1roZBPP5a/Ib+9cQrFhkmeJmvpDVgMAJV8zSiq7m/rTArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MxK2C9bk; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MxK2C9bk"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dd73b7c757so6027055a34.0
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779982557; x=1780587357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI7C+harLEOD3D+1WLwk6qnbQEE4eF1dnIlCrjDmQFY=;
        b=MxK2C9bkLs2tH0tyy6K3UpqPOeFje0R3mUfU9tQ7rU9oOHSRphIAaXDeAQerQ6BPbL
         eHevBZTydY/3hv2LRxTqn8LkH5mIMUKqjSkXpnn1MR5yGp3G13oFsE7KTL2TkW2aGbwi
         3FBx76jnzNg0QqAVY95Mf1kBqywYCOmd9+fkDGFlp4XbqFlmupWwPHb6QvoABzhJuTp6
         HKq1Ac9HuJTqqON50estI3TFmrMRWTGEkvFJ8UPSYbaSW6W0flo3eAC4DhozR6jnma6Q
         0ob/7G1P8fuA+epAyoaKQfargnjwJRIsJUw4Q2lhqFl616GD6+Y8qVjj/1up458yYezL
         ArvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982557; x=1780587357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI7C+harLEOD3D+1WLwk6qnbQEE4eF1dnIlCrjDmQFY=;
        b=FsURrSLsURyP4W0eJy/snbgYfKdzzqwjXOwVd6wl43sR+5ZNhkB/r0lyZBGTopcKgC
         mpseAOcBqM4QAfqjRHG2xHYg+KlBgY03EzRolqEtX0vaiB0zrxp91oZcHbRbCZ4PD1yB
         4QGirWUrNQ/xpVFeOhcHmkIjotHna71GsT+2c83mr9TcPpt9aIJgP4rjtp9ubhXSuhe1
         +7nNzZfimgTk1rTbNCWNi8MdNmJYX3Fepr0XZr/z5hAOMPJtqUsTkRsZ1xpaDKyN2zqR
         +Zc+KSSPmNllpqQ4HMie9JVTRLZwR+LPIDg2GtiHV73zHEx+qDT52pCNWU0BxpEitDKM
         Y7Vg==
X-Gm-Message-State: AOJu0YyxDAAfR++5C22YLq/SCiq1bpEDFqJsa75RjVbO947WGbveSXVS
	+XSK40pw5PMPFj9oI6j7jGiZRbWC4DMkiRll+wkB7fRioayIVSRkJ1cfN+8EqPV3gt8=
X-Gm-Gg: Acq92OGP7K6sqH1vU3oPLMlmCf2zSVlRO9bmIB3KLH4KmUxJjSyJUq7YUGuJhN94+v1
	jQiOy4nUc6JTvhql6OeO2r1GI2lKUHwiL0V29S0A7+m1TJk2LDpsq7PmhJkzyKCAgDdmUAtBrZB
	lhesAWDrhiJi7V2xnwit5oG/IG0J1W0MB6XnrucbGiaTQrIrtuCgNE7s4YFFZKlOJx0Fxnr382g
	0+PY2/aAbcOQxggpgSYZCa2x1nXOhbJUk9rmcXpknEIHyJNW60sMxbWtMPeEB6S3ZYZuhwEYJ4e
	Lr0ns2f2XhUtHZr5SlKUBup5HizNnYANCRRTWm67tCWxDtsqmPq+z7ZpMS+ZwDWgwsfcjI3kKtS
	nr/wF0INvUiUEKrYv9MhtSS1YoB3iP/TEu9mARlooeAIN/BkXN/SO+hplU9fgNIYBrSJUKxRQC/
	jDkSzubINevfLFXw7or2StiBu00ffQ2cbJYNfrkwellNGTES/hQI4XUMJSRLCp4fpB+o1VgCWSx
	xy+9ObvBG41xA==
X-Received: by 2002:a05:6820:809:b0:69d:ead4:3300 with SMTP id 006d021491bc7-69dead44438mr3221680eaf.48.1779982557410;
        Thu, 28 May 2026 08:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17548732fac.12.2026.05.28.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:35:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260528010041.1533124-1-kbusch@meta.com>
References: <20260528010041.1533124-1-kbusch@meta.com>
Subject: Re: [PATCHv3 0/2] block, nvme: enable passthrough iostats
Message-Id: <177998255663.134892.12620757795008304893.b4-ty@b4>
Date: Thu, 28 May 2026 09:35:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 18:00:39 -0700, Keith Busch wrote:
> v2->v3:
> 
>   Added kerneldoc for the exported API
> 
>   Added code comment for the passthrough safety
> 
>   Added reviews.
> 
> [...]

Applied, thanks!

[1/2] block: export passthrough stats enabled
      commit: b7f40ab50190e2500c3c297d15e00040dca47feb
[2/2] nvme: add support multipath passthrough iostats
      commit: 7d6eb455ecf0f95c54257ae372ac1272cff834e3

Best regards,
-- 
Jens Axboe



