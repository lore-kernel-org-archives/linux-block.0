Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EE32B115
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213327; cv=none; b=PWpkYF+huZDAXDDgt36aPfZaEFdNt/pvEvrmKtnZjOB29CRIrK6f6dcHjmUUyC4fxWuq7q2MTwVLBBu2LJLIvbAw0i9NC5zEmUiMEalTLXYgjOl6Gw7qmL/2cyS4qx02NqALNIuMI0U6Gaxzt50bFnIIbXsPQWtDzuoCmCBZfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213327; c=relaxed/simple;
	bh=ynYZfKDdoWBOPZGITgWLe4S8lT5sD0opPDjs6OZ9D04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nW3oevTftKYxX5Z7wgqzaSblU/8sLaJQhLhYfjq9XCGhT8yhqf08OF6Ypg+Zij2AA/17k12ldEfQkKo/yH2GnszQUbFYDoDM/NWjMq3CdEBjaoTVXWzstBXyIb2uCi3wxftYH1t6hzX0sB6b8YvV6tL4oi/6Mds+LaQzgR450F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=i7Zqlwbp; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="i7Zqlwbp"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43a6491f5dbso2808019fac.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779213324; x=1779818124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9xC8UU77j05lpvxVmHFMOKFIKEG4z+FYvm5qvWSlNY=;
        b=i7ZqlwbpyhKZ9RK6l7n2zDxB343L6A7jI8PVdj3p8F1xyDSF0Gx5jtfRNIpyVr1Oud
         W6KgBhkD1kteDeBF0hanUsxPRiIvJWQo8zeTWVq+QP6zRm11tT3XeZqjEbqYts5ghJBC
         Xy6ZFoXF7Z4k1T+jmWzInRegNyIwRvYhWjlYCtqIoBqCrIMKTWGD3l4pW+9cQFcbjwNn
         a1cyvWpoeWz7hDwqEF6QQtfm2QvmVM/cYQehzA4DwSkjoH3stGhUpBhpjVNCQzzgXpci
         9UWHWDFFL6HLaS35xQeR+KTFrVFSCg01KkAD2s87MuvD3X2i98JvuqqjeyW8pBAphheE
         W3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213324; x=1779818124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9xC8UU77j05lpvxVmHFMOKFIKEG4z+FYvm5qvWSlNY=;
        b=e3BlGvBYXtnhql6fFiPrzZLT7uyYyW4aW/1IpJWmzBjgj4syn9Cs+7YDCb2k3ilxMn
         gYITzbmxf+rhJL+11cU5WRZEySFOM/9CGHGHR57wJnrdx3Cy3Q/sVNX9Sk+WnP57e9b8
         UZffhdHlnBUZYDtidlSsuV8SaLoyey5zX7A9l+SxDuy/u8WAknsFbG3N1xK3sMVXtIbL
         3VyYuJ5ncY6EjS2avHSoyY5UmHGSnhvADCYTT8LOTlTBI2t/LVl4YU/hduGpqD2JITer
         YF/MnJZWtPTAUt10ZbnWiwy7zmh5mpbPqHQROA/asqE0gFeNNbiBq3tyTTcgd4pKZXEI
         zWuA==
X-Forwarded-Encrypted: i=1; AFNElJ+K+SWIZgirNgwMmc8N7vPXAqwgCkGv5dC21DVCdfM0D5AOkSGRfCVk0grfOrTD/IjwnLrovZDaMxhVag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6SOICcfzuuj3sN2AuB4YGN7rD8cC4DJZmcalNdiUGe3P+3FN
	KUnPXchLEomq4SZJyimnsJKitnxymZLOKUpUm6Rj1hNXQL75prVEbbEWFDrJtuihVuE=
X-Gm-Gg: Acq92OEn4XCgh5xKNSx3ozr6i7/XeavLKCUlefbM8sfgApy6mlRK0GuBiAJqZvd1ghP
	BZz8LBTH9Kn8VQe1K+KeIDU0/cIL1pSSLkXXLxs28yFCxUCMjHyuy0FvnBliwBuZVrdDfv7hIqp
	hppcdfc6L8z/vYKvq5eewCMB5ljwsePFHYOcE+cpS3PA8Fki97skkFHSO3bmgOfoED45hjohzlu
	tNo/7EkINj3wfSijT86Z8i5kvK7m2AcpR1tm9SaxCyEJVPcS05WyZPtdujAOKpkYaeHME0zRYEo
	eVbIHcBw5PkLgKqF/amXxcRWH4RpDxXXt4sF6s9iNSRyvx+yukB2cSWI07Q969sqP8u7qQCMPHF
	Uc59gMMlO4/F6/gzHE0OkAwwta3wNYvXA7ef3kQTo2dt+suplvI1qCUvRFdPedIyWNoysr97Do7
	fLAy11no8r+WQ1xoC5ZHN3z/4kuZDhKraoLXTYv/fSiy1AO61bYtqRdaFIsqZatC/SWmk1lPF/1
	JMWEuQdguJA7w==
X-Received: by 2002:a05:6870:2c41:b0:439:c7f4:9fed with SMTP id 586e51a60fabf-43a2dd6fb17mr13002711fac.11.1779213324299;
        Tue, 19 May 2026 10:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a94fce014sm8000183fac.7.2026.05.19.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:55:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260513182924.1753582-1-csander@purestorage.com>
References: <20260513182924.1753582-1-csander@purestorage.com>
Subject: Re: [PATCH v4] bio-integrity-fs: pass data iter to
 bio_integrity_verify()
Message-Id: <177921332352.177962.8933559422429188461.b4-ty@b4>
Date: Tue, 19 May 2026 11:55:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 12:29:21 -0600, Caleb Sander Mateos wrote:
> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.

Applied, thanks!

[1/1] bio-integrity-fs: pass data iter to bio_integrity_verify()
      commit: 431e40042d3599559e588b8946bb28bd440b4f65

Best regards,
-- 
Jens Axboe



