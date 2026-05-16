Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5333D4E2
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958360; cv=none; b=larco6w91h5Q8xKGHgvQTDaPx+xlEspHpit24oC3mvigQUPeeQpFzsSoBHDMZm6OcBcTCLOi1xgWpEPw8EevIvqSBkYvIe72besYWv3IrHogkXEA7R6L0r3GMg3Xg94wQvUdEtTCmiJKHrmWGSvV9RlFQg3vL8Vf+RO645Lpyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958360; c=relaxed/simple;
	bh=hdNAim/eeQH9JSNdB3L12HJaIbYbXjdVhrkoV9JPnEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iXjNQ0fdnR6KX18P0vwcGCXbaJTGIH+FJyF5ivcdxcLk6N+JSrLD+im57ygIJZw1iDFDFSwvShlAzQ4zX0H+2bo10iV1qtDjuMJiYJyZQqwE5Sx4B/CSy8IneJdmzz5i6/sXSiRiaGvL9DjBOGmUWWgXKErdBTnTjBOfr3GKeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=x7N67VX8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="x7N67VX8"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47c7b282e21so376039b6e.1
        for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778958357; x=1779563157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooit1MB3KZU8iKFSGwpko54r5dXfQYdpro5w8pTiWHo=;
        b=x7N67VX84kf7EADSWpUREHviukUNad7q19D7aVOYYyc38KVMZ9gJj1bZ35dOwBcbht
         bLsCC0nEUMVceEsgsEp6JtQD8/Ns/V7J95mefgFuUAcX59Fro57aWXiruzLZxP/jRpsE
         BcOdtwm3hqifq3g2hhOXpFNdrBF9zxY4tZ2/3Z4iSPNhPMUjYIx7whv6o24n2KrTvvza
         4sZhMULr47KhY2jJ+SaH66wNArNkW1Q1Re8Tg3c9tub7VOmqLlVl0qrO3BEt9bnm2U5T
         MJYU3B610uH/WvX9gyYnc6QRUE7lYEEktYHZwbKhV7dbJ6UNuYz11saU73DlYcAXcoBH
         Vqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958357; x=1779563157;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ooit1MB3KZU8iKFSGwpko54r5dXfQYdpro5w8pTiWHo=;
        b=Ra9Gm/Nh2EZkh+m0hFtcvUdntMJhiT0tCbf3HejOGYRLLbq2I82vqkeMvIOGDebEs6
         Oyb6MTJYKir6M81Pzwzrd3cfAs4+KRLcigC9Oj3Dx+wnJgFKFk8tBkow6u3/NQWlKusK
         RAgUV6bvj7gC3wYn2aSEBEE5HnF+fjKDvj/d30Ipm/Dj5p2QsF9EFJX/X4rViIW+Peif
         LhSa0cb8zb0O6GcGDF9ezexrmv+R+4+D88sU0bi3xV3d5Lm9in/9r8Bcy7K8xSiQ/1Ub
         pZk1rPZgr8k3TFUcCEICSOu9uLGY+f3EHIwp/lPoKz0tSncHLMv5LiY65qM/JCmY6FK4
         O+sA==
X-Gm-Message-State: AOJu0YxTSQQOz9Zhf+01etpVDBk7MbGn6i+vYxa4UIf8ngzrh9SFVO86
	dPnMGH6w0fHpmttNvUG7GHHMJ6D82k6ebt6YJHVxPGgTIzHuXxuyikwzSMaQHiVwt2JbcN8Nsmf
	z5NdJ
X-Gm-Gg: Acq92OFRBCLlwqkt/397jCUqE8vW5WB1vQbSzslMYzZI3npUrBOSfnhgVlwMGvR379P
	jS2g5eQfgfp1Q1Nj0pZ5rtRpk5iAc1dEKs05JAZalLnsCZZvMyHZxwq+Gcc8HQGJcXnQBQzVlpU
	xDUPSQQFlWYrU0mKljez0u2jeVzugvAysoyoDvFj9OlfREtHR0+4XtnPwFtjUAwu3/Yw7rvdj4l
	qibnk4xpUElNJGbySToUHyVTZDZIPMPHOc/ErTQXw/vT9NtWx80JJcvL6lHh5qtk8n0qCvMemcd
	GxNUg0e6GgYAQx1gD5tcw4kvVJ5QGer7xiW5EamJwabXvf1LAfhXB6HKmMCu1rFEfW/hcO+bdqz
	tAF8E3UcWc9/kRfSe4PTYb9Gfs2SZQ+Dt1zoXORDJKJN9nzZ3lGor0bKJ8ruX/gqS5DL4VZGIig
	00qmyfez1PhBIauu2sw7g3vB5bKx3qorelaBOsQ5IvTC60zEKI4nCBmV8g3y3jqs3xWoXCH7wS/
	Ixw
X-Received: by 2002:a05:6808:6410:b0:47c:3c56:c96c with SMTP id 5614622812f47-482e591d290mr6019765b6e.39.1778958357138;
        Sat, 16 May 2026 12:05:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd08ccsm4023092a34.17.2026.05.16.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:05:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260515045547.3790129-1-hch@lst.de>
References: <20260515045547.3790129-1-hch@lst.de>
Subject: Re: remove dead code and export
Message-Id: <177895835632.925638.16812583618402399833.b4-ty@b4>
Date: Sat, 16 May 2026 13:05:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 15 May 2026 06:55:29 +0200, Christoph Hellwig wrote:
> this series removes some minor dead code and dead exports in the block code.
> 
> Diffstat:
>  block/bio.c            |   44 ++++++++++++++++++--------------------------
>  block/blk-core.c       |    2 --
>  block/blk.h            |    2 ++
>  include/linux/bio.h    |    9 +--------
>  include/linux/blkdev.h |    1 -
>  5 files changed, 21 insertions(+), 37 deletions(-)
> 
> [...]

Applied, thanks!

[1/5] block: remove zero_fill_bio_iter
      commit: 64cf531f9900c011afe97a28c8ef464d551cec1b
[2/5] block: remove bio_copy_data_iter
      commit: 8d57b5876d39679c81d479485422e88319f17418
[3/5] block: unexport blk_io_schedule
      commit: 9957d5bbb916d37b277bf298e635d29a71205f99
[4/5] block: unexport blk_status_to_str
      commit: 82aaa55a3162acaad10baced6f87126a4454a0d7
[5/5] block: unexport bio_{set,check}_pages_dirty
      commit: be34ec59ef061a1cc435a3e066ad71ca675c7fcd

Best regards,
-- 
Jens Axboe



