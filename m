Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA51A8403
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145068; cv=none; b=aOE1Mnq5f/bIw3t3nHQ/kMJ2ptxB5Ds60g9hW6Tw4HX4kSCfh0LylffUlTSuI+i5UUbWl3YgvWLHtIKJAWz+SrnlNL2840b/GYX+ypgDOltrHlxFt0hqk7PUXk4P/32AIg1RMniNnaGvAQ1KUyaSXAoNchAPbZkprlbZnqqdjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145068; c=relaxed/simple;
	bh=dVzqiFcZBuXVHk6HLMWLRs+HLmmoRxUiHymSqqkdtKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEWM1YRar/K249OJh2FlCEDZnn92D+FtOyope7ePM0FNX2CzxvhfvmZQ4QisGvg4SHWPJtl1HGxU/+VZweyUbXG77SVNtT9iWmhb2Gd9txwZUDeu2nkw7nX3rUnExKzSR8KGUID730yPILztSNpTTQaS0GEAo9dnHH/CWl4QTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cy5SqIRx; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cy5SqIRx"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e161a8b4so83520639f.0
        for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 12:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737145066; x=1737749866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLxmCJlbafkuvfH6Qxktog1C8CaKggnWioDyBY6DGok=;
        b=cy5SqIRxOOrAAMkFXaB48tuXdsVRPXOKBG8rPidnUBV1FuNohePGdLkA8rqmglQr0o
         ybm20a4V8tYfwpjDxzOcBtgRjRKgxfxt9d18TvpZhHtOpueWE3dSXt1wd5NwUIGS57zH
         p0CJRzRsGIQmWuno9Dv0ZDPXogP9cEHb64QJwTrAA9uI+aWxwcBjh4RLPOBPBtcdJc8F
         jqp1l4ReAe4LUgvgxFWenm5n48Dx277e2lsIAL5v/0GYLmPO7qbVsRINCpjyV88S/jSe
         nBhVIO0wMP/yR58gHTkbBhh0pf5KHSQnoe3PROTgx0/siLT8q0BcQ8aPM3vgYoLoInma
         ixiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737145066; x=1737749866;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLxmCJlbafkuvfH6Qxktog1C8CaKggnWioDyBY6DGok=;
        b=qZkNRVsgKprNersP6o+++K+96rGij3MmToVFIolD543M9W8XAW1cQIaSQFEJwObijS
         zRHGFgLitKS/dwpDRnP/1wehSZZOBKg47bn+SvGv/c0SQlhy7HeIaivRo8q4qsAqYFe4
         xZda9AneGnr/UQTRYjLlPKpuwgMO18Xcj6gcyRrUR9BEw3aEKXMZBzd0VXAMFk8XrW/i
         Ae3ImohIjRBpANDQYS6ob55VL0MaOStPYgD8tZRucod95ipG1536hqcFdHp0lfotpITc
         ITzBShb5OEmswRdvxoH4XErKzCDbB9Xm/5/e2oOIeXh3cLLoVVBext/SooH6V4yUqp9g
         /BdA==
X-Forwarded-Encrypted: i=1; AJvYcCUREE6rBx7ApfEWdek83wXe1lENE4QtuxR/v58w3NVNiuONGGZqvJA4HPPTANgpPO7/yjthsY19zOwBcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV45nE9XWJlFOWi7V8GHrBBIJSfvfbVELunhJPAAF0E08ZtTls
	Sq2T12i/aJhUZkZzO/mtioz32InNIetTFEIqdsIHB3zyop4xxk0B9kl14wb3H0w=
X-Gm-Gg: ASbGncsOh+0WKvJagJTmwWm8KT7JxVGG8itxqNoXoEgKPbiBl/B12JR3tLgztqoL5eB
	xSPyacENzdzUoWZlqdCId5AkCFSidTbRLvArJM7oaEJO7lBxzWnubslFlcsUhhy7TpFXFRp/qNU
	kFVZ7dtkIA48qsqbSnXyn23/5h5oMsZu87JSG5lPoZmexB+kJNGCt0KB0/nYfIeSUJuiZ7HiyQR
	8pf0PY+815Vkd+9PzVgmqqOR9ljKvf7CVP2/hFfi3mxL1Vl
X-Google-Smtp-Source: AGHT+IFKrGW/S+uGv2I4EYYiUbyKoOPoxLNw8UsgVKt5gU/rDXc3yKG6eiPIIz1vOQY4yFiQfe+oBQ==
X-Received: by 2002:a05:6e02:16cd:b0:3ce:f1b5:6d19 with SMTP id e9e14a558f8ab-3cf7447859dmr36866315ab.18.1737145065752;
        Fri, 17 Jan 2025 12:17:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cf71b441e5sm7336155ab.57.2025.01.17.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 12:17:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, mpatocka@redhat.com, hch@lst.de, 
 John Garry <john.g.garry@oracle.com>
Cc: song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org, 
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com, 
 martin.petersen@oracle.com, linux-block@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20250116170301.474130-1-john.g.garry@oracle.com>
References: <20250116170301.474130-1-john.g.garry@oracle.com>
Subject: Re: (subset) [PATCH RFC v2 0/8] device mapper atomic write support
Message-Id: <173714506441.181264.7271209320638609494.b4-ty@kernel.dk>
Date: Fri, 17 Jan 2025 13:17:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Thu, 16 Jan 2025 17:02:53 +0000, John Garry wrote:
> This series introduces initial device mapper atomic write support.
> 
> Since we already support stacking atomic writes limits, it's quite
> straightforward to support.
> 
> Personalities dm-linear, dm-stripe, and dm-raid1 are supported here, and
> more personalities could be supported in future.
> 
> [...]

Applied, thanks!

[1/8] block: Add common atomic writes enable flag
      commit: 6a7e17b22062c84a111d7073c67cc677c4190f32
[2/8] block: Don't trim an atomic write
      commit: 554b22864cc79e28cd65e3a6e1d0d1dfa8581c68

Best regards,
-- 
Jens Axboe



