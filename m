Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF22D5926
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696149; cv=none; b=WJ1/j1jE3Te1RUa6sjwUaR8kzEWsi9k3ppJZf/PWb6jL6vrYWDZ92BA/7nleM5gD+rxrvZwS5A3EYcPqDuGHIVn8unKcr0zGqvOFZavdws3kOXqY51dgra6O1xOSWuIkUBZexrLTMYLtB+aCsXoN2c/T85V1ofUiJaJoXmO/yAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696149; c=relaxed/simple;
	bh=VIBBX3cl6rWXkdD2OEROnBIfyfxiG/yYPHuS8OihCX8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jFNcqmnQPOms9kEmIjY1t/DaPMVsk9IWEeXwSx3rZ7cl5HHg1VMhlElCY1K56DGcLPlMbK3BJHupwQJmOYCboqGOcyuqNbgsdXJ+jErcbSKtv5Qzh5/+phyArKdX3ynorHz5GvUnwxwEWj+D6J/zM96QIKwYJBUeM/YsZjG4bEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IwYji6kC; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IwYji6kC"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb545db3afso653020a34.0
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783696146; x=1784300946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8czkgUXRj6O1Wp+SDMx8lgL+MynprJo1fYUcHuIszUY=;
        b=IwYji6kCZP5Yomf022TY/gk90L0CJ3x15J1ZsQz9BlfOKH8Hh5/IhHX0QHwQLSYlsB
         AurdYPt4NhDuVlxJdU65P20JoH8GQ3pWz8YJcY4wtFqPxLVpR6DFbnX/8ALsdqzvyG0x
         W0ci39u3mZPvXUZXpUCwjIFTqUicmLk8i2l2UZHgWjhoRRhzoPmDSzrMCaiNEbTO3hHu
         yBI6WWFiHAOfkoLtVN6qsE2milhfCqhchT3MXjkCtudYR+2xxJF7ksF8W4fPI2AUj4E0
         i6H5Mdiq/IadvnuQFd0zvGUbEe6pyc59i5j0QkkYIQyCuEyLXJetYgLMRkfD+SgoS2G9
         zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696146; x=1784300946;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8czkgUXRj6O1Wp+SDMx8lgL+MynprJo1fYUcHuIszUY=;
        b=gM1oPv6s3kSzQpfNYcT3cSMJGHdX9MiQZZqKl93qjwbMQdKBwEGQ8pQRfJteSBK3/B
         7nnyhCA8C0akyDDRZXTpXw4eAvCgGLXjzrNor0EIcgdAiN2wz3AT+6sd0rcpx42J4T4v
         rpOH3NEu9TCeaPM9ZR3mO34bv9zP+IpE8bjWtAF5m4ZrCN6ft65TBP0FbxBhJ/4Q0K8N
         lTXXexD7mfDoKYcMWnnQ5qIF+K2nvBt2gJjwG3X1InaAn6gk4LH9kPtKnmpaW1XOSERS
         pIbwjXXlahDDLjNVgQviWwiUYi9EFKFPdqtjG3MRXsQREHT/CGKsMrQxXwybgxNwA0FO
         HdxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fH4QyZv0UcQtDNbdPOTkRrxc+8vDYxVoQn+QHuJklDXgjDtFl92ZK0/p60ehMwNOuChTZVGgHbYw/BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzN8BrsMCqotqyfWe4QxSGnuuQNC18YcOs9SFsnvespRCUEAc3
	o8kjEoMWpuyhoQClk3GT0WNKWDKGWFqKdCZCPezgYGbTZO4Qe13b9I6N1YYaUGGmFF8=
X-Gm-Gg: AfdE7ckXdniCoE9dZxKcoyDMsT2vZ6b6oJS/K+ckHN5xAl5LyE+NAJ+zEttrPjxFPuP
	XBBBVXdIw3KGfWp4vQp89K13O4IV7hneqUKDHDQ5Z3cPe/3ZwrKU4lIOxGHFECIOngucnSVrbfv
	MXZRMFXCujdr12UOdGezaVfWXP2lMWigCKbvqmLeUUiIJZ1gMB0w4B6//76sdoeZiRmgcTR0KSk
	0Gy+65G+2KDKjuwNHiAVHN/muETeIdLzgKcjPTbFzHQBuVdM2k2gTvVAvIcRko4No1scohFvE23
	JC5cf0Q4wj8XZdnya5MQoOOwAeZ7g9pE6srXTbgqW1PhcgBXJTbECy534gPGiOiHRbrmXWje7jb
	3TgxJcYV7Sy22YUqizAY79xPI4ssxGRdW+OIHpyBg9hLB5k9TKqV6zIG4/Meu1ixUiwTAsnXBV7
	DbZ9PvBafX6aeT3+eNeStplWgjkycRxVmjgPovP6EAO0caVapBCdzcX1/1fTaQJjKhYA==
X-Received: by 2002:a05:6830:4387:b0:7e9:ead3:4449 with SMTP id 46e09a7af769-7ebcfe1da0emr8679171a34.6.1783696146204;
        Fri, 10 Jul 2026 08:09:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm6709330a34.5.2026.07.10.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Christoph Boehmwalder <christoph.boehmwalder@linbit.com>, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260710022837.3738461-1-michael.bommarito@gmail.com>
References: <20260710022837.3738461-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH] drbd: reject data replies with an out-of-range payload
 size
Message-Id: <178369614511.284240.12733294719230479134.b4-ty@b4>
Date: Fri, 10 Jul 2026 09:09:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 09 Jul 2026 22:28:37 -0400, Michael Bommarito wrote:
> recv_dless_read() receives a P_DATA_REPLY from a peer into the bio of an
> outstanding read request. The peer-supplied payload length reaches it as
> the signed int data_size, and two peer-controlled inputs can make it
> negative. With a negotiated data-integrity-alg the digest length is
> subtracted first, so a reply whose payload is smaller than the digest
> underflows data_size. With no integrity algorithm (the default) data_size
> is assigned from the unsigned h95/h100 wire length and drbdd() never
> bounds it for a payload-carrying command, so a length above INT_MAX casts
> it negative; this path needs no non-default feature. The bio receive loop
> then computes expect = min_t(int, data_size, bv_len), which is negative,
> and drbd_recv_all_warn(mapped, expect) receives with a size_t of SIZE_MAX
> into the first mapped page.
> 
> [...]

Applied, thanks!

[1/1] drbd: reject data replies with an out-of-range payload size
      commit: bd910a7660d280595ef94cb6d193951d855d330f

Best regards,
-- 
Jens Axboe



