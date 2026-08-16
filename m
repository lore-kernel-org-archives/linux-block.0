Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A94B04B1
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838524; cv=none; b=npAgWHZf9d4OO4AB8CAufwLeoTRB5YYb7TxccPkHt2sGl4AbKOn/gyNXHazsvBZGI5s1vtvjKGqhTU/UZWrgi36suW1Xx2N2sJNFDh4H9ONP369MgEl2JfrPBLRUwVIYVl5R8U77sxMG5Z6fDwFbY3TmjFeKpqW0EMs0/qzD4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838524; c=relaxed/simple;
	bh=E3sBlEaU61QSuqT2GTZx4rPxZDI9KPqcQgU6Z8iCLCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JaGrv3BwNlrNfPdffJfxUEg1S64cdEtZBWutmljnqy8vg2sK+6+EHjpwqtiGL9pFIxnOzf6u4rDDtvRn8gqAc1bvJNIRsVqXw83iKcW0CsdNImiaWXuMRX3NsncTTjxg+658nbXjHyGzUchRw9VKafoRBRSooKiSWMci6CJZ1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Vx5+1Gko; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Vx5+1Gko"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af7283bf83so916484b6e.3
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838522; x=1787443322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tJUEdR6hdZfMROoVNOXaAOmkfprvm17z0Q20z1DxVg=;
        b=Vx5+1GkoEuCp54xtsI5cIITZKm2CvB3uOKQ3DcKGjFi5/yO4N4EE6GyUXoqjdktc69
         ShoVFpX9yjM39MpKh2TPGhU9U6oL3NDfuiSnGUBifUeOjqR+l5q1SE1J0XriP6s6HWMN
         Wictzjyg7v3Q84F3nt+aZEIVS1Kyzk3Py+eNwkHmBWE5cJ+TKgyOeQutkZ/MzS/1suUj
         uF/noYzuqkuu3n2mK2aPRTvkHBHgId035B5l60r5J5WlOa9E512YEfwy+5vXZqKq8okK
         yiqp4nfj7uUKG/yMb8MduoPCWUop+hThUVoVGbuRwZA5PuSFgFsffB/iaDMfz8IZ6x0u
         TWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838522; x=1787443322;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7tJUEdR6hdZfMROoVNOXaAOmkfprvm17z0Q20z1DxVg=;
        b=XjOCPBM03g+ihDnp1YcncbkzGgiAAOO1HDxgKp/wvx15OaFvd2lQQ+O2BqfvrtANXq
         xolW8jq2Twbz7/D1eEd5UQMrIoQ145SfJupOMLNwmXkXFxXzIHnscCOP4ofngNPv0sHD
         nLINkoe+aLhT9j/RKOQJ9oBbYCBSZkxghgYmlHBh3n3DIzvp+hxs98Dh1EwD4hYhgpjl
         SzXZliLCln3rWyH9sau+FzfEAD3aQ6IpSOFbYJx8geOWv/kGidVNKrIY4OLMeAs4oNgf
         5A9pNR7iqKQ87mdYMv3V39Fii6JtaJDqYJZYZbgVNiBZn0W2+7+i5g8oKOHV1lHFKGqZ
         CZAg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1KE2T+mL9CSIsQlDsVXjw2ZGmjPChmJg7ZK+1sflk/OMvp4x83zZIrCpg6ObGKzP8h9ZVWYT0vIcFcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywppc/3lfQLxUZDvJkJqTTYuwvmHDmEtfOdSIvZ/jDwrNDfyr4N
	x1oiuXe5BRIWMdmu/VsRKt0ByeRdoYdxizuDYK7wrII9U1NS5NuYgGScsYp8wQ3gm3o=
X-Gm-Gg: AR+sD12373jgFWLT2Bdj/bkMCl2dIiSRhdcaj+j2jEDWw69YGTub49mL8FODqsU35x6
	ClGBHGgT2RVjyKo+mPo62ENock7RLW4/fVDlky1wTMeV/0yyN94trXYH7YZgT5Bbyw9mrq8PXLf
	wlenMpxvjORUwjBw47ceFaoJWSbRByOigyyMWs59+YQDc8yUaqsxwE20rS5bFwGVnb2V/wnGOBm
	+vzMCZPL6GFmkStQ9slj9LDeXbx73iRONi+WWGfKFPWUvshZv2yjC7Md6NvNY6nIBuNf6/jgM0m
	0F6zTjhqiJiW7kpMrbmQp2BrHitdNNo/j9IYGcCfnFJ7pn5rVX0ad2UBc2QDpVXjYi1+dmsP6gD
	T8qh28l7vu+g//0Ue/z0OQxl1AOj1rZes1z3ol2YlvDLU39705vwz7G7oB9eDcab0Nsk1t5g6p7
	QaEWM12oBLFtY4uEYcFch2kUzpXBrFZWaQWFY9SZM6VsCwfsVU4XtbhUCYmyCRLuMbB4DS7CCOV
	Ji7YVhfWev/RTp6E2i+dB73cRJ0e5o+BO2HDERLaA==
X-Received: by 2002:a05:6808:220f:b0:496:3a1:e44f with SMTP id 5614622812f47-4b2412f2c27mr15232886b6e.6.1786838522072;
        Sat, 15 Aug 2026 17:02:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>
Cc: hare@suse.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com>
References: <PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v2 1/2] block: set QUEUE_FLAG_DYING unconditionally in
 blk_mark_disk_dead()
Message-Id: <178683851816.1984298.16963880204383175367.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 12 Aug 2026 11:59:04 +0000, 胡连勤 wrote:
> Disks created via blk_mq_alloc_disk_for_queue() (e.g. SCSI SD disks)
> do not have GD_OWNS_QUEUE set.  Currently __blk_mark_disk_dead() only
> sets QUEUE_FLAG_DYING when GD_OWNS_QUEUE is set, so for such disks
> blk_queue_enter() and __bio_queue_enter() cannot detect the dying
> state via blk_queue_dying() and remain blocked waiting for I/O that
> will never complete after surprise removal.
> 
> [...]

Applied, thanks!

[1/2] block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()
      commit: 7e9a46004b471eaf69b082c473d865316a4158e0

Best regards,
-- 
Jens Axboe



