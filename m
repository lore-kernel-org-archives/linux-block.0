Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD01D555
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915420; cv=none; b=FYTlVyNviGTf/d0leO/77ksglXyx3YORLkDKZrx3JThiuC5NtNs9HhcEXfLa3S+u3SKTAK785FNL4s368fOWCV9Ab/ta7E7dWNAp5bgeaTznTeFnUQNpWu62nZN7nM2mPZgts2HdJCjynLWnCQv4rDiayB/W/QCGvzM8bOsMYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915420; c=relaxed/simple;
	bh=eeVl3+DqCceUEO3eRjlmQ7hOlJX3gN6wKHKSrxZWG6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zvo19p+RaL9/0I2wXSyWylqO3DjFQQO1PndBGNHYqKvEJSHaV2X7mB2Oc6KxVP5npmaHTN8fugU+Fy80SI31gUESwXzPRoCN+/OPAiFm2+SuLTEyOVrsL3LbVqrdz5cUhMpJnvxxU8yEFOgW03PbNDwHAhaTmSv05evJDh6ZL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dxtbwusR; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dxtbwusR"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-837b92bd007so247355839f.2
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728915416; x=1729520216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxBZDEsQX9BjKzTJw3lU/HTwsov+2B4h0VIxpNC2M/4=;
        b=dxtbwusR2S+Vj0xae2/KwW2P9DgGeF5V0/EyIBncuGiMNEyWJRc+w6U6xCBrq2ykgW
         7DUk+rNAUjHriHEklyt6mZVMacvTPQiWY21CdzIvjQu9dC1Sf2nI95G4PvgcaR9BV6va
         OQKSb0dtzSEEEDIz9MVhmK2kzTpYHpGResKsS0cFD7JZs0PMjk874zwTZC1bzBvEuR7X
         AekysNyR3aCHW24Ad+Z+/hPFgn76Y6hqycOwbCISmx/0jtobFW46sQWnYm6Ay18rdkaU
         IfhFZ+7Mw0vf3KUp2kY/kjCZviMhXqohqxclK46SwcuVbK6vobGSUODwM2/mqTRUQ3WF
         234g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915416; x=1729520216;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxBZDEsQX9BjKzTJw3lU/HTwsov+2B4h0VIxpNC2M/4=;
        b=e2CE8e6l9wdhZpKjq1Cc2uxZTZ90qfbogGIplmn9GBgvIAJtFioErnmtHqyn2qwr10
         lJhSDA8XVVPoopchWN6owcNf/NTfuXG2NatIu+82TmrHu1NuAluyNoKtUESHjPUZdA3Z
         LNjUMksDr7j2G1MK8/cNNVWb0A51B6GCS/Dm4K4NPLzoSRuZyZNYxkKi2hSIsdHj/7qn
         7wiI9pyowRjc71ZJ82Hp6rzU+GSGVCJnZt+LFLR+dR+yUGS59WKeg8DBt4O1JyePUZLb
         jevfEBZMEdF7D55ZxRlbG5CwdIUwMT78ebGYiWwpQQ87iqskPnNFGZGz3cfyKsWBuX8I
         MqZw==
X-Gm-Message-State: AOJu0Ywbr0EWYYILVXcd5VJSACk10x8+RFdt4io0qkIk9Nm6lZqvRM4f
	NPyzNNGRXNc2owC+PAufr8RyHiE5xjGqYu3N6qssdC3XpoDdDkTfJLhbwqZcgNl+v3pZJIZsjVl
	jCUU=
X-Google-Smtp-Source: AGHT+IH3macdHJBcQXSR1JriK0WB/4NCiXsJ0StBdQTIPOnMCngXB8v/fheb4ZjQ2K/i/Rqaxse7OA==
X-Received: by 2002:a05:6602:1414:b0:83a:63f4:ad73 with SMTP id ca18e2360f4ac-83a64cd3f14mr663489239f.4.1728915415878;
        Mon, 14 Oct 2024 07:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbe2e9b91bsm4188655173.2.2024.10.14.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:16:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Rick Koch <mr.rickkoch@gmail.com>
In-Reply-To: <20241014005115.2699642-1-ming.lei@redhat.com>
References: <20241014005115.2699642-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: setup queue ->tag_set before initializing hctx
Message-Id: <172891541486.378385.13328209578544417079.b4-ty@kernel.dk>
Date: Mon, 14 Oct 2024 08:16:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Oct 2024 08:51:15 +0800, Ming Lei wrote:
> Commit 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")
> needs to check queue mapping via tag set in hctx's cpuhp handler.
> 
> However, q->tag_set may not be setup yet when the cpuhp handler is
> enabled, then kernel oops is triggered.
> 
> Fix the issue by setup queue tag_set before initializing hctx.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: setup queue ->tag_set before initializing hctx
      commit: cd6279bd6e3c022bb74f88bd2299daf63ae519e6

Best regards,
-- 
Jens Axboe



