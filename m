Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672865;
	b=d6g4eAueqm0qEPOc3x9OcbZFZZ3++VcMt1sBHsjo1MnLy+0VYzZS/zgFaDsaMduyGupT
	 WUImRXJvWKluK7+pvzlfk2khRiAsG4CqQgFiirWRQOjYNcrsWvLeVpgNVeZwioduIfVH5
	 aSsNJggJ0l3H9szHvGbqcNe5InzW5f907kVgyqJRZYED8pMVIix+tERnls8lvc7Af5OsG
	 fVwLMZWV6VeqRi2MTtgCX2rPRoItBNBNEHjGwdvqwXtDxUtP2prcGeyCMli/BIToaWQ+Y
	 gVXPpEV5Z7LLHGAQ25g+59ZKKclOPriQNEP1cafmcca5sK5/y/RKfXpW8946l+M0A7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=;
	b=i4/q2dKH6ySITzDi6SINLN6DeuFH+Gp151+28WePaqCbaneWWd8n7l1Rc5X8GvUt5cTV
	 OOrDTqPZeUxORqamQV19Lv3XAGtQp8tWXs1Bsoy02EQ/IoNzFXrdra4MQd+lvhv+ra/r1
	 LngN06Jms2Jt0PO+e6m1oLvPz2pI1akZhXl1bHq+LWlm6y43+faFXZzKWdyvzcxMh4EmT
	 MyRO7p1xSk3Xl3P4PPV8pYRjP9/ebLq7cL1zUvAKydsQ4tX9vfrqiqurtpJ7io0nKnLVS
	 E9CZa5odq3za5OhbdV/XWrX/4LmcpwMyAwCk6Kp+f5ko8atdhX3pMBBDkRkBkBVwp6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BMc2Aktj;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698B606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 12:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A698B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=BMc2Aktj
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so642218a12.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792672863; x=1793277663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=;
        b=BMc2AktjYWq1T+ctah0PDRPeLKdSyz2QpTK4BLiZwDjyiOTiRj6Subul6qGteYqjE2
         krvq3xL0S6kHVMrTx5UTdPJh0gWLtotytoIRbFlvVnIUExFdTWI8EnHXncPGljEfWG/o
         /56xmRqZDlHVP7RP0vx/AF5SflSIyk4vD/b5fiVXhahTeZRtY9dNXlBJz/RoPWC5qhP3
         a+KTPO/CjfI8rVmIBVQRgPghoujQlNKJ/6zyweo+HfpXgbtDrTnwEtHrLcWdXgn5jqCT
         0uIGZSJRvmifzxU7z65O+5tZOEWY3NfebsO7pXBcZi/IpcDyJkY9+oB0CNibzS9v2sp8
         MG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672863; x=1793277663;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcN6V0kVf6Aq31J0RAqWWkvpV1VAcbfbB6YKV5xFzr4=;
        b=nFYcxfC0KXSJfTqSV9PCP3YfeCQFAiJRdJRQdYb8DJduen9JNYU7tqW7dJ0Q8i4IWx
         del+bQj1uK5BoPiM0C1+v5r06OiDozAWRZpdxvYTWtkt1vUyRWWZdzAK0+dpI9hQK+D7
         zrCL6iAvhOinAQiUXlNu8tytl6OlSrSE68dkIAErFYglS7FRVA4RTXczDDWwTeSnZTlK
         4tho/PCb9cM9qXATOXMvocE4HhOCI/A+bnGvxf8JRQK7sLSMSQ+OiG6hQmnrhFpOSNIQ
         4XTiQQNN8ucgCxIPexjCHdbqchuiPxJPS3douR3czC1+RnmXywkSomHGeFGfI5fuuTiS
         GCZQ==
X-Gm-Message-State: AFq9FYJVjcFOchr2RXhBcroOZJ7B8OFa8SuFKhR48Z9oWuiyYZYZPklU
	gQ3l5VDIdWeFukHXxRUwGeFpJUbTvJ0VVjRDCNmu1oGVTSqsHSp5q69OLLOBX3/g+8M=
X-Gm-Gg: AYBFou1rOK7XMrG2neylz+fSMdmGGh+fAXZGFpnLeZMbPlMOplhghCTuPENZR9QbVu4
	EEaM8kdQFImwXwqj4LdHKdDSxgO9/RkE1NwD7ZGtTjI8QeEG/S13wlSRdQGlmays/SYcfD53oAQ
	iIHPXT5LzbbQgZ+8VzqR2eeT21uPH8RW57jgMQEsbVDz5jW65LAHcnnr6ljrCOCyK/RmKFdumZI
	wzr7MMMK3jZuY96cLiDeC+i652zsjv5l9IgCTGcuwjitp2S/v0Ze0HeTZAvCtmVumacmUWDlcaQ
	+nzICohbCLYy7CKOPDH5es5vySp2aSuJtCpwiX95d/Wg28F+IA46UB+3d7ECElmhg6g/V3r5Gpi
	VAf62+elKPtaqre3GSWetQcCLaOQOZ4SjnDlyHIBBGZazZY3nPaaD+5v5QQVNQ1WvfHSwGhLJFf
	oU5/tlDoP5Btl/7FYbKbGAe+4lUr1JqG7dhkHhII9Qg3v7mxHAfJJh50cnTKQeKVDLKuf9cj7vH
	aBKjhZprEkYnitI21Sr9ZmDOn1mrQ3BNMIjZ89o0Q75ILQXKtbUR1PRHVXZva8U9NoZITLgQMy2
	5WuUjBV88Q31GlK3uTdVkMStf2Eakt4yO5be94M=
X-Received: by 2002:a17:90b:3c12:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ad86d57f66mr3763863a91.45.1792672862598;
        Thu, 22 Oct 2026 05:41:02 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f4b103sm4484148a91.3.2026.10.22.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:41:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 asml.silence@gmail.com, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
References: <20261021184658.644645-1-kbusch@meta.com>
Subject: Re: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
Message-Id: <179267286175.3853015.14808759833206340958.b4-ty@b4>
Date: Thu, 22 Oct 2026 06:41:01 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 21 Oct 2026 11:46:56 -0700, Keith Busch wrote:
> Just a couple minor fixes. I wish I could say I caught the first one
> myself, but no, I prompted an LLM to look at it.
> 
> I am assuming changing the bi_offset type to accomodate large offsets
> isn't acceptable as the bvec_iter's size appears to be packed to be
> small. I think there's a path to accepting larger offsets through
> bi_idx, but the patch proposed here is a safer quick fix.
> 
> [...]

Applied, thanks!

[1/2] block: reject dma-bufs larger than 4GiB
      commit: bcbd808652e127a704c21fa44d908eb56cbcda03
[2/2] nvme-pci: detach dma-bufs only on removal
      commit: fd13f31ac62abac4df2166bb0a6fbff53b288e0c

Best regards,
-- 
Jens Axboe



