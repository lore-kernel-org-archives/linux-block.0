Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EA2853F8
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716792; cv=none; b=oJx6d/TliPLI4ZGgQ6EKYNKaHTew36ka43jOj3Ocg/BRV/hatyjChgVt0yWJBG3+Y6/A/UEexEFUbVu5yCVeG3HwxcINVzzecmd7Sngisk6KK+vmVyjM+LBFj0JuAcxh7kY9OkLxSzTAZjee0MNp+H1Ae6aJdMgpT/jsXAsinjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716792; c=relaxed/simple;
	bh=iJCHBHoCmU3LnmTUsPRCCACILpFptrZktkIZpiUYwrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RIE8MM6IGPawMxmCT6MNI4fwc/M8U6hiFPiuHUHlcETS1DWZW3nGS2gEpjBG3FqBqQ01KgR+hi3JhIPsf6kDEH8dvKe7TemUueSFiLdwirQrXFJ9tAnpx+MpfjHEWdXM0HIzAsLcZMjoEOjyfOBxDBrkJ6UWexhzSMpLJxYxjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OPyDAfD2; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OPyDAfD2"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86135ad7b4cso43264639f.1
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746716789; x=1747321589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMtew850gCDT2aUsP+c5rPIUjWjMK4ntex+714PkH5s=;
        b=OPyDAfD2PFGG5Zt+tqOg3UMwmWeLE9FD7UULvEFLXdHTrupoNBEHlXy8h/hivshpIm
         RL0ayMQb5/3c9yqEjzagsycsHtat8TM5eeIvhMugxmB9bgkQffGyvWvE1iOqaXqRyptX
         0qrxT3I6vERC8DqS3v9Cp7vfkoA4rQlR+Yki3MSrlABqOayw3Y19MNoR27G57vGNFgqe
         dJN18G/R1CpzXF1Fj+NApIbCLnW+30GKEtwR1JUcXDxI1AR0ohzYsJLcbvm9Zv6Ra+25
         d6Ne7xIL8Cc+9J8MaFXYv4lAJztWyXopUTJ0AdZCFglr+R1FyCxP/1hWhZGqNupkuu4n
         wFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716789; x=1747321589;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMtew850gCDT2aUsP+c5rPIUjWjMK4ntex+714PkH5s=;
        b=vF/MZcAloRt3fcWX5cR8yptAVkWDw2YTtEx7416cDqtLw1GMmmU6ITLbNJFBfRc+md
         Tr4+mKDIebV5zuIt1iCouAvHqu/z6SU2k0eMDBZzSwyKv4WCjvFQZ6KoIJfltuW0N7tN
         ZfvxMAd6Td4RIi/MK6vU1lIo4/hCLKYeaFa7z7IUq2qeNcH4A7lJt0At2WX/FWvGRXE7
         7RLimDe1TaqhjarKbaOB8Zk4ezhnW5DQiJWeA4qjTThkESTmzfdClr9gtZWyFqyW6eRC
         zQAB1JKUkqVk+YmkYFWH7ElrThoKAT0WybKtPuF15DkOoEMUcH+wduGPMwxJ+n/r1OmU
         ySwA==
X-Forwarded-Encrypted: i=1; AJvYcCWZOz4wU0G9v8eXJ094xUllzb5qcnvcriVJGZ8A2PZeXMG1cEiEmSbTFG+qpNci9JRlft/G5TRlwooTYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWOjF/ch1es2rj4I6zSdTTXcUsxr3p63A0HUeB5W5jrknFlGe
	apX0J2zZVag/Comi0soT4ptaWJSi3hWXoYSvarkyVBEBSp0a2FC9HLTRY/lDpsg=
X-Gm-Gg: ASbGncuaJBLm9dWJCBfKce8hV6iVkVQHkPjdME0raexEz/z398y/wyuIn9zzxB2m7o8
	nM2R3W3zL4tV6cF9DZpkCJ+Kp1uk3r3WgiVizgWxWEOG9SYpIDiDYC41PziQ9ZYDxQUH9TvcP1Z
	HVgVqz0hisOxu+rvnpUNlreehHow+5h6n69n1qCad2e70T2235O48LSGiRcdDnMSPXhILVGunAU
	PlDQ8uWOIesf+DRvIXcvjl1MKkBgdxVS2b4azmewW52rRtwlMMjqxTZNwBfdWUltXTspc/uiYKY
	QGDq5zxL8k/Cp4njd7cuSq6o87TiXmP/B/i9c2BUgg==
X-Google-Smtp-Source: AGHT+IF15lgmSBn6LT2go0n0pbsbPQb/xkfcKwB6egXRZqw8jaQYzzFp6AaizybDz12LOq70AFnmKg==
X-Received: by 2002:a05:6602:26cb:b0:864:552f:eb26 with SMTP id ca18e2360f4ac-8676352147fmr1812639f.1.1746716789575;
        Thu, 08 May 2025 08:06:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a9418d8sm3110872173.63.2025.05.08.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:06:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Kexin Wei <ys.weikexin@h3c.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250508083018.GA769554@bytedance>
References: <20250508083018.GA769554@bytedance>
Subject: Re: [PATCH v2] block: remove test of incorrect io priority level
Message-Id: <174671678847.2122953.5548552861160934372.b4-ty@kernel.dk>
Date: Thu, 08 May 2025 09:06:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 08 May 2025 16:30:36 +0800, Aaron Lu wrote:
> Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
> definition"), the macro IOPRIO_PRIO_LEVEL() will mask the level value to
> something between 0 and 7 so necessarily, level will always be lower than
> IOPRIO_NR_LEVELS(8).
> 
> Remove this obsolete check.
> 
> [...]

Applied, thanks!

[1/1] block: remove test of incorrect io priority level
      (no commit info)

Best regards,
-- 
Jens Axboe



