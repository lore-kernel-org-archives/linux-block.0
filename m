Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D04B049B
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838528; cv=none; b=bj5Lc1rd76aomS7oENnrlxFUzJONbB7/Wwm4e0qwQ2DzRhLJ8EqzVuyoEkiHxb/TQ0BfTbEi2ZkYmv0sJ9l4ToDOqATEsSM/0R/u4Sqxdxhu2i41y7kN6Zb7h85tSZiHOnZmST9ckSfv6eJmSFuQnI9f+l7bQa+5Qg4Rrvv9p68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838528; c=relaxed/simple;
	bh=OORmAZmJWGiMm69GtVa9hDhtzXz2K80ut5LE17ZEmc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MLrM2dGOyzaBKS33rqxsyf2o3ExOlkZPn2uVq5XrJ6OHZbZsz0a27PkOKHhpCyQmkKS0d/aNDGbrtpzCOGAsP0t4yMf6696RVs5g4DTpSAPUVIvVouq7Ud4YyX0CYwR+92Oj7sIxk+j58Tyf/Iy/6iN0WGs5vZ8TczNWjLnJy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mTJTOhHS; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mTJTOhHS"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b21f09ec76so1187613b6e.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838525; x=1787443325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHgPxko6KRiiZJ52ZI5YbS5E5wxJwWwr2l1h2aFkbbs=;
        b=mTJTOhHSYJu+a5lyu/P+p2fmAY0nW2fIhaVSksfdZlRUT48W37DNzkxTdUGUYdd4sJ
         U0Mi54e6umsoLro4e/eel0o+IVVnCnRsDV/rmMip4uwE/+bR9slzRARe4rxIY4fVRqCZ
         TXVYwSCaybbwk6gZFCn3irc4b6CPxbfamNdSxvcseffGe2EPBIDsjY3B6DFAf6osWrQG
         fg2lRgJfBkvGmy3gbGVXbuHioEVxJtQAed6I0e7oTbCQFx1JOhAiSCJGrYjHO3vqqGqt
         vOVAXPCrBxnpCrYfNRFUt4r8tXJGgrs//kDeaX4neVPLS5W6K5EW0EfKa6aRH31I1kBZ
         Scyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838525; x=1787443325;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHgPxko6KRiiZJ52ZI5YbS5E5wxJwWwr2l1h2aFkbbs=;
        b=tVSDtLL6G3r3p4Pnf0544P4uZRyIjPkI20Rh2YPuQgQcuSTMh1obPH3VSWXA7mH/YY
         JY22Z1pXaYdDMCFhDA43s5q+QLgP1hDBY3hV1wz/QK0WY7IHk8WXnP9Dr6/alRzjSF+8
         /VeK0PLIwZdvk/hfRjVMMu0IMnFgtmcQr5bElXDxq5RqcDM9N+rU0GkP+vhGf3FsRWYT
         gWw/R4+oZsmqOJWZhXOjah/JjPDMLINA13KeRgn3JHEuTBrx3TZypXFUVf9pP4muX6Go
         W4Vj6U6d8Rb4Q1MbAlwDXuqSyqoeTQcDJosMPY0b0QqayKWkDCRoa9Y4KCHk97oAYaOk
         TKzQ==
X-Gm-Message-State: AOJu0Yye+klKkiWlLGRwn/gPMaz9gLR28KRTZxhZ9pRl6wDDT6Ec9kEb
	EuKsbPysxxauQlf/C82R+p2eVo38Rju3pf79mHdZqawl285tIJKqW5oiK/R7CxfyHW0=
X-Gm-Gg: AR+sD10us1HroSY8Fq2a5PsbjxDgF4IvLocroC6bkNAmvV3aZaDqU9Ccoo4MO+X1tlp
	fntd36xRInryCorzTLo176hetUZuWE9AwQtnsUqBs/emkR37BCF+AXWmIY/TR3M1WXH1YjTaisq
	gGfull5ghFjdL8ONeOITCs+N5vJ/GBEnh/+53e8EDjUVQ+kY7xPNfPi7Eap0uQ/aVuokOSffyjz
	Ezblp/3rBmzdYMxUw+QltkHmIW6uxvf0VaUF52yt3rSr8vIwAZMSdT+3dn8nN2OhURvz+WXA47c
	90/VigZT+fyBfpmiNQ44h9+Lql/m4UEoNOvN3ZB9U71h+srIVFxsZHSPnBRGwaNKpu+CAeWKEf7
	j/qOE3uIWmeU5QxObrwtMgT6WmUJP+zQ9IaZZQjO8/0v7tkamd4H0ICBmEI0fwdIvx6n8eVmOuy
	RaW25wbyr6hJFMoTGyGXM6foLsuu98CwHoL4iv0V+vaTRTo9Vo68O2UMKXU/zJb/Ng/rXebDn9E
	ZIte4wGLE1nMNtRNncgGnORv3OQQklLaUR7pi8Bzg==
X-Received: by 2002:a05:6808:c3cb:b0:487:61da:70fb with SMTP id 5614622812f47-4b241ccc82fmr13929586b6e.10.1786838525664;
        Sat, 15 Aug 2026 17:02:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, 
 syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com, 
 Hannes Reinecke <hare@kernel.org>
In-Reply-To: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
References: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
Subject: Re: [PATCH] loop: Fix recently introduced lock inversion
Message-Id: <178683852226.1984298.825035093635787568.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 13 Aug 2026 16:14:20 +0000, Bart Van Assche wrote:
> All block driver code except loop_set_dio() calls
> queue_limits_start_update() before it freezes the request queue. Make
> loop_set_dio() follow this convention. This patch fixes the following
> lockdep complaint:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 7.2.0-rc5-dbg #11 Not tainted
> ------------------------------------------------------
> losetup/2924 is trying to acquire lock:
> ffff88816c76da68 (&q->limits_lock){+.+.}-{4:4}, at: loop_set_dio+0x318/0x720 [loop]
> 
> [...]

Applied, thanks!

[1/1] loop: Fix recently introduced lock inversion
      commit: 06a2ff603f1f22dd314e24c50092717b4b8c3ade

Best regards,
-- 
Jens Axboe



