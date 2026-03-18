Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA01D9A66
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797577; cv=none; b=pzDTR6AHKoADfBapUtS7Ag6Gw1V36HqWSpPaaTxQ8pgV/xzLuSh4JnH5+vp+KuFRZri9vdSMMNSA8F6YnYGX6O0ZY12et46U+doBXTl5xvZjMghOLehQlU5dEQFKq5bJUac+nBUaORKWcUtDFUQROSk0bdrMOHuqH70oqT+Nhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797577; c=relaxed/simple;
	bh=KuUjD9YB10H0NeUmAk02gqaD3ExXFOK9aDAnSn5p4g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MKe+Joue4P4B40m+W/9Ch7N2IV6+1r10oxfaRoC5EVOhnGfZCp1VTw25cPZjteC8kEdXnGN6+NNW77mKbKeFC4tbyAQUOz8REmw8lwXVKC+3UyfCZ3XWBaCZgeWhDs/N8KXY/LP1l0/wK9IpPZpwr7w7goK7cB3QqPvirBKFnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jrKmYUuN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jrKmYUuN"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-41706b23543so368308fac.1
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 18:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773797575; x=1774402375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn3uzIPkD8X5K6/j9sFiQ6D2mCa3vt2KvagoW9sm89U=;
        b=jrKmYUuNTuLTtSc/1KfXKNw8iloOQBsok1SnEY5mHYF9Sm8I5kPxTbHKTl9dwZ6ZU8
         efWAj8nn3fBjldu/ELSQp5KnTgiUk09WUa11a/S8cnaW4rRwZ6FllbT39IqD54570Jq5
         fyxy1TpJuRbO9+v7l6Vvm3InxeAJfhlzxOqZfxukYq267yhbqfV2f22ZBsysUhkTFMMb
         nfzqV6farPlz1GZeQAMuOQU/mjFckDJYOh93feQ11vrQKLlOy+bmATjeoU4zDm5ZtNp0
         FVIKTPjcnTDy6OjhML1L9MBm2Lx8L+hUZSiXpRtsh+VaO5vdsaYdYkN9VdZ8n9zlTpII
         6fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797575; x=1774402375;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fn3uzIPkD8X5K6/j9sFiQ6D2mCa3vt2KvagoW9sm89U=;
        b=lTyC5yaFPdeNc8OmSIQUG2R7RN02F/Axk6nLQi69Euf8xUXcWz7TYNen5XoIs/v4Bw
         xa+lhEAG0vPVNTM/lQrp79IUK1NL3iJuepgsUNM5S4H2dlw+N7tZ4HDmQkoD3jQSYT7z
         kJkeXkLWUfKj81D6YFSdUywLMU859ZRVsKvYZ0hdEbpiJ4AV0D1HGepkgANvvDyLVCKN
         gtyG4BsYOlTwQrCgF1mssf+GH/rvHZbrVm/vMFj21kGySwiQCRHwSip9qtSKpos99Q37
         rcwL/rzATPoxDUEOiaAzs/ee1YUb77Xdgw/yv7dP+wQR9+9qXAZxL+HLTzng2OrPp2Ua
         LJww==
X-Gm-Message-State: AOJu0YxcpvLNDFqV3mNUIzzXq90REYyjiFqxGnI4UeuS76CmxOCgIDOh
	RtMMaST2+9aih2FILmppSKDdZ7O+95rxmsgOMg49+hTlWUE5kSg+yHulr0rXYbrQtIjG/9zTcw8
	4MDjg51E=
X-Gm-Gg: ATEYQzyPtE8e06OmviAr7dvMKUWv84RdRDtH9xQIlblYdj28OOVZANlzQS4HHWNykXy
	4ly3+434xWm4QktXwv2EKqMANTkKtorT0lPaLbJ1V0JOiVq7fftjWKmKjstYyZMX/wEsmvG+iTy
	AcPXIIDZq2yIT99hW87peUhsARsWDDORjxigWM6nUFicNG+EFqqAF6HzgjJodyZrXvj7zAVM24F
	XG6S7y8gjDToxuFDmhdF+HnwfChWbRU5KVPlVuz2ofOR6WJQhOO/SSqWRlYYX7D7XyvYPgml6un
	LUQhaRVL5NVG/TNwgvmsqHR4HF0LjFqY2XG++qJ28E76r6A5ZKNoAEbbaeF8aDiiIbtcKMkDMQO
	7LoU1l9SX5XOkGZo7q0NGj9SfDgHYHJxZmOfSPWRXwjg3L6PReGBGp42/PVgzP3BtYenkf3Aj7Q
	myxP7/4fSJle9vXmEka+gPEt2brl2UeaonstierB/B77Wpq2VTCrqqX3Zaw0HNdY5SKaf9pguB/
	E70
X-Received: by 2002:a05:6870:d182:b0:414:64dd:a2f3 with SMTP id 586e51a60fabf-41bb09ec9d6mr3477615fac.29.1773797575039;
        Tue, 17 Mar 2026 18:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd288d791sm1441221fac.7.2026.03.17.18.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:32:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
Subject: Re: [PATCH 0/4] block: make some sysfs attribute instances const
Message-Id: <177379757390.1036731.4304443188385516980.b4-ty@kernel.dk>
Date: Tue, 17 Mar 2026 19:32:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Mon, 16 Mar 2026 23:43:50 +0100, Thomas Weißschuh wrote:
> These attribute structures are never modified, mark them as const.
> 
> 

Applied, thanks!

[1/4] block: make queue_sysfs_entry instances const
      commit: 223983874d0366ac12d30eab3b633d699bdf763e
[2/4] block: ia-ranges: make blk_ia_range_sysfs_entry instances const
      commit: 3c9122630953520e2a2b6c6a28751da23457e4ef
[3/4] blk-crypto: make blk_crypto_attr instances const
      commit: f00d826f1b8ee39a4e9283f2eb537f5b49e07829
[4/4] blk-mq: make blk_mq_hw_ctx_sysfs_entry instances const
      commit: 3141e0e536b43ab3555737cb2ee6ea1ed0aff69f

Best regards,
-- 
Jens Axboe



