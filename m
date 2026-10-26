Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052507;
	b=NjvH4zCwR/9eJsjS7q5wEqDSMnhFyVKg13AEdABBH9hXGk3TmHle5i1dEtCJ8PaZRTsm
	 TY4CIi299+8LKdMHvsJG6qrmtUhzW0ah3QLb0lnQFVhwIlH+ouMEcJK6wJeFbDq32VNzQ
	 0dB2a36zrpuBbqfZ16RuDV0ACVPK0u0NISM74sA+TP2r3Cs2qzk9DHxrxSLtldhH713dE
	 k25NviPjw7ciqBwgvb6zKhOih4IgpsucXaf5JGnfH7jCbG+fsq4FpPCbXThztiH3nON2c
	 qCqjgkJo4Gp1Gt6rNCbVh3MqdWju4jHM6/eWmpV2VTUyDQzM0MLKBlHXw6CKma11hNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jMc91yRqwLdM6D0hK7JmiPccEPADpL623k5VEJKckkU=;
	b=THCqOuaJKS2Xx2J36aflaWlFwb+68FwbJE2fPJgj1C4S1/S7alLa2n6Oo1y3GNayhCip
	 ELFjCc7PfP7jpVqMc9akCpGaLTTCVq/Hdz1R18RJsqxonwZVsfeaQXvs5gLuz8C+/hypb
	 UMP29Dc1osk2nM6zBdQcP4CrpIixSIlYGnnpeSrjnEwz+nEFj6baey2PB2MonQ9LClhg8
	 VbLNLRbv/mhHPnSdUI5zVKK+mEU2SxNdJKO8drPmGayMwEh/XLjiDchpNEPxd3yURN93C
	 Ig6p6wiuG0tFfcGnU+6HxLhd/C6kwtmLlO3hINvR9cHP/lzHzZgyhLXqBHV9oHjM/sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ag1B7Q49;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26D606A31A
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 22:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF26D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ag1B7Q49
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so14420545e9.2
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1793052505; x=1793657305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMc91yRqwLdM6D0hK7JmiPccEPADpL623k5VEJKckkU=;
        b=ag1B7Q49e3X8yMRZ4b8XjNgAz6LQ8SqzfAF1Er/ahM8I7U26iEQv/wlCymTXGnFoxU
         iqt66Ds2F2+lDpTm1TqrpJqCG6hIBO+suHCsbImQN7f5wENQOIijmu5eHMtQeXac9rhX
         8e7am3kvsapA90SSapkzedgHzU6L5kYCZZysXFY+mgr2j1y/7+kg4TEciMp4rVAJo8tZ
         IYHYfOnqnvMW5siwcnrPCoCVHRnRXJSCaKaNta2AMY4w+DnPpmJDhaYSFyOnUZMWwE8l
         +ZzAX4gP05+lc5m+MJnpCcsbcWSVz8Bl2b/uzh48TD8MV28DRkOwgyAJLzpasvEXyjKB
         /zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052505; x=1793657305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMc91yRqwLdM6D0hK7JmiPccEPADpL623k5VEJKckkU=;
        b=t0CHmsh9w0I/VPNvBYXUlFq83e3ptC5br1YD9mjoobYV9bbLL+NZgA9iL3Q9vEDcbh
         VSDSANpXoYPp/j3UpQ9fIhBKClJ+cAThVqOXlMCnj47FCTNiPDK1Cr9KkQ03r3D71A2B
         sqTZYurOfOVJYLHPFhfm3dpEQJzCx0eFssLYFAOrOTbOyqadF04fIl3L4w3j9Gg6MB1m
         Ok2xGD7knHb/iLHUrlyXBwsYIc0oXAmwlFfYYZtpfAF9yVhLOPdA1YbNn/bt0Btl/Njc
         4TkK98TUjPZnBMAoimA7hkuNcNC7rEeJORy9kNr8CAicTM2SxnUs9mdPwcRGd/d02Y4F
         yXhw==
X-Gm-Message-State: AFq9FYLfwLytHuYE6MoA3MpnBRKHDjIzckrb4Kmz3yq9Y/CDOBNSA9bV
	cVDCy/RXOffJhGl4Ovd0BPkIX/ntE3lsW+66uPsOpmMma6VE5vlCb2wntdEivPU10PA=
X-Gm-Gg: AYBFou0XH6gokLHPHjPIRJY7x4v2soYcPQSGr/+VvmJHXN/wSkDLfWOGSpkqRph1+RH
	dSQADWOKZUZcHQQQ35psWANmupkZkOw3ylmdSHyRvGZRPPtb1uJjUnvup/JQB4vvJQBKCJzLD6h
	ay34JNku+xgrszx8TZqH2HZprqHxkBcnL6poNOujxSxeWTNyUjYQNgS3mo5DFuWKVodgiKukmyi
	fwjVQITQrw0F3o+8yFbSYapEPydPW3s0bd/KEu7VOgDUcc1zLP3vm12bAL1T6VTxocz29tfuW7v
	d0i4wdErLWfP6Ke789YrgNYASMIDWtQTTJrC3mCII7AdUmQiuimJc29P4VHqinJ7fBn6vudkqCR
	EzWEfnZjZzeMWOrgOKVoY6uGpspLJ4FLioCmWzFKHBrrtgmAPuPHifp+qPeaO7r2dxYOW/kWLaF
	Qws5KjDAiXYO7vQa4Q3Fwd0LXinP/usqqnPFbIVH9uYlOhzQuQr6XzWyh0nLQfmSStvwhEwnUx9
	55wtH9kLud9py0+cYKan8Vm51k=
X-Received: by 2002:a05:600c:3f14:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4a35ac8ec61mr148967535e9.15.1793052505149;
        Mon, 26 Oct 2026 15:08:25 -0700 (PDT)
Received: from KernelVM ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm19365996f8f.38.2026.10.26.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:08:24 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	rdunlap@infradead.org
Subject: [PATCH 0/1] cdrom: new patch for inclusion
Date: Mon, 26 Oct 2026 22:08:22 +0000
Message-ID: <20261026220823.1162-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch from Randy Dunlap, which removes an
unnecessary header inclusion from include/linux/cdrom.h - I've build
and runtime tested this too.

Many thanks in advance.

Regards,
Phil

Randy Dunlap (1):
  cdrom: drop linux/fs.h from cdrom.h

 include/linux/cdrom.h | 1 -
 1 file changed, 1 deletion(-)

-- 
2.56.0

