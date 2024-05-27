Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBD1BC59
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839842; cv=none; b=dwwuml/voLiQWmKMHT6Qvks55NjRZpNZZGcTcNgQPWk/xebCz19vzRoxdylj/Ph2WeRIj5u5Wzoa1NAfRd/zjdOCIosBfC7lB7wUrbP3Tqu6jKNu0uEAUVURDRm/q0CevgjG9aOhXMSWbmsVcQAGNI0y0vSipeKaztFCPOEdjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839842; c=relaxed/simple;
	bh=y/hpS1VJM4itxltG2E9ndZ5cg4O6cNgxPpCpok+VsoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iGlWUhb3qZ3IQUXIW+J4K3ox9WaW5s8/sDxuNt35gb8PiV8AAMTdZGib/ag2wcPcWv73Km9dG/Ku6ov+t0kzxTj+DePgHGmwSEfoE4HNP7ATV4tmnMMAzvmvp28lcXhtcCI0pBD0jqYyPyLR7EtXmNEDzq/PVPF7DYQoPj/odYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s/bpfKSv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s/bpfKSv"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f8eaa13d5aso1310b3a.3
        for <linux-block@vger.kernel.org>; Mon, 27 May 2024 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716839839; x=1717444639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaUw15ddSvME/Jq3vZZGc56yztAZh0Fe7HtU6MVLww0=;
        b=s/bpfKSvpDTUkdH4ty9QQbPBjVVx34Xj6wRbrRIdgXPQApj05VglIiwvMfIaoU1XzM
         rK9N5d11IcVM3tWzQ317jHSck/KnYX9FmIP5sV/OSeb7iZPxOilNbFOzqc6gicol2gTt
         CLuogmUy3ABLqQwvqhpt3ygbmmAYPCIX+B3i2Aupbl8w8N5XmJf+zdcH97iV7iY6j+en
         z7cgN9bm3Jxr7B99SKCrS1SA7ELfSKKOyYrAeQZA2PWd+CsO/594q+iLRpo6pXpMhAoG
         GgjrEDwhYLCGWRYBTt9m0i73JNMCV+RhwCMsl5hEX5j1t4DIIvIPdNEK92PPmxs+RWRs
         rJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839839; x=1717444639;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaUw15ddSvME/Jq3vZZGc56yztAZh0Fe7HtU6MVLww0=;
        b=vWQwlqy4I0JLkpb5GP48MGkInIODiEGzkaeb0KBkK7ehNPPEEja82/dlP1alztV9GH
         dZSRSjWlcwjxSS/G3hPzN3BEYkxsOPnZpLDiaUFIFGu5E8taOp79yq5iRgkvwXsfyZN/
         k338limVqYbpn9hcdKz1tcaN/cmr3+e/DFNHEClkgjPVL4tcobbgGVcLokl7Z7GRZbN2
         EXtZwGlj85fdlJJwPXO5x2HZABOfVJIqcumc72xYDIlMU4nbKEiIBZzYp20pDF59r6+f
         Tj1vKjkog59+3EirrEt5/fw0DVeSL7O9Ec8zdhlnP4kDEcCmUbTIpJiZcqEnplgiYwvQ
         norQ==
X-Gm-Message-State: AOJu0Yw/K02aC4n0fKue4Ifez2oeWhSv818rJt8f3Kq2pG2g0Z5fT/69
	GdVfYHfRYpRQgZCoZe4OmPorfA0UaSM9rWdkrbHXRa+mPOoMICO5gnUS3aJDLiFKCGeC7l4ZyPn
	t
X-Google-Smtp-Source: AGHT+IHT5RKO2Oo+qz2yixgMBUdEH1Kfs5f5zN5NFyc4NnJ/+qIhCMeSBSeyP6sWJAi9y5zrdJHpAQ==
X-Received: by 2002:a05:6a00:2176:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-6f8f3e843a1mr10650175b3a.2.1716839839057;
        Mon, 27 May 2024 12:57:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeac22sm5248790b3a.113.2024.05.27.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:57:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20240527043445.235267-1-dlemoal@kernel.org>
References: <20240527043445.235267-1-dlemoal@kernel.org>
Subject: Re: [PATCH] null_blk: Fix return value of
 nullb_device_power_store()
Message-Id: <171683983784.261912.1189137394920975702.b4-ty@kernel.dk>
Date: Mon, 27 May 2024 13:57:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 27 May 2024 13:34:45 +0900, Damien Le Moal wrote:
> When powering on a null_blk device that is not already on, the return
> value ret that is initialized to be count is reused to check the return
> value of null_add_dev(), leading to nullb_device_power_store() to return
> null_add_dev() return value (0 on success) instead of "count".
> So make sure to set ret to be equal to count when there are no errors.
> 
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix return value of nullb_device_power_store()
      commit: d9ff882b54f99f96787fa3df7cd938966843c418

Best regards,
-- 
Jens Axboe



