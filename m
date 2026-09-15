Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2E3B5F48
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476842; cv=none; b=PkxJer9Wf+J7psnKtBX6Qeg/4TRhgXCFA9zRncyOZL1E9YBYJpzvfQqbkTYIlrRr2Pn3WI8wtHLZ89PqAEstcbwySyvOTbzXHBlQ5pZT17ek7G+S7ZbcBmaACX+GU7UbMjFJfAtN2cNVpOdOkG3VrPQIhbD/A/Hy7u7hF1MUbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476842; c=relaxed/simple;
	bh=S2RF6ZCnUMMbtUiJhrnixclGbnpKSitAmGaQHjFweR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AM+4jr7g+A5EoEKS9Gl9jmj3Fp5HMJcRjNOTBVX9FkA7FU72ckgFQR6gBFvB8HJqcR4wK1FP48uWTAVzMPIWu0u+mR0nGvMLrjtDGqsseMhBlOK2vzNOzA/BdM7PK/nwhOIrVbFDztXGAo8i//ITK4OZK2ZQEgGCrushOlZMTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=shu21HI5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="shu21HI5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso30381925e9.3
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789476839; x=1790081639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HC8VwZlokvzkUt8f4B6apIsYjucLeKK7TzBi5abSMlI=;
        b=shu21HI5wupIdjWEDTLUONUlmBbPOjQXwPhxAFj88ZsUldJa1+mVRgVamQ2JRySTij
         MGmAvy2f0TPoPdisNHUl3X/rclKEP0DRRndolXHun2iwq5Mqimv92iJ/sHU1SiT4xUmE
         GsnoEsp8Gzx3YvDKLQRqC4ziMadQEfXrhPmmuRxaVp9SyA6ILRtuGhiInqWqKp4mrTHU
         x9xmgudB7XQRlu7cm0HHeDVjvFpLenQ+LSG6k2wssQnTyvR5ertgXF7N0VKBK7XuGNcv
         ODiuqfcmruA/AsuD9tGbiXWjx1locE6/5bk+8FXb/uSivX3up2wXWRCbcAxbu36OaGU+
         9prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476839; x=1790081639;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HC8VwZlokvzkUt8f4B6apIsYjucLeKK7TzBi5abSMlI=;
        b=tu3KYxMXWWeyQkjWnXTBltDPM3XMhy51b4YQv62+uqOPOT6jSPbVJmzgG3ksdFKz3h
         1YjY8qY/RRvb0nJD2mgcM6UlXeOliKMPLnuHogL01qKwaBDOmcv/aT86gYj1qb8PhdDS
         0IvNA34RoBrUjhmrXHHkCetLQXpD0aAPhdZBAoJvFsXiNzhhtJSOrmr+HHrLaCQvx9k7
         EjEJ5MYOnJ0LS3rAyzP34Q9/dJqM0J63injLRnMC55T7u2whv1WrRjXlYaxD5Sbu0O2S
         nS/N3gxBAoH+IUf1s+y/bzmm8g/sVfjfTETyWFN+4GaVSa9NQ07iiYp9f7uSThzACu1w
         cTcg==
X-Gm-Message-State: AFuF++nn2I7ZEut6XRBfv2zQySHj7aSLsLCt7zmYvDffvFtAFNYnEzUI
	c6iAbQIlniFbinogCifoO3k2UvoVaw4Q0HKjZljtmPHpfEhMy/zodkW1FtY5OVs5x4M=
