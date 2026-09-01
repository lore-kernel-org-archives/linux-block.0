Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4823D5C05
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273865; cv=none; b=HnvEsHY/0Q4ZSLm2qCAAjOzUjlVV7nndgRpNCWgfDGjQgUVX/10Eox+zDC8EvWR8HJOl2tFg0Ch7sM2sPsTOVftDYKNevMO/nvQIlRfq4+kzY6YYfox4nV07yM/zmk5Dfg554uDn6DMyuBaS1qihD9o9Z7fDLCp4jcmAnNgMkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273865; c=relaxed/simple;
	bh=Vs/HIaaodVD0NnC6VQzyfnduG7P1UEMs/f8x8tun0yQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eGyfdUzk7jlxDQy7ZM427tH4rxDsFF5+mgwmsXRAa57Wbel3iaTGJ959PD9dBvJk4GKhjoxeJNnLNSwNp3smQKiaeoXroWpYV1eObmCuwGFB9IH5WmdHoELH4rUXiQUCSKPQE46fYAJpG9E8lCGAQho0AZIsYWhqU9r+7XE3ymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZAXUcdgQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZAXUcdgQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedf433a99so1256064a12.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788273863; x=1788878663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQDWcVu54h483ErQ9KWOG+VkD/7kihXvcoMajqP71Fg=;
        b=ZAXUcdgQoHH87yJ86V3R6KtbHfosNWf28h+9DVD1ehq9uXstzFmU+KQFWSVUPen/4M
         FHheunHUX4KxC699VAIW1y+RyVRjtBbXlRO/Il3N4rOzAAGVyKMyM26d50RSIPXuACFs
         ZcB80s/oAZzu80zVeRkIkocaP5lohprCtpHK1lPxDjPeO2xLCJCoNk7kDNUcF9s4rkwI
         aRiNbWRaI3paCh90izSe/ckZY8FgW1owLJPT4EkmhdR39RohTbJSLZyKBtcA58UFMKRS
         dePgxB+rg8OQOmoK1lRnM96hokmITqJ7dUJhPc+1Dmv7VRgCqXVFcXQukZ6PxSq2OWxR
         IULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273863; x=1788878663;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQDWcVu54h483ErQ9KWOG+VkD/7kihXvcoMajqP71Fg=;
        b=p9p386irRLDLM9jtIC3x+Nf7B+dGxBFwyPyKlrq+LbqT0oGnIzIQBEMctA70j89hSo
         lwQu++r6OS739I0Is/RSGJ4yYbPRKIwgUrU2rP6msg7ww8+eHFzmqIAPfrftO8LOq/D3
         IrS43uImZOpy+LN9tTkp31yFQRNALJEJXxSELVI/H3fYx+yREpdGVHh2KeUbpxGL3Ujy
         Jjp4n4PGhN6BgsjzHOqp/vBj6mYa/N0uGKdH0n64saEqAF/xScimBDWV6F0kQ0vib/nL
         H8YK1hHVKgz+qFL0pLNLCnAoikJ9Tmy3/KeLWsKh+lgVj53ox/LfgVxr52zlfmaIvICQ
         ZDEQ==
X-Gm-Message-State: AFuF++nsTffxMQ7U8WfsFRmZzWhg578N6awLpptGYrbJarUxJHoIRMcF
	z27WKhYtAHBFLZ70SMmrSCNQDFEzcPpq85NR/4mnY6XTjzfwDBcayD3+OTuKcWvdBjC2CGls+o+
	WyaP5
X-Gm-Gg: AYBFou0KXpFIh8X4Co+KXn0Mlln3m8JyPOPBJxNeZRwc7rIqSiONOb1WTx97PfcROzd
	hMBWEHjgHRwv7LLrKEOfGbESSAvptk20xYgEPpOOao3hHH4V8WOZEwhX2WE8bO7dlDALpLJyL2B
	v4uYUzWr8JWhq9y6LbrHjwKf0N03dcJUQuY4b1MnIR5aa6YbK7IfALLjtu2mLxydDMyYLTSfdmo
	oRzAoeW4yyQNIoP5awe6xy5cALfyKX1BXAcsvWpKspeELqGzGb9gmX79P5D6CqfHmOhAfRQqXPp
	RMv+hjgZJHXu9gcEmhZqSsE0ozc51t12/YjIMyd2VmuXyxGpp0OviubLw7ESCcGmNnyvMme9r0R
	VZwM9dKOIr/ALp04S/DW2Jfuhr7v7SmE/qP93/uP4qh18PDJzote7jI89j7zOyiSZSwdW1HvGB9
	Qpo5zMLR/SRXOz/bdcuciY53bih0l4RbAJIxz+qw1Rkrc3mza3y1S02tYExjYn2273dRWviQrBF
	2ljwhLjAz/HFQWrJqPCCnR4Y1I6fb4eyIs0BO0qU/w=
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr56992579a91.14.1788273862595;
        Tue, 01 Sep 2026 07:44:22 -0700 (PDT)
Received: from [127.0.0.1] ([192.77.111.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e907fsm34773046eec.25.2026.09.01.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:44:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, 
 syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com
In-Reply-To: <20260810164218.3721636-1-kbusch@meta.com>
References: <20260810164218.3721636-1-kbusch@meta.com>
Subject: Re: [PATCH] loop, zloop: fix dma_alignment for large or unreported
 limits
Message-Id: <178827386167.2511601.16975161509394115271.b4-ty@b4>
Date: Tue, 01 Sep 2026 08:44:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 10 Aug 2026 09:42:17 -0700, Keith Busch wrote:
> A file system sets STATX_DIOALIGN with zeroed alignments when the file
> can't be used for direct I/O. The zero underflowed to UINT_MAX and
> triggered a queue limits validation warning. Fall back to the block
> device's limits when dio_mem_align isn't reported.
> 
> A file system with a block size larger than PAGE_SIZE may also report a
> memory alignment that can't be expressed as a queue limit. File systems
> fall back to buffered I/O for requests that don't meet their alignment,
> so cap the reported limit to the largest possible value.
> 
> [...]

Applied, thanks!

[1/1] loop, zloop: fix dma_alignment for large or unreported limits
      commit: e52349a5ea6a74d46dfb703fcb64e08b5af28e8c

Best regards,
-- 
Jens Axboe



