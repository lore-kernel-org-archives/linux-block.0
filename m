Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2192C15BA
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262508; cv=none; b=tGAj8ThYjv6m6tCt7NXXIQvCye4ZjPAYfvb0bmKlcxe6u0lYKTZFa/cMY06rhBmoQkLOGNqNnX/iUG7mDus8bPpAPGoa7vhr5dtxRL9LYIMBgod6Rg5YttVd4/5y0PjTw2hZP2fXqnSjcIEU8I/WsefkzAOwwirPyWnBJ82Ab3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262508; c=relaxed/simple;
	bh=rniSLWzq+j6F/OFp4LCIQuaKCm4TU5+I4xgbBmuX5s0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3uQpVuIwJhU8qXAOGo7Ypn0+6o8/ZOvD474Vvg/+xsU7W78wTkBEVT6LrwGVGlx1WTxuCepytVPLFexRAhhB1U47k01ACFVET3BZ4P35HsiuapIJ3O6wIDNDrYS5AEHfBt2k+g2FCT0C+ZDjvSfh6bttlHRtr+W/OaIL9/IrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UFMficp9; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UFMficp9"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40429b1d8baso1161848fac.0
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771262504; x=1771867304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/LvOneH/nT8ypSFSsWXSmbYmlTfsJ2qNHg7b9d1jQE=;
        b=UFMficp9pODLHP8Khu0RTGqhlVStEZkhdhcukKKezWC08Td1/mHnSm5W8C300ZsIgD
         6nQQP0EX0vTPO3sdV3yyWoIawMaAkaI6hkJO+JMuLOy+U7RPgcXuG2tzANcMWl3E67eJ
         GR5DoKBrNo45rAP1JG9gPhK+dB9Vy1xE1GOpl38rQTCincWMYwc68fCzi1AWqj+TEh5Z
         3t04++xlpTlZKKwZFY3diXvrxM2iCm582C/JHbp5aE2GkWAa9e2hqFxCxbm0auibjo3r
         KOYVD3rH7s+mQKks3HhMWBFjiOsOs3/thSbFtxY4xuPwgHOw1u6kK3yTNEMIrZ8gmiHu
         iHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262504; x=1771867304;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/LvOneH/nT8ypSFSsWXSmbYmlTfsJ2qNHg7b9d1jQE=;
        b=p4JD/r0qR0KkaKTgNjSZc2zCe4VuXwOFpihVtkC0isAV1/AvcUQrktMcHhO5QKuaHc
         qt6FtJzqD3g4j7LFFR7p7M/x55FyqGEABC6IOO9E/XkQ5ycnXn/nyn+UNaxdpdqAWQvu
         IP6VIKuaKcSZFi2Ej3l7YbTY/kezSk8Had61s2CQNk84G9yOpPO3UAhUDI2OfGicw0gh
         ClDD+XQf54d0MgoXCSwNekFSJc8vh3Ny+Unw1O64YUPwiYyT0BptllSxfob5izG0Isl5
         /P6jeO1YBpf0stoJDyyC1zjTdi/gVL8td9W17KueV0OjfyHh9UXX0FH73YmCkGO6+xtw
         DFsA==
X-Gm-Message-State: AOJu0YwXmnvpLb/qVeJRrPKOxyXTNt6cO5ouPVCgUe7ZHJVAn7AQI5A4
	SgwWB3GWs5cOAlHpxfS6H0glkg0ZO4suVDvD8SaU+pGdgvlDnyJk35y68UMgTRfxmvFY9d3AXRe
	sLPd7
X-Gm-Gg: AZuq6aJiKU5vhyaMIs1gIggL8WsPUMOHc9A4fhRufAhsFn0okZXiiYeYIZ802yE6vKv
	M/fIUI6MbCEug0ABAhNO4z3PqvV7Ftc+uzG26Kijxsyiffpf/VDIWx0R500a5vAcKT7QuiHPWNR
	glNY0Mck4gvRTfi+P4gLUXRKw8DnsXkUEaSca9+tTezqcp6ZULdp8c+6hgUHQOHbvO3e/0JzQss
	hG93k9oCuz1pbE36MA9xaabvC+pHZslKA2MiMxbpxJ1MyOdSVB0qhv/18EvvkwcqF+s2BNEFL0a
	OX54yWNsDXWir8MOuXwKrn5PBtCff1bXF+59kMTYgwpcAorhRBBRxJhu8ZtNKBI1/ZW6XJnZhgK
	yPkvyWQHhRgpQRD3i/RFk5DluRKPaukuLJn/a0UntzL1ftpF0/gPQ/+z6H6gy+5XdiSDpm3NQki
	m42cZbdtlQD00wggD2vg30MYmpaEfezdj8kfAv3Dwct3qL8WPv37lLHWba6n0LOoKSXPVH6Pk3A
	11H
X-Received: by 2002:a05:6870:16cd:b0:404:15b0:4602 with SMTP id 586e51a60fabf-40ef3b7e945mr6084121fac.7.1771262504058;
        Mon, 16 Feb 2026 09:21:44 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee90ba325sm11658295fac.8.2026.02.16.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:21:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260216052941.2744390-1-rdunlap@infradead.org>
References: <20260216052941.2744390-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block: fix enum descriptions kernel-doc
Message-Id: <177126250318.152457.15668767280339480930.b4-ty@kernel.dk>
Date: Mon, 16 Feb 2026 10:21:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 15 Feb 2026 21:29:41 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in blk_types.h:
> 
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_READ' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_WRITE' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_FLUSH' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DISCARD' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_SECURE_ERASE' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_APPEND' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_WRITE_ZEROES' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_OPEN' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_CLOSE' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_FINISH' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_RESET' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_RESET_ALL' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DRV_IN' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DRV_OUT' not described in enum 'req_op'
> Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_LAST' not described in enum 'req_op'
> 
> [...]

Applied, thanks!

[1/1] block: fix enum descriptions kernel-doc
      commit: 4c431a76a288ce958aaa114d8ea6fc0968942832

Best regards,
-- 
Jens Axboe



