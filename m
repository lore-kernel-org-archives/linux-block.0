Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC016396D1C
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674972; cv=none; b=bPyaRPpORGGBnG8RdimXfo+zXzP+iFb+FzF4ruy58LNaNaVS/i1Mh64ePbeHIjdhqWpwcPzbf5MlKCL+wYGgO5rZUdMXSYzqt/jnhDZh5MI5+Q19YRRZooNTtrJAy8Hz3t/LwHFJIddVA+aPn1sBH5QGi6ZO+2QP8ZLyY+WVZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674972; c=relaxed/simple;
	bh=GhyU+I4AObATmube0HVJJl5NTQHluwYkJadT+SOSx2g=;
	h=Subject:Mime-Version:Cc:Content-Type:From:Message-Id:References:
	 To:Date:In-Reply-To; b=mXxulWrguR5t1STFWjMwPgCY9JuHy1pnXDwdBAbn1KJ++A2syaziCGRCUcGc3vugPeKs5yr9okLuyWO7ozio+HmnuXGghTLVteAjC4QFVUsu/iblg569l4ARSpDQGSYp4dgYumUI9gZF0q9t8mxmHiu7P1CMajTO4+sV4D6IknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=HpzolgWz; arc=none smtp.client-ip=209.127.231.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="HpzolgWz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785674960;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=n9lZR9qf3kptXY4+jbcwUniPvs3a4Q+wtE0w9TCgWJI=;
 b=HpzolgWzd5pGnT2/ThxJoHKxhY8c7Z0myyXH35sZDkhMEO90bC3M8nyN/rirM9A6AVvfmP
 Q+cXNt5nOFDinypumHjapeowlBJuPsncNbxvRGDVpSN4NpcOVTSSkKP0J7m5Ynt1XNBIhj
 GmEoU36ca0EjEsjmO5qoExj4FNGfPLpKH5KpTVj8aaRKFW+cwvbSlx2lgVTZi/u97TvNoA
 LZd+Ri4yN5WO66j32PoizbmTiEkD0Gm+Lt6ok9tQeni6D0qSskEjdU4idiLqyp8IrWgK2G
 JHPnTxdXJwaeyJhfM/uNxpLyE21T7y8lDNzVckBesi3g0WDv14nwd5OByekXgA==
X-Original-From: yu kuai <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH] blk-throttle: remove dead field last_check_time from throtl_grp
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: <tj@kernel.org>, <josef@toxicpanda.com>, <yukuai3@huawei.com>, 
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Tao Cui" <cuitao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 12:49:19 +0000
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <da74ba48-334f-4637-bebf-d394b72a13f7@fygo.io>
X-Lms-Return-Path: <lba+26a6f3ccf+11c1d9+vger.kernel.org+yukuai@fygo.io>
References: <20260717054855.2018578-1-cui.tao@linux.dev>
To: "Tao Cui" <cui.tao@linux.dev>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>
Date: Sun, 2 Aug 2026 20:49:15 +0800
In-Reply-To: <20260717054855.2018578-1-cui.tao@linux.dev>

=E5=9C=A8 2026/7/17 13:48, Tao Cui =E5=86=99=E9=81=93:

> From: Tao Cui<cuitao@kylinos.cn>
>
> The last_check_time field in throtl_grp was used by the
> CONFIG_BLK_DEV_THROTTLING_LOW mechanism (in throtl_upgrade_check() and
> the downgrade logic) to timestamp the last upgrade/downgrade check.
>
> Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW"=
)
> removed all five of its uses in blk-throttle.c and the surrounding LOW
> fields (latency_target, last_finish_time, checked_last_finish_time,
> avg_idletime, idletime_threshold, bio_cnt, bad_bio_cnt,
> bio_cnt_reset_time), but missed the field definition itself.
>
> It has been a dead field since then: zero references in blk-throttle.c
> and the whole tree.  Remove it.
>
> Signed-off-by: Tao Cui<cuitao@kylinos.cn>
> ---
>   block/blk-throttle.h | 2 --
>   1 file changed, 2 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
