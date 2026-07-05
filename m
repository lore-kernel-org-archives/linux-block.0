Received: from va-2-41.ptr.blmpb.com (va-2-41.ptr.blmpb.com [209.127.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BD30E831
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783243959; cv=none; b=RrW/vg051yv6/PnmwiCggJj3RSMFMAQ0WKot1NsIo//cFAS84u3BnbgEGSJIxdVvxxrGM9lFqAS+cbKJCv0z0kmu7PcwSXvoT5gTJqm71mynDDv4MiX/mPHo04FVJPLp6D2w9dN0J7u3rtnKUtZPohRh7SQpIyuZ05l1HHPH4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783243959; c=relaxed/simple;
	bh=mJcdztOL/HKkJyr20IVdaCsHNNcnr07Inou3i/GzSXU=;
	h=Cc:Subject:Mime-Version:Date:Content-Type:In-Reply-To:To:From:
	 Message-Id:References; b=ub+RukjJnygnRzEdmy527NdOf4ZT+VUZqe9UEpF4Fzsof4DFecSIttjuJA5hZB3qygxzSru0di5OtCDB1YWvHxk5IoX0DKrfYAsw0k6TNRV+3iGh3Dkc7e5aVwg2iRuh1BMe6ZwVfwnycMWD5r18GYEElmYu3OIysjB/jSe4D/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=Xd6lnBBF; arc=none smtp.client-ip=209.127.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="Xd6lnBBF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783243953;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yfmo+Opzuf9+9Y6texDec4/pAC1ruAiFfECAfXs3mT4=;
 b=Xd6lnBBFX6bPLeFS448dJ+s0XAhRBS+i/fKVR64kfP0b9mde6m806bQDVHWv9G1SSPTP12
 KBf83yDKpRBuL3p2JUeq5fRS/0QItdLBYU/cBz2B3zL6DIDQKqRQnATenn+hLu3YsFcYYO
 K7DDu2LKQ5HjU6Ca4wOPev75ntB19Fg4X0hvfRTCfyE5fiuaGfGFiWGkVpCtYjwdeew+DK
 m0SkYql8xA+VEhsxWbBHNL0siASqlSkO9132hkMoutg+Ij79ylulAmFd0ZlnSb/6g1P4C7
 tUxe3fOHkef8CukCpEEcw1plQUPLv+7YXAhkpBlxOZ3E2ySeaF66oJBYUcGOCQ==
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Subject: Re: [PATCH v2 1/5] nbd: simplify find_fallback() by removing redundant logic
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Sun, 05 Jul 2026 09:32:32 +0000
Date: Sun, 5 Jul 2026 17:32:27 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a4a24b1+787d4a+vger.kernel.org+yukuai@fygo.io>
In-Reply-To: <20260625084458.4171890-2-yangerkun@huawei.com>
Reply-To: yukuai@fygo.io
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Message-Id: <40aef437-bfd6-4484-ba4b-04adf192be86@fygo.io>
References: <20260625084458.4171890-1-yangerkun@huawei.com> <20260625084458.4171890-2-yangerkun@huawei.com>
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2026/6/25 16:44, Yang Erkun =E5=86=99=E9=81=93:

> The second conditional checking nsock->fallback_index validity is the
> logical inverse of the first, so drop it and let execution fall through
> naturally. Consolidate the two identical dev_err_ratelimited() + return
> paths into a single no_fallback label to reduce duplication.
>
> Signed-off-by: Long Li<leo.lilong@huawei.com>
> ---
>   drivers/block/nbd.c | 37 ++++++++++++++-----------------------
>   1 file changed, 14 insertions(+), 23 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
