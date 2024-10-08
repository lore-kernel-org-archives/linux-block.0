Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1FDF71
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400158; cv=none; b=jD9D/4iWULEARUCgoPN/gmBeHFOlRsy10kPpuc8DEZMAxwUlSfq5Msn7l16Y1YT1zF4ti/sqoer1LTWSXRoQPzQs6jJGSd2vBzd0GFO/hzqIozf+5DJ9MWbE/c96p9GhTCdGdZ+RgD9WehBmhF2/FAUv3yJKE4oPw35AvxpNtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400158; c=relaxed/simple;
	bh=04YZjx6jz5Vf5DQ36uIvJNnbq1iVhHJLd8s2OxBGAMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PSDbDfQHyubWxm3VnmsEgVqK2WWzaCbiI/gRIfhtgc1QQBnb20DFNlOdn30udxEl1zwKSbaENlSwLXG+u63RQkY9sBrT8RQ28y9wJQQ2+UtTTP7nBpeVB9c3kQEwEV5yvfmDT+++g+VytIQ/v7pAJe+ReRmpEzn3/2K7WX/GQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KuaaTUcw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KuaaTUcw"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2870058ffaaso2228932fac.1
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728400154; x=1729004954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OCQPv+lxEOlQp7QK3KN9Bh9GGU2su8eGk95BJ59lwM=;
        b=KuaaTUcwd6t3U97RzbthkI4SbpYk3krKcDHZ/TjCqQlwGZr3cDFE2f5pROhP/Hnfke
         sux0kI1aM7uRJkQ0mYbvJ8qV8mCodmW+t3GLTmIj3/NlgjwajCeO59LHy4rjfizK50IY
         vazG4p+PIAT2iwFcv/wSLDsD5ARmRAN+Q1cnOX12JaKvqvvqATzHo7GouIVFi40/XE61
         VU4CiUlg5E+xLMPoCthLBG+NG0L+/DsIwHyV59Gquxg20xmOsWTV7G6o1UaawxtGZNLk
         OdZBDGuvTOn+ZOQGF4S7E1d6y9H+vfYN1dGX5VvV3FA/pWigPXmzsdlOdcjTL5a/UQbu
         WSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400154; x=1729004954;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OCQPv+lxEOlQp7QK3KN9Bh9GGU2su8eGk95BJ59lwM=;
        b=iWxHN2cd5dpLdhTudE7F7iy6X/yCzFioevq8OYmWJiCkMsuK4VDEZUWe1ArWeapWdq
         s8PHqKTJIxxOhEOnYaicXvUpbQvcHFe9P7QWikFt8x1sd/nDtAl/lG9ESlqh1jbHsXwk
         KnWaXoSY2+Afb9tzN2ulIaNcCicHhfXIqmDYWgOnaY9tnNsOJ3SF3y0kmDY78clUp+mb
         jtZ4Y6MWpFtZpb2vT11SrQkoCjn28I6tfQSkN0dUJa8jW9Pq4jCPO9ULcCupzliuSZM5
         tMklufzaGbMm4N/KMCg8Qw8uyH36XHkEyx1eFqyppoDMUjvNdkj6SXTkAueombEyADD0
         3U+g==
X-Gm-Message-State: AOJu0YwhaMVbPovaJCnknR88PysH6CQoNSVrzvH+iSOITQuFPHb2Nq1i
	3pGOd9y13wfX0gohu6ujHqB7/1tRTf5w+XA6gc6lKwVFFbEEmR5aAKxpkZVxBo5YZJYf/rwZgNG
	qbik=
X-Google-Smtp-Source: AGHT+IHRO/gWKTzon76yB9KlTJ6Eg1AXImSNgJIIs85PCNHfA5B3P1rGA1TFYPmtP8Rh7MbTjIDB8w==
X-Received: by 2002:a05:687c:2c51:b0:27c:a414:b907 with SMTP id 586e51a60fabf-287c2291b2fmr9125651fac.33.1728400154462;
        Tue, 08 Oct 2024 08:09:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0dd9sm1702297173.120.2024.10.08.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:09:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Cc: msuchanek@suse.de, jonathan.derrick@linux.dev, dwagner@suse.de
In-Reply-To: <20240829175639.6478-1-gjoyce@linux.ibm.com>
References: <20240829175639.6478-1-gjoyce@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] add ioctl IOC_OPAL_SET_SID_PW
Message-Id: <172840015340.13129.2305302955179646945.b4-ty@kernel.dk>
Date: Tue, 08 Oct 2024 09:09:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 29 Aug 2024 12:56:10 -0500, gjoyce@linux.ibm.com wrote:
> This version does not reflect any code changes since there have
> been no comments on the patchset since the original submission
> on 13 Aug 2024.
> 
> As requersted, it does contain an expanded description of the
> patchset and a pointer to the CLI change. Thanks
> to Daniel Wagner and Michal Suchánek for the feedback.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
      commit: 010194b33241ca05a0ccc952dcb94f89f68b9846

Best regards,
-- 
Jens Axboe



