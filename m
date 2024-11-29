Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A631482F3
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896258; cv=none; b=YiXUiT51zvUZ5fDV0Ms2rxtBgrikUFP1EO9K9DmhhHJZZEjOh65E2V0WyVrq/xiPGZmPdvfj+ZavbwDI/vizDDXgvom5UCbXxdbUMc6XJemTG6cJWW1gexcqbeEsedLcoL7tzM2t9cOfEJsmB1o4WqhOFcN2X+VmY1op9q4xMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896258; c=relaxed/simple;
	bh=yDyiTJZ7PCMME/KJgTIqn/qo1ueK+4yeonUxMByXyXY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ngKJuopC7IbumquRtPV6rJaTp4ydiJRs79HBDiT1DlYFX0XIO2g+k+TuG2QnxPkqqBh9PWwjDDxdCQz6e++WuOBj8IMDeHqFIDbGMC3l6CNIuuqYBUT4BEiQ5DdXi1cSGg4zU5DgB0st9STs6CISTooE7llTM8xGZ+bPC7A/vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k8tIptTM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k8tIptTM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-212776d6449so20098305ad.1
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732896256; x=1733501056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIoWwq7VQwCR7bigghGYzbnDItKHTQx8KTjyFFdWLAI=;
        b=k8tIptTMqgaQUIDq2+UcuDFDWDaegM8UMz8thV1EF8zbnxpywcHcejeV3ESG2op7f/
         Yw8/KVJbhPMmHQ+q+RmRhsK3KdbOm5UIv+rsJfM3qtQ2Db59ugl25UmsTRj+x8V5Ucms
         6RHKolrP5Yv9TOMXbPlcI8dhWzBGzghPrwCPEUVwxjIi+G2Dyf+1df/4XWF35UUMB1nk
         eNHe/pTXRwGN/L7DfN0DOo7iVDxCb4FKfUfgPQ+YhJ/jYzGCtxlVdzGMPbnyVXOqyw4F
         gN1MFe9/91qNZFCPhn+8VYr+vOoTf+4sWoMKC+S+cNylB859DHUyyofwfqxWpAPz2LiS
         dZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896256; x=1733501056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIoWwq7VQwCR7bigghGYzbnDItKHTQx8KTjyFFdWLAI=;
        b=SnsMs5IO8RGHpCpylzdZ7CKt7gwfsURCRez4qQxCDFK78t6ZbGJuX3VMSHnO96vPia
         fdeMWzltSLZgR8B7bUFJ1gTcWDtVn8ZMy94xSEadU+yHvyotr2TGOkr0tyFMpEUsNr94
         l3e1+mTtnrCJvdQhJvPuSJ/6Us1FxgXMbEIfLlizuyTKj+J26yF48eR2IjFDcQE014Rb
         pI75RUE26SQzKplH6EmeIyotlDv6eLZexcnPPczW1LVTZmLt/VG2Dxr8/2dudRp9t+Cf
         cWergI9FiTBi6mtbPCUOXCO+Y78W4kmOedf/NRds4YZwLuhb8yg4vZq/fH/VR5qtQaDk
         bJhA==
X-Gm-Message-State: AOJu0Ywl3MTlLXh6YXlnt7D4IO66N2vB2eip5fyx1rud3Y/+G67q0V8M
	dwO0JJgm0ZAEx83ySjtQhs9U7c3Gk4LFTZp7BgwvdNislVOdKA6HVfQf6yiOP9QsJGNcih9+iR7
	n
X-Gm-Gg: ASbGnctXFXb0CAe56loqahxe/Dz2iDnL5VSFu9t0z1v6F3w/Ll0udbFxe61fEUzTB2w
	0JCmAfxXNfXnKNv0mAqLaN5Fy8RtCOCiHP7acBLJt2mj3ImfnuXrwln/avTD5EKAlB6+OHsCuzu
	O2f0Xe7GEGYG3o5uwLARph+E78FTkCgEpSl18vAm4WhIA9Z6juL3oQxJx0cu84/oDd3shfBpA1p
	Sg8z4JHUV+UeEvY1YR8OaufAWzwGc5WNZW5gajdVA==
X-Google-Smtp-Source: AGHT+IG+hkJ8ifUL+a8CsKrf5+jFMNu1UU7ShJujOegyuYilMPf5ufFzEIptTTJATV2ZKS4ZOseoiA==
X-Received: by 2002:a17:902:d2c5:b0:212:4d01:d43a with SMTP id d9443c01a7336-21501d5d3c8mr189018105ad.48.1732896255968;
        Fri, 29 Nov 2024 08:04:15 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f46a1sm32302925ad.39.2024.11.29.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:04:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241127135133.3952153-1-ming.lei@redhat.com>
References: <20241127135133.3952153-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/4] block: cleanup queue freeze lockdep
Message-Id: <173289625498.195012.13697470232900500446.b4-ty@kernel.dk>
Date: Fri, 29 Nov 2024 09:04:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 27 Nov 2024 21:51:26 +0800, Ming Lei wrote:
> The 2nd patch kills false positive caused by removing disk io lock
> modeling in blk_mq_freeze_queue().
> 
> The other patches cleanup & improve freeze lockdep model.
> 
> 
> Ming Lei (4):
>   block: remove unnecessary check in blk_unfreeze_check_owner()
>   block: track disk DEAD state automatically for modeling queue freeze
>     lockdep
>   block: don't verify queue freeze manually in elevator_init_mq()
>   block: track queue dying state automatically for modeling queue freeze
>     lockdep
> 
> [...]

Applied, thanks!

[1/4] block: remove unnecessary check in blk_unfreeze_check_owner()
      commit: ed8c161ce6cd884490e74939607a9f240181c48f
[2/4] block: track disk DEAD state automatically for modeling queue freeze lockdep
      commit: 5d330161ba9b12b3b8351ae13812a6bdcb40f0d4
[3/4] block: don't verify queue freeze manually in elevator_init_mq()
      commit: e4916fb7a27971a645c6ab365bce64928f9ec4a0
[4/4] block: track queue dying state automatically for modeling queue freeze lockdep
      commit: 4583dadf81a3ff8919a82c814efa6742c0f857c1

Best regards,
-- 
Jens Axboe



