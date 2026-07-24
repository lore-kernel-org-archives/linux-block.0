Received: from va-2-17.ptr.blmpb.com (va-2-17.ptr.blmpb.com [209.127.231.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135737189B
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875927; cv=none; b=Hbso7RXKr33bjUY1rugZDG1pAiWy5GmAGYuJ4hgKS+bOyL6r6A83Anjjm/gOlxiU3w7/y3rBTRsuTrONVU8Agbcu68bgAv1TIL3jCwh0H4CwCViwFLsackvXKmGdAkkw7rv6fTb/MxvH4aG20xsWpdFEwAYLM2Lwuagy7dQ5Fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875927; c=relaxed/simple;
	bh=zn+6VazBSsYN1xj07uPDSy0RG1w38dnmgYkGLIH3Z0U=;
	h=Subject:Date:Message-Id:References:Cc:From:Mime-Version:
	 Content-Type:In-Reply-To:To; b=Zg2a93ErpdyPIprPK4BEehQNG79UgnK7pxAHXgKU1/5IS48/pujZxhaC/ftPBtMhoxrvpJQGfrJgGA24z7I3NBGEbCBYc9ChQZfkz5I6+XkIy2o9prVMRCGPLUDQ07JqnSkjWxpt5CimI6E7c7TwYLtAgr8njAKOB7LG0QsTLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=bmLKbJsb; arc=none smtp.client-ip=209.127.231.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="bmLKbJsb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784875910;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fPwcVdDdY6A6ZzikL/yHrEvXieB7f7S2nqiVfRVOOUY=;
 b=bmLKbJsbyvaaRKyZqDNX8Dz+MAPQwOy5WcyKY2TPA/TKIL7vxDv10d3QlIqjLygOs3a/mr
 qqhOxjRAEp/9T5IdXI7oiY7A+QOCDIjXPg7TklsCsyJuCMw4Wp1kJl7DdAD8BcgJJNGXcR
 aG+j3V/VLpKizVCLVzlLt9maWKYOyzIxFLEdS+tkf5AUnNPMlHWrwguOdJJ9UaHdFXvcEp
 0MRfMwp4MfTBoySYvahHmRdTVNhd0DLxeEvgRvR+8M1CMIOSU6sebgkZPgQrJcn335OCUg
 bDYO4EaXlLVDiVX3kD+6+obiLh5/VqY54Q15l2eU5MRPVsVqrUduKH2Zt6WghQ==
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Always change enable_state to MANUAL when setting latency
Date: Fri, 24 Jul 2026 14:51:45 +0800
Message-Id: <2c695292-2fa6-45c1-86e9-d4bf0100debb@fygo.io>
References: <20260717125021.88825-1-yizhou.tang@shopee.com>
X-Lms-Return-Path: <lba+26a630b85+06fb04+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Fri, 24 Jul 2026 06:51:49 +0000
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260717125021.88825-1-yizhou.tang@shopee.com>
Reply-To: yukuai@fygo.io
To: "Tang Yizhou" <yizhou.tang@shopee.com>, <axboe@kernel.dk>, 
	<guzebing1612@gmail.com>, "yu kuai" <yukuai@fygo.io>

=E5=9C=A8 2026/7/17 20:50, Tang Yizhou =E5=86=99=E9=81=93:

> From: Tang Yizhou<yizhou.tang@shopee.com>
>
> Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
> state") compares only the boolean enabled state in the no-op check.
> Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
> is therefore still skipped, and enable_state is not changed to
> WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
> WBT through wbt_disable_default(), silently discarding the explicit
> sysfs setting:
>
>    # enable_state =3D WBT_STATE_ON_DEFAULT, min_lat_nsec =3D 2000000
>    echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
>    echo bfq > /sys/block/nullb0/queue/scheduler
>    cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled
>
> Skip the update only if the stored latency matches and enable_state
> already equals the exact target state: WBT_STATE_ON_MANUAL for a
> non-zero value, WBT_STATE_OFF_MANUAL for zero.
>
> A write that passes the check then reaches wbt_set_min_lat(), which
> performs the actual transition to the MANUAL state.
>
> Rename the helper to wbt_lat_changed() to improve readability.
>
> Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
> Signed-off-by: Tang Yizhou<yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
