Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D6281378
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539312; cv=none; b=PXRF7sOwQ/fL7SedkUskCIPefKQEkveJM9RjB3+hIOP48SUfwa0GdRPzkVAc9i/ZoJtOeyKUAN/Isa/sNUwCLx7RgQHSyyZcCLbfNiW7o88vB2kIxXYjTKNgIe+WZdmg7JEoD9n2E2AfoXA+GIrIjxS/3yzt1YBaJVtuErtwuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539312; c=relaxed/simple;
	bh=OVPjnk58sAjD6lOkuGzUJJpO1kIh8lZaHkx5IhvrZtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UB5Y2U78ZSaTysLcQfoOoYjHK5tNrKrroKpUnPQenPjAxat1XJgcLOzEIn2nXHsg39wmnO1g2ImKQaCvlZObrgFuaYkQP6/e37N94r6MmCb0GqGE64zbZoWp3clZVhA5El8rGiIFxoaJEMLMXwSHKzXO0ttA0AxOC/oXaimS4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zCMX9BV8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zCMX9BV8"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d8dcc7cd17so21267775ab.1
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539310; x=1747144110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRwZHtNGHxGz7cMvrbL9m58GvybK7jXmfwY4+sXkbgw=;
        b=zCMX9BV83SFWKSlTYBAc5Ld/F4xjQCCXETkNaMbyjohdjkmzfFXEnE5wv4ZabixElq
         LE/uawQXHmzSTpXSeJHCmrTlp7vZTlRfKxPvKKSI58zTWisiREEhDv8NrM3ixQAQlw1O
         Igqqe5iuhhCwOldBsLA104eh3eF9siBql4/XW1sd7Lpkw2T3NPcEZxAxOdAJNs82eGDX
         twLV/iAqlkjt9avTQybnrzh2CbbpZ2EF1C1KeP3pxd0/GHf+URyHSZdZNc66QnlluPbG
         +kFI+LPc2m3FEWXEBcDt9SqotZOA7Co2Lk23ZEl7V+V4Dstdyf0Q4yI0aj0C/rXRLOgd
         1xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539310; x=1747144110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRwZHtNGHxGz7cMvrbL9m58GvybK7jXmfwY4+sXkbgw=;
        b=A03XYndIMSAeyddCyUD2jZQvWR2oTiMgmeFYbbMtuOpN4g/24zUXc3i3jhwV+1xDYv
         mhfq9DByqTgLpAsiutLyrAes6aQXp2LXg4mrtdhYCPfBHPN6545xjTh9V/OYc37O93TN
         laQVbZbgNrmvD6XBK+FEPpuwJsVQFkWSdj93gwe0JiryxA3H9hVAVlArG/ANmzykzlzi
         2yOSPmbZyG2Ah0Qt67ovZDi6dZZGGtSoP+jp3BYzFImcOI3Tn/stNX1ENvtyG330yITT
         yWDZdTEPgfVPM1H151YatNdAHWffJG3bZ1RCupzQtpachEpNREO9p0SsATpTxNZ7wnOu
         2E6w==
X-Forwarded-Encrypted: i=1; AJvYcCUd2hBJ39CDy7yohdeOMP6e5VATTPZRxafBUCT91u7sVziTPjEpxMnF7SfkNB+w2ZiTwa0irqfs1/J1tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhYtePhznnjHu2gon5zwXxZgplQfySLQxhYkBb+uxHTpwViiB
	+l1XuoCHTUuBBnSU7SyZYZV4Tg52JIHYuD2Z3ZuNV1pYCArkeopJs5OFfMY+G9t2gmtjh7WyRlX
	y
X-Gm-Gg: ASbGncuH4Zfp45zAgqCJOgo1sCAIHOh4rLbxs/fB2/aqej8RFyzsFbeez9b7slaasnG
	GXgKNEhcCH8+dBlWDfd6ijkxBbSqgI+UWjHxuahGEn+RoPJgvCRx4kugQyzKU0r7kTP29cYhgxE
	FIkTDWZIdBIa7BUpYXtUP9BibvwhmfxFzd3A+fnJpJLD47Rejipb9JD24QlaV8unAodGLkQHRMu
	k7QMwXaNdw3VIozmtkbTxSCig9CB4PGm3bN8B0TkT8p3BF+eZLTCxjLnjtTfDZjCs8BtBrLSruN
	T/ZJoWDKYVKqmdtaq1FOKqbNMU3yCbE=
X-Google-Smtp-Source: AGHT+IGGqSGncuqW1b64SGmhcTd/a5TNB4SpKrKtCPeYxhkMeu4JIFWqNNk5EURazEX/1gBRwR8A9w==
X-Received: by 2002:a05:6e02:214f:b0:3d9:6e2d:c7fd with SMTP id e9e14a558f8ab-3da6ca65398mr42537515ab.2.1746539309978;
        Tue, 06 May 2025 06:48:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
 linux-block@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
References: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
Subject: Re: [PATCH] block: only update request sector if needed
Message-Id: <174653930862.1466231.6893702883914572134.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 06 May 2025 13:27:30 +0200, Johannes Thumshirn wrote:
> In case of a ZONE APPEND write, regardless of native ZONE APPEND or the
> emulation layer in the zone write plugging code, the sector the data got
> written to by the device needs to be updated in the bio.
> 
> At the moment, this is done for every native ZONE APPEND write and every
> request that is flagged with 'BIO_ZONE_WRITE_PLUGGING'. But thus
> superfluously updates the sector for regular writes to a zoned block
> device.
> 
> [...]

Applied, thanks!

[1/1] block: only update request sector if needed
      commit: 3bb6e35632fed829a36c68385811217a9e8072a8

Best regards,
-- 
Jens Axboe



