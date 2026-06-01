Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339937BE85
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340374; cv=none; b=SFvC/6QeG/rNGM0W0SiwpdgFny8PiJxaOy/oIkbZlVAV7ZoGqpC/Y6cY1TQEb2P06WpiAk7OuCH89LCrmigAxr//d8saMlso0dhLdiBdREdyugFDB1fXlrJbw57WdAid+teS/uMlBDvfAjcJC+zk+7hePqfjA2lDqwGBQm/WZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340374; c=relaxed/simple;
	bh=Oahdd1iyQAdZ95ufgwnXaEBMw30/SX3sNkls3ORHuvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gl5SCBiirCtxkZh7lfZUrHOpaRpIbNZY0j6RH6BbYB8jDPZ8tX2e0vaF2MCd+vST2JHPimnY8IYyLRgjvSLODoMtCpEyxn1h5REbnZy36kigbxClqFo2f/EuxwcJJD66QDXM9G1zuX1ia3ePPJ9nHiJLM7wz4zKFkBr6PrgtP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=fB5hycku; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="fB5hycku"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43d2c7b5a6aso89983fac.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780340372; x=1780945172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBiOs3FxTFG2gkTy6rTBpEb67IkQRWWZbBsLVd+5Kqs=;
        b=fB5hyckunecC9TV/G25nJIbpsCq6skjo8dvHRn+XSzWiQl5ZfZnJHxjIGgwITG54t/
         RQIw3tiptESpAbV8Cqp/t4ktw97oSkGTSZHeUaWcWBLZIKgYu0bfNjNai2zYbpFg7VSO
         ZPJbAIKVdOmGp1gs8Kg+IdbpI6EqUrPlQYTA+RXjJOFmPwLipxdac/PvY6uSugyaOzUC
         KHXIW/uQK0U0HAz1L9MCZtior3urI/jPy/HFON+nzYeZv+jW60Dsq8dplsmivpTq4NQs
         QxbERlR2L3398UJkmvW1bB5xnnAUlsGmG/itir15SdU950cvECv6BRIbe1acjCM5xExd
         RaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340372; x=1780945172;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBiOs3FxTFG2gkTy6rTBpEb67IkQRWWZbBsLVd+5Kqs=;
        b=F5vzLc1x2biW8cs04HC/XDuFJvwXblCqgaj1QnDMzQEv5T2c98MZRBU7v/zm5PEHs6
         w04n1NuXyfe53O5N39D2W91qWG++6RgoBe6uTyLSWLd9iWnsOWEoW+98XAYDlyQlTXIw
         ID5SI+3OCYmur3BxK9p+CdybqSKUXlvbUrIAMADSO2OOeNB53xdo6d6cEuoWoL7dtAcV
         38Up5TPuHjTJIKHDCN9U1OkXcUNs+x2hFlWsm0GW+mnR5FKs1UDqRmY1Md/SqNzU6u6v
         Bn89SpvORtJfLK3wK9ZkN1M4KSvm/deag2F57GQLLAavspVRhN/UtpZXiBCwgKHS4WVM
         HDeQ==
X-Gm-Message-State: AOJu0YyEa6AtjL2LFfmNm2VYPXtd0OjyIlnJ2uYwyksqsmyv/RCDR1QB
	Yaq1AVmHns/XTMvQAZFFL6VeURJhKiYG9EfVibp0assz8GLSgR8/GguzG0soE4m7/N4=
X-Gm-Gg: Acq92OGycTiACZw4y5S3btIapWn+xXBAE0QSMj4CZCzVfrYmAlJDHDMgmyD47JGWCSJ
	v+Rh5+tlctIVKC6v0w2dDtTd24lw/rE+1WZnaFr+SamzUlslZK/teDjybqiAkhtnn+v8dqwcDGP
	4hzUsWmpayApvOjw6m/nE/6RsYNLu9oisMu1Z78vOwCG3NM7ztFIdh0g3eSQNc/j9hA0UUnO2WO
	A3BLZAnakhvg9zGiSC1Jj3IrQbat55t94l8PyQytM+jpZzEQ0SV1DQbb4qAO4UcBgZ/MznIKSmO
	dpSnqOwJEODUuUC7MGklplvFJbiOALO3KSmnJl4kBCX44IS3BA8e8aLfGv2Hq4Oaxqpv2/sibiZ
	gySYIvFbgkULT7AyVdMaCYLrBRyK3gEu6NVMpiOMbZxojOOqrZwzOZlr2X2H/U7jJNe+6AGpHS1
	yJtpsLoTyfJ9xVB7X30KSnX1Ksj1QULu2QNZn9Kf1zf0tvsRdkrZfXbvqFaFgi5Tzm1w1xPYiTr
	GYoGYW+L5rRGw06qV0Q+Q1p
X-Received: by 2002:a05:6820:2219:b0:69e:2fa:a5d5 with SMTP id 006d021491bc7-69e105a424bmr7103390eaf.55.1780340371861;
        Mon, 01 Jun 2026 11:59:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm6386319eaf.5.2026.06.01.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:59:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Yu Kuai <yukuai@fygo.io>
Cc: linux-kernel@vger.kernel.org, jack@suse.cz
In-Reply-To: <20260601061502.899552-1-yukuai@fygo.io>
References: <20260601061502.899552-1-yukuai@fygo.io>
Subject: Re: [PATCH] block, bfq: release cgroup stats with bfq_group
Message-Id: <178034037115.437649.11950865294578053638.b4-ty@b4>
Date: Mon, 01 Jun 2026 12:59:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 01 Jun 2026 14:15:02 +0800, Yu Kuai wrote:
> BFQ cgroup stats contain percpu counters embedded in struct bfq_group,
> but the old free path destroys them from bfq_pd_free(), which is tied
> to blkg policy-data teardown.
> 
> That is not the same lifetime as struct bfq_group. BFQ pins bfq_group
> while bfq_queue entities refer to it, so bfq_pd_free() can drop the
> policy-data reference while other bfq_group references still exist. The
> following blkcg change also defers policy-data release through RCU and
> leaves BFQ to run the final bfqg_put() from an RCU callback. For that
> conversion, stats teardown must belong to the last bfq_group put, not to
> policy-data teardown.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: release cgroup stats with bfq_group
      commit: 9e1183a465e4a912cce1e4b389d0d7394c127eb5

Best regards,
-- 
Jens Axboe