X-Gm-Gg: AYBFou0QzHb5urh30iIOgvAvIFsZWnHuL62num6BhwjGcAjEyVvwLcLnVz1EDU/+aWz
	EtMBqyqRNM+w9vVmINySJbMPpvFeFoP/qyXVJFRWA8v2sjQZarnLtrUPvZs5fNrrmXsx8hq8RQA
	HDO+qkn71+3+YFr3fMKUOlj7CitaWhlpEnQed5is8JFmUVwkQQSu6yCNdAlAl8kmrK2//7EHx2L
	fVWYtha3tbEtw2jmG2LqWhB2Uen0nofmt0F1L7zeJRqp9DzyGALNoAzBn/qxc9N59ng1/7upRC9
	afQc1lzwM/ydWbLyxs/VXrWEapUgBnzvKIXw1+R27HIsLmuAJFqyeCKTI8dD5UC5ugD9a6k/sqk
	b5Gxupl++YwMTKiUc7QVPYFnUXt2J/Mozz3toPQEBphZxB53z6VSzTj3g6+8ivAYApu4fpcb4N8
	gAH0GUz5ahTUatBst1cFE98hAJ+1uIbRdjD5MNPBl3ibJ9Hp3B7OxShBQpbPJgSsRz2mKbWCgMV
	YCQea3Z39vPcOYoGcs4iMh36YRXrCsB6ev10zaKpCSkLQxcZGb+vaQaE0tA0ZUdHqDS9i3nBQwM
	du1P9obu2Bz3aiZ+dl+o
X-Received: by 2002:a05:600c:4745:b0:49e:799e:c1c3 with SMTP id 5b1f17b1804b1-49e7a6868a8mr80715465e9.17.1789476838832;
        Tue, 15 Sep 2026 05:53:58 -0700 (PDT)
Received: from [127.0.0.1] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d28c734sm57627925e9.1.2026.09.15.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:53:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
Subject: Re: [PATCH v7 00/16] Improve handling of offline and read-only
 zones
Message-Id: <178947683541.1379494.6216753235289124805.b4-ty@b4>
Date: Tue, 15 Sep 2026 06:53:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 08 Sep 2026 17:57:29 +0900, Damien Le Moal wrote:
> Jens,
> 
> This patch series refactor some zone related code, improves the caching of
> zone information and the management of zone write plugs in preparation for
> fully supporting storage element depopulation.
> 
> Most of the functional changes here are around the revalidation of the
> device capacity and the management of zone write plugs to better handle
> read-only and offline zones as these conditions can become more common
> with storage element being depopulated.
> 
> [...]

Applied, thanks!

[01/16] block: remove disk_free_zone_resources()
        commit: 73ef8afbe8c9a53c2f42811f9f2a7f862647d180
[02/16] block: improve capacity handling during zone revalidation
        commit: 496b9748884cf8b1c656a69eadc9f9f7eb84eb4e
[03/16] block: refactor disk_revalidate_zone_resources()
        commit: 670a7da6359f260c9141e0f155b8a7bd173a3e34
[04/16] block: refactor disk_update_zone_resources()
        commit: 983b770dc5ba205c3afe6d30460068cdca9f1d16
[05/16] block: remember a zone type regardless of its condition
        commit: bdf2bd32f3ff98215ff3b40abc3987d8e1658318
[06/16] block: refactor bdev_zone_is_seq()
        commit: c1e59cf62cde58a9987f7479d4d00807bc0859aa
[07/16] block: improve blkdev_get_zone_info()
        commit: aac1472513a922b9b36e564111e8902c18cf8dce
[08/16] block: introduce disk_for_all_zone_wplugs()
        commit: a6d2959cb1a4b2c881bc5dc1df632bc59395152e
[09/16] block: serialize zone revalidation
        commit: 35b5438c72229e5086c07ce9c56bca9a305b3c7d
[10/16] block: drop all zone write plugs on capacity changes
        commit: c0832c20104e2427e2c2fa0d953891be46207d4c
[11/16] block: retry zone revalidation on capacity change
        commit: df5de259ba5cd4802242cbc57fcb8c038fcf79f9
[12/16] block: propagate readonly and offline conditions to zone write plugs
        commit: 42551b5997752d1af630628643d7d1d164f62f61
[13/16] block: always treat offline and read-only zones as dead
        commit: f7f047d333b3a1cc39c82fb89017857069c26727
[14/16] block: fail zone management operations to read-only and offline zones
        commit: 0687c9c346ac8c22ebbf875c5caadca83cd60881
[15/16] block: allow read-only and offline conventional zones
        commit: d44a97c2535453898df0a9f8b70923abe63651e8
[16/16] block: simplify disk_zone_set_cond()
        commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7

Best regards,
-- 
Jens Axboe



