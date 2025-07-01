Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA42BAF4
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387460; cv=none; b=TH8DoPVi5MiA2Fw7JOgPNuQEtm6jBcPdKE2LNYKyHbmWrYtb/3LX5jKXK7ZQc3x8eBzGjYSkefVhgBTpqk0ESV3HpCBOuY5s0y7X45og09K2E1eyBQDtOQrcbXm2IMUDdRni4BU0A1P8iSMSr8N4vm6XBKuxxo7zrwO6SYe00eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387460; c=relaxed/simple;
	bh=ccu6doF606i3anOKp0WzDRUWJMLOrwaZM1RVrtVnpd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtPZSik0wWhmUFVy2YwrzQNjT3s3dH3TzQ8lssEHtrS4Zbs1IlG6w+ZUtQ/qYvgqIgb2pza/nIML9r0L0ULyjVrHQYec7K+n51N+okfYqDIXxJbskjtWK1k+/WUgl89ZbEKArEYerO/dhHbxz0b696GSF0qXVKUblePbqJ1o418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zlcos8GL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zlcos8GL"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2eaf96c7579so2319285fac.3
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751387458; x=1751992258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+2FNWnu3aI1hBbZInqVaj9v9ytsHBTZW74r6v2b6BM=;
        b=Zlcos8GLVNTnx4j4NTQGjLQCCy25FLNv3qZ51Blkgf2mcPXDOqVEdCy+wk0iuv0jg4
         3+JyRIy9MicuitQ/0fJ9m0/i7K4yj4NHsEc2E5qWUMYBwF2DwV/Nm5SxDNVZQVPia/sU
         jtPOw6Qb37ugE5lNjCiHt+FsDTVuyYkjLFcePoB/Ycg8EwVFjIsqCZDdRncoDVLzw1M8
         osOM62dZYxtGKeDDX1Y7R9+sG54+3QT/GVGshP6IlR33e0payMLWIdahzFM3dxajGBYz
         0R95u7LH11hvTW/L2Jh254AUWABDKbim+yEX8zkskzO2MsjsJoXMWYvnyv2Qmyr8Q0HM
         KdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387458; x=1751992258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+2FNWnu3aI1hBbZInqVaj9v9ytsHBTZW74r6v2b6BM=;
        b=CSv2XA2EHparvBowmDSgCaSce8jJFNf+lVjP+I98oNp5DuTlOp+1th/d7jL0J1p5X+
         A0CgBaBqogqOu1JaPX7VaXovKROd7dqbSUypOAW0ByHjA0c4tCkKqF9p2Odv5+OvdJGh
         cNdA5qzB4QhKSTF7WUMsAKqz+g2mL7iw4I7OYJAeDeehEWyIeSQnctk310QPCZ+C+nON
         iQ3OCnaQSc0oE6EfEeBqrkVkJoMRUWaIpR3/Sv46rW1FdH/QGxbBxY7vDPGkDntaUywb
         a/bv9draVq0VjU0e8H1noRaEm7MuzZqNUHadzYUvc/0FDtPGqXMhIDwWCVhh6/rxmur9
         ncsQ==
X-Forwarded-Encrypted: i=1; AJvYcCURcJXLXrkspiT9ztcWkHK/B6CriMBOzncvo8+VsmqKTLVALWNFvyMQ8zIh0zC1BCF8ilH1mLs+BZAxZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytLZaJ4ZLs+ZH3ol4pwBW39A13e8fZcWFAQejtb/lgv2XQq5uJ
	eSZ0vC5uqNl9oj1uNNEfUD2wke8VRzI3eHI8SVZI8B072HrkV++lKgVmwspo3VvK0J02uEyL08O
	rqRr0
X-Gm-Gg: ASbGncvkBC1r8INNIQhTIOFCx06ymLhXw5Wv42+XFPLxw0hwfK3rIZJutBljBSeHjh0
	e4TuLLmpFg4b4sjcpCUtHy+TnILMw8jfiD9hk4TGBnYMi2SW8ZAo6er75+ndoEACe1tbAGePvUF
	a8fj+gNRdGgHWL2rsKnD3atD9Cao6bZt9gHibLjmZ03JPqsw1ixslg3SSsqh9CQvNQ1MpUEGMC0
	HxqWzSDfvAWurR4buYOOhMQ2xPkayctHtlwi6WZcMeFxTDqNTazHsORp5Q5QdKWYLgwiMmqny2X
	Eqv68Yv7NGhLuvNdB9B+iIXgXMrDosWxbqk1TbM+3rgOv11ochPAoS+Srg==
X-Google-Smtp-Source: AGHT+IGpJPyYM9iqExtSNLl1uBdGovogEv7fqGqaODKiiDJ0yDkdIcICzEP0BIRa0y/5LYk6VTWJoA==
X-Received: by 2002:a05:6870:3116:b0:2c2:3ae9:5b9c with SMTP id 586e51a60fabf-2efed453acamr14111876fac.2.1751387457693;
        Tue, 01 Jul 2025 09:30:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204a8b6aasm2515673173.92.2025.07.01.09.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:30:56 -0700 (PDT)
Message-ID: <20f07b3b-194a-4dfe-936e-0f159bf44485@kernel.dk>
Date: Tue, 1 Jul 2025 10:30:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird delay introduced in v6.16-rc only, possible regression
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e597d8c6-ed77-47ae-b030-1016727d6abe@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 3:45 PM, Qu Wenruo wrote:
> Hi,
> 
> Recently I'm hitting a very weird delay when doing development inside a x86_64 VM.
> 
> The dmesg shows the delay (10+ sec) between virtio blk and device-mapper:
> 
> [    3.651377] virtio_blk virtio4: 10/0/0 default/read/poll queues
> [    3.653075] virtio_scsi virtio2: 10/0/0 default/read/poll queues
> [    3.670269] virtio_blk virtio4: [vda] 83886080 512-byte logical blocks (42.9 GB/40.0 GiB)
> [    3.672096] scsi host6: Virtio SCSI HBA
> [    3.708452]  vda: vda1 vda2
> [    3.711073] virtio_blk virtio5: 10/0/0 default/read/poll queues
> [    3.729879] virtio_blk virtio5: [vdb] 167772160 512-byte logical blocks (85.9 GB/80.0 GiB)
> [    3.737535] virtio_blk virtio8: 10/0/0 default/read/poll queues
> [    3.747045] virtio_blk virtio8: [vdc] 83886080 512-byte logical blocks (42.9 GB/40.0 GiB)
> [   17.453833] device-mapper: uevent: version 1.0.3
> [   17.455689] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
> :: performing fsck on '/dev/os/root'
> /dev/mapper/os-root: clean, 240299/1048576 files, 3372218/4194304 blocks
> :: mounting '/dev/os/root' on real root
> [   17.871671] EXT4-fs (dm-0): mounted filesystem 00a85626-d289-4817-8183-ee828e221f76 r/w with ordered data mode. Quota mode: none.
> 
> The VM is running kernel based on upstream commit 78f4e737a53e ("Merge tag 'for-6.16/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm"), with a lot of extra btrfs patches.
> 
> 
> The v6.15 kernel from Archlinux is totally fine without any delay.
> 
> The v6.16-rc kernel may have some different configs, but the config is used for a long long time, way before v6.15, so it looks like it's something in the v6.16 cycle causing problems.
> 
> I can definitely do a bisection, but any clue would be appreciated.

Probably a good idea to go ahead with a bisect to help pin it down.

-- 
Jens Axboe
