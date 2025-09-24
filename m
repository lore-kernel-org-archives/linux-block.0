Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE332DFA3B
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714521; cv=none; b=n78vhcMBECxrla3d7jTFLufRqsnMDXjtDMh/rbNa4Aqhyw5Ppy7pJWrO8TlaCsrIcfdPT/Kb3k23RfdbE9BZUbyICVD1evFwmTJn87orlEfJi0BnyMt978KzXY+IiVYJwq0vEdJMEOYIeZSNNpErwiwt2R/ypI0mwoQmLVV4c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714521; c=relaxed/simple;
	bh=pj8PvxyzC/z3kcdQ9jQHUKp9r/I26BHWLbx0ugQyktI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nxsd5Oo34F47W29LZaUYzTs5d5lQJvwR1aSngEEO9+wTuljgFWseJwDiqr/ofh2SA+mbhL5A4IaaFg383P5dkxSNHzMw6lyP3u0Oi0VPekmlbxAOWenHbXte1ixKTybNgUcsnD6Dqm0677PA2wRE3Wf2XDlPszxXnNuuE2c2W/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mliPwszf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mliPwszf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so4966355e9.1
        for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758714518; x=1759319318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du9BNVEhuhgOCmpO5yclDaaObVQns4cLiTGaVHcZCxw=;
        b=mliPwszf0dHDVbKkpq5hGIWdtSh1O/PSC2DMplnWdSGE0BiIp1xnsDORKKtcStSy6C
         5DtK71cwvI2JbHvKInRyguiUO02QMZ6LjmwkkjXQiB+YY/aZdgY9PiRHyzLG8/qNLaUV
         yeOrVcuwmaeQg/xUjSh/UBfEeEOJIxzzw8cXq++At7RlmVb394l4JfNprcbx2/JD2L2f
         yl07j6YG+v1CcazuLwOsSEahuT7y+0VaFcHdLDLs52LIYylYYAFWHNQW5k65Qk9oKlhF
         fgqZpu/wGyPQ2+s4scpv4eEq1/t3H5UzEJZhtlxxu008xWf3EqnY6TH5i4y0FfvbewZG
         LHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714518; x=1759319318;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du9BNVEhuhgOCmpO5yclDaaObVQns4cLiTGaVHcZCxw=;
        b=nqsoNLlspzKAq7jiC5JDydsvRZbCV9X+ev0T+VifEGeAe6juYXE4UVRCGmQdHeGKYf
         Pb5BwDHohAPjq9862Irs+isLvB++hcbSHz7SCtuJnN39DW1AYZG7WDl+Z4NhUiw6RK3o
         tdxmR6PDhRwkCYivFIqU3FD0RfOoZHdtJaXCkKJohSzqR6CWXHxoUAgmzss3M0HrMRA6
         Dh47a5jdNr6r1oUPY/3I5CdC1Y1nbPmp9TpeNHQdIthJx/Ff3TBPV0DptAf31A6f0WhS
         fIs2TO9YHhSqDpT56kiAtZ+8/tBKivDan2aKJVTS/8oDJqR1iVMPzmaVF37I2sXw4ZPX
         pf8Q==
X-Gm-Message-State: AOJu0YxeSB0qEpt4D1mAu3TLahrDtCSDH6iJt7s1mlK+lJi6mQb5raO3
	Lf0p+yBgrTrSVmJ4vIVC+FX17FxSWVHEJ+ooEqDpvHcGgRHiJw+/pi5jF/M9HfCSUeRYtLju9r1
	sMaDwo9Q=
X-Gm-Gg: ASbGncs+uf4p9KUpbupJDb2OlrZWeZLkrNC4GtLR7FEaqFr2l2XPV/ww1lzUiQ+5qDK
	fvDgJdir7Jrr5gqKaXKYhchrgsBSzkelOOT6hj427NlqbGFJHnpWAvRIdXEc0axNfruJGIwpRQX
	88caSWI7W6qnH3UjzMyFelU47k0B+zT17GKLTfcEYNSmxvFWsp1BMZup5sQIVrCXvelrSxQOOJe
	aTrvz0xp8PvUDJj75Axpc1Sh7vnJNiMTEfl49Wi8ew/GXyBMFsvaBEZxQbpodzSIPkwMqfYl6Tz
	5ixsIrXLTSo0oER+wX0iyOVlSIu3RPZ2LIh2HkIW8X+KGen5KwmgbbaFDkh1hS52mLYUSRGfd4r
	K+3bKfRfoI1UXn3cZvw==
X-Google-Smtp-Source: AGHT+IFgego+GrflALefJre2aO2eYh8KTDjGfe4uYRtoi3EEg/5php7KyGqhlwX9+ZPt+XwIRrvSLA==
X-Received: by 2002:a05:600c:1553:b0:45d:f7df:2735 with SMTP id 5b1f17b1804b1-46e2b556f5amr22847345e9.16.1758714517495;
        Wed, 24 Sep 2025 04:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm28162185e9.11.2025.09.24.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:48:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250923155249.2891305-1-csander@purestorage.com>
References: <20250923155249.2891305-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove redundant zone op check in
 ublk_setup_iod()
Message-Id: <175871451630.316144.8713000663758942668.b4-ty@kernel.dk>
Date: Wed, 24 Sep 2025 05:48:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 09:52:48 -0600, Caleb Sander Mateos wrote:
> ublk_setup_iod() checks first whether the request is a zoned operation
> issued to a device without zoned support and returns BLK_STS_IOERR if
> so. However, such a request would already hit the default case in the
> subsequent switch statement and fail the ublk_queue_is_zoned() check,
> which also results in a return of BLK_STS_IOERR. So remove the redundant
> early check for unsupported zone ops.
> 
> [...]

Applied, thanks!

[1/1] ublk: remove redundant zone op check in ublk_setup_iod()
      commit: f85e254b51aeadf8dc367aaf2fbd2c20378f75c2

Best regards,
-- 
Jens Axboe



