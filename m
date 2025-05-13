Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E61F2B83
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169251; cv=none; b=REOhzj3DzyWq8wRi1qpn1mYw2A7zTsUeUFvdhCaoXTrcGPI+kHnXJ+MRhADeOC4THiTb24bLlAAKcaJG2s0dTas4c6FaByW/sSuef5fIGm1WvTP3hko2ruNHA6V2kU3rXlNBrcXgLfeN1avnw9VCSuxdCi1G/dmRxAwAJFI7kyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169251; c=relaxed/simple;
	bh=4BMyED0LbmqU2y7tnUtSFSF2xd75BsMTQ8D8Nk6hn/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTmDlSUduPre/cgVEqGx99khfSV452gkYEVOkzOfDr3BJ1swFNsdYlw4FkPsHk9REJB+gbK2djZBQYun0PpXVeLklygr27ZjVDzc/15PN7UnB87vaxLHs3OTaMx+nQ7wMMC2nqXa0RJjE2cSB6D97Gm1lPkkyteCxEXBDyTjXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=norfWnBa; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="norfWnBa"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8647a81e683so149903939f.1
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747169247; x=1747774047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4qYuHAm/y8xwUC1hm1RzQO36y3QZZd40xoQbkCOzME=;
        b=norfWnBaMH95+RoTBRDeeL6RYU4GNcQUiJgo5v7Q55zKbZbbZolNcS2Pj5gRRuIlVR
         Us1KVFMnkI0XoMHz1oyQu5aIiG4aCLAxznu9psXLhQF0yYE3ILvUxrkvpe/6HBoEArT3
         3WLO+mVwFHm1FTgxO8ly0gboQQD9Fs7ylXbaclceIJws+2vh2rNXKJLt0obuptlvYbus
         Y+XzoLgQGYdxQExG95Q+AxPgYbzravN9yb34WyUbwkamN8XfKHIFjrLXjYsmhlQ+cNxH
         IFtsOpvylDR6sdYYGGQq8JJ0p1OPMkKFo6n340Zqu6m2npS2O3n/gRb54bj/9Fjy075a
         BNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747169247; x=1747774047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4qYuHAm/y8xwUC1hm1RzQO36y3QZZd40xoQbkCOzME=;
        b=Pds5fBVNm+nGbShzUUiQF5n51gMxLs4WOvH9KDihNXzMkJdENAzUn5wavt8Xs7qZoE
         UJ1Tu8ZVREeoEJ2jWgfWcI81j7kqvbo0dZHRX93EPL5i/xZK0Wb46auwPDAvSm7BsM4X
         s24kpdbyRZ/tuvuyGKoaiCF/VC8BTyaA65x4NsYSntYhbGrgMYr4kf3wsYvNKhZNeNWx
         XYY4qTMYJzJboOMf4NmE5y/uw0Cqs1WevfOneS8IjuAmN+jmxVCEV91zflQ0XiQO2UZ/
         ttUtC2JwovdSpQ+WUVxdG6jpvxHIX643L25ELI7mYQ08O1PrhtvXFkV8zJSZL+q6u2kL
         rP1A==
X-Gm-Message-State: AOJu0YxYiUdRj53GtXOnTS59owMQM7z6ptIkAfL72VmtM7TsUGI4hIZb
	UzATtQKWhFtzFCzlU6WASbDS9doG1fsfkeOhjj3uUFWmT3M8dGR61DanmXQTI5hQaXGQ7GaPoUD
	3
X-Gm-Gg: ASbGncs07rqfeVzYJwIhP2GsHTuatWZsivj8k4p8r1cF45tNNvNJ4XmnLeyMsam+njb
	neHJkjfyz4/VibxgOHnQitJjtBU/U3V+NkMUFt/7DVmm/E9Gl5bZ/SZIdtfFH7rlccKHBaGlpB3
	u14d0Q3wyZEj/LxGNJuyrqDnmDJkenlQ8dBCNTdAP5pw6kbCqyTXXF1UCvO4t5UqDr90zbrNSWA
	mlwN8ndBVer+Wld48gC6/kBHwT4+3tZDsM/uMjoaU2sU9Omv53AB3iePvWJ8fGJVxLtlhEfHcdW
	mitAeMDtg5CxSJXn4D7acAZqn0Rgv3XZghFw7Jr/CA==
X-Google-Smtp-Source: AGHT+IHbD3AkzAxbmeFbNUw2IrFpMyqKCLMw886IIQz7AIxGUFyNs24QbkbyNaScVgVJA7GoY1lgAA==
X-Received: by 2002:a05:6602:36c8:b0:85b:3791:b2ed with SMTP id ca18e2360f4ac-86a08ded21cmr117355939f.8.1747169247639;
        Tue, 13 May 2025 13:47:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86763570018sm240731639f.1.2025.05.13.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 13:47:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250512042354.514329-1-hch@lst.de>
References: <20250512042354.514329-1-hch@lst.de>
Subject: Re: [PATCH] block: remove the same_page output argument to
 bvec_try_merge_page
Message-Id: <174716924633.10749.5177442932058601665.b4-ty@kernel.dk>
Date: Tue, 13 May 2025 14:47:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 12 May 2025 06:23:54 +0200, Christoph Hellwig wrote:
> bvec_try_merge_page currently returns if the added page fragment is
> within the same page as the last page in the last current bio_vec.
> 
> This information is used by __bio_iov_iter_get_pages so that we always
> have a single folio pin per page even when the page is split over
> multiple __bio_iov_iter_get_pages calls.
> 
> [...]

Applied, thanks!

[1/1] block: remove the same_page output argument to bvec_try_merge_page
      commit: 77fd359b6dfdba58f476d5c17097bab024af9467

Best regards,
-- 
Jens Axboe



