Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED0279917
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346975; cv=none; b=VT0eupKekMkvIyxQ96E0zLnMiPaBtorxM6v5R8eElmn0Bl3bEt5ym4lQX2mq6RCEHG088PK5jhgy2NDi8KG5JbhZC+lpAMRaNobc6vTt5csqovEszNXnDQJhkDocFCAEq6yhee7hjOphW/gsmkOSY2j6kT/VjMePo1/wPc5wHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346975; c=relaxed/simple;
	bh=8jch7V5/JV7pNdEal+YzMwz2CniBpBDtTRI2AVqi67c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZV7jGcvpwEewVv5XpgmNMbjy3vyGaZaeQjbHeBlQCMHTbiHABE6TYVJpICx9nklbhy+v6O1y3uORcCAQZMZBjVP5NEKt+7gzD2Lqw30w74kU4CdPmHFnm1reWmEfOlp+tZi60t+FoD3gyk6jvc5o6sr1KyELMXpmlzEaft4J7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KD7Z1scj; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KD7Z1scj"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9487e2b9622so86489639f.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764346973; x=1764951773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbCPSFIm3kgm0R08DPiBcTmi2Y4a9LGKVt7fazZIKo8=;
        b=KD7Z1scjwAh4PRLxuH/QRH85ucnTTj6exYCwkHkbh+n2qK6mrbOGslQ7FanGOCNLNx
         Mwndd11ZGGi8YuvkGItFl9aui3gCPszhI9KwX3pNVPzdK64jui3BjItyDpocEm+HqlMm
         8SyXrhv2P1Mk5roR9zqT5kG/izIP3DMW7QN8f2yDZ30rFJdi9Toge9ZwUFKaMlBOuToF
         7YJUiV++M7teRzJfCZyulBV6+achQkv2bnNUUNF0Rmp36te1/Li2nIOtbLWVPYMlS9Tx
         yMypIAx967AI+2gQxk8ujhZIS+jYj+DBEPsW5RxjviPvXS3efcVKNUMxLcOO0mDeS7S3
         KpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346973; x=1764951773;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbCPSFIm3kgm0R08DPiBcTmi2Y4a9LGKVt7fazZIKo8=;
        b=Kl+SRcMbPeNYFtDUBo7up33uRfsDOmthwJlxPfys3V1Wy3NzP/Y3QbW0ZtUPHV1bt9
         RpOus/mwbiFghY8gOTBUppa/gxrQTj2KQuXRgNYVtRxp+QD5rjBtMtlVjW7MAeDKyxfk
         nLNy0GE+fgX4zyV9yJc1gnlJf0qBUIOc4ccju6cuhlKvJqds1ICXAM1dJpRvylaOskT3
         uX3WVSwyX2rnHLqVSlfpns67uGyR2SwcThdpsCIl/GZfV7pwHy3H7JiwjsufPAji4UVM
         XZc5eHdvjRtu/vhIQpDeUF+D0UKCNJxesCybpbpEjw9z30ro7YVXu6qnn2AWhWCZ2NBu
         3g8w==
X-Gm-Message-State: AOJu0YzpE7XNnibZl+dkczBBK5svAvX1roT4qp5qSq2RbmQmaEmPbzZj
	XISiN709mZ4BmzASSkahXK317+gJs/0C2Ghc7vb2NPT1qYlC0lh20cf0MsSaosN2u0U8tUyMbnP
	g54wmdtM=
X-Gm-Gg: ASbGncve4yrLLomozztjrVIRsXe7Yq9dFTNb9m2JooqRQsiwsFF6rLKaNl2X8MrhHhK
	0uUttPtUHpXBXWJASBlGDRXBt/xQQfUibB0EGbW11ls9sqzTp2IpuPTE/R19i0s5hzJXpWFgbmq
	fwtWkdlA1y/uAF9fzDBwPp4KBtQSNMr0BxCLdC4m9+fQZg3/oXjqbChTDUWSe5aVLMEiQgFzgS7
	cnR07j3NnFRycG1K3N/crwbb/8H3IHW8LUjQbkaRurFGoIWlqdve8b2NsDjoBpbRocMfbwwsPls
	arjtgSpI9oNc3AF9Fk6pA4lBquOw+fibmg9saJi2gmcC1u4LqVmgjqYyDOA4eMaLEtEPZK+GwV5
	iSpNQ3LQUFQV7FjsvzqUEH0RVlOqeIaWimMSDgqq2tjQFr1/55YQl6w5CO5A1EO0BdSAGXix9Zn
	QFixQ=
X-Google-Smtp-Source: AGHT+IEzLH2PgdJ+clAV7iqxn+tiNnDdz1u88CVZIgev3c4rFiAfZjrRe8sj7LScL/nBQPb+PyvTog==
X-Received: by 2002:a05:6602:1549:b0:948:cbd2:3b84 with SMTP id ca18e2360f4ac-9497786e4bdmr1299156839f.11.1764346973209;
        Fri, 28 Nov 2025 08:22:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc78113esm2309257173.40.2025.11.28.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:22:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20251128065754.916467-1-rdunlap@infradead.org>
References: <20251128065754.916467-1-rdunlap@infradead.org>
Subject: Re: [PATCH] sbitmap: fix all kernel-doc warnings
Message-Id: <176434697237.231521.5722721037211301653.b4-ty@kernel.dk>
Date: Fri, 28 Nov 2025 09:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 27 Nov 2025 22:57:54 -0800, Randy Dunlap wrote:
> Modify kernel-doc comments in sbitmap.h to prevent warnings:
> 
> Warning: include/linux/sbitmap.h:84 struct member 'alloc_hint' not
>  described in 'sbitmap'
> Warning: include/linux/sbitmap.h:151 struct member 'ws_active' not
>  described in 'sbitmap_queue'
> Warning: include/linux/sbitmap.h:552 No description found for
>  return value of 'sbq_wait_ptr'
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix all kernel-doc warnings
      commit: 418de94e7593081c29066555bf9059f1f7dd9d79

Best regards,
-- 
Jens Axboe



