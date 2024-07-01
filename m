Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84815A86E
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838412; cv=none; b=CZboopg+rBU0QAPqn47HB3EgYo9bSZGSyutyzLuZKXeZM5fSvYjspy9fTyDnc6xh6pE7rOlkaFCAQhdqi6MNxC8PtihcV3M8u0JapFWBji51Ns1g91DcH0kBvWucTd6JIlQCy9wr7nvdFj8WP2XGcVtZkkZ4xuk868aac9RxkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838412; c=relaxed/simple;
	bh=c5whlHHCbZabxJ/nGPaupq/1J4RzzZ6i9f4RWj061KY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=auzIMUvpwsDmyWva8iSx6Yk5MKmmhRLf3W0W9BCYKU0yp/MMwz602HoLt+biQi2pTPyrbgk6eO48Lnt+K2UU/7y1qM3g+VRTZd/H6bXsbaQtK3dICcPJoASmSZ4ghFhX4BraMfceFG2CDmE1CJy5S6rOJaikC8Tr+9STx7geivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pRnApJzh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pRnApJzh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7a480c146so578540a91.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2024 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719838409; x=1720443209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn96sL16xMTjEGY+KDMGbaKdAgdCeHEBQjOm3fWFWdA=;
        b=pRnApJzh0l4MZLOKinHhEEnqj0RvWtVAVfiqVAHIcIaHnX0f1z5lxOsK6vuhkboYJM
         o+z3R0GCATOKSEdmNzn/69qqETCKrn0XXo3q8fLk6rlJTIEDXj/QYrLjYMP01U9zsTnv
         LE2IXjowFXYEfdquIwOn+BU0E5q6109kC/QQt5zcZH84MECQdlXC/M2z2VSWWHavUI8O
         1TyhnYTQSTrzydrM6p3lScbUM9wq6BTaY28Mmxnsg7o2i5wQQauP8cpepJGbSEgDk983
         wqOfQkOfZGzjmYE8DlGk4wrDWpRdfGn68XFspxmhZatedstdD9HJK3D0hJ/T0nIePmCB
         Qusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719838409; x=1720443209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn96sL16xMTjEGY+KDMGbaKdAgdCeHEBQjOm3fWFWdA=;
        b=CH+ZEp5BjzPYdyfNx5AzJa96WptiS5FyFt0l25SpSufzm/SWlJm3gdPEfMh+i7IJwm
         o2CIBFhzXhnknfhrNXJh8zx77Cq+2Y+V+G3L6JNLe+3JOkL+VpLsZeS/XbCNUBLJRgV3
         xwoOwwLdct8u0xdRYR5/EnBF/mLOhg/9rDMIwGo7FTzp3TdOW+p33M2P+0iw2TKDNOKA
         L9fB9t1Hbj/VE816Cxww9ichjXtryNdkBJDTj8WUx3YPX7OEJdOvC3ZmmQYd2KPZAtl5
         IaDa0emh/V8s+XqpDLPOaofbRmJ1KdgK26ULHMC2EiQdgJBo3+V6Twyxc5oqdhRz6zaW
         UTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSt8DrzVwHX80Vs0powgwu5P0iMqLy9nQ/Qc9w8QlSFIpixMC8F5mD/Wa2CyomNFG2Mvx+m1nxeWT7cXOnq7KBWar1QoZC38z92vY=
X-Gm-Message-State: AOJu0Yytf+i+JGK71VbRe+21yjJHRPqpEfk3nCd9zClEXzbTgVMtXo07
	aEZPcOzo+2tmB1IIGGhYALqiE1JDab1p6iWcwwalBFL4DmL7Z2MP3yaJ/bh7wOSODsc/j/D2AL+
	Xm+Y=
X-Google-Smtp-Source: AGHT+IF/M2rq2rCBfYzi9F3zCZdGntRWmhfn9lWdC/EOhqP+6hOiG2RJprL5YE6Wf8HY38GAC8yAQw==
X-Received: by 2002:a17:90b:151:b0:2c7:dfb6:dbe9 with SMTP id 98e67ed59e1d1-2c93d7a0329mr5630186a91.4.1719838409371;
        Mon, 01 Jul 2024 05:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1a292sm6648820a91.7.2024.07.01.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:53:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
Subject: Re: io_opt fixups
Message-Id: <171983840808.13284.3309840121093222072.b4-ty@kernel.dk>
Date: Mon, 01 Jul 2024 06:53:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 01 Jul 2024 07:17:49 +0200, Christoph Hellwig wrote:
> I recently noticed that on my test VMs with the Qemu NVMe emulations I
> see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
> a one-LBA optimal write size, which is a bit silly.
> 
> This series handles this odd case properly both in the block layer and
> the nvme driver as a sort of defense in depth.
> 
> [...]

Applied, thanks!

[1/3] block: remove a duplicate io_min check in blk_validate_limits
      commit: f62e8edc0a9fda84fe5bf32d5f5874b489d6c301
[2/3] block: don't reduce max_sectors based on io_opt
      commit: 37105615f73125cb0466c09796f277a4c46d9295
[3/3] nvme: don't set io_opt if NOWS is zero
      commit: f3bf25d5135539603f24e377c6dec3016fbd9786

Best regards,
-- 
Jens Axboe



