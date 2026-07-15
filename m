Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA13C98BE
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154879; cv=none; b=huijsgWgI4JSgMKOadTXhqg0Gbjnylw2C04xtE5D/nXp7H1YKG7vMwtSW+DKA8qsSw4hXQNXt8EFUxC0Xg9n53VxYRWpxngeO20fUrNsqDmzV7IkewRidzVP6elIYJ1f1yJ5k6yh6qcObJdcsXNvGivypOgohk5Ujzqj4WapnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154879; c=relaxed/simple;
	bh=GIdlQuIjDuIzsJqtcE3kFuAvSVLoG9tPGeZwKd7I/wQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sagPqWiIdzvSAgkwIKlu8Yxfek8JXphQsl0X21C506yRUoUnw0Xu8F7oWiIiMjPIdQgSuTARt8J6i84yisTpkXGvjZJBqj4/dPQjcuHF37gaKc7vo3EQIUnJEx9K+2Rq/njLs1G5eMGSjJmmbRLxyTUMzLmkX7e3LCGZWDVtNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=0roWetlT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="0roWetlT"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1519773fac.3
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784154877; x=1784759677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XggqMlUurXEr1KQCtY04ORi5k4fbc/Vyu3AcdPcPDs=;
        b=0roWetlTJ6EipKRfJISFaLjbWTkKGqMjqR6GR7UKoZxG+MVrSzMq9jjQgMPedkNlIp
         4iAHKuRZmduwR0jvx+8zVpgkkeAY1RPMvIzmFcKRcitNmX4ooYVMxhTU8yN/ymNHuytp
         z4exdlJotnQoT7hM+6PF+58x80kN8DvDKtJ2GeodK62B8+NINgIZqj3jyc43yWOfxfLT
         COL4XImIpdlDSx7gbsq8mvQb1CsJ+jYIHHEpNoOg5u+Xi3vIhfG8KQkGI5tlNLCJ/943
         XRNe5clshOHbhKs7H/XHwCBSGWF2KCD7MpHO0ASYIJHxlbybEZGmKwrrEzf2tbFI/bKW
         tLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154877; x=1784759677;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XggqMlUurXEr1KQCtY04ORi5k4fbc/Vyu3AcdPcPDs=;
        b=rdQl2k3a4x3sAquUBWK/iL0QNuCma94XYcOb9KeChWKOW+2FYZI8RMs4jTj/vKsKEe
         r2ULSq/TxNhrqMMmYszJpNrt6OpYdXZxuCvpO5YajAIqh/zjmjaDUCU80forzHuv4zbG
         tqsZXrjoDQOq+HU5vEbFp7E7IqUpNks4Pod6C5BraixsrE+12oh3qnwmKfJh2K+SedzC
         nF8xzqt9PNfJAo8a/2uUz8nsNFsbsWDztqDSC3ZcCWL6puigUwcCnYiD9BL8D16drlel
         bTaO5gQGNNts4h9qHtzPfR0rjzsDwplgpnKNsro0GL6HSv1JvAh6q760ZY8S+QGMeSzO
         sR3A==
X-Gm-Message-State: AOJu0YzVKrMF7g68PJGEd0k+dUP+3lNKnhCf8W8HUC9fFYY0VWw3FJk6
	wdc0IbhZrXq9YGQhyfsQfsXNHUS9Wu8axqkAtMISU3KnbxJdAgo2v2nBH0CVKWZZKCc=
X-Gm-Gg: AfdE7clgRb8RQqC6a5uIw5zg1GTx2f/CMaVHp1nr/qmVV7hX79G8uVk4arfO7EyZHUT
	uiIETCGGCUGW7WgCVO6BDxzUPjGziOAcowfesnyHytV3/817s8OgTzEfiqheLCkO/eJGG/umega
	tTM4hW7zKBFCO3G/Apn7/lK9WvAgE3HE9ObgmvKmfEvGZGZihfW4e6KEp1UFL6LbUzUaC/XsvpM
	GzWHdaXEJR346E/k9GzVCa8av6HB4GytR64GPfGF1PpTjwUoJ4BzrpW7PyzqX0HX1kP/1h6xbTY
	tgC1m/rx49Vb2iqwILzUN2fzoSW0lN7PyDlNod7g0R8BsY6KB1LgZRN4+6X0XiQTNodeyWUjWrc
	ZG70fYQgEHFyQLIg2LcKwL0eD6jnp7Ys+I1xrS8lO+6kSeV/vHFWHyJp4gxffNUHnkjXR/2aMj6
	f2k1iaQEJTs8C1tO+ktuNVeNt3PxfJNPIEm67TH1QHY8F5sO5a6DMPG5M=
X-Received: by 2002:a05:6871:8788:b0:448:c6ce:9617 with SMTP id 586e51a60fabf-451f0fc79fdmr10720122fac.5.1784154876738;
        Wed, 15 Jul 2026 15:34:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45200b7b4c5sm14362722fac.10.2026.07.15.15.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:34:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, Daan De Meyer <daan@amutable.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <oliver.sang@intel.com>
In-Reply-To: <20260715-b4-loop-partition-cleanup-v1-1-b9f59910cd1e@amutable.com>
References: <20260715-b4-loop-partition-cleanup-v1-1-b9f59910cd1e@amutable.com>
Subject: Re: [PATCH] loop: remove manually added partitions on detach
Message-Id: <178415487567.159585.4815884092425440929.b4-ty@b4>
Date: Wed, 15 Jul 2026 16:34:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 21:39:57 +0200, Daan De Meyer wrote:
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from
> setting GD_NEED_PART_SCAN because loop devices with LO_FLAGS_PARTSCAN
> rescan partitions explicitly. However, partitions can also be added
> manually with BLKPG while LO_FLAGS_PARTSCAN is clear.
> 
> When such a loop device is detached, __loop_clr_fd() skips
> bdev_disk_changed(). Without GD_NEED_PART_SCAN, reopening the unbound
> device no longer performs the previous lazy cleanup, leaving dead
> partition devices behind. A subsequent LOOP_CONFIGURE can then fail its
> partition scan with -EBUSY, as seen in blktests loop/009 after loop/008.
> 
> [...]

Applied, thanks!

[1/1] loop: remove manually added partitions on detach
      commit: c4f4c0fc551cbcdccbbbc2d874d7d6440c7b4983

Best regards,
-- 
Jens Axboe



