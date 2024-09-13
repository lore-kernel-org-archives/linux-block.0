Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1374140360
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255604; cv=none; b=TFwV4atmt8w10KOx9MP3z+zEq2D96usvDoDhavC/RakWSfQEocXJwDRveeBu5g69cFjFfOI4OKHHT0styIwEP2+NoRHlSARjubRwpNSWaAbIq91kVOSOkfwL5l0mC+EHPZXk05njmxmauHPBWV0MRH3ULrPazKMzd9CJoA5wrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255604; c=relaxed/simple;
	bh=ZXYEcX1Mp8E8GfrnHPRFqhD/PapzV2PwJx+5tyo3n5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dQ/Z/1CRTNsHIFaQenqjuvp6E0iDiG93sBoEF+elbgNuGKvu7AYz2R8cD5s3EshO9+ysaN0nk+2LpMuATUF/PI5bs8gluBaaRFQAGGpWrhbatu8Hk1Rbo/LyXFY5Vn4dqNIXNaU3hBcNLpyV0wEijU6eqKBJuAjVfKb9Fl3gADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WfK16WPA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WfK16WPA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206f9b872b2so25670115ad.3
        for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726255601; x=1726860401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3NzF1MHFtF5YbZhVTwzHlZz/lrvjfWDx+o0jv4vpJw=;
        b=WfK16WPAXaQADXnim3OKdWPNoXbRkAoLaHScFmPM5thePlLbw5lC8yfH1i5cTojfDr
         C5z22vtR74kvX4oYsHWyfQ1PukvKyXgXNfqv/veRGLUDF/kKHooPMwo6qGfJyAj7bEFu
         9PaF/ZkBhnMX17n3JUJbCK1/qZUSaCedihHeSJbPhisw7JWm4EjVU34jAt//+iGJk1Ax
         WCHMTX801ER82GU9zijwA5MyBMTrwxkCVfvR8rizEYLr+ua7vtMAHQ3ulDDlfelktnKo
         Yx8rVnorybL8TjjxhnGNc+tLdHX4+sYE5HiQ5LDQ8rOID+gElYwC0W9pHdUg1nTpMzBS
         DKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255601; x=1726860401;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3NzF1MHFtF5YbZhVTwzHlZz/lrvjfWDx+o0jv4vpJw=;
        b=i+tLj81P/jRmrqjvIo4auQiZimcOxU4Ccvmt6PS8V5nhwun2r4JdmTSZPpdWIvh0ey
         TwqbAYRwm1dUZlnT1PqbzPMVIYRs5JCYoRv5yFY4Pu8mGD6hC8lTtirjQ0X4KVfgVWSb
         0CkgJHMJq6ybp6mj8y8zoXvPYVD2B93dobznep/CrdJ13iuJ+x/qYHyQIt3Vlk74c8zb
         VXCzu/HqXugFBKqjHPhdGbApsDQSOlbwl09+OMXNXmeaP3F9ZxdVM+WI2hE1DSGqASdw
         XETIkRIoBVHGNuOmTIepAEgTePFfphlFANVvjJAHFqbApnbOHm/d9TlclZauYzwQVvK9
         bfkw==
X-Gm-Message-State: AOJu0Yz3lp/wbpHm1hsB9lR9RQWVEpGRIBflSOFaUtWqbFMulCgtJNrd
	vQ2Q+plZbRBz54OTYYjPxiOr2llsGau6tKH7eZO5NaLN49/CMdFxh+JfBgEzhXBiukyqBkcXHrY
	t
X-Google-Smtp-Source: AGHT+IFTqOrH6i5vFHunF5cStatsRtcRhnYwV3xkIDT5UOlSPIiYHlICLEuvtgWSM0kVv6js+HBHiA==
X-Received: by 2002:a17:903:2311:b0:201:f853:3e73 with SMTP id d9443c01a7336-2076e36a5fbmr117193325ad.11.1726255601095;
        Fri, 13 Sep 2024 12:26:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da5basm32405ad.14.2024.09.13.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:26:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240913191746.2628196-1-kbusch@meta.com>
References: <20240913191746.2628196-1-kbusch@meta.com>
Subject: Re: [PATCHv6] blk-integrity: improved sg segment mapping
Message-Id: <172625560011.737578.8113848772953432193.b4-ty@kernel.dk>
Date: Fri, 13 Sep 2024 13:26:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 13 Sep 2024 12:17:46 -0700, Keith Busch wrote:
> Make the integrity mapping more like data mapping, blk_rq_map_sg. Use
> the request to validate the segment count, and update the callers so
> they don't have to.
> 
> 

Applied, thanks!

[1/1] blk-integrity: improved sg segment mapping
      commit: 76c313f658d2752e8527610677164aa7094ef7a5

Best regards,
-- 
Jens Axboe



