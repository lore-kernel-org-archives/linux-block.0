Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1152358A2
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uE3a2yIW"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so9708539f.0
        for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702650921; x=1703255721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c9EhAhTj5YruNrjnTsmiE9VBgD81Dr9SoN1SIaR4mM=;
        b=uE3a2yIWPFHLoOm1U2q0Itpj065P9EEnODUjwHssR469+Wz5CO6YZcFQIZ2WHJFFhK
         +YAvHsAkYahZ2STdfYaFBPiJvy0zibQOtCA0a4GOllCO4k16X8gHaAvwZl9BaFiQ+fxk
         RXwPy/o2NLaPW6xO4O0wj3osAFYgtFMFviXTtp/+N9fA15HkT+/Az5E84HtNn8lmtNch
         VakrF2PFF2bVR/VuEIPWTdI7z3xjm2dRj6WN44o4Sos5vsFcNEKNuiK4BR/ahHmPJJCh
         75mGOuYGFRI4eaCy3GtUPF1eRHvZd0uCxb9czOldKMyJa3pqTjIM7GIghe6IdAGunAVf
         SBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650921; x=1703255721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c9EhAhTj5YruNrjnTsmiE9VBgD81Dr9SoN1SIaR4mM=;
        b=C5TXUcoDv13TTwMUEwbEN/VVdsDXtn9+bfHvoP4eqw8/f62o7yVH0gwh7uEXRlYhHF
         v3OU1B5PhdP8HWrQ2XVHv2WuHYf7KQyoxhWbQBlQrXfpACbGLIoqSOg7j98yOwUyGp/C
         J2s9lH+Qz4YVuqTgYmXp7gMKgdx/XfsrMVFgufc0+Nr7SbqvCymTpsXE/Cdjr/WePyrK
         S3uGlrJ9uVZnwJ3AYSfrL7zbqYQ2eITyWM9S3ShSjE49Tti5lMCe5rLCLgUqGwNDhnL1
         5QeufXtHoxNs4uaHVkoJ5Yqv/j+LrRD+cXB0znRCduyGCKcKMMLKx0ruEMX5EMBxszLL
         BGzQ==
X-Gm-Message-State: AOJu0YxJvTUAvPOeUYSVZEab9WvUI4KlM/N9CzCxGv84NRbk8dIu0qDb
	eOakYGDZMw0cHA9J2N/C6FoQntM3cMkb4yCfbsP/HQ==
X-Google-Smtp-Source: AGHT+IHj3HOFzvVT+MdqVIko0y0sBXxk6dTvP8vEnXd3bE011Nvs3Jug2zJmcOuzQ4ne5YF/8oQ6oQ==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr19698735ioh.2.1702650921411;
        Fri, 15 Dec 2023 06:35:21 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05663815cc00b00468ecf31973sm4140873jat.67.2023.12.15.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:35:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20231204173419.782378-1-hch@lst.de>
References: <20231204173419.782378-1-hch@lst.de>
Subject: Re: fix bio_add_hw_page for larger folios / compound pages
Message-Id: <170265092073.460397.9406653828604455703.b4-ty@kernel.dk>
Date: Fri, 15 Dec 2023 07:35:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Mon, 04 Dec 2023 18:34:17 +0100, Christoph Hellwig wrote:
> bio_add_hw_page currently fails miserably when trying to add larger
> contiguous ranges than support by the underlying hardware, a it
> always adds everything or nothing.  That isn't really a problem yet
> as there are no callers that actually pass anything where off + len
> doesn't fit in a single page, but I've been working on code that
> will, which immediately tripped it.
> 
> [...]

Applied, thanks!

[1/2] block: prevent an integer overflow in bvec_try_merge_hw_page
      commit: 3f034c374ad55773c12dd8f3c1607328e17c0072
[2/2] block: support adding less than len in bio_add_hw_page
      commit: 6ef02df154a245a4a7c0a66daa5a353daa788dba

Best regards,
-- 
Jens Axboe



