Received: from va-2-57.ptr.blmpb.com (va-2-57.ptr.blmpb.com [209.127.231.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBD3E7BB2
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918955; cv=none; b=H5p5RjmdZZVd3plGspF2LUEpRsyYca1xoXs7K2YkdJNJUXzBiyCyYkuRty7PEw4zORPksyFA4DrNJHyCkxBVAcyEurBtUpa9DQ/e/BMqsBLWgxYC6QWy/wMjFXl6VYcT85q8/4ALsrxAFLiSvu2knevosd1nXYPcv2OKvsGtCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918955; c=relaxed/simple;
	bh=athiwGx3rkSMI/H7uUsLzhD4qSA6Q16FKssbSpckeuQ=;
	h=Cc:From:Date:Mime-Version:Subject:Content-Type:Message-Id:
	 In-Reply-To:To:References; b=MY1aiIK1JbefbS+6C+PHckuCLfuTKO3nnfSmPQI63FcmgR558u6wms44LCkXdVircNiFpaa+PfI8aH43+lB8Sd0WMNndZX2r2s2Czc0ZYbTCwaVxxAgZZECM07KvcHNBK1myPold7/otvDxfFtZV2EEX1QVMRnkcEZqPDvsgEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=HIY3adUI; arc=none smtp.client-ip=209.127.231.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="HIY3adUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785918947;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=u3yS7oKfQYhCVlu9mMBThGfWdtpLgln4rmmneXn3X9s=;
 b=HIY3adUICwxXb9/bj66du+28c43ZWDCfGvYlHxBXcRo4dCjUPmh1H1F3Vz91Pz3Gy57Hq6
 hN0QG8AXA+IoHoWovBii5zsm5P3VEPfMx1/ICC0OFSbS3s2odWv/68/WGAx8YvdgSaXPZQ
 M8vM/1TQSiCcjpfWeeYeyHvY8iQH54FTAed6DkYDl3C2z4gNJ3jXQI+ShthgQ1ZNUUcmKy
 jUnk853YdR5+cYKNBT9i6EweJtNCBJ7RRCqMisYjSpVNbKONKqBiW+Ye1sY4mzZ3/kQktF
 Ai4Ss8jfmBEkCvbvLo573x2ny8zVfM+MLsRD3a0reN2uicsFfRY+RjmdNP4Tkw==
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
From: "yu kuai" <yukuai@fygo.io>
Date: Wed, 5 Aug 2026 16:35:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] nbd: clear queue limits on disconnect
X-Lms-Return-Path: <lba+26a72f5e3+a3c958+vger.kernel.org+yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fygo.io
Message-Id: <9237caa9-cd99-40a8-8ff2-9a4177af19ce@fygo.io>
In-Reply-To: <20260805065843.3332859-4-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Wed, 05 Aug 2026 08:35:46 +0000
References: <20260805065843.3332859-1-yangerkun@huawei.com> <20260805065843.3332859-4-yangerkun@huawei.com>

=E5=9C=A8 2026/8/5 14:58, Yang Erkun =E5=86=99=E9=81=93:

> An inactive nbd device may refuse any I/O operations. The nbd_config_put
> function calls invalidate_disk, which sets the device capacity to zero
> to reject all read and write I/O. For zero-sector flush I/O requests
> from blkdev_issue_flush, if the write cache is disabled, the zero-sector
> flush I/O immediately returns 0 in submit_bio_noacct. However, since
> nbd_config_put does not clear the write cache state, an inactive nbd
> device might still have the write cache enabled. In this situation,
> zero-sector flush I/O will return -EIO because there is no active socket.
> Additionally, BLK_FEAT_FUA and BLK_FEAT_ROTATIONAL flags may also remain
> stale, resetting all of them ensures consistent behavior.
>
> The limits update uses queue_limits_commit_update() (the non-freezing
> variant) because config_refs =3D=3D 0 here means every fd is closed and r=
ecv
> threads have drained, so no in-flight I/O can read q->limits concurrently=
.
>
> Signed-off-by: Yang Erkun<yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 43 ++++++++++++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
