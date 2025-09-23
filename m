Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90C24BCF5
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608587; cv=none; b=GoWGlM8C/tyu1qqow2psnXzhQkbe3lIak2cBrv7yVFrnBREO/L009bHPCyocEAVkcTLWyesPRaFfjrRiCTk+VNeHdR4L5Qyrnfilt7C+tFYUwbGa10KzTa2QnI6E/p8jfywgczIXTSLdRiXJs4bJ/sfWT9PvRXycJVn2a/XDEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608587; c=relaxed/simple;
	bh=gpADuRh6f+Vf5jCE3pTHGFBoL+z+Mgi0YVuks2Gjf0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7itZwc9dPHqvC73SUiCU6UeP7mTVr3q+mQ9uhktQrcLfdhSXwY2lfhcuNozrGwCtI5AkkGsAp2oKwYXFuepm2vZL0nXfqQ2RmWLHs44nwTmXSMOrU5mwPOX/9Futaq0nGbgzfCcRumFfHtuij0DdXVXB0DPNc8arAiKu3yUofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Md4maQk; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Md4maQk"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-60170e15cf6so3291225d50.0
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758608584; x=1759213384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlYhy4iad0IOYSealpZd6UIVZ+8slfEkxDcbL9xjfMI=;
        b=3Md4maQkG+q2IPHpAbiehmO0Q7heqvgagKzaNgo3JKKVr2X1isG0u0MP77ZLi8wQm1
         2slsseIp5roDeiW9v5Gm5toVYbuyl0vFLWoz80RBqFKuQSw60/3h6S2M5SBziZaTRpyL
         sRR6h+3uCSPC4UnpnTfc/b5W0UEu6tN3PYt6IHwA93zQpswTc521SHWgcaK0eA9oyz6a
         QyHa8pumZmQZp9kjNmzXmE/I5v8Bsw5tqmr8mgoYCi9w3qD7OyZI5qfTq4yzeoQo/Tq/
         rezkFxnmIkwvMcxzDPlAhLSG1zKuVbCL6y5E2ufNrn/5+pYl7HtxCMIVbVf+xeuqY6TG
         mPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608584; x=1759213384;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlYhy4iad0IOYSealpZd6UIVZ+8slfEkxDcbL9xjfMI=;
        b=Ac9ED8Oc4SxOgHyPdNEC1pvBzErlBIoWUag3jgTNcvBdWDTJ30hgYXgNPJuhOPMLkB
         Q3si2eBZy7LGroYVeiAm84oOURNfIxeKqkSvLGKCQS9ZGFdJGpDJlhzTi+1r2nQxyx0e
         C50Nnpyzpz7QlOm675LvMSJUxnupT8PLf00mtc4ePgU5vQkmYghvISap6Un7xYfMiiu1
         qS5V8Sxex8rkMOOAfkwb1AhM7ndRALqpvVrXy6+fp/ivCuP3jFQ0x4rOEzEc0zx/yrHZ
         rAcx+4p6sSn7TbwwnL8sm2pOJ9hzcF6UGmqoNu27O16AZOGMR4eRC98l5AHl0EUj5C5S
         x7yw==
X-Gm-Message-State: AOJu0YwVyF/5r6StW2L6KpcdViKIeAvwTnj5a/fKWqd2tl1y1Tfeb0I2
	jGyhPLiWWxO4gyyO0T5yo101peo8QzdZPvIsHgq12e7kt6km/01/0LwdU3PClLiMu08=
X-Gm-Gg: ASbGncsUueQGGR5dQE+LkMAmevLwur595Sji+Zz1nzky9fPm7RBD5oqhA6P+6uAvADu
	3d3MuLGMWze1OFk3mn0Gk7e5YGyfY91wuy/9zJ8Fg6AvAwW0CAneTySoXim4rig+qhsRaVU46fx
	gkd4vJD/hKU51LTF0MsLpNq67CQb6Q2SCqP8Zz3nS0Lp9VBFnTL5gEvlHu1vO54a/3wZZV6ze/d
	TY7H46Q9KUARW2QTy1DD5C4tTQmF8ApD6FTiA9lAyo3i1T8L89WHyXU70KvW7ulpV8Nv46vi+E6
	bunDRR0ifmLXkFzsXt9r4JLnW2TOKMvELxWyzqf+44asJsaI1rwBIyDfw6zpk+NJS2mG0Skp+gX
	dD/YlFHNii8RTYcuflg==
X-Google-Smtp-Source: AGHT+IGIm4Q4k3llfelFX2FrVB8K2iuSGVEKBxDxDg/xJVMBugUdbfQCiMQnPylld4SxuM2wlFRBww==
X-Received: by 2002:a05:690e:2497:b0:635:4ece:20a8 with SMTP id 956f58d0204a3-636047bacb2mr946246d50.45.1758608584199;
        Mon, 22 Sep 2025 23:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-754838ccad4sm8286267b3.57.2025.09.22.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:23:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 John Garry <john.g.garry@oracle.com>, Ming Lei <ming.lei@redhat.com>, 
 Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20250922201324.106701-1-bvanassche@acm.org>
References: <20250922201324.106701-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Fix more tag iteration function documentation
Message-Id: <175860858293.149066.5053815124541921058.b4-ty@kernel.dk>
Date: Tue, 23 Sep 2025 00:23:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 22 Sep 2025 13:13:24 -0700, Bart Van Assche wrote:
> Commit 8ab30a331946 ("blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument")
> removed the hctx argument from the callback functions called by
> bt_for_each() and blk_mq_queue_tag_busy_iter(). Commit 2dd6532e9591
> ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn") removed the
> 'reserved' argument of the busy_tag_iter_fn function pointer type. Bring
> the documentation of the tag iteration functions in sync with these
> changes.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix more tag iteration function documentation
      (no commit info)

Best regards,
-- 
Jens Axboe



