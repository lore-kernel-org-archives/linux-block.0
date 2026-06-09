Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6A37AA7D
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021594; cv=none; b=AwWgd+yTrm9zZomn+dUHQYJo98rLUEgPbllIFAvlNbuBJAmQkKvKEWxLszKmsTsdtPorJp6EiZCdD+jCGeU9qMwlWjV4Sg3RlR3dujSqjKez8Azteserpb/E6OESUi9OC+jofRlf9Uw7n+CyRdhcHUGBPN2QDgd8UV2a3xVHJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021594; c=relaxed/simple;
	bh=vpW5PJghEiTw9Pq+RXKf8lkYnuoR+8+PrYc9Ipivzmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UgqCk5MdKzXRKTevmRU7Z/5V579os01s2NR4xhDySVY4TQ3u35qrWJv1TIVbY6yctdU8k8l9z5hq98jkOy9rUpihcnm5QvyN6U/wt2Ja5MP8oeb3y9Ex8u13zzmNsBosz1qYbDg4gpHLynOlZU83OG5FH4j1F9wQqar1XDMcr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=r2GGU0Vx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="r2GGU0Vx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69e9b037d82so1436044eaf.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781021591; x=1781626391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBWfZ1CbWmvzC+YOoCRLdxmgdDxI9buGTpdr6VHXZm8=;
        b=r2GGU0VxD6sgZ/MJXEE/1KL0ekEeJtleHxZXNzsHIEeM5a7nwSDfbXT4ZyzYKcHDjC
         11gfAuTPGqzLwPdn/RkB/cL8itIBqEDQCrU7PkBmF2VJ0dKXM2a1EHNDp0mtE/Mo7fpJ
         fXCa4wEOh4AN8vJvQyMa5vn4mT3KSfrddBPUmkle4GKRHzWuoHFcyuWJ2vjglCvAebC8
         XJYsP4+cxVSbmWXVPXM/J5Mh5qHZ8rvVaHx8Lu8uZUyH8CZDVWlPCHfL2PdXh4yx00jY
         xa1/TeSi1vTDeP5cFR85FHOLcn3B5fuaz/PMtzL+PSX0LdKkoW7sXbeIlN4hT3UnAtFi
         LcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021591; x=1781626391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBWfZ1CbWmvzC+YOoCRLdxmgdDxI9buGTpdr6VHXZm8=;
        b=h5F8i9t3Joh6MorbANJZFtVvOgVY+f9DdiZPYy0Syy6LyZEHltoPYu7m+jqMPZq0WB
         2dGWvGCtkn7LtL1PURke3PG8XyW0FjL+VQKrKh4KrKQf5gg0hIUeMCfQRa6E66ScPCAe
         D3f/sC9vsWgcIVbRh4IE9FpuV2H7uwWjRVBoYVi9sLaXVsiMjVVCCCBOVtIjBcwYzjrv
         YKV7iFQnNftwPVHjwMkN/9yzlTh8e1QuzR7vTDRJxQT3TaKqeLyfGt/AlIcRpPPDczc0
         KQT8CegjLUXfs8OBCiRhzS9lHAo1QUMfl47RAR0U6LX/2CjK4DcjrjhU22aE1caDaT+K
         3mZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rO8uusLs4XtCjOHX5gkuRXu2+7Ws+iFYe5miDpTP1O6pFwc4XCNlQahF0n78NDX83vGNaMWNgz0c39A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmPLAWS3w/XxQP0lUeotcCr0XnZq0ELvTZSB1aMjjVAM7RBvJ
	1w+T61WuH8lTxHYiVuFLNJrWVDbeajGymh3GiXy9EQ+qFAOEPDM9XwcfFXH/xmIOY10=
X-Gm-Gg: Acq92OFlx0xTuswldbCvNHUGxyXOE9c0fd46sEdUaSJ0zQW0CIdBvSzhSAvc26jZyuT
	3//Otj9m4xYfC2fPCs3X51jEKxqFP9xjzlSuYU9dcgrMM0iK1g7mg4LgScj961+lgJyLjic0WFY
	gY2r4WwAgPrYsL+O2+SLtfbCo5WiKEZMYzRbL7Hix15MH48w8JDG1MHpyAJ9R4sO6dxfckqeQbI
	KnYa2CdSvGu36DJOD/FC2y8UwdklsrmtxDn/c40+DRPlPnsG1JGzyUv7gHELs7FH03vgrkvQlk0
	Lb892/S96DOfpdwcBv+GxFtsytHeJIjYVjxZ+CyCiHG7co/22+G68pxTxZPuWpTQ2cDehrbU8El
	LMIhoubMycZQK6dsaIbrXJG78u1k3aOYeX+NYDNmOidjIei1lbt+SRki2HvzOZPTzqG2fI+Uj6M
	Zb4pKpTLw50AWjTQxpcdio2+efUd6wphOVFE1jek/aCbMCMYq/WpR+4RXQQEIJ4Nw/3EZ0Kf/p3
	UEhR906ZCHJow==
X-Received: by 2002:a05:6820:3084:b0:69e:461a:d845 with SMTP id 006d021491bc7-69eac8dab29mr2316673eaf.21.1781021591613;
        Tue, 09 Jun 2026 09:13:11 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8295aaasm19044837fac.9.2026.06.09.09.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:13:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, Tang Yizhou <yizhou.tang@shopee.com>
Cc: yukuai@fnnas.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
In-Reply-To: <20260526021555.359500-1-yizhou.tang@shopee.com>
References: <20260526021555.359500-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH v7] block: propagate in_flight to whole disk on
 partition I/O
Message-Id: <178102158990.1202168.3633326270232612056.b4-ty@b4>
Date: Tue, 09 Jun 2026 10:13:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 26 May 2026 10:15:55 +0800, Tang Yizhou wrote:
> Now when I/O is submitted to a partition, the per-CPU in_flight[]
> counter is incremented only on the partition's block_device, not on the
> underlying whole disk. This leads to a problem which can be shown by a
> fio test:
> 
> lsblk
>   NAME     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
>   mydev    252:1    0   20G  0 disk
>   └─mydev1 259:0    0   10G  0 part
> 
> [...]

Applied, thanks!

[1/1] block: propagate in_flight to whole disk on partition I/O
      commit: 5bdb8ec58b54b0e86672ba1991087611c7e52de5

Best regards,
-- 
Jens Axboe



