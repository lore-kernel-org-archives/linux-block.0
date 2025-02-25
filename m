Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CE14AD0D
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498202; cv=none; b=KD556J3OOwp6cBUSMtqUFEyRVmQtx4orG1LPu6kAkyFOASSxgOAtQOOUlRp1bJt4X+6xZIf2tDMM82ngVHTDZmdS7bz1bi0+atYLuQF8n5OuVSgA3aMQFlQTZeyN3S5REKzoQjc7own4v4XGjCoQhI6jDlomAwnudbZ6NIMDl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498202; c=relaxed/simple;
	bh=XBo2b8Y/XjGfeS2W60jlAc7RF0pRoC+2UgUyNhf7d7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f4M903zeTaJvWT/M+auuWtOOc1DYWE+8ZjOAoiXsnDvWai0+RWiSFYAsbX+gbrHT1x/gKt8GBq3UdOvSpVguXyknTqcrc/F5ueUlCoZnkcKitM5TwfTCpxEYVEuKxnxd7/DhlmG2FbOpJRGbxVR156oXEojxoa8Dcrt4iIAOQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=geBU0Ieb; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="geBU0Ieb"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d2a869d016so15585315ab.0
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740498198; x=1741102998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl25CRJLWpT7WhGCxrWJw/fYo0yTqJ1b9Z+lF5nq91k=;
        b=geBU0IebH3hsdN1D8JwHlbPJDD1bVmpSNNd62ycUU6rlxJx/3WYWfKo5F+aZ04niuC
         fegXXJj4/5HcpEFFj3D3WQlyL822Ejvv94CRz0gM6AJhdLYgbrCV+Gf9RtkJ7Krpj6Ml
         nEXE5m8iuL3fk0PXDxlbcPXtQpprlNfQ9LaqWsPN7KOV5GvNrO2Xw8WGs8HCz0FfwZqI
         BO53vNBwE9KgqieQSW9n1eBVbBasatRzHQ9PKZr4Dyofy5L5+wtMAq/w4vcRHYLVD/LX
         3l2tYlXwitONReFefJf1Gsom0CqMIPL7zjICO4Cuegp7KZ5DmC+GX9HbsFcY99eSI2iv
         /2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498198; x=1741102998;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl25CRJLWpT7WhGCxrWJw/fYo0yTqJ1b9Z+lF5nq91k=;
        b=fLHBQlUSQmEveH+Bfny1HIrxOKdPCdVeZDa+Fz5kY9IEkcQ+Wvw8/n6ugqRvTmh6pa
         FeDpEsi155agXEcE+cJVonOipYcBtqcSggjM0clFIgB6M+cNT6UXuwvPNOXMt8P+FEWU
         2Sk204iNGycYq9xEkcBXIOEhSlyPGa+3lmUfF2mTKVWS44t40OvUnU18BbDViTGx/Y1R
         HD8U4fzkyAboZxR0+33RI/rrGie6hGOAU52VJu3gFRHhlj7vdsszsQbqu5agYuSQAtxa
         gqYTzOCcK+iJAK7Ty1Ui9ZdkC+Y7K1lGNn/2hf9h96wjPp+mcq6du/9AGOWBmel+ip9B
         7H6g==
X-Gm-Message-State: AOJu0YzIT7OhsGR0ufx5+FTSRkRgb047fxVIBONH55hCatDa6jBbuTbq
	ajqXbl2jznXmLlh8aSD42cHIXcPzKTH77m3f6gwUnWP2gktnrS6niePlehklKyJjx/ouQtBvn+w
	D
X-Gm-Gg: ASbGncv3tTTNHRjLJPvLMA40ojtzanjNhe9Wq6s86V1ZfLdZvEY4ClKC17g6yndgpY3
	OnjJZc5cSfosSI53i/ejXVQYgp4PuebRNMXj+SVI8ENXkczwhCV3dxESfDwa4luyhlGGRrRZvo1
	YgRzqgW9iBbEv5lfQLwfU/b3PtFal5ddcvMt4JVCE0erQcKakpT7b1L8iq2FtmUWPeV5NHBNgsB
	LcZj5U4f09MDcZQHFvcQsZPjKAU/6+41SUe8ne2odKhcL8r9asrGSKtZf1qC0hbxJn71GJ4dXIn
	eXItM8GdbX99jOIw
X-Google-Smtp-Source: AGHT+IG4rwhFXrfhIMOAmsi1aiu231lRFp5Dq/dUnQQEyJ3pavhYWb2UFeK/ljuzQiuaNkhCO/X8gA==
X-Received: by 2002:a05:6e02:2148:b0:3d1:99bd:5503 with SMTP id e9e14a558f8ab-3d3d1f9882emr50935ab.14.1740498198145;
        Tue, 25 Feb 2025 07:43:18 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361653505sm3795245ab.23.2025.02.25.07.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:43:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Paul Bunyan <pbunyan@redhat.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250225022141.2154581-1-ming.lei@redhat.com>
References: <20250225022141.2154581-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-Id: <174049819700.2142921.1446847727971657823.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 08:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Tue, 25 Feb 2025 10:21:41 +0800, Ming Lei wrote:
> Using PAGE_SIZE as a minimum expected DMA segment size in consideration
> of devices which have a max DMA segment size of < 64k when used on 64k
> PAGE_SIZE systems leads to devices not being able to probe such as
> eMMC and Exynos UFS controller [0] [1] you can end up with a probe failure
> as follows:
> 
> WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0
> 
> [...]

Applied, thanks!

[1/1] block: make segment size limit workable for > 4K PAGE_SIZE
      commit: 889c57066ceee5e9172232da0608a8ac053bb6e5

Best regards,
-- 
Jens Axboe



