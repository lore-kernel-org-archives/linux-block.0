Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C720C00E
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330010; cv=none; b=Ba+cnb68t0qqF86pKv9L6S/hEi70QA/wVY0tuDrGWWsSxunUlhfvJXaDBIo/Uz/ISr/s76qnxns4lSTrIImR5mTnmTfS/anGhKCQsqrj6MA3GKFbQO95KgynOOi8QhQ9e3kDWGOw5EpvByBBigSkllONDG7yRFcM1tKauCTuzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330010; c=relaxed/simple;
	bh=jjpAsfnDViEPTArEMDoLsQjV/xeaagtYm84LbRevTPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ib+LnzhrdDW8VdqQNAkHviIKSGm6t0cyDu07e3brm9wsH3akWZ4dqWfDtUImaww09DDP2Jew3XeF00Jjiv3LfKMrz/HWhqkbDjdylGBR+3vn1lDVxjHo+47bWv/JDrL6DlgbnK8UWKpcmDCBEkPxZ+HkZm7G33NxUrXDsLMYMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q/+2DcYx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q/+2DcYx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7259a26ad10so9501b3a.1
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330007; x=1733934807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb5hc3qgWT9L6cng9NISv31Ehv7llzw2Vl8uDpnsua4=;
        b=Q/+2DcYxxT6g/pM9QwL+1fSTK1kRbq1P6IgWb/Rv+dPmn7PBTZZjF3+VTyhrbLSn0H
         kv3aeHSGxOfcDPYlTwx3THE3tTAGEp9cEdccq6kfHDz/2g6lYP1jD40nb3U+5EM+NkIs
         H5prj+UuDenOoB4vMGAOvvw3ANcHudneUU+Rq74Rz2mgJovQO8vHVzMYal/RaEXcg0sA
         QpZHI79qxQBaEks5wnJYTju1CMpK5eJX3Hwug62bNLANPnKpQ9qnc/2VXiFucODz0wCN
         2NPwPwRWdVw2ElxTrtXfpCm8kJhGkG9hrhYGiJKc90tSMha3djazlEQmYr0b0IOLbvGl
         JyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330007; x=1733934807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb5hc3qgWT9L6cng9NISv31Ehv7llzw2Vl8uDpnsua4=;
        b=cVNkAcEV1EtHJmUMwzY+VM8AL2+/P59piWEgZ81hgZj18j/U/BVGRc6wTxk6IhTc7X
         VF/zUSpqpNQ4wg93t8cilafyPCu88RUD6opyntze64E/Rpac/Oo6bR+mTgsgmUcYr5cp
         89bHBEJmQj96VPzGg/8x4BvjDdm0lVfClECw3biSCjR74sXEUfpLQQHlRvGSbVYaCfDC
         Mr+uTbH+BLQ7SQ1ETAqD2Fy4uS2b18OVI7+Gh4tmUZqon5IPDJnLQrja3V7d8S+ItOdQ
         Rl+Em6U+DHM4HTp1Nmhn8TE3XKcWttKi1MmJ2EcII2gjlcjepdisR2a4m4iVlRZ9Nwqz
         ojxg==
X-Gm-Message-State: AOJu0Yx6iqY+q1d+Y0tpYtiiVnL3+zhQSn0p+62G7frd9oktkSyEPRZq
	9oOoAZLGjNWY4uWSeiTc8vCsQ+1wh5IE8brRY5NlvkKlhqUEMhQi9cx2KSXgoXafda4jtoYVdAZ
	Y
X-Gm-Gg: ASbGncvjBlLJ5MaNy97ROXONkD9XSWObbI17vJIM3EnlNL22jDQS2i3bRX68i2xSHA/
	tfQpj/oJUJgMhj59euj3RmGcS+rWE25pUz0t604YpkBeCyei6hGqXXjMMFSZJAj27xD21etg9Un
	asMNveHZ+vrh680m6rc5GKpGY21u5FKCIMkAIgStYuhLLefM/fknofFia3tE7tklAuRHGiGsmhD
	vkYcGFM/Jc8VPXYmSBB/YeNeOxq3Q==
X-Google-Smtp-Source: AGHT+IGEY5dtfqqu7yQqDHuO3mHKg1f9S+1DRwm5m5EOLxdsx+PQqoK1BhMnJkgc7n3v5DxDmYv9oQ==
X-Received: by 2002:a05:6a00:cc3:b0:725:4915:c0f with SMTP id d2e1a72fcca58-7259d6008e4mr10467b3a.11.1733330007187;
        Wed, 04 Dec 2024 08:33:27 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm12955492b3a.185.2024.12.04.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:33:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, 
 =?utf-8?q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
References: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
Subject: Re: [PATCH] block: rnull: Initialize the module in place
Message-Id: <173333000587.511414.15268819552143079818.b4-ty@kernel.dk>
Date: Wed, 04 Dec 2024 09:33:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 04 Dec 2024 09:38:39 +0100, Benoît du Garreau wrote:
> Using `InPlaceModule` avoids an allocation and an indirection.
> 
> 

Applied, thanks!

[1/1] block: rnull: Initialize the module in place
      commit: c018ec9dd144dd29b4a664bf69e486f14bb4ee87

Best regards,
-- 
Jens Axboe



