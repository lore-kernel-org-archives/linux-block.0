Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A32749D6
	for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021588; cv=none; b=nXgD5Dyo/ArGYtvgAKkNT9xCOKMkn2exQXCpgRqCmd9ljvm3ztWtId1rXHIQrr/MApZ5XX7ocH3+STqapOjdpfMVrZ1mjGytpAZ+A9Wzuk+BCcrybF9o3ClyMXfz7/oC110bjeTWxbRcR0b4xv3D+dQKuKFNvEnYJ+JlVLA+5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021588; c=relaxed/simple;
	bh=9hKz0YlE5sEF/vCIrriEA8uj+7j8dfzU6rsLnooTvL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pWn7Yg2AKK/EYDy+ESdKNgxgGIf07FPQIzulrBnUZm8pKuL4oynlUkg6333XEd3B+VTiT4/PdMKMFkAfYmFz2xjp2ejXslTmbksWWBd+5E2GjSGcKI2dR6WEGTrGXTUlcZfTZS9LEfnLjcUAQvLCCHoK8+Yhf3X/OKc5yKl0s9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b2hXL2Wf; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b2hXL2Wf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7caf5314847so5834853a34.0
        for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767021586; x=1767626386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irnSD6CgsSgf53U6Y+/egPe34yR4vf5V/wX/ig9SSuI=;
        b=b2hXL2Wf9mePRnynlM9IySm9STQYEzpopwQ2zpbEhVZycUKxmHr5Khr0L3LUWn/JYx
         4Lozz4s80sLOtCqDLkcdbAtmVdc7oybbtPihAAoIkG+Ne2txq8GjbiLmyiL2ZjluExWf
         ffAODkAVxmBonGpzFLbs3Y2bw3DxAY4Gh6wkIfBwAEP0uam/3W6cYCH7PylKtkVu0Vmd
         tRqM0bbptdUCwtbEWP+znRKiz9251fTTWZijiphjiCNbQkUy9RAkqRSIUFG/FYB8Q8bU
         wVSZFm4Ruj03xLGIVKmGG4oFbwid8/hLEbnP6tKZC8AkOsrXHKrsel06xYxIe5MsL7u0
         MgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767021586; x=1767626386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irnSD6CgsSgf53U6Y+/egPe34yR4vf5V/wX/ig9SSuI=;
        b=iTcjpKs6ty3Kc1nbUHr6I8FO0ufqrt+JK1lHpmx9zzYIHn1vV0Sd79ZVH132iIQOq+
         hcfuD9fN2A4d/rYjvYcW1+O+m6dPIOhyKbTtnh1QZdI5OpfZpaNBLu2ZL/4WuboPBgz1
         DP9cLOoHBlvh1sAXg6mU7mCgDAxuhLVyMvg9rp2c05hiiG200+x/uTAlJa+YWO8Oov7A
         HINpwm55MbtEpAs4344iVnkmKwDGSKhumosnglGZh5W+oQw9chQgLLHam/x/T9Qz+p1o
         fYJ7MIj/HNbXzRtnxKKbGuDCjclT6xmjytbWX1tjMJ3Ii4lwH/lK1rUPJ5XKvfstiS4w
         05Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUwKMgxh2vzl/DZyD244/4CiRizzt2dNPUEN4Zl9x3QAk0ySFrSq09uOqAbNjkqs9hlJih3pvvzW+dVfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Zvkqtb7wkxeAE4vON/aEWPT7ASXApplo3/d3G11lN68pvC5T
	xTZAAi9iMaMrY5WOmXVFzMjr+BMz6AV8Pto3r3HFE3s7QNdJKAXahnoylaagpPqNjq2JLzNGiLc
	oFpmw
X-Gm-Gg: AY/fxX6hWwdwCSwaaVIwo2NYbiy7ZnRjmUfYY/9L20CtxA6XFD4ryYwKqrjvLU7DySe
	hH2VFEjhUmK59xI/08FqA0pCxbygi9y5Rg/voapmeIenmvxozC7G19X0swWfXr+d2ZEecGl5eKl
	sn2E6ZEZDfc2INRQmExTJLqXl9JCAmFibVrZDm16bhQ8PgVl422vQC+C1ZAzdduLz9bUBR9xjlk
	atIM/Bm8A9xUENnpN9far2teX1ZSYQGOt3iuE72uUF4X+pHhVX2zXIe38drFNYQk8buS7g5cKwH
	bYr0DldhPBRjbBrh6wB6/N4wwO5849O/w9DpOVE387hDxmrJbAkRjbVbjCnzvauQAdsTvN1hLTg
	R5aIqHl7mEsfGgnI3vOwjVFN9AVBX0zYMhthoLnUokbLEDARfvMbFj43NS6LERaZ5DnoDvTts3K
	XS6eI=
X-Google-Smtp-Source: AGHT+IH+3Cmic9K1ebyokljCYZKom3K2Sa8cUeN5BlUVC+hmDmyCYtsXap82Mh8gP3OFPeOK4v9kZQ==
X-Received: by 2002:a05:6830:264a:b0:7c7:60aa:6496 with SMTP id 46e09a7af769-7cc66a0bb00mr16932231a34.4.1767021585790;
        Mon, 29 Dec 2025 07:19:45 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673c32esm20939101a34.9.2025.12.29.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 07:19:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <71cd74099b2b8ab7b153b2ea15b53944189d014b.1767003948.git.christophe.jaillet@wanadoo.fr>
References: <71cd74099b2b8ab7b153b2ea15b53944189d014b.1767003948.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] null_blk: Constify struct configfs_item_operations and
 configfs_group_operations
Message-Id: <176702158486.237054.163427666901563233.b4-ty@kernel.dk>
Date: Mon, 29 Dec 2025 08:19:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 29 Dec 2025 11:26:07 +0100, Christophe JAILLET wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Applied, thanks!

[1/1] null_blk: Constify struct configfs_item_operations and configfs_group_operations
      commit: 9e371032cbf0c8fdc757df5510b55e824668b938

Best regards,
-- 
Jens Axboe



