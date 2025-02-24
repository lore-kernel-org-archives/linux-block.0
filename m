Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CF2571AD
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439106; cv=none; b=H+QFBDteoQQxXVXhwXeSJK+nxtbbEXLX0NZ5BD17dGrRCuZKZf94QIF2ceWO8lGSb1NAZSScO2jfP3J+zGUofpHagF6sVsh6iQCS+G6F8zeCYvh97jI211BABEeQu0NLGt68j1c/BMTGup9VXkpG/w6BttpeeCcjUbAAXjBerOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439106; c=relaxed/simple;
	bh=XD9bbo30uut2Rxt8J59fFtONQhxKdq/YUtfTVnvejJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A6aL3+nvC1DQknfSPWLyIIGTuVXkoLkVYnTqbnvbdEz92xAIwMDu1Mu6qQUd8PtDktUYX/0QZmnp9J4bPbUu/nH8rGRW97dZC8j9FlbRrTrS8xMTzwEy9JeL035Hc06OA0I/yduvC0LvrChHBvdEWmJ+BMgGE024HkUgOrqPom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b4+2lPcN; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b4+2lPcN"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-855a5aa9360so368275739f.0
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 15:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740439102; x=1741043902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM0eTbGjAXeGLJUlqCGDKcVkeHfdIvFuvL0ZJQFPvWI=;
        b=b4+2lPcNXKC/hcW34J//fxPGZFFWzAyWF0kIeAPS6Eq9XaFo+1Rlcoyyi/r/phKSmz
         HYb6K5VsnAWfZ4xcniVl5p49i85v7opWmTAFqepJLIu7HuIUgrGI4dBG+ASgyKWL8fXu
         IGUc/AQhrBsxcf8/aUoakJxLkw+8XV+ak1dvzW/r4GKthYI672GAma4t7Fb4zX9BLEEx
         gxcSFn7IRc/v8dkhV+AXuWICuJ0gUGuWu7pQkJ5O2zD2qJRLzngGfcRdlwHrTf2TbgXH
         r/mxhpzCa/PJp7GHOz95IZEuxuCkg4b0U5/0m/B7wnAqzETIuDkRxyv5jItAumbmAewt
         XphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439102; x=1741043902;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM0eTbGjAXeGLJUlqCGDKcVkeHfdIvFuvL0ZJQFPvWI=;
        b=CQNeqhcqsgGLRfLrbHjyCc752jr/1NdmD4TdkP9cldUfCRQC79YLTu8KRdbyzgJ13A
         pRb1vpvQS5NH+H5s5USS9EhSUl44+UCPvJl27mbKFCiEkHakesypiH/w6gh7P868sfgw
         +XsuyvK1mjr2RFth0sDTej4Mh44p2h383LzdL0yi5pDIaVPtnLmPDGLJS+hTnDrcC9XZ
         vHchA/6kAqBflpb3y7moDE/V5k7dBVFEgev2oyFGiLCBZbLhUVSqBMayK/ScLSQwGHTH
         FFmlnRQ/4cZNMYzfvnUPFhtLOBiC/4/ECP8d4i38hUv0L/ZJbcogLZMgu7ep1u6O+UqW
         zhCg==
X-Forwarded-Encrypted: i=1; AJvYcCUwoAjYHWJS9um4A3WBQQZCb5M9GeZpLhVbfojKS+ImKjhiwFjocminMd0cGQMDMq2Pa8qdxfwZ7Y55xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjG52iPYpxYagjCtkKiPU65TzYPCfylL15ZTRrw7d2Bm/XYBp
	Cnd54URbYzZYemugLRUyPNDF3oIt71iVkTgFlQSIwy8bBxDsRmjkY11Qb3f5sDdQIox98BDXWJa
	O
X-Gm-Gg: ASbGncv3B6TkRX+ByUEmS4UdpbyPQfIMQSJVZU6jSug6nLVqiQg1PiZJSj/AnA/qZUm
	dRGNiHyxEgX8wqCQ4wMU7exOpB4SfaAxfYzEUquEZXMu6stxxBrnlkRGL9Y9+uJgh2Oj8+3mfzw
	An5Tju27FhXYRsNv93vJ6OetOfVgUmkKm4gNKCug4JSq1AcyEEF/Kl9d4veCTgiwrjphaXdy9kA
	qNFOXNrj0NVpQCPg0zqbtWYc75Vy+tohFUMGH27V2GpHUDqgZ1Houan1oTT/Ina74X+BWBxqMeg
	F5JxkO2OMkk+M3T0+Q==
X-Google-Smtp-Source: AGHT+IFvFVTGRzgc0KiCRJ1rUY9VBu2Azc23fWqESL9L9lETWIhPDitPQnINL2VSAPa1z9ecrLErxA==
X-Received: by 2002:a05:6602:3423:b0:855:b3f6:c89f with SMTP id ca18e2360f4ac-856203b287fmr132749339f.10.1740439102420;
        Mon, 24 Feb 2025 15:18:22 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85620a3073dsm9481139f.24.2025.02.24.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:18:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
Subject: Re: loop: take the file system minimum dio alignment into account
 v2
Message-Id: <174043910107.2070348.11146556322408560811.b4-ty@kernel.dk>
Date: Mon, 24 Feb 2025 16:18:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 31 Jan 2025 13:00:37 +0100, Christoph Hellwig wrote:
> this series ensures that the loop device blocksize default also works on
> file systems that require a bigger direct I/O alignment than the logical
> block size of sb->s_bdev.
> 
> Changes since v1:
>  - also do the right thing when direct I/O is enabled through loop flag
>    and not by passing in a O_DIRECT FD
>  - minor cleanups to the calling convention of a helper
> 
> [...]

Applied, thanks!

[1/4] loop: factor out a loop_assign_backing_file helper
      commit: d278164832618bf2775c6a89e6434e2633de1eed
[2/4] loop: set LO_FLAGS_DIRECT_IO in loop_assign_backing_file
      commit: 984c2ab4b87c0db7c53c3b6a42be95f79f2aae89
[3/4] loop: check in LO_FLAGS_DIRECT_IO in loop_default_blocksize
      commit: f6f9e32fe1e454ae8ac0190b2c2bd6074914beec
[4/4] loop: take the file system minimum dio alignment into account
      commit: f4774e92aab85d9bb5c76463f220ad7ba535bb1c

Best regards,
-- 
Jens Axboe



