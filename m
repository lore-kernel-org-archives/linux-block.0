Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AF3FD141
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967633; cv=none; b=CdCcIy4izwFADgGmtbMrcLmilaY2N0Txj1WzL49Wb7xB8pRwdDxAGOsEFh0brp1d+3Et2dmT0oCHheOsQMBHfAMLuj0ALvb1TeGHGQsAoJ/A9JV/xO/08FFf1gc+4HjxqGVEWAZ1e6ZVPjXu0M6jVvU1ayPkIBd4m7ZExOjS+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967633; c=relaxed/simple;
	bh=c5YTapI/QnJBK6uTPoSQOxs88nNqqKubStnwUGKaIzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BN+uegCSr0nCfpbzOISgi6xXgUpmZyVO8WfxumpjaWkn13MJkqZCrZGGuzU5mZicDvsJ7+Ox3VhFlD2Hh+rDy6nvI2NNRwZtP0ogSg7ODd720a0x4XdvzsUkAbZ804Pxv8gJMZXP4N4RPrOQ5n3nHd0Ae/uw2VFyDDhp7c8Amx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DOlVx74Q; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DOlVx74Q"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40ede943bf0so3545978fac.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774967629; x=1775572429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbH0MhJV4/ZW85jR0eUvCxY4gP4ckCkoQ0rETMso+XI=;
        b=DOlVx74Q9F5paefQOe3jqd9D/uK6EladTBz7snpdmDVHdp6xYnIgB8XS6IllhRN7NN
         XN/MhtPIoNBhJhltBhrQo/EoypHqen0jo/xQ+blScbHXdXJMUbLlO4rYaBPkgpkwQmzL
         IfDmTHAy7yiNCojEK8VWuqx9Hy8p7O4CfnlykdPxzGCYMogcx21e1iuCn3eAQf4qdc7q
         tCborqW6/ijntmZ1Hrx7dHVIwuKKICls/NNe9JjaNXZBNYuAG+skLCjRbBl8a8sbzIt9
         LmUkF9TdEn3m1l1Jmtz/DljZpLia/PqxoZV1zFZj/xB2OeGFaATkdYRxD6Tnn13bSVER
         BwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967629; x=1775572429;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbH0MhJV4/ZW85jR0eUvCxY4gP4ckCkoQ0rETMso+XI=;
        b=rz+AydKvHbuSbpK3CD3gU9PDh7lz7ivwCx43wEDw3huQbjQrpYfeB6s6GQAI9HsIAf
         AJBf/5uGCjYBryuVpeREc7tf65cQ4IVg4gHJu/5abgQnd0UAQhR3gDfd2Ct89db3ZmzR
         poeDbwZPkjTj6cLbRwRFsobqsxwYhwoCw3wPSpmgWVwNEJp9E5gpmyDI8d1lCos9AK6R
         zHNip1+IYRjQKEgT37/FwyklOrDvNwOudZwfVvfd+00V4H6Eck5+1JKh8gZ6NuTBHuat
         bdYcexyhtYBGuqw3Fmnp3IihKSz6XuCf56+wKSkzZb8dC8fSa045MoyPR38bAhfDJ87u
         S0nA==
X-Gm-Message-State: AOJu0YzAX72/7h4+ieWGobNvFFmDH8I1nSvnTSCAEdusSIAnDOd1Y6ZB
	pguBDqtV2yrWqScpM2MpWbw580bZSn4HwLIIi7lqVxy0X2/8gfrihoC+6ebw+FYnl+Nidv4R5Ls
	Jd9+S
X-Gm-Gg: ATEYQzzLpoeBs2pc/wGt6KpoWFoASEJ6dYt8oVRs7cuWDPT9+lrNYNSqfRaJL5nuFuk
	w2l7ETaHptmwvqPaEt19NUSmKNlXn/j7L7InuPwLAf+1dmSAsmWD2AGPlo0vKPB1Tyui+uyTJjE
	1GZJF5CMOndWQdb/sUIDsWRvk5A1uje73RsdF3wow7QFE6FdfXcTk1kdYR818OzazuVn11DyEWx
	b7ltzGH8vUgpvq4di9M6ws16JbMSONPRMFoYy714LWe4djA/Z5UqgF9bFuWmENRwpmWmI6sAzO8
	Fn/sym+AGJxrhnvUsts9qL/ZwcCL6EWYiA+oEKpjEx05KBLLwG1Cm4TkJjS9nkDaBd+OCrANqUL
	arkD/2Okr5waB7hQEmBy2GvX1NYSGpXSdd12g0UDpFAf4hnR+dP5gdxTo/dT9h9dSoJDTbW+AmJ
	5YvqBdp5Vnxidomz6W7louUZzJbQ/Q36A52KElQDN5UGBcBWmOmqxxmmZQ5652zBG8T74zqEQ7p
	3NJ
X-Received: by 2002:a05:6820:1384:b0:67d:eb3f:a4c7 with SMTP id 006d021491bc7-67e18706400mr8873565eaf.44.1774967628913;
        Tue, 31 Mar 2026 07:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231e1329sm7074495eaf.13.2026.03.31.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:33:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260326203245.946830-1-dlemoal@kernel.org>
References: <20260326203245.946830-1-dlemoal@kernel.org>
Subject: Re: [PATCH] zloop: add max_open_zones option
Message-Id: <177496762812.863151.14659720253076398296.b4-ty@b4>
Date: Tue, 31 Mar 2026 08:33:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Fri, 27 Mar 2026 05:32:45 +0900, Damien Le Moal wrote:
> Introduce the new max_open_zones option to allow specifying a limit on
> the maximum number of open zones of a zloop device. This change allows
> creating a zloop device that can more closely mimick the characteristics
> of a physical SMR drive.
> 
> When set to a non zero value, only up to max_open_zones zones can be in
> the implicit open (BLK_ZONE_COND_IMP_OPEN) and explicit open
> (BLK_ZONE_COND_EXP_OPEN) conditions at any time. The transition to the
> implicit open condition of a zone on a write operation can result in an
> implicit close of an already implicitly open zone. This is handled in
> the function zloop_do_open_zone(). This function also handles
> transitions to the explicit open condition. Implicit close transitions
> are handled using an LRU ordered list of open zones which is managed
> using the helper functions zloop_lru_rotate_open_zone() and
> zloop_lru_remove_open_zone().
> 
> [...]

Applied, thanks!

[1/1] zloop: add max_open_zones option
      commit: b2a78fec344ead9ffca63ee13018f482392bf09d

Best regards,
-- 
Jens Axboe



