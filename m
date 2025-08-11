Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2313B7AE
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920909; cv=none; b=HnNZse3fN3aOmHqNL7yvPTyFmcst2sFP0pR/gElt+qlcqInjPBn4WNm8vMby3rnYjl2N2fqmee1D5iU933ka4//LkI0oDKSMt4p5QvUwVARm6sETCxqY+VTKbNtumRpEyEebSMX2rfXKwJX42wZ9S0AfT5kma4idc0w9k+UJhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920909; c=relaxed/simple;
	bh=XBb6UToKAx2wcDx3fR5U/UqfyEBiYBSF/8BSiUStg+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FZgCt1KkDTahUAEn9aljJhWYWLobDmviPQner27Lyl/qa1bYqqf7ISXhWqY2BIb/chLSEyEi17CUZjk4Xd+z4Xecje+vlIZ11QJnT2an7gkvnT5OOLujcWhHnqcsluwubiZKmbHvbzP4vYXSvzwHqC5WaFVUUQjQZRzRnVGeSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TNxGmh25; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TNxGmh25"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so2854556a12.1
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920907; x=1755525707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjBs1p0/NbPjLuntxkjIdS1sRnWoFU1tGonDHNXLht0=;
        b=TNxGmh25w0hJArIyjDm65uCXNtBnL+eGPGWliwYs4YZQ5+Qp9KNwxjLtmhFGUUCNs1
         XosH9b60/rowp2EkxZfG95iQkJawg56yGD8RH+UKq79+j5mX5unkjUBkV7gOwDKHjFdV
         dEQ0+w38t8Tr2frt4BW3bi59FNcZ3o7Ve0MkD0mVjzu6yjHhI/W6buM+aq9uT0yzhBJ+
         71tD2bk2tvBs8eXhCoKpJlhwZb0B6ORMKCt2uDWyPYTRXaPlM3firK68lNxXGIG7GXTW
         t6E7HpipuRwVOjiXBpG83oo4jhAEs55tLXZORF1EdEI/fZosMp3tfP0jjOV1bCZKtGt5
         cYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920907; x=1755525707;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjBs1p0/NbPjLuntxkjIdS1sRnWoFU1tGonDHNXLht0=;
        b=iLCF8tZWacKkDHUL1Y9YDL7erbZbWBTZMcuGcV6DMXps2Lygwu/mvzr/7Mqs04jzWK
         DmP/DkfAULN4EIVp5Af/CIec/58kpYgbOIb5PeSyR/kz2TFsXVoxUcYfrYc6c31VfjTT
         ur/u428HSngRZfANSgAbWs07NQCkEXklRWGfJQdebLOUYOyztyPjU34kbQrJbxvkrLBk
         nIMb5KTdHoa6Dj5v1kVJamaHMo+Yfzv9K/RM2aWEv1f5CCPZ2fHFLGuWZDEoKv36aa+R
         5tAhuj7xCa0beTVOnBNp7i2syrw34Na7Ohtnl06DwOtUmsB34GkuX3rTm13rA+cW+TDt
         z7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXRGyGVclca4QhqDUyNNMgwLJYQfYV0D3CmKrpZZPN4G0EsNThAexeeJG/4xIaTp8S4j4kHynAkc0yF6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0VXqO7BKTr5NufLsnY1uV9QsJl1FLQ7BuxEHhDgn8iXynIRJ
	0Bq2eWszAGlww1xQ76MlbdgRtQ0k0Rgz+mfA7eTm7I5qwoZJoC1QLRDPvYLtNbm1hA9KPnIdt5G
	1Hr3e
X-Gm-Gg: ASbGncs36N06Il5EcDkEOkq/Edzd1uC0ywT8PmFkso44UIACNXA8CS+0OXcenkuP43O
	9xoOHMmbsxbE+PwTsJmPjGNOrvmgQwELmfp6iT6JMVvqK8eLOkDDCZCGpRA3HIFg9feFHWBfw1b
	MlFgLwzkvlxIGYoZiWyH4qYXUUTX1UbNlIENhcabc9hL6ItwxgjclMfOruONX9TkCzZcFLFINa6
	AmYNy3dd+4/0geGdpnzrK/rddLjm+dbir4pjL1YaC3e3DudVxZqoj/8cYhr5fijeKRjQ9qJGVgu
	7LBM2+Vib96eFbbQpDZDlcrSepA1OlgeHFOiutHodXYA7NAUfgf9ptdsAkRRYYXv6HF7kgqrexM
	2LpjF413sXunfsIk=
X-Google-Smtp-Source: AGHT+IEG+EPunzjJanJtxibmBqQfuE/BD/BPsLCfQHcWyKgSOYhhNJuA2U7Xhq6QKFdDKZa7AnFtAQ==
X-Received: by 2002:a17:90b:2544:b0:31f:42e8:a899 with SMTP id 98e67ed59e1d1-32183a0132emr17806156a91.13.1754920903742;
        Mon, 11 Aug 2025 07:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: Remove the open-coded page pool
Message-Id: <175492090268.697940.16894165700096915187.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 05 Jun 2025 12:38:52 +0200, Christoph Böhmwalder wrote:
> If the network stack keeps a reference for too long, DRBD keeps
> references on a higher number of pages as a consequence.
> 
> Fix all that by no longer relying on page reference counts dropping to
> an expected value. Instead, DRBD gives up its reference and lets the
> system handle everything else. While at it, remove the open-coded
> custom page pool mechanism and use the page_pool included in the
> kernel.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove the open-coded page pool
      commit: d5dd409812eca084e68208926bb629c8f708651f

Best regards,
-- 
Jens Axboe



