Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077D3DAADE
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919217; cv=none; b=r299tspREMHgPav8pNpfmCLS6/p/xv+RVOZ0N/0tdQp04sMSQmvk+g9pSLzyHoHBvjjB/euH0jJ8fC2sBsTMyB2iyUSQbU0Fg1i2HMr3YsrKMqAgtgE8Xy3yFICLmIwiGPWa8wFlpgvz8J/xpnoBXxDEebZ+sbP69TPptJKbepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919217; c=relaxed/simple;
	bh=uXTDmQcWebTvaQpjKCx0nOHnxPanU31AevKIQPvQmU0=;
	h=References:From:Subject:Message-Id:Content-Type:In-Reply-To:Date:
	 To:Cc:Mime-Version; b=rtpXBdA2+P/KXunVnu1laKIg52OnTEL+MQ9l3VaAmE2i8jCpSgvMT1GIEug+Q2HtIBNBOrP0pAPzqr8N6xb0zHbVaptHK8lXDIH3W9ZiTcBElkIl0tw3IAnmx8em6WKDE3egjr+5bjWFPw9md5ch2/TrLGxSAfswpgWJ1ED60vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=m2iq/Bqe; arc=none smtp.client-ip=209.127.231.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="m2iq/Bqe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785919211;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9lLCVJqhGBVepF2/WAIpM6qjby0NmwidtzaVQjxvPOk=;
 b=m2iq/Bqegykj68xQaSoXMUUNXuvIBOJYMZzL192jmwTW/0NtW/kZVTU9evTLKIf7MxLWii
 zW4JSetT++xZbEoy4QTRLDQDUBx7BuOpyaYKY9eDRMLDX1rbCltoucQHVeF+zdr+PhVTiC
 q9Tm5bkREqGu95gjQJikSbiuUaIHrMLm7a3RQcA+I4FAyk72vYKWVRYVb3EWyo2O34h6XY
 j9e//8f1haWe0aSND0J61pC5Z0qk8e2Lnhx0tA294zDfzQ8N+e/4s01PE43/57S+M8urRy
 1RrMwHRmpcE/AUe7uB/wt0OWw3T1I8S1bp+f62yxz9ZaVi6af2BVqeXXyzmLVA==
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Wed, 05 Aug 2026 08:40:10 +0000
References: <20260805065843.3332859-1-yangerkun@huawei.com> <20260805065843.3332859-7-yangerkun@huawei.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a72f6eb+71d478+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v7 6/8] nbd: factor out a nbd_genl_foreach_sock
Message-Id: <351f10fa-3f74-4c8a-bb31-484ce9383409@fygo.io>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260805065843.3332859-7-yangerkun@huawei.com>
Date: Wed, 5 Aug 2026 16:40:05 +0800
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/8/5 14:58, Yang Erkun =E5=86=99=E9=81=93:
> +static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, int fd)
> +{
> +	return nbd_reconnect_socket(nbd, fd);
> +}

There is no necessary to keep thenbd_reconnect_socket(), just rename it to =
nbd_genl_reconnect_sock_cb().

With above change, feel free to add:

Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
