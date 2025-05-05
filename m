Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5972701B6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472995; cv=none; b=mDJxLsceANossqqtTPr+lVkgoIQymB+MPbJQJ3aHGMLDfZTna7u5tMR2bXthu5ph0B5dqvzf4se3wmWfVBL+GtLKBkZdksBWuV/Jk8xeA1u8FHkbiPKao+G6SLfIu8kybq2JokH8ZLaeA5IDvwpZle5ovlgtCqEam/RhP/6YFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472995; c=relaxed/simple;
	bh=ENSwrslkI8QKccIUjGOSW7JPQFj0MtcxngdcS/b7F70=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C+ZZWSgLrv4uNwXxm7mXCj14atiI+aU2eI5ZBsHfETm4gjl3PXMGPsJFD6Q83c2o4HTrM2rx3wnq2ymNy9Nnp5KW8S2qpopEKVLr6NglC4dX/rKOeJJ9bLIgY9kCJQR0s8zJSLU4RmyvEQiW+rTo4wN6w9FD3pGT6XWtnb/RqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KzU7a7o/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KzU7a7o/"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d93c060279so18437635ab.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746472992; x=1747077792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMVeIpMgFF4mocy+t3rzmtkLWK0EgWsZb4AtQGZnRAs=;
        b=KzU7a7o/03NOU83+KXDRr4VoaKCThhQSEhWpcfsB7BOO+72SsMmlp/k2fW3HG7h9q7
         /NePk6i84NyiHnYHIjqsxWXZexMHD+r7oiLb8a6eElueMmWS9Uxt8tRB7wjYzbVK6DAt
         VxnZNa7MuHcswUyv3Mko6USTaFAh4/SUVniSguPryCGnAyzMgrNgLIJsLHrjXidqjeUj
         KE+tFdJHX/hELKBMw1JWT7u4NKGmMoas2agkcC9koVmMNxEvM4tU/TOcTLwmE+cLbR+k
         8dKIqWuGwhfNFgltPDo4O8LM0y8pbBslX3urLbQPpRJAimwzD96UaEAoMOzOlnyiuiYX
         o4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472992; x=1747077792;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMVeIpMgFF4mocy+t3rzmtkLWK0EgWsZb4AtQGZnRAs=;
        b=SRSzSGgpjbzGC6DD/mC+/fvNSUlPLlOhfgsfQT5EayEXvp0KQdmMW1YQ6SQLOf9dDB
         QDGsUEi2xjdvKTGCQjRPE810nx2tyvF2ffsUgBHVgNQLmbr60tN928XQAebh7gmgCGem
         65J9D9TY2FKFoOrdW7psP6bdXNmG6DEckz1JtUpqCtopoM9X7p1Gk6skS+E7xxo7Py8i
         cYSJDyo6d+wDSB7Qwg/O/03I8RJ8aPMl3GMHuOvmsm4jhAfO0JbLvlmkD/E6DAC/H/G4
         EnfXpgEtleec26rZFZ86DzSWzWuEfWlDysliF7yzEuCjgDXegbMoNq67GivD7qxXVgNF
         U8og==
X-Forwarded-Encrypted: i=1; AJvYcCUnP+dJ/y99FButIt3ouA1siDKINZONjgJPtD02xFVeZfz3EzhQCoXnw6GtpcplP/eLGsGTvZ/DzJ3LOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrnP7K3Nl5CuOnBDgRA5175/hNr9i+kny07qLDpeHzpZdATIo
	xtabZy+TywOK8DPU6KBqUKVSJVbL+lvDVE4/sHNie3jItzAkf+IuEQh5A/hrNZ4=
X-Gm-Gg: ASbGncv66ysAjuOk9s84mRFgLSs//mHQeUaq6j/1ofbvFarkJS0cpoleBctlinbAh5O
	jw8fE7WLSp/akHy23wLLuD57qvvisgzSNbUBgxp7nHm2jDeO0NBHR0KwaA52yYIKroY/IWvkamg
	1J7Dvl36JKEVUxto4voaulrdmeZhurhj3wwxJYJ0kdTxZJlq0eS4Ug9su7yR7/SrXOg6+966aik
	0QyIWXYWHKt5IJY4ocURol5D9xsinttCA3k8CCmOweME3FN13ww5SXDdofu5d4UO4RDY5e2oks7
	CEI3EyS95ggNHwjJlFTM2w9BpX0vTvrH
X-Google-Smtp-Source: AGHT+IE4U0Nel01JtHK/rX8QBl2qPC8iA3WLhlaneMKSKU+x8aeNWP3CpSNUZacnFBxkOoaqFfb6GQ==
X-Received: by 2002:a05:6e02:378a:b0:3d3:dfb6:2203 with SMTP id e9e14a558f8ab-3da5b34518cmr82097595ab.19.1746472991964;
        Mon, 05 May 2025 12:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f6d771sm21077235ab.63.2025.05.05.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:23:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Juergen E. Fischer" <fischer@norbit.de>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, linux-mm@kvack.org
In-Reply-To: <20250505081138.3435992-1-hch@lst.de>
References: <20250505081138.3435992-1-hch@lst.de>
Subject: Re: remove block layer bounce buffering v2
Message-Id: <174647299114.1416870.3005554851862973144.b4-ty@kernel.dk>
Date: Mon, 05 May 2025 13:23:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 05 May 2025 10:11:19 +0200, Christoph Hellwig wrote:
> the block layer bounce buffering from the early days of highmem keeps
> being a wart in the block layer despite usage by only four drivers,
> all through the SCSI layer.  One of them is an old PIO-only ISA
> card, two are parallel port adapters, and the fourth is the usb-storage
> driver.
> 
> This series makes the first three depend on !HIGHMEM and for the fourth
> rejects the probe only when used on highmem system and the HCD is one
> of the few annoying one that does not support DMA.
> 
> [...]

Applied, thanks!

[1/7] scsi: make aha152x depend on !HIGHMEM
      commit: 7b32cb540bff6d6c8a1659babf930e9f66283c2c
[2/7] scsi: make imm depend on !HIGHMEM
      commit: bf69bd3fc26a107611e76b342027bb60b2411d4e
[3/7] scsi: make ppa depend on !HIGHMEM
      commit: 27a0918d4b701d4825e191448e44b9f14dc0a3b3
[4/7] usb-storage: reject probe of device one non-DMA HCDs when using highmem
      commit: 48610ec22f0cf7ee5b5658b2b3bab27a8f2ef78b
[5/7] scsi: remove the no_highmem flag in the host
      commit: a9437f6a1d8d0b3787fe6ff03d9aab4d3fe9b940
[6/7] block: remove bounce buffering support
      commit: eeadd68e2a5f6bfe0bf1038ec49e3a8d99eb5fe8
[7/7] mm: remove NR_BOUNCE zone stat
      commit: 194df9f66db8d6f74f03c78c2ad47b74a5a8b886

Best regards,
-- 
Jens Axboe



