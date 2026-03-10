Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84282DCBE3
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154739; cv=none; b=NhzfNex/gLrpLwKO2KkErVJaDsokQxgQcEIV9bvVO/jcSDu415bFIiJYwhMTKSs8SR+LzMt1buhjmjv3cnPPhXMjVVStjykUIyrXVyCEGGq/jQlWaJbufv2fndbda3JcfOvDDvc2btSzAndc6ZK6y/UiVjxDoYDw1GVAq24+8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154739; c=relaxed/simple;
	bh=S+anfbSwaDJsvX1PlPr7RWxLq/UCfSI4a9XfAmzsRbw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kxIk0oG8HX1CwhVF/rkg6W9CaIllb8lSkTLrxZ2dcW1JUbzgWn1RVP6y8CdJPEsCWe+Zmp2eMc1Eof5TJaflIEtB3RV0rYf0ApusZszRmQpIZyT0UaE6UjY1PqWGFCdGUMDdkyf224LkNP/UO+E76VGT/JI6FpguuUzkJsP8X9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z//TMhtC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z//TMhtC"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so5067344fac.2
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773154737; x=1773759537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlzuJzaGVqKByGHYMWwVZYmu+ZMyTR6bqnVlHDMtpUk=;
        b=z//TMhtCBxTE9BvEBDwxf4BUAt+KwCe9apbfRDimIPC8cjo38ABUwSsutVrT+MQeG9
         0hyWTfpDlIYFYekjI7hkUP71KdgqCads0x5TFywDbLiXuGjT7pi0h7iC/5pysGWHQT00
         CHErLO0lWji0EZNvI2yPt6MCmCePndOdXLLBcNlUshzxTvD2hhubUSNJc4RHBApGf73X
         Bq6egDcVdch5bGx3t0tgakbup9+Y40jA9Q7Re1qNjW0S5rIFq8nhjYRWls5b71thui7V
         BgeRssHqDRawbET/Vay6FGDm5Gfq0dTwsSJLER0I529AYXCbzcylMvgSPV+2nLPS7AkW
         pCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154737; x=1773759537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlzuJzaGVqKByGHYMWwVZYmu+ZMyTR6bqnVlHDMtpUk=;
        b=VKoe4tW1iDlVefP7C6rZQrbGjZS8HrDJg9dFyKRCYuqbHQHgHzXSVyD5rIYdvzxeou
         iCHMXYpdvjm8Avgpb4CFSIFu7JrgNdp5rQtWOUF56m8HK+MKV7Hl3CMMtzVbw2TwU0fl
         /QvPjYV0Olq0INAtCmlzcJCILs1EsmfoCKxOBT3qg1V4zJEcJOgxvSoLXS+OBQWv8DGt
         e/hBQKl7160NqraTO3W05/bKH6YTb3kTPXwFBSS7Sm+5FIoT9VnBMFRjIBmuAaUdjQpF
         3xLGaqVOPdlqIA1tHKvCLUfPY5UWDewJAPzYVsnwXnHv7nnD2mQYTnqTbxafu4+d0+Zg
         WwGQ==
X-Gm-Message-State: AOJu0YxiZCoaHDAcvosA8YtdUwSAsBRDhaZ8yMph1cAc9X4fVz9lHLlB
	ue6vKQoDwVuHlxK/rOZHH1aSvZFOaID3jEcSyLqf31A8UIicH03ZB78jpJ35+LN/bmg=
X-Gm-Gg: ATEYQzxPL/4XyqtqG/MIbqGmf1sUaskQHm/W/Vmk2iqqSuHDyJDE0AGPOa+US/zPT1M
	TwUr7L50THuBhk0O3O98uappT2flIdbZmQkuLDk7JBdk9TZkhNJNu0CpRJBXAWSwdT4Ms7GwK8l
	IMn6EFVkH5sCbg1eLNmOi7asR4f9GobUnhqMGWcgJfnUj2eAcy4haISkxEDgKgbp0cR2jUH3ft7
	z8VbW+4THr1mCDxQw1m0aXBSn20UScCMG1BI0hsOMLltfXZ6woWLDExk/t802m1ng+zO4z5WD4q
	brxiLjU3C+52g1juB9ozCnv9xvSSijDXm4rJhaQF1FecK7QWEDZDaxWLj/9ci4KNOi3K0bYjJav
	Ce4gPhsB8gKKhOBHEPwf/arpruwXevTqo/GPmxt9UJAOSeC1UYb4YrPJDzxL187lQ1BXh+/QuiC
	43iqqgPRuE00ONGCOypgsf4D+QuobZgbA/8DC1ct4FHqiFiItilV0zzo9hZfw7EStX6Bfn9u59H
	6y2
X-Received: by 2002:a05:687c:2703:b0:417:3a5d:c2f1 with SMTP id 586e51a60fabf-4173a5dd3d8mr3479186fac.7.1773154736920;
        Tue, 10 Mar 2026 07:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dcb1e8sm2924913fac.16.2026.03.10.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:58:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260310142330.4080106-1-sth@linux.ibm.com>
References: <20260310142330.4080106-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: copy pair swap fixes
Message-Id: <177315473593.70675.6747808910460583265.b4-ty@kernel.dk>
Date: Tue, 10 Mar 2026 08:58:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 10 Mar 2026 15:23:28 +0100, Stefan Haberland wrote:
> Please apply the following two patches for the upcoming 7.0-rc.
> 
> Both patches are straightforward and address a rarely used code path.
> While users are unlikely to encounter these issues in typical
> deployments, the second patch is important as it addresses a potential
> data corruption issue after a disk swap.
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Move quiesce state with pprc swap
      commit: 40e9cd4ae8ec43b107ed2bff422a8fa39dcf4e4b
[2/2] s390/dasd: Copy detected format information to secondary device
      commit: 4c527c7e030672efd788d0806d7a68972a7ba3c1

Best regards,
-- 
Jens Axboe



