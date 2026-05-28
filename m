Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F6264FBD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976892; cv=none; b=D/RBl1/gtdkQG6zJvFgYOpnnFjB4V2KCNDCifzGiR0PGMoQmhyaVJvnmnJLBziZk6cTMrRjkBf/Q08ECuAAMAZrKquCLn74awAj+oFFNUhTcBGWmoTquQrfwECKJd/1fKU4P6rul22Kd8siEVlVb34zULr2rtNFIWTjXj50FFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976892; c=relaxed/simple;
	bh=mkvkc7St9DrVKd73CAc9lSJJ6UxtbkKQ4nTlAa+LctM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nm/kJy0XKuEqrYQT/BCHq6R8lV4giU3LkkwEKiAL/DPsDaR1COl9+EEvHAOMZ8SX1WWBDK1mqIisbFFZ+SWQT/Hk2ycFTU5fR59ANhphnShAgR9zo4Bj+/mKjsBVmrK/FJI416KvuBldHtuQdOwPXBx3nowM7/YOD06OR35XmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=C79WFjXg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="C79WFjXg"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ea36b56b7so9612513fac.3
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779976889; x=1780581689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFbJkSdTC7x0Ukd0ylRpVZgbAUY2iq/+kf4grEFg6Mk=;
        b=C79WFjXgaOmn4xO9IwXXaa8XWZLls2t9RYN2UY4y9+2JwUzmY6MroNqh4Q06CbKjjm
         iiuw3fcGYpnB623OUgqvAaIvyoj+4WDq9i0MC+DlyCCQoo2IgWp+G9JXQrsFF7pn1aho
         0pjuTTEvnJ6NHwbcHZN+yf4B7n9APGqUJg/zJDi96CWEQsEzt/B0uTFrQuBM7AxOLV0K
         FTzboXbLic6mgSSpkyXdotWKiAJXkFkjwZ92zPMtcLNWgNxfFxuk5JcPyGPo/Zyv+/oQ
         86+W6YztQIW2vcN3dNcMKlP42NAuCYDjSAYtfQYMBNxuikQVjxt4GD0PA1drAXTtxoR1
         jR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976889; x=1780581689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFbJkSdTC7x0Ukd0ylRpVZgbAUY2iq/+kf4grEFg6Mk=;
        b=S8egXgVajncg1cVAzpTTDJRwfdHEURZxDiB0mboxFEoVZQmy9B1BJ7N4ryE2Bt0weF
         AYH1MgmCgVGEyLGAjlrSQSHgIe+utXLbaxEWN9CT6NJ8Jyb2gS2qPCtJl69b0Zr1yL6B
         gJUNkuGxuP3N5SN5cya1RxFUglG7uxadkehmjOWav8R1+j/H9quTm5iPGPaPdvmC0CUy
         g64aK9sEnm3C+Vgn5mCgIF9ZLHYYQmlbEMnAjJaE091nfdng48pJRNcky1eawFZg2K4o
         IEo9Rea1VpaERmkKmaRx232Nbe86hS11EeFA1u7LHGZjl8KZ7ONrSG58FvmAiLk1Q7PW
         b5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9HHLBYyiSnkqkf0wLmT6Dj8GyI9kNPmkW89Gl3Af3Oi64ZE00SmxG020wP0wBXai5N9VMcUs95O1o0Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZk+a3dCUEH/tVzv0BXTEWWKeyLHEFAqbenTrmpNvOEFk0RpoE
	C4zNOUB1B2IQNHiTh48bqh7ksWHIBEGB1OJyP2ui3lvTcZtvz3QfuJkYoD4WFJ59VjcIJMELDAK
	UiQB4
X-Gm-Gg: Acq92OHgzg54tCxSnwVaU0KGqQj7EbLdxW2VTh4K9RxxcDyY3APrR+d9r3Du0eF7X3B
	cRiMR3kfeAUAAOHUzT+gOuVUTHGZahF3CyYpLsCNVU51vewLkEwECe4ztFVQY4ANIJCIhsRSuE6
	wdY8wENRMz+f2cXO6HBNoJobyKiiR7iKnb5zqP67mQpLV/zzvxOdAzPuuByrnq3uT9lSx0YuF5i
	tuwPn2L8JpcxEUnRuStH6xQsJua8fXUxj2Xsd+sxo2Yz+npu2MDrcNB+VRfkiBNZnGV2NFpSBXw
	J+oUeGXQSAWE+EapTCKqZQVIm3B9wvwYp1QePBO55J1K1LWZN3JUiFsZDZkjooNEA7Q0pAOA0h0
	GiB2azt7fJzW7FvT5UhghFTfvZOdEq3pRQS3sJjcyUBwf4GPxRVPPlER4Hw3QolUUn9z+fTQPPf
	Vo6hc1PsiHKfjS5MD2FByqsifq+mF3gEYcxxFyzah/2ukVG5F204e4NCO2N47UWIzv2r56CLavR
	NQvDHLbRSnKO6wjAzUqA1NE
X-Received: by 2002:a05:6870:3292:b0:43c:4d4e:734 with SMTP id 586e51a60fabf-43c4d4e1fe8mr2788634fac.32.1779976888372;
        Thu, 28 May 2026 07:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17356278fac.12.2026.05.28.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:01:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <tom.leiming@gmail.com>, Bart Van Assche <bvanassche@acm.org>, 
 Caleb Sander Mateos <csander@purestorage.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
Subject: Re: clean up bvec iter helpers
Message-Id: <177997688714.93541.1880481294502134735.b4-ty@b4>
Date: Thu, 28 May 2026 08:01:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 17:10:19 +0200, Christoph Hellwig wrote:
> this series converts the bvec_iter helpers from macros to inline
> functions, and to facilitate that cleans up a little bit of code
> in the loop and nvme-tcp drivers first.
> 
> Diffstat:
>  drivers/block/loop.c    |   24 ++++-------
>  drivers/nvme/host/tcp.c |   27 ++++--------
>  include/linux/bvec.h    |  101 ++++++++++++++++++++++++++++++------------------
>  3 files changed, 84 insertions(+), 68 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] loop: cleanup lo_rw_aio
      commit: 7dea9029721675d475e093116cef569253960e06
[2/3] nvme-tcp: cleanup nvme_tcp_init_iter
      commit: adf3a5cef1a839e388dc382b3e07623f52746322
[3/3] bvec: make the bvec_iter helpers inline functions
      commit: f6fe52a7b18675d76d7f7dae0c16f412a4e33f9a

Best regards,
-- 
Jens Axboe



