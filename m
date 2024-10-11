Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B61BBBC5
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666714; cv=none; b=U+cGo71NlK1u0DtzgZPiANcpx5X18JGx4kFjXIn288jiBHng30pnTV9vN3HK+LN303sjH9iRZIP6r1ff5ckiz1qf3bY9v1eTKZSlUDK9xIlvd+YoE+jjTLYmBYndaqFvmckTFEkFvppBQ6qAK0R0mJS8JNn2nFbOYOSjufKudso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666714; c=relaxed/simple;
	bh=aiN47lzHnJWqzKP2wtzM26gAcaTIZRCbMy1ZtpHDJls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=thekxHUUcbQN2MvjajbvkehyWIuIMwPUfflzZqNyY1oGVtpI0G3WAGqCzadkKq737l93c8jpqu7q3RWzh2IaiHHOTL5DjckGWVByDw1lPn0aPMXMfqoPZpoNEtX6BH7B9nxKpQlSOFCO4uGs53S2ejyTtLVSqDohp/rS49uS2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MRsywTas; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MRsywTas"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cd93a6617so78973439f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666712; x=1729271512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpbrnuNpT2hceRYe/VcgBMKHN+/sFFWJd7A/mmO9d/A=;
        b=MRsywTasIhIfc2p7gVl5Gq/gYjwQFJVwWvHF18P8MpU28Ju/Dze+R8yYvOUfGBfVTg
         /nIrxKaWqudYGNriKy7ZWxQeNN0t5VJyo7NJcO1MSXnbrpa67zTIHoyzLlS/0vMSBgQ8
         RuW/9X+5+VPIBzSAeCEUlcP3MdMjzIGNtcHuYbV48d+g//EspXv7ucKkkfdljlYRGs+4
         ZUvK1T7aKvMgQJUmNcLt01xD54nzzTb14D+6RFFqCC/gmjD8fp0Zma76K5jAESoWKl44
         Cv2OcRY0z6cAdyHUL7zmCvzFh4ijVZFqudD0/almuQNw6FZKh8Np0YWgPCzHmdvps7CH
         6Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666712; x=1729271512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpbrnuNpT2hceRYe/VcgBMKHN+/sFFWJd7A/mmO9d/A=;
        b=YvDYGIRC3cOAtMFLcCrbk+/4HsUXcX+AN3EdJ63zklyGiLfB8gt9mY9AjIsup8TdBZ
         M+SeoouAu3mj/wqQkVeMPn3GoQsC2waKpLZoAM7DBLG0Dm5fBmw+U8qu0A8STDHmZYI/
         InvAr2DCgAWCCe12hkGWm4EleN2IOXKtBkunVYLl87CS6VDpWwTtRe1G2hDYW2uG6TSU
         MvwmU7qd30oEzUbz+YAWD1caZpqoJ99rOfLZy9pw/JxS/qxeFIs1f+//BtLVt7n1MGj+
         EE5Up/yIvK8Z5wqgpebrAsAN0PKRnit1NcPONt91Hdd/YdKR8Qg7P43dboHggJngoEhU
         4v2w==
X-Forwarded-Encrypted: i=1; AJvYcCXBcfX2GBjP5eYH/hsLht6+x4QLpYiNxMdkuTm2bKMx1IjPkQMrSF3+UD/JC9d4LuZAC4GwDytZLayS1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6oPNZoO2NLE8Oh5oS/AFTmUiaCC/32lExOT18IaiLyztSqyJ
	KHPNDyFuicomIlx193afdKFjgr80cYL/0QOtblqtgEtB8l4F6zcTRGq6Ny2J41E=
X-Google-Smtp-Source: AGHT+IGI6wckhy8W+1rmF8si1f4MWwmV9cm88orXihhz4HO8zA71D88m2Jd/YkHmEzs3BnLxoXNMVA==
X-Received: by 2002:a05:6602:1407:b0:82d:3c2:9118 with SMTP id ca18e2360f4ac-8379512759fmr301961139f.16.1728666712217;
        Fri, 11 Oct 2024 10:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241011155615.3361143-1-leitao@debian.org>
References: <20241011155615.3361143-1-leitao@debian.org>
Subject: Re: [PATCH] elevator: Remove argument from elevator_find_get
Message-Id: <172866671104.255755.3061014354205659222.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Oct 2024 08:56:15 -0700, Breno Leitao wrote:
> Commit e4eb37cc0f3ed ("block: Remove elevator required features")
> removed the usage of `struct request_queue` from elevator_find_get(),
> but didn't removed the argument.
> 
> Remove the "struct request_queue *q" argument from elevator_find_get()
> given it is useless.
> 
> [...]

Applied, thanks!

[1/1] elevator: Remove argument from elevator_find_get
      commit: ee7ff15bf507d4cf9a2b11b00690dfe6046ad325

Best regards,
-- 
Jens Axboe



