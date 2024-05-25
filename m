Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412A84FB3
	for <linux-block@vger.kernel.org>; Sat, 25 May 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653398; cv=none; b=FXcZNnoUW1LJgSg6k7AQF4IsD1DPKJMqAH1H8hYPciKW8PSqAKlbAHqPeanVcHQrhaa6kpJNX9BknhcZD9aOrXfCdy+0uDoH4AQXaObxHPkU4E8eafTDcnge50aLM9FNdqjo3xb6FMPj3T4O1+5sl49YVwVz4MF8mxliW9CKmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653398; c=relaxed/simple;
	bh=ULegqM8lE5bdtkX3KVzwwd8rBi0IA2VuFG27hCJEkzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s2RAQYk0cPL9xRKcv0ulHxAUwCzfLmk+7MIpNzZrIg3yUQGrEix7euSNSir7D7vzsZNYzIjUgtJM5M4OyUYGP8aXYPcXhcDUXBEx7zOcgI7Tovv5JaPdCxb92LJhfCXC2IP9iN67BK/Y6ripiR7RDh/ElgYxEDEyIXKNQ31+pzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ls98SUhj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ls98SUhj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bf5bb3508fso351913a91.1
        for <linux-block@vger.kernel.org>; Sat, 25 May 2024 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716653396; x=1717258196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtaZXvjPs7V8ADzOcZqxTsMj8PlpAXZ+KzLAnSF7664=;
        b=ls98SUhjLyw+JM1mv0mBR6A60INmPuPTCUrDbgXa09TShivfnfXY4zbT4u0YDMOKH9
         npbJAZVtCJTZtPwBfgAwIZmwOlKp6YoQWgGzlwVRFQCaYM3wsA9/y3n4rQOjCg2vJx1N
         N3I2+BPQOniUNT7/7H2ZML8IaUh5HiybplmifMY9qHtrSkQ9UTEZUkbOjyIDRqNvKFGb
         5JikY2dLUnlrk/Oa3BOlzEmm0EqE0BIRpL2sdAuoQZOpAkdBpCBiihO/c+oEIjtaiqc7
         ++vkyBEbmU1m2njA+nfnj724MG1uUWYzPlILLiU5ZxeL+rmOY8lmbESTV9BDY6l1GVsT
         Wxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716653396; x=1717258196;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtaZXvjPs7V8ADzOcZqxTsMj8PlpAXZ+KzLAnSF7664=;
        b=Aei1E1UV4d41PrMuixc1J25xK4OOLnLgkVj41iRlSGf/ZV99+poSuc/rbmOP1eUwRb
         H3DqsAvpq4JcrqdGRdNSuh+ZICMsy1tMJNwh+MYzIFED5kz16HAe+qcOuTJ2zmyWjHa8
         2Tdts84Io4WL1lwzcumGO2MH91T3JGRb7egHKqPnAvim9S63sSjNOvuhmwtzI8/EuUTO
         U3hiCxi/yjv2u7kxeZjlgMX249DkdMRAANzir3VgiTKKvqe1lECK/Et2dN5rd3JzNC4j
         TOOSfZRTzOu32VlqHprmkIkW5edtQGGbtMUREtRV2IIP8D3cbcDeSjlEmV469O0U3hF7
         IIag==
X-Gm-Message-State: AOJu0YzYwrql5VFLd5HagtVCzXlLFj7X5iqR8nFpwacbotsmABCbyTaL
	pYHaCMwXJ1E9ANtIYOp5r0VTrRwIooQ6+hb73moCBlwjWuPXFlzoteiPCwAyH9JMRlVQL2lXpWo
	m
X-Google-Smtp-Source: AGHT+IG6bOdMkWUgMlGS31QT9WiMtfSYnGx1J7m6JDPK3bRwJtxiwioNq4RDwnMSE+rFXyYm8TyoTQ==
X-Received: by 2002:a17:902:e810:b0:1f2:fd9a:dbf8 with SMTP id d9443c01a7336-1f449907a09mr61146185ad.5.1716653396371;
        Sat, 25 May 2024 09:09:56 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96ccfasm31974765ad.147.2024.05.25.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 09:09:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240521221606.393040-1-hch@lst.de>
References: <20240521221606.393040-1-hch@lst.de>
Subject: Re: [PATCH] block: remove blk_queue_max_integrity_segments
Message-Id: <171665338954.160479.1052207499474780924.b4-ty@kernel.dk>
Date: Sat, 25 May 2024 10:09:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 21 May 2024 15:16:06 -0700, Christoph Hellwig wrote:
> This is unused now that all the atomic queue limit conversions are
> merged.
> 
> 

Applied, thanks!

[1/1] block: remove blk_queue_max_integrity_segments
      (no commit info)

Best regards,
-- 
Jens Axboe



