Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984151C4C
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068915; cv=none; b=LH7abNj52grFHv9Q2QnftI9J409xKS/Wj0hT3kWECvwx+6Lju2IwLkUEDawVULPQ9Rda/OK9h3jbTXNC0uUcKy8xYoFPR+1AMzJwGOLyDlvjGjNebySqk2D36zS9BibZOKnEom6fhDqKX2t69t0FAPQoFvu1rh8QIIKhnttkwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068915; c=relaxed/simple;
	bh=/x+HoFJBoEPs8vQ+7AplVXTf0kNDUWgaUzi+AZtV7cQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=upW7eJXLOAnrdSuDWBpnU3nCQqBLok2UN29Gp22bWhh3HWjgYxrvAjG44EZzTwJkrHlGYOB4pTZA1omOozj0e6auV3g5xM4w1rxMhVDwWssgiBrKypKRjV0EJKp5J46y0sWpWU05mY2eMw6kBI801CLvntdAkwUWUaXq7x1EWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2sJRLcWq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2sJRLcWq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1651537a12.0
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709068913; x=1709673713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UANm1dgS5T0WOHSiSrzCuBbRubRxDNMtxNP78En/ilQ=;
        b=2sJRLcWqhSir15jew9knqtpTxex6Td4AMF0HJPBzubva/j6kEnl5KFGjjq1X85lkiH
         ouECc0BuN+WbdNE+SgYCsqWxFhD6vVImTge/GcUG/opDP4+syGnfoJdg5MndPshEx++k
         6JRae2E8cjDJGp0o03nsUGmVq9tJTuz5ujkFBOgiVrBOpTmAmxdXMxPtbuZfm9BXHZ7P
         1De6/pKPtD8iz9vAlFiTkSXX5NERWFlZGca6Zo33wUTni/nqdO+wCs0HjDukL/j5EBPV
         2x0J3koJTnSPjiX+ivDbHTUn+ZrFqvQAzclPs4zDRtOp5XciRokyB/40L1OIIEHYodsz
         KpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709068913; x=1709673713;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UANm1dgS5T0WOHSiSrzCuBbRubRxDNMtxNP78En/ilQ=;
        b=Un96DBfeuTAZJpKc+ThrPxZ0tAltCpgUbpDYHHcdyOV4xARkGgdKza1aCGV67Iy57h
         i3T0ryuFMl8z9cpb9s7M/saK2L1SeEd7UW8JuwnLAwfaGf5l8T5TnJE5mzaazbUB0sDp
         x47KzI6fXEvZU63M8irCZZ04COE7QHV4Ef2tXaLOe9NiyfN53ieevvP+gb2an1L+OU92
         MfzdRrplnFVvBKZuid/ww58njrLdaX4x4HkD3peeSf3e0+T+0Q0rwNdhYwC2s+zB06hk
         aDTIx+G3+pWvSdIt4bEqoTSyPPo+WcAGFq2YuQcQ7YZXPNJ288dPtKe4IeMjIAT103O/
         vixw==
X-Forwarded-Encrypted: i=1; AJvYcCVaJGJrI9rmH9oEwfEhCo0yoOLlpyTqf2Du528NKIOx9KeCMffefxvH3OBIOOs7vqw2yQ3AaylgE7mF2bPDDu872D1lcecD5Am/lkU=
X-Gm-Message-State: AOJu0YyqelChd0FdnOaLuvxZqLVNSQZx7F4f16ikVHSZTJDymKNcUHl1
	Rh2R/RkKtu4VJGPudEVAEA8IMwdnA8wosdyx3MaUqwXOJwHyJQ74yvqQjicjnLk=
X-Google-Smtp-Source: AGHT+IF8ppKk3qSRiiw1IL2DaiUC6GURziSEFqA+jG8dpM8Ewv32Uofv42ldLmpmg5FLD3yIW5RJVg==
X-Received: by 2002:a05:6a20:4283:b0:1a0:e557:7ec3 with SMTP id o3-20020a056a20428300b001a0e5577ec3mr14434749pzj.1.1709068913195;
        Tue, 27 Feb 2024 13:21:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r10-20020a635d0a000000b005dc36279d6dsm6125145pgb.73.2024.02.27.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 13:21:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Subject: Re: convert xen-blkfront to atomic queue limit updates v2
Message-Id: <170906891213.1104664.4203607989260212614.b4-ty@kernel.dk>
Date: Tue, 27 Feb 2024 14:21:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 21 Feb 2024 13:58:41 +0100, Christoph Hellwig wrote:
> this series converts xen-blkfront to the new atomic queue limits update
> API in the block tree.  I don't have a Xen setup so this is compile
> tested only.
> 
> Changes since v1:
>  - constify the info argument to blkif_set_queue_limits
>  - remove a spurious word from a commit message
> 
> [...]

Applied, thanks!

[1/4] xen-blkfront: set max_discard/secure erase limits to UINT_MAX
      commit: 4a718d7dbab873bc24034fc865d3a5442632d1fd
[2/4] xen-blkfront: rely on the default discard granularity
      commit: 738be136327a56e5a67e1942a2c318fb91914a3f
[3/4] xen-blkfront: don't redundantly set max_sements in blkif_recover
      commit: 4f81b87d91be2a00195f85847d040c2276cac2ae
[4/4] xen-blkfront: atomically update queue limits
      commit: ba3f67c1163812b5d7ec33705c31edaa30ce6c51

Best regards,
-- 
Jens Axboe



