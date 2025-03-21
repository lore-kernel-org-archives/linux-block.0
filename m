Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB241C64
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586425; cv=none; b=mQrEsjM8fy8hXmMwQmT3/YVWB7gSaYzPthnPME0ynCfyoou0SEoiHkWA4cz4bdp4wOxG1unhvparGLUbAuDo4U+o7Z/uZQUaEWRcUz3JT3l0ugDfAtHfBclLlf9jZWwm7ZayOvW5nl0o+lHm9x2ie0xS5PfrU/CxaXWe3O8W5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586425; c=relaxed/simple;
	bh=+WnbsCQf0RkeQjRKxamSw94es1Sb3f9LAw7sWH14CZI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y4ViWDWts3SPFDxAyfqRpEtboNp4VPMoUYsJKeq7P1bdk1F1IsR1t5ZFwapXXkPi37L51upKxWG7HkU1l9HvQG+z60azrCYeimEeMGRJuf6LW5eHwAc+LOcPKNEhYG0q3ipfTZDWQ6HlQp18VPqEP9+vyW53zgoiCk2Yu8DIzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yU0mmTdW; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yU0mmTdW"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b515e4521so72417339f.1
        for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742586421; x=1743191221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK2kg9IYmxE42LXnq6anIi6OHhpvShyg+1plxYgL42w=;
        b=yU0mmTdW4mX/07KzFbcThuL3XanyNlv1VNy7MMra6KgP+Hs08ZxSusvvaTmZR7ywrH
         lyUHvcXf9vi5nCp4MLYKxHDwkn8QG0CIirgbxdlNWCcdhNQmMLyxO2nnqYzd/LiHGf7l
         GIVnVFLeJw2VfQfRm0TUjkKH23Y4h1vnf868x6Oj1rKKepfGlz+PyoMlAahot7fImE+C
         o3OsRT8+trrFvejqmQPm9plcnpV3QlJ19phlifhv9PZHIniN7XO+WnyzsS6+0VH0dwg8
         XR1SYzwEBr+SqiR6BbeHz5YrpFil1VNGwGw8mL/zPXMiHZAB+CKP7q8BdyayMpzmdbrP
         32RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586421; x=1743191221;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK2kg9IYmxE42LXnq6anIi6OHhpvShyg+1plxYgL42w=;
        b=UHfJEsmdfSZmRpvse0h3Q8z2XqYTXSDnarBSj9d6Eu1yaWPvpOAXOW8hZBq7xvW8xh
         KZPWQMjU3rB89CPOPF0lZSwP/eXd6bY2rX+OAAi31d66mD41CzZnRMGt1Kpobqf71Pb2
         2ws7iUG+i2EqO6kb6cJ4IOAJVeViGf7DS7bHNc0xTMPPN2NYLd33Xvlyj6mLmtjTEvJe
         a+hAiTJ37KUrqAmh672TIiS8u/MS2IUK2BfSM8X+R5247xgAbfSSkmOCqXT5LOFM6LKm
         3E0QMn26IGvrwy94jteHrI/nPWfs4BB2gOunqV3BlmvmggpE9+ibjiLMUiF6H3yME/7y
         vLWA==
X-Gm-Message-State: AOJu0YyUf/ZkVNPZP9OYed1vWc5Lk8Vp2pm7RNR2b+mct5ldd2efTpY6
	NkqSdG/P5IhYUXQaUtWBgTrk0++w+0WCc+sN/pGKcyW4s0KefleIdFS4mCCFdY3V2y2aCOq1cyi
	0
X-Gm-Gg: ASbGncv9Ue+FdxnJaP7WGudIwI9M1VwQZUIHfBlOOV1YB/2lSui1vNOPLN/kj+Oddec
	PJzpAY5Q3S3nn01phmu34ZsRzDVlm6tVjfMOmeuU76VWBkxhzVWD4MYjPOTkcod9wxfT/nkPkmR
	1laqKKfAms7mDoXRmOlsRasD8WWVyUjBckUiJNCQnGdo/3sEgi9cFY1Vfgv4lYre34NaAQk7jgA
	hTeURNFpLRISkyaGn2nGhZH1KQPXnYJ7GCGB72qZvXpt1T6SMxaWWg6fkNUei0TWDtuDuCmgPJS
	Y8mqDj6ECvPTSQVs1SarXG3LW8YVUPMZy3+6oyvujLXt4sQ=
X-Google-Smtp-Source: AGHT+IG3olMYGrDAWHqUT+U6acPiKVkiz2EfrAeXXfW5t4GvNNSOzt4Pn6Enrr7ke+n0/hFa0vzgCA==
X-Received: by 2002:a05:6602:380f:b0:85d:9e5d:efa9 with SMTP id ca18e2360f4ac-85e2cb423f8mr512036539f.10.1742586421442;
        Fri, 21 Mar 2025 12:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbe80b01sm579627173.79.2025.03.21.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:47:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250321135324.259677-1-ming.lei@redhat.com>
References: <20250321135324.259677-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: fix starting ublk device
Message-Id: <174258642055.742061.1713958203897349462.b4-ty@kernel.dk>
Date: Fri, 21 Mar 2025 13:47:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 21 Mar 2025 21:53:24 +0800, Ming Lei wrote:
> Firstly ublk char device node may not be created by udev yet, so wait
> a while until it can be opened or timeout.
> 
> Secondly delete created ublk device in case of start failure, otherwise
> the device becomes zombie.
> 
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix starting ublk device
      commit: 2b17a89292b98c27ffacc7966e2e42bfe0465242

Best regards,
-- 
Jens Axboe



