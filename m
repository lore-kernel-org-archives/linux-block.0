Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC63BFAEE
	for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258967; cv=none; b=t17q/4U8/SYxV5FsByKWBkpdPwN5zQ2a1j7RU1P6PuBTfNmK6YS92gR+tARDA1pMZpZ3LdZT3J5nX+H75LdO+kDIX8Vp6N8o2wuPQ5071Y4I+ewdbvrW8kw/gjQPcqswqfsSyMlISfUqgznh9LwOJ0rTlT6nM1ROjnC0zv94cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258967; c=relaxed/simple;
	bh=b/lwLchtB3+8tZDaht+Coeh/3wH+oEPNg88ZX6OrS84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlgJz9l1SGcDhjYmAouWGDY762XE5tp9Ep1JZDmM9SGipvCvyCA33PhdawVXu/wGU2+QpShBUANkNGVU++cDOkr7Q6knlBr7unOBFc0jx3mRJC6ABM19kmmGnR+VPcAvJnyGn0dEcJrySA1EdiWYWUSUgEtpf/E4CV6XGBglWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpNnyiEp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpNnyiEp"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53634b8328eso7807271cf.0
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792258965; x=1792863765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/lwLchtB3+8tZDaht+Coeh/3wH+oEPNg88ZX6OrS84=;
        b=EpNnyiEpcfCgN3J7gR+VxhAF896S4bQBtLvtrLJwklSmc3famuOsDCHoN5wp+PUYZt
         mqSmcUoJPGarmhD/xjcaHwOA6nJC+Ge7qYqLG1SCXd8y0ewOBJsXIrw4BgS2ebL/zxsD
         bteMk5oOG0vQ/N5AdlbTod2lLQdq7cXUzHKU1THixGbeJwGe5ifPTQFeCKY1iZBSnLis
         W9R5blxdIC4kiFnzdOh770T7OdpnM3xP8H1QbDHmk/dcbwaJPx2BfNJvo1EEu4V3ag1I
         GB/f0RHed63h0HJLlQ6CiTP30SjZlwwmUTQ4x3iW7NGruNDGpK7Ne1roP/zjGfFw3BbK
         4+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792258965; x=1792863765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/lwLchtB3+8tZDaht+Coeh/3wH+oEPNg88ZX6OrS84=;
        b=nCR8BMFkFUW+VdPFqXxKrdwvl4HcIo8icKU5i7EyTLC35m7vC5SRezAuh5kW/AhF4a
         3H++8zWmtCvYK1fNazDcYETuy5BJ067d8wICsoAg9sWhClhYhCaJqC4s4z+PEDxVhb2f
         XaXXOh5CUxFUEFsT0gjvdTCdqm7XXpJCbe0J3b6aMK8pKNcnyiBD6aL3jEVHM35kd2rg
         Pkat2bSKUrKW3pMg1PXhlQxOdtzbtp2Zchuno0A6wpBpOMwI7bV+agE46XzKTDyDdoCi
         DHw2BR3TVlGuT8EtV+/DePFrCzjeB9/kQYScnOCY73ydGFmDaXigMdxKAdgeeEdGsc0k
         H4ag==
X-Forwarded-Encrypted: i=1; AKwUvByczwpQF4vvxnkRThj0F0j4QknvmW1Iw2/CqeXjjT4VbtaPkFdLmas0C6G+fTCT0yrHA8VQ6w9JRDQ6+A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLtGz/Szkj9jwty/fRKgoP3qUQEa4OvJrYG4dLKgIkyYSvQWGWd
	Zn5QYz3Wk+tt0xc+WhD8uKl69vmJ0RjE52cJPtlw/O+xHu0z2OBnOw77xi1X+SSnorJk4Q==
X-Gm-Gg: AYBFou2yBeqlscEFovnVuM+HCD+zYJBXfRTqtE/z7GXKTCyILi0m/+xUDd8xiCc/sc0
	OqrLIK+kpFF24pH/uwDonX7+Q2mvXMzHcYiAae8cYWQBHEWI7jNWZVTFotg1izjuh2gRzLY3Prc
	CJXkB/qCiFpifhj5CZScj7/n87sUsDpDnE62qlX080Zj988BcO9h9Ki2zQhnap96bmm9mH3rZJp
	a4fS/FwayBl0RxwiqOuqeAGQETzDPLojQ2Q4EAU6ZGk62+YUJib3SUn5G3trPNMroZvdPXPYEft
	qXObKFrW4dmTVfcVIdF1FRntki/aoFXxKywwWGf0R59BA9HinIeDHz2CB/MDCLfGzW4rEghk0oa
	dgQyyI4rVvKh1I0jHe9gSzOXnSg7UyHvGig2nHnarDfs1mcPp7yLmAgVaQYoM/BQASUYYplVZya
	Rsc43A5ZV6M2ZuAOhArnO18Cj68LWXtMYxSDd4V3jyulKDjxEp8XoQHxvxtqGTWw6Cdwga
X-Received: by 2002:a05:622a:558c:b0:534:8eb0:3158 with SMTP id d75a77b69052e-53645c1e804mr45466761cf.5.1792258964648;
        Sat, 17 Oct 2026 10:42:44 -0700 (PDT)
Received: from debian.lan ([172.245.89.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5363c24f7b1sm37092681cf.24.2026.10.17.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 10:42:44 -0700 (PDT)
From: Maks Ivanov <mi9992828@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: Question about asynchronous blk-mq tag waiting for io_uring
Date: Sat, 17 Oct 2026 20:42:32 +0300
Message-ID: <20261017174233.456797-1-mi9992828@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008214137.1267424-1-mi9992828@gmail.com>
References: <20261008214137.1267424-1-mi9992828@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,=0D
=0D
Just following up on my question below.=0D
=0D
I need to submit a preliminary bachelor's thesis topic next week, so even a=
 brief indication of whether this problem is still relevant and worth inves=
tigating would be very helpful.=0D
=0D
Thanks,=0D
Maks Ivanov=0D
