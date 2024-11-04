Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4833FE
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741737; cv=none; b=ERd8Zf/mmKIYz7mnWSwzrXO/scVMuGmEROwMiwxRS0vZhqKwPpJxjHiS+p+HQ2tgjUFBBDyrcRUT2U9bxJqf9lUtRGnnJ8Bki8NcnMFvnmP7KRWcawaU9mHuzPKg0gayqZ/ku7LoRo8w7V9VRbjlg+RGRpZKeU4HKQRuNv0cuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741737; c=relaxed/simple;
	bh=3Oe7sdt7Dz4180bx4K2bBcbboI5TfwwQJ4UEgB2xiTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AjRf0Yqy9Uhu6hRlmNZm7Jllh/ZUe9bo6E+nxUt0iKF09EIZ4RpTuRPSYrK0YMcP8obV3sGQmUlYt2RRwvvDZ26INg2T2+9v500qAxdhwh3DoKZACZJ4ey3Hg2dxPZQ17L/c24gxCZKoDDtAajmMqQPq7szuIEkPBW2EZf3F8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q5s24xfW; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q5s24xfW"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a6c3230858so6727425ab.0
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2024 09:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730741735; x=1731346535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRF8r++0JFoOVgUo9JtQrZ4091Ij/LqOddUiT1AY4pQ=;
        b=Q5s24xfWM8HEkqVCgAJ6Q28ILfg8JJLIyS/nulxgjcjcP8L8JuiQ0z2mrZzmgtgFhd
         dAD3gDzO0EHIIq05gnf52lOrQ8wMf44kIRLDuY4CMIojxdBFdZrK8Y+P7WD2D7XSEua+
         gjBY/e0geEuL92hESBIGT5UghSq4T6OcsEgkFEPEldgmyA/UUrurRUrPIM6nfGE68Xue
         Q4JcF8VJiXvX0tZiH+1oqmFU7CMuJFt5Khxw63jDCq/xQuZn4GB7aY5+4NSedwpG+Hxy
         kEFZIixQgsgq1unfAq2Fvlpi93kEp3L2oswhkeJ+aoBIgArS5sBJLPJp2oL8Rq126CSe
         G+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741735; x=1731346535;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRF8r++0JFoOVgUo9JtQrZ4091Ij/LqOddUiT1AY4pQ=;
        b=BVJyzD6XRTK5Y0lkHlLH8SDM1YM3runTYHUJkdT9zBn+z8wwIETr/H9O5kSv84OnT9
         vG8D2832wgj1wuPiror+WkZVxc3nQkWA5vWSwEbjJyIad/eshMZTX/2jTFjmx5OtEgQj
         t4zENNRP4eHAHJY74+zRhoowWu258EeVhNJUKAL/A4nuIWXI9BzKUpacqClZXlp5MUVS
         ZLCrj8wIzCufhUoyemaopqtW2sAKawPRLhwQDyGmtYU1YQQGouTlbyFroJfoe5nuKmBO
         sUQdht5tEmIPq+LnVMLCXFsb+WVhdc/3Nq4Xim/rSeoZepavCbklx9BadQaylxgx6n+h
         gUCw==
X-Gm-Message-State: AOJu0Yy2khTei5TuxA/JMJLIGL/Oy/XA1b6vr7Q+pDbYC6xMxSwLRXJt
	tSH6698eQR0wVHq1jgKU2j0gQxij/RHu4x672sRDPRrNkOnuCRLXaJ8Xt2jq1oxCLGhq4ecPb/7
	kVIc=
X-Google-Smtp-Source: AGHT+IHz4FrlB7OyherwgPODOxkRZaL9EEGhWWZfyRudaX+9Tg8BzUlsCTVOSOkXddkJEAYdqproWQ==
X-Received: by 2002:a05:6e02:1e07:b0:3a4:e9b3:22ad with SMTP id e9e14a558f8ab-3a602f7fbabmr175854245ab.0.1730741734852;
        Mon, 04 Nov 2024 09:35:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a44a7sm2000870173.154.2024.11.04.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:35:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241104054218.45596-1-hch@lst.de>
References: <20241104054218.45596-1-hch@lst.de>
Subject: Re: [PATCH] block: update blk_stack_limits documentation
Message-Id: <173074173405.399771.17722839859019485619.b4-ty@kernel.dk>
Date: Mon, 04 Nov 2024 10:35:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Nov 2024 06:42:18 +0100, Christoph Hellwig wrote:
> Listing every single features that needs to be pre-set by stacking
> drivers does not scale.
> 
> 

Applied, thanks!

[1/1] block: update blk_stack_limits documentation
      (no commit info)

Best regards,
-- 
Jens Axboe



