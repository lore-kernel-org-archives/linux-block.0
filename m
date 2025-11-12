Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F921CFF7
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981547; cv=none; b=GhxJ0Pe4839qFQfbsWMp83DD523KXTrDfFBqTNPCArFqqgyun1HfuvzIfYwDjd7Ok2DFCOohQxael3IzAQqYj5gtidz+aUOMGxRZAHYkD5oLyrrIr2gAHbpr2pozBC5bJTrcW3GPhZCbvztBwmz+1jMyNCPe9fd/ITZEqSU65Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981547; c=relaxed/simple;
	bh=YLo0F0mD5DlBszAkApGWQdfHw2Wq/ParPfCJui06MFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RHF+QIRPxQIPIorO7SLrN/ZLzj/fpxvu3+uEYc/XVQScfnZge/5XOck2uvBSx8Q3UM3kFg75xoGtIYnywVW6OsfiMoLi03tzYSD76sbvC+2APtiCQNUzo6mXfil2FyYTs+fVeRi+WCNLrz777QskuAVhtv4WmCT3WuTKzYQMm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z7Bht+lZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z7Bht+lZ"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso666025ab.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762981543; x=1763586343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrPRJiGa+26hHG4lv0VXP2dVW59pB51KcUPOcLNvo4I=;
        b=z7Bht+lZjlcZkm9Lq/OJ8/v0BeclG4DR4n7yrejKAW+ag1cLiar025tzWk51/SE1kN
         ubYr6Pd28ylovTKW6msVW25iMXCL9zRltoFOC+TYjKf2Dw3bJ9pzGLlGaaPqtcaSMaWP
         qumjhpDeJgciE1dxtujcmeJBquV/WGBKcXz4o/uLMBgQVx/kt7mtEsWbKanrdx1hHYjg
         fTbEJEy6iZFr5qmtVYgCq4GCX7601mmF+U7yqrqqnKhZ6C0e9x2VrrOcB1+fDcdPcVjG
         LUvngRWhEf5TGpgA6rgJ4ThPruguno7bkXEOXvujYi9/Du+7xno2mwQwi7Gt/1PzLV3D
         05eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981543; x=1763586343;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrPRJiGa+26hHG4lv0VXP2dVW59pB51KcUPOcLNvo4I=;
        b=fyq6QSjAG6O+oeT22gcHvSc+eBlWNmUOQa2wHmiDuak2ViyjfEme489ctR3U314rWP
         K2+o0K2jWH65Y9E7KLISQHWIALCxyng7Md1lw/gNfzaEV5hHohzpvmM+QiXEnn1tkI0q
         SvYy2jTdcItGm4kK7vKgYtsg52TarShuYS0k2E3hg/m98FnMUFxLuBeMmMEqyf5Zfs3e
         iXZ0D87FB2I2uIJsb6816d+NXiiosrsl4D9oLE5KYG6fNwWd0J5vqC1zPFLynIF1Ouih
         fCQc3NJYmo8A27yT5kcx3waCh5gMzdvkyJQ4ASr4Tnb/4KLYdmdQXVj+nVuIDILw9pCt
         Sn5w==
X-Gm-Message-State: AOJu0YwJ4QtmaPL6TWUXViQklqc804GymCdYs9VyldqEStdkiLHgPzXr
	SRJeocy4KPgcP9EiT2hx7Zn1Isz1bkj6WV4LxvqTzIeYlO6+gRMoBXPZ8FlfDg+bTkWYiK153PK
	V0LpD
X-Gm-Gg: ASbGncsvGWhPUEJZ0r8Rx8i2kLA+UPqL4pF7Ir+4vOhMIx2er4KiTZk4wZb2bsMHiES
	cj1KMF2foD4HL7Fz6sIj+5t9NY0qTWmc4NaU20cGOv5j2jI0DVAGr18aNA0N8T7egXn5MOYKLL5
	hU7lvvqUgRWdiaS5oYs2Jarft8iF/ohIsfORCM3oLeaPgLQnEnVpbX1fUVsDZJjLL5pvidGvBr4
	pxax2AtOf4DdzTGHW5az8+A3Wd333RD246OuMMsy24TizC+O3yDwm8NcR74YgGFRRWL19cjAEYn
	KcdTgWXUOENqVNXS++T/DsAus1N4hUOXwonp3NF1Uk6OnjHVcx2Krq3EmmqtXb6gloOkYP/uh2h
	k2ilLC/ugrBVn4ycuZXEYSx+SoMj84th2eAZ2ouN4Z0w4Vgq1nPJ+y6Q6jmODyiirstM=
X-Google-Smtp-Source: AGHT+IHeAQAU23KEbX4xwicPvzWRHUHBVK4jHhAtX3+Bkshzj2Ki9tRjT8sDLcJZQe+1pjzcIG9Ejw==
X-Received: by 2002:a05:6e02:330a:b0:433:2711:c5cc with SMTP id e9e14a558f8ab-43473db49d4mr68964025ab.32.1762981542682;
        Wed, 12 Nov 2025 13:05:42 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d55asm14486685ab.18.2025.11.12.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:05:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251111232903.953630-1-bvanassche@acm.org>
References: <20251111232903.953630-1-bvanassche@acm.org>
Subject: Re: [PATCH v2 0/3] Refactor blk_zone_wplug_handle_write()
Message-Id: <176298154147.89130.73445451656520455.b4-ty@kernel.dk>
Date: Wed, 12 Nov 2025 14:05:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 15:28:59 -0800, Bart Van Assche wrote:
> This series includes three small patches for the zoned block device code: a
> typo is fixed, a lockdep annotation is added and the code for handling zoned
> writes is made slightly easier to follow. Please consider these patches for the
> next merge window.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/3] blk-zoned: Fix a typo in a source code comment
      commit: fd0ae4754c7b2add72338b14ddc8c8ff5ffda426
[2/3] blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
      commit: faa3be1a61bfaace4c2bd57434de7b13347f9f31
[3/3] blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller
      commit: f233339188cd9b1a985fd8410d5811e920fdd4ef

Best regards,
-- 
Jens Axboe



