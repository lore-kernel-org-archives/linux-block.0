Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD41274643
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120310; cv=none; b=GR2YHJ1MjLJh8snb9dLU2xOhwLFLEPvi9kmMTnwZ7QFB9oiUP0SJ4dwxCSEnHPA5oTskRHIO/ShnnlK4QXapQSR/ft9uV2qGW3Bm3nm/L4mzFeKzShsnjlxx0Nhk87e3pbxMmM73CfNi6awZ26Y6PwM5RaPzpKLijRJgRDbCXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120310; c=relaxed/simple;
	bh=VCQKXK/b6w1p0rJZZ0YdDkePSLgf9Ak6OzkldxZRzdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKj9qXX2ZeIf0Kf1s0yZvPhtgnhXTER/Hhk38OmIw3CkDPN4BM1BtgMiTjhUB4zd9TkPIstG0w68zx3ZoqFhr0qEJGrDp3HYFbb+5iNPUPP1NQvTmXE99jvrXqcPnO1FoXHzpt1441alwdxoPZmyamRD6HydN0BKcMI/XMoaLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnTJwRE7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnTJwRE7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885a18f620so835143966b.3
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120307; x=1770725107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1+6Ooei3qcktWMsNzPcdbmfIrr0F/PihFSzcD/XR6E=;
        b=OnTJwRE7iOPQs5eWmkNgQt6vOV6BKYC6WbrymRs/RPpLSnnPA7mb6WuNa8L8MDJJ35
         8QEUpDYWyNB3tUIHx+/a4kYXjXVM19MuUWUWJT6/3ZbFjFyzR8B+hczC3OYlRYk9YHIl
         wJlUDal5lJ+iiOHcPldMa/Olez48ETiJcs26EvJcLl1ISG4E2ZjPV+1HosnM9SRQTV/7
         N2dUi/hrcmZiDvnF/9qE/4LlcQt9S416pFmgx+D7PIZCiYaHT7WngG7bTG9NI4xSriIe
         FqwrGHjs4RakQV0Pm7kN2wYcw2VTXBm4qyfC2Xi9680IsSG60IJOTobgzjJ/M1T9Y/EC
         9ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120307; x=1770725107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z1+6Ooei3qcktWMsNzPcdbmfIrr0F/PihFSzcD/XR6E=;
        b=SI2nusINyvS2ATaSapPuZJPVw6myZ2or3zPT5oeGNfYGOlbUnJL9/EnjYysS8QQVy1
         hfShEwcEaF8rCli+3LUdWCcZktQeVWFwFrnDRoXr4TBe6EmNbYjOufJ0QKOCQ8kqBPmO
         Zqg9Xu0daTAw3VCvbzRLLjWDCtwE/KR7kxxabOCwSAIBZalnSiz5Yt3ObzWzUO4nHIE6
         ZBz746QtngtL0pfalx4pGYLSlx2VCrEcXp7oj/VS2kTwxIlWkWnByxCrPVwU92MXGJag
         Nk62iGlb/YTa6zIyd4ygpC88Bi7r6SP+bqhhgzwjHUOutC/tC3tWtbjEtF3h605ifkAv
         lVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmSEGPt+ARkbnZ2X18yOP+wh64A0elc6UsjqnQbenVgqlaUNvxui2OY2NJzYOxmMFG8LMzQ1TGSgKqjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9bMkDhY1VdfZc5Emou1kgrACVUsO29Ta8GYSZdlftm75Rvz/
	NmryVuceXC0kuBMSKwYCiyEapbitruQRkaUo2MUW6qst5NewDSvV00G8vOKRDw==
X-Gm-Gg: AZuq6aKLT7evz6kAJVQGJ29k4M0DfTtgo0h5JkCsThzZ03Gfw+v6P5vdk4hTuKkaGyx
	KqfRmXGlNepYGTa9cA4u64jB3D4ZbXHFVt1Udrn/Y4/BR3Iw4mTT7iiL7NdDc5D4zi3simw4f/9
	nJjNp8p5kAtByvP0DyRNeBS6BbSDp6UaLaJxHXnLRSN5d3nji0vxGiimeAu4VAKdNxR0FrEZixK
	PszLthFrkhRDz3V7Q73X2gl6hVGjteDJONmqu+AX9YNSA4lAHQ5OgQsOo3j/zA+BJNFHmfgIiSW
	j7n3it/JOAcoNmmDA8n5EMQZBrsr3/1lFCJLc6q+dOgsrcxnXN+SW+krXnx5uX8WrnD2K6fZ3VL
	oYU36+lTvlGmrgkNM0rscs7rWHgb1V9ZKP2kabm09dTyLOgjJvsITfdbnQLuQGKQtMb+QSZUw/k
	UtGtL2djI=
X-Received: by 2002:a05:6000:184f:b0:435:9d70:f299 with SMTP id ffacd0b85a97d-435f3a7e644mr22293614f8f.22.1770114553095;
        Tue, 03 Feb 2026 02:29:13 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435e10e4762sm49060917f8f.6.2026.02.03.02.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:29:12 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: dhowells@redhat.com
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	cem@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	kundan.kumar@samsung.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	wqu@suse.com
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Date: Tue,  3 Feb 2026 13:28:21 +0300
Message-ID: <20260203102821.3017412-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1763225.1769180226@warthog.procyon.org.uk>
References: <1763225.1769180226@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

David Howells <dhowells@redhat.com>:
> Can we make vmsplice() just copy data?

vmsplice already caused at least one security issue in the past:
CVE-2020-29374 (see https://lwn.net/Articles/849638/ ). There may be other
CVEs, try to search CVE database.

Also, I think vmsplice is rarely used.

So, if you author a patch, which makes vmsplice equivalent to readv/writev,
and mention these CVEs, then, I think, such patch has high chance to
succeed.


Also, as well as I understand, this patch introduces kbufs,
which are modern uring-based alternative to whatever splice/pipe originally
meant to be:
https://lore.kernel.org/all/20260116233044.1532965-4-joannelkoong@gmail.com/ .

I. e. these kbufs provide kernel-managed buffer for fast I/O.

So, I think it is good idea to deprecate splice in favor of these kbufs.

-- 
Askar Safin
