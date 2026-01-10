Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390613957E
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064173; cv=none; b=hTpv4ZjpDS1kpwdwyhkX5zUJlYZViQHjRQkIH/36v+phHLt6oXo6Y+RuzHDncHEit+F1pG3Uasygpdx0INdNwJFOETnQSCmS25/9nxSiD2PGdDkkcvDuyb5RBgfjOFSe9IUVELG1VD8p3qS1UiQxtLycE4gDxUE16509reyBwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064173; c=relaxed/simple;
	bh=E/vqhgvFTb5ADzwJFr4cNOQjRqIvC++exChk2BklB98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mwf2ESgf0QcPDBPhsutNV/9J5hNRb5TGQMMF4yCkZjhqeJ7Cv9nOihJpaInMX95NMIsf3igKyQkNwpjcJo8ThDHyt5YXXeg/KM4ebI6n0w3j0o0Na5LVDTGZ5L9Ft4PbDunQjRzrmE+OO9hytWi5DpjhakMcJi3t4NV0isOj6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lqKZ1fnr; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lqKZ1fnr"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso3831993fac.1
        for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768064168; x=1768668968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts1vNb8Oss5BqoI8k+MspJthdPV8enkOHgzeil1WzdQ=;
        b=lqKZ1fnrXwe2UcLLsNg/REasYr3EVKhqVfdgYO2RA2IPw7Bj3ZwalRwhiBtq8fhScY
         Fev3MS3p09FfslO3eL5gS4pg7kHF4PF3EqiSTHmmGh7Jr0TnFq/nag7tuBUXYlqsIxta
         LpkhYusppn48mNcGVXKiTmMXpfiaQKAyaVE5dJwOOLiK54ymPrNy24gBJTcvKHI5c6Tb
         VL1BFdo96y6L59CvdnUG0Tn1PlqaND5TSIOzqLaUtdPbbMvziIOpZuPGyauWYAPHnuKp
         hUb4simGdCf8FDB8WlswTb159NIonSpY+c7jIHhQu6SjFpxY6pF2vKwIUH0KbNa7Dwga
         zwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768064168; x=1768668968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ts1vNb8Oss5BqoI8k+MspJthdPV8enkOHgzeil1WzdQ=;
        b=pYC9Jdyj1Cmt/nPKSnlHikVWgtz5G8esYf5DW8IEG4qIbLGTbIxARPH/MC4151l5vN
         KdB7A/UHfbH+IKpG9GeRpkUaFi54Rd5CmIkQ9NKd08tsJ7NLLT3EgFmVxX3ZdAiR/JWb
         avlwhi1rDKj0PIUsFWFhaG6WKq0C2pmdZNjUfvIjcYjoWs1CWqLW/NcpZqflKqHWHLu4
         5Z8YN7Tg7QmdI81e0FPCenvDMepzDj35hgwkJfcicpiifxmFVJ96QzvQZrO8UhM5VUvA
         raKJYH/euOeCw+BTv6Al5mqFvMPSQNEatwKE2tVtX8uN8dpnU0ZVbjJ82pc/cC4Bu/8p
         Y2vA==
X-Gm-Message-State: AOJu0YythdCG+6VwY1umubCcz+zZhRjDRC8Pcygt8nUnxbLCpbR0cvzf
	8SsqmBiuZkaRGTBwXsv/jCcbffpv74rJovpHOU6yxe7KHVwW0XeTu2bV3aJW4g5WqgSzcqXHL1e
	VF8vi
X-Gm-Gg: AY/fxX45VcuXANvvQvORTsRPgG9XXjRSArOcCuHveSZ8N5p+lm9ZKhrC1mw4Rb0WNMI
	7+GNEkFNN4YHdUMORgkvSXW2l1KGRSGIw/G2exv0ar6yFuzmIDYjQUG8QIbUd3CcPN6wnpVg1Nz
	xIXLjB11Kq3C0l9IGQdmZZt4+iUEKYCLQZi0ToclMr1Q2Z/FEYq0EY+5L59RigQ8kbioiKCON/H
	ruOfjhopZ9aOztluMEa8dhEMvTnn53s+Xp49Kvo69VikmADGAt1BKSyElzQhiW/0BxwuO3ojy+J
	3XSZK6bw/d1RRsqBZemOkrV5C0OPUpHKWk9PyJ0JFuClpIVfU39yZNHVrlQ5OHyU9Rt90m0LKNJ
	vCHBRu+M8lEqbJ76X/U6thHIAETCGRzhJknaFNK43j1+Gzijyul132H/9hu9XeuLFJOypW1jU1B
	zH6Cc=
X-Google-Smtp-Source: AGHT+IEn/8EAyH17h4+RIJdlTRFz0BQFUwF8XsOqGrTI22FPD/K4GajMr14cAzc/1vcFy0oSyEFF3A==
X-Received: by 2002:a05:6870:f71e:b0:3ec:e09e:b80 with SMTP id 586e51a60fabf-3ffc0b6ba0cmr7121894fac.37.1768064168491;
        Sat, 10 Jan 2026 08:56:08 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50722e9sm9138858fac.14.2026.01.10.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 08:56:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
 Christoph Hellwig <hch@infradead.org>, 
 Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20260110134236.442681-1-ming.lei@redhat.com>
References: <20260110134236.442681-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: account for bi_bvec_done in
 bio_may_need_split()
Message-Id: <176806416769.162964.16972858799904355920.b4-ty@kernel.dk>
Date: Sat, 10 Jan 2026 09:56:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 10 Jan 2026 21:42:36 +0800, Ming Lei wrote:
> When checking if a bio fits in a single segment, bio_may_need_split()
> compares bi_size against the current bvec's bv_len. However, for
> partially consumed bvecs (bi_bvec_done > 0), such as in cloned or
> split bios, the remaining bytes in the current bvec is actually
> (bv_len - bi_bvec_done), not bv_len.
> 
> This could cause bio_may_need_split() to incorrectly return false,
> leading to nr_phys_segments being set to 1 when the bio actually
> spans multiple segments. This triggers the WARN_ON in __blk_rq_map_sg()
> when the actual mapped segments exceed the expected count.
> 
> [...]

Applied, thanks!

[1/1] block: account for bi_bvec_done in bio_may_need_split()
      commit: 5461a44ce37a507d8ed7e03cc65eefc52cb5a8f5

Best regards,
-- 
Jens Axboe



