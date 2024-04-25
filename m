Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C51494D1
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052900; cv=none; b=bKUJe/kQ96SrjL0NVscb5JKye6BLwGpRE12vv0uiU8NC463Va53c+8KV+GOcQB5PF6j7At7+FaBQnQxVf23iGg27D6ajlqajG9UhRrR7DpsAqEZGMT/E/oOqGKUEGfiWeot3hiCyD2+oZp+1WqRreFKIAXAyhNVGxQYR/KQFMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052900; c=relaxed/simple;
	bh=yijp6mDuEryQSYSEQujTRdi93LxCLeRMH+/iuMy9lvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUHRpkGlq5vtyxUJvirl1AIrmQVs1H3c310NVnA2jGYFjE360XXNgfxQ3uHw+cjRI3rFNmepE4cHvNvCNtTytZaqP13yUadIUV2xphEoKM1vlUR59KSLfoXpoY/4U3j1iNnr2RNFK43HS+pMWfHa85M9uGlMZh7OYbb6dQM97yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pvW4Isqh; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pvW4Isqh"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da9f6c9c17so7397539f.2
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714052897; x=1714657697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPHeMhxWq9nFoJQSdKvm8ireF5N0fGXL8+p/dhppbKU=;
        b=pvW4IsqhMr0Bu9jyZ6vYoHTj9rPpsrK7vXoTcnRavgBO3ARhZBdBi754uJXm7Frbai
         JCO1tq47p70covhZBWk+6OqJl3S94Go3AEHIjJUWeQCZtqBI8XAWLDQhCeGDjTjtYOVS
         1GweirISznoqM8WI3p7/sYxfXNrbeC04VOfNm/GKHq3kejKy1+sOp9u32AL50yvSHLoz
         DEVEZYjDFluMgbkrBSukIDdyXacOjbCGcrNkLx6x/EF0n4raBFzKJKih60m1EoYFmyNH
         8mIXvG+pcplMvIK9tNBeu4jCwdHJcolou2reSfMW1+lDOwEFP7VqDZb3GhUsH3sW5cUf
         VVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714052897; x=1714657697;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPHeMhxWq9nFoJQSdKvm8ireF5N0fGXL8+p/dhppbKU=;
        b=raRF95SKI2vGHnh7pRilvMBWtyGHd2KlqwBY+5fSEyldl5w9ieerDB1U76Zg2BJRmp
         kDAQn2tV0piGV1H5r1jusPk+cHxp60AZu2wDVa1dRa/5iT0cpnJYYAYx0OD0p8eDsBVt
         EC2uj8UOz7acyq0T/V2cgmUr4ocab+Kd3UMFYhj50YMSENEHcwEAyBWPBL1cqB6RuVB0
         apZWr4wqUtSr0WRE38lJBSjz/RS/4asofQsqlZWo4bAnWCOuTnC3Be6UxykCisZo6EiW
         nGAtnFlGsidrsQSTqaM0PjQYo5WFJmmv1QiSJx4fLyRjfeCu/+wAau/g/HxRMBaH+fBN
         O+ag==
X-Gm-Message-State: AOJu0YyPHdx29YEKfNOBzSm0vW4SlqnvwHJ6ZG3ArRc4FFoTyX+nx2Xj
	ZlzvKdahvKRMKMYHZvoEOl078QPJz2BQuquwrAVjtzWJlcYS3krSfsPqoyBaI/4=
X-Google-Smtp-Source: AGHT+IHqg9KQni4h2e+Fa+0oBBFAhys8L+aTh5tu93cKCQvaNfLZ1u4kK62O9xK/urRkpRAUHPYtAA==
X-Received: by 2002:a5d:954f:0:b0:7da:7278:be09 with SMTP id a15-20020a5d954f000000b007da7278be09mr6506167ios.2.1714052896720;
        Thu, 25 Apr 2024 06:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i14-20020a02c60e000000b00482fd2a95e8sm5048887jan.43.2024.04.25.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:48:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
References: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: check if zone_wplugs_hash exists in
 queue_zone_wplugs_show
Message-Id: <171405289567.163506.2493622305669607904.b4-ty@kernel.dk>
Date: Thu, 25 Apr 2024 07:48:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 25 Apr 2024 05:02:39 -0700, Johannes Thumshirn wrote:
> Changhui reported a kernel crash when running this simple shell
> reproducer:
>  # cd /sys/kernel/debug/block && find  . -type f   -exec grep -aH . {} \;
> 
> The above results in a NULL pointer dereference if a device does not have
> a zone_wplugs_hash allocated.
> 
> [...]

Applied, thanks!

[1/1] block: check if zone_wplugs_hash exists in queue_zone_wplugs_show
      commit: 57787fa42f9fc12fe18938eefc2acb2dc2bde9ae

Best regards,
-- 
Jens Axboe



