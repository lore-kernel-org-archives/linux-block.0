Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5D37BE81
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476835; cv=none; b=P4vkDHArA1+1jnfNfTHfk5Au1akVoEcjtoYsrurPUp0H823blkbToQAT+aoCB4Ulsyr0Hwb2MO6drneQkOLmVMFzr8vltTA7rBp1dAkj+YOLSti2+/RzqUn9dfbFglse8O6RvKwrcARy54BQcxIFPrT4+RXL+24oDmJYtb29wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476835; c=relaxed/simple;
	bh=tCyEQjSDFe00pC073JyzZXWfq7rYtgwZTd/CQrBOXkc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eg8vFlBWx18fgvfibPKa6pjc+mbzx0wXHRKdrjNUwxCfVAuX9jOr4jpM0guNuyvSyKqKImQtMuFNlJXlYV9TEgeJgRKjEuJXvQhn6S1wP2n+gts9i0PDzHS1kFLY+wMgSOqy0l1SnCyiBkt04BW86O0Wn8DqZZRnpcLa2UcWFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wEYiFBdL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wEYiFBdL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso13210745e9.0
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789476831; x=1790081631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PUxVwUgybIe5aew9mr5/6ByjFEeiMXlFl2uVKWwMuI=;
        b=wEYiFBdLzCsuITvcl3Xdpa3V4QGzg3OuEs0al4tiQ9hL04y0trk5HVqvNo4rSCMIV4
         HRzNmzrKLCcYlVyPQpMaxZrR8yX4MnKGzE2W/WHW3Uk7x4QqEr7pnjJ2ODsF/OO/Jwa+
         h4ao3xjm7pYhE8ZD7Qg53JXLiEmc+NvJjrPKaVrSnZciZjhgDe0NqIQ3YRb1uGFovXue
         RV/VKyAkcdFSm8kIS1C5wKI6HJHhRORXx8Q7OoUmiCmxxbkK/I6d5xg4kKHmB7Fny4BP
         mj2sXi5+A60tHMb/CTAx1KIB03LYdmtqZF4O/8a7iX02eoHPzXkIqYWnoHlLkTWHFvc2
         eMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476831; x=1790081631;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PUxVwUgybIe5aew9mr5/6ByjFEeiMXlFl2uVKWwMuI=;
        b=M5Qczr71oi9IYIK8x0Ng2FYzbhpdJUDbhc47n4xyCQPty38FPgiTXJMiLhOrbxBuDr
         Kc3XW5lgs7U9v6yqOKZEjsRnr8QtiEjrx6DAttdWXUL8tGZt+64pFGTjxJjKimC5Sjix
         LP8WJw+nE28+UXnabnBI/neKfsIveAZOXhzOyKvFKX7PNihsDakkrJPUYT8lRQ/h2zU3
         ZUCEa/24hA5+0W5w+qwcunn01IuBNQ0FKxWRBaTTHm5TGcd7FPEVW/Ywmgm0QBtN7WIN
         49aVMFf7nyNh4oefG22ZRDsdAKPp+5/HmaxkwnJ6EhL2hZhjWu5/R0XVBwSCBil8PY2l
         grMQ==
X-Forwarded-Encrypted: i=1; AKwUvByBMZ3Lzh49hL0zSBcMvd2qUcN31xQk5GGDyki5OqGxtoXrrvccufqOyLc7VhRTPWzrgEIMp9qSt/ebxw==@vger.kernel.org
X-Gm-Message-State: AFuF++lHStvJv8N5Ga8OFzv3WUQ6MPRCfnzvx0brd8GTe5IvADm9BKje
	KTuIpqAwRqR5hsww0B1l3yERvaHK6psBhxeEeUN5ykxdBzZ205pRQBSzvDdPy1XUZTCGXJXY2/6
	SAST9neJxDA==
X-Gm-Gg: AYBFou3THUL0SFWKpKy7BsD23QtmbyM55CUvT0bEUa7bt5cco1mj4y5UqHHXpvDrsXp
	NQ+IRv5SUpzC5A/VKHEmskQcnqOTxNj0GybN/TciUDWKdHiRnZNIcKsFwyemm+niNn+07oBI1mQ
	Jsc0iJbMqvho/SRgOybVoKwhjmsbBEQpJ74uc8bmeXBap9/ExqctgOS6AY2Ukd1ucbf775QlCxR
	Dx8iScXpXBCSz934StD4STymtnygbHKZYuSQG68tSL58KOmMitMXW/xkGdwmv+002qqqky5Tcb6
	d6vG3KLQaNW/6Ph9iaUx+I/+4djhbXN62q8ZFpODlfeHOsERQCiqd0cplGfj4KVUs10FY/Wdndc
	6I3uX4+l/oRNcVfpKdLOdLtnxTT0KYSM6anq1/0fyyw4WdtYSIAf29LV1TOVDZ+Mma9Bn5um1F/
	3XEs5fpvsri9qGTvvbNwlYqZP5kQy84vzHCvaKsGeOLfeL9+n1NKK+8q7CwFDjeHYp7hYvbTwnm
	PeWlVyQc1iO/REUn6lZI7TkGSXSwnPg2PMJcqLuTqnLduPbjClDtNcqBpQJ0QEC0QaexII/w2Tm
	E9TrgCglJ23DDEown1QW
X-Received: by 2002:a05:600c:3e0c:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49e7a67743fmr93863945e9.26.1789476831070;
        Tue, 15 Sep 2026 05:53:51 -0700 (PDT)
Received: from [127.0.0.1] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d28c734sm57627925e9.1.2026.09.15.05.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:53:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Zhenxian Ma <mzx199711@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 Zhenxian Ma <mazhenxian@xiaohongshu.com>
In-Reply-To: <cover.1786782832.git.mzx199711@gmail.com>
References: <cover.1786782832.git.mzx199711@gmail.com>
Subject: Re: [PATCH v2 0/2] block: avoid redundant flushes for O_DSYNC
 direct writes
Message-Id: <178947682983.1379494.5604562804194919219.b4-ty@b4>
Date: Tue, 15 Sep 2026 06:53:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 15 Aug 2026 17:06:51 +0800, Zhenxian Ma wrote:
> This series removes redundant cache flushes on the O_DIRECT | O_DSYNC
> write path to a block device, following Christoph's review of v1.
> 
>   Patch 1 skips generic_write_sync() when the direct write was already
>   made durable by REQ_FUA.
> 
>   Patch 2 stops setting REQ_FUA on synchronous O_DSYNC direct writes to
>   devices without FUA support, relying on generic_write_sync() instead
>   and avoiding per-bio POSTFLUSH emulation.  Asynchronous writes keep
>   REQ_FUA, since they cannot fall back to generic_write_sync().
> 
> [...]

Applied, thanks!

[1/2] block: skip redundant flush for O_DSYNC direct writes
      commit: bec7d36a6514153ded6ffe1323ab14912ced42df
[2/2] block: only use REQ_FUA for direct writes if the device supports it
      commit: 0d492f40c4ad7af7b1625fd81dd58a7978ab97f6

Best regards,
-- 
Jens Axboe



