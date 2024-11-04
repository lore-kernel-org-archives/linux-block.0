Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA1C3034
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741740; cv=none; b=lnP2vBc08vZ/WM77nSWPHjwUiROlMxqQ4aysCWq7ZrBZ4HfwLPXbkixi+QMA335u9cIpQzUpA3Dup1RamjUyOSDPbiGVU0xMiobtYzP0tU3vOmzZWAuM+ee1qGbN9BKmiEKuvIQWsop/3qMAwCPwRZ6ezd6uJmDlcEJINJ2Wohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741740; c=relaxed/simple;
	bh=KfLXGzlgzC68SApHDI9a2FD4c4qKFN+OdUwhw7Ocqbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=burdbDxOY/z/wK+4+Z8UhXEKo4H0e8Fo8Z9VqbJLcruyHH1Q2gcXnBrBDXWrwSeTvbujDjBzsEwg9f54Vx399OKbE5d7zffIDMRaDirWrUKCVbuF01adqGXRHD8M/tS/ptNOjh7Eqn/JEFnPqz6E5tyRXVoPLVmdWcbzSPDds/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VMFt1TCP; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VMFt1TCP"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83ac05206c9so156025239f.3
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2024 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730741736; x=1731346536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eazj1l0lTo5ffeRkPP3wb4QLnpbwhCIt6F8IBQmB1xI=;
        b=VMFt1TCP/UFqlUcRp8Y4krVy2ag+VV5XIDLPwIsmreR8k1nlfsCL/6Y+U5s+rdlXqI
         1ujnZArlCKDacv4LhQlqjPL8gp+opG8GWzrDvjR94Qo87wqD6jWqFdeA2gDcHL5hlLuk
         gh6EcnMkORziGx/o9qsqpntxVOkebA0qPfMuWhqgbDHM8DdtHJxiBNSr+89x1pfEfRy/
         fCA7jOhVVV3UQFwmMcmjtZxQafXHhdORO8cnWk/iWf92/e8+PsmEYRgF/1FwlvFmz0PK
         kLmj1YrOUrkM+pH8VFHXUiwTWvCtwp6+O+vcXBAqIF7tlF30CAFI2LTG8GC7SVCFo4+n
         tfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741736; x=1731346536;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eazj1l0lTo5ffeRkPP3wb4QLnpbwhCIt6F8IBQmB1xI=;
        b=sIybKeytGeQrtv26zpFrLv4QBxTzsFcpMuHAUjmGtDYINsinFlxOCf7LdhrTLVfAUs
         D2sjY8mor8a5rwTYyaWZJz92GDe3pdlhUM7PwQq9YRexrGJpHWUbgrmzfgeWpJ95a+jR
         TRkyLJHIzHSHgpSRSrnIGOX6QH05/RP8jSYkaHO9c6hO3VOvyalbR/9BscKLaeAcnONn
         d8enu0WEejuA82BnqYgojaRc6MEDlS6UuPe0NUZzcT4PPtk+2Km/+26LS/Ej3X/ucmxM
         gZKTyArcJxAKtNdcal1rLp0+Ey7hDxpGVhQue3u41DEwih24Vu1+E4/eYGiVdp8xqCeR
         iNuw==
X-Forwarded-Encrypted: i=1; AJvYcCUEjPTZ74FDeXu1my5bNI19P3l4eL0TaI/BCwMJ1dzP7PaWGXOdkN117n5vkPm42mrYdtrNqt1E+hsL/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpmWcqfpB9yZT2D+2eAZ31bXnApxyaeZT4vHwONN2v1RlHvL7
	5QXHnnpaqq2UGEz7aOwSM9VgzSNFYcCe+uOHqKQfcmky39dNSjpOk6LRCoE8KTY4aIO+/fIgiPw
	pHGo=
X-Google-Smtp-Source: AGHT+IEDFtvqKJU90m5AA91LpMTZ9QDZ0BjUUamePZt3dL/HFuIcT55OAkVEPPQj6J+2dikPSG9GAA==
X-Received: by 2002:a05:6602:490:b0:835:3ec0:9 with SMTP id ca18e2360f4ac-83b71a1b34cmr1024242639f.15.1730741736158;
        Mon, 04 Nov 2024 09:35:36 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a44a7sm2000870173.154.2024.11.04.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:35:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20241104073955.112324-1-hch@lst.de>
References: <20241104073955.112324-1-hch@lst.de>
Subject: Re: pre-calculate max_zone_append_sectors
Message-Id: <173074173496.399771.10785874317568086791.b4-ty@kernel.dk>
Date: Mon, 04 Nov 2024 10:35:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Nov 2024 08:39:30 +0100, Christoph Hellwig wrote:
> this series makes max_zone_append behave like the other queue limits in
> that the final value to be used for splitting is pre-calculated.
> 
> Diffstat
>  block/blk-core.c               |    2 +-
>  block/blk-merge.c              |    3 +--
>  block/blk-settings.c           |   25 ++++++++++++-------------
>  block/blk-sysfs.c              |   17 +++--------------
>  block/blk-zoned.c              |    6 ------
>  drivers/block/null_blk/zoned.c |    2 +-
>  drivers/block/ublk_drv.c       |    2 +-
>  drivers/block/virtio_blk.c     |    2 +-
>  drivers/md/dm-zone.c           |    4 ++--
>  drivers/nvme/host/multipath.c  |    2 +-
>  drivers/nvme/host/zns.c        |    2 +-
>  drivers/scsi/sd_zbc.c          |    2 --
>  include/linux/blkdev.h         |   21 +++------------------
>  13 files changed, 27 insertions(+), 63 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: remove the max_zone_append_sectors check in blk_revalidate_disk_zones
      (no commit info)
[2/2] block: pre-calculate max_zone_append_sectors
      (no commit info)

Best regards,
-- 
Jens Axboe



