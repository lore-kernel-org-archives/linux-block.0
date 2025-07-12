Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5201E51EB
	for <linux-block@vger.kernel.org>; Sat, 12 Jul 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752288009; cv=none; b=ZEsiVegMmT9qjuU4EiSsDr47KVOe3cWVY4NprfJLGxUlm03pyh4EDqsNY0xOnWby30FFk9ePZqZBwDaG+F476HlVuzf8hVbqjfqEnka6rmIEI8nnBZy2sDdPeUoOOtg9+VAF+PDDMVwQQQmW0s7M5XUIUOUWvri9mDBP0Aht0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752288009; c=relaxed/simple;
	bh=zpLNea46eqilpaXHIo3ln75NHPKf5uwXU7dO1N3gFWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FmV/Ic/2rMdMWcD5Kw/wgnpy4ubaTgWtFDPRjj8WhzWgSRX0I444LzVPkdegykXKBRKkDP2DCyAjpv5LX7LpOnpJo4XnQnbnAaSGl/lO7m14bEPiUYyL9M0SnZcI0gDkg3Z2tmZbZD+tIBrHcSL/mH/xlNDWTBYHP5GPdj1/GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bD3T+j/v; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bD3T+j/v"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8733548c627so96127639f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752288006; x=1752892806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4WImu2NtZSrJkqdjdhLHzSmNsrp14bAane9ntQopr8=;
        b=bD3T+j/v2y6zVjf5basTwu9vTyfO8gGAS1p6rFgBHVW+yw6535bl2frtNTYj+SmLNH
         O7oDpBHe+4uZ1d3NEZ3ik1z/EXPAgmzkibO1qZ2IazJuqk8N5W4Gpq0ddIYZ7iGBljMG
         S45Oh0/lNg+M60VjAMVuo1SccwcepSXm6aMzvK3Tf1QS/n1gm7A+VX6z0YFlC/JFSS02
         px2vnDrtHx2t2NZATHzRnzgRAPmioxQ7K3u3zQjI8S5cZCZquYAJf1a+ADxwyxSWeeQU
         fj3mRLAvKtWlaKFg01/UAJg+3Pc4UpRsRsB2I3Y39Hfnt1wUDSzgx+lyV/5bEyDYviGJ
         HTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752288006; x=1752892806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4WImu2NtZSrJkqdjdhLHzSmNsrp14bAane9ntQopr8=;
        b=EBBsGM3o5l0rEtH02g/Zx2WHYr14UL6g3vJkNB6bopg7cOUbIE3arWblpITShAYF/7
         ARCFqmbDsrMDp3r4xZIP0XGiq2kEkKobKWvtg0rvq6AQSMPqZ11Y0yQiNKuWzvoptLwc
         XtG91E7LTd4JxF+vslsdDp7Eg3QK0HPAaaEDq5CxZRfTTxoNXkcqaA11pCFf6kP3EYKR
         wqEhVwCIJvWJPzvHfMEw9t6a66pLl3X9DlFlINSpc+L4MbwoY+vzNthJR+s7h1IHkmzL
         fm/YzlDEUvbz5OHg7KjHu6X32L3vY04Bljs6XDR9dulCjP/+4BnuZH3De8KKBy42rC1Z
         SYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGxiaApHkLWfJLvp4KvunzZ/rEe8EW9mFaNz0HVAXcCm5IX2CdtpkmSNJd+ycZttP/QNEazZf4Dne+OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNQGqYAZfNfD8FdHsf8vh4EIyX85S2kXP4oHEFetyZjyGOw+7
	6BwQq2q549gfYrMoVcslEp1v9+BOqfLm4GVp4cvoRkFkYusm4Abb+c9MIDvpZYHVmuJUswtHPor
	69Myq
X-Gm-Gg: ASbGncvl5+Cyxi5u/V8OsLleogAcZCluf2XcOz7ok+C6kK2BR5FCOfap7ydNcF4dB+J
	mh6Jemp1nlYknyFfE07Cjunlh5VOecA2h6OyXg+r4Gi53oRJYYADEbFFmNQPU230bbzmMTK5Y7J
	QMDHfqVZ6qxJ0+MFBgme/lIo8tVTIxHl7AI6DTpE7YDWEKywyrdkV6vxV5o+43F37C9b+9ASMpW
	7DhztHTloyR3VQLDHYWgq1yp2mm2PS/qBLxcQMMSCxN3h4n1BUGvommx7wLc9gXqYU3YcIta3Vf
	1CnHl+9/BeivI9EyfF3HAtSTvnGl2+MTX8zeckXhQL5ZNSrQk8kt0NnRmaDXRR63+HQJiHSDeLd
	qvsD5/1nDgXiinQ==
X-Google-Smtp-Source: AGHT+IEpxYkdBcisV7HP3p3UR14Bkj/gzDXrJtNLWIvqBII+yXOz6A2rCxpTknGn2X7a/ulxOaJs8g==
X-Received: by 2002:a05:6602:1354:b0:876:d18f:fb06 with SMTP id ca18e2360f4ac-87977ea916amr685927139f.0.1752288006313;
        Fri, 11 Jul 2025 19:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc34395sm126333739f.32.2025.07.11.19.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 19:40:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
 syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
In-Reply-To: <20250711163202.19623-2-jack@suse.cz>
References: <20250711163202.19623-2-jack@suse.cz>
Subject: Re: [PATCH] loop: Avoid updating block size under exclusive owner
Message-Id: <175228800423.1597338.7519956192674264145.b4-ty@kernel.dk>
Date: Fri, 11 Jul 2025 20:40:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 11 Jul 2025 18:32:03 +0200, Jan Kara wrote:
> Syzbot came up with a reproducer where a loop device block size is
> changed underneath a mounted filesystem. This causes a mismatch between
> the block device block size and the block size stored in the superblock
> causing confusion in various places such as fs/buffer.c. The particular
> issue triggered by syzbot was a warning in __getblk_slow() due to
> requested buffer size not matching block device block size.
> 
> [...]

Applied, thanks!

[1/1] loop: Avoid updating block size under exclusive owner
      commit: 7e49538288e523427beedd26993d446afef1a6fb

Best regards,
-- 
Jens Axboe



