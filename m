Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3F611E
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001683; cv=none; b=hykrerQwXnvp/uX57q+WoyA+biV6yMlt8kYjAiluvPuFaJmXCXs6+3WgQCDNlVilxmTV7KYPiEHmnG9K3d8YFJ1OOdkGmNwv5LeorqujzT3M2ScGmsUFOGQAXD7w0Sy3qLdbP4PIB2z6LN1TlS4loOSILhgZrmbmJifakIleP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001683; c=relaxed/simple;
	bh=G2BnGX26PUJwPNtKkgDw/Z/6YxRQh+f8bAqoAuDkZEc=;
	h=Content-Type:Subject:Date:To:References:Cc:Mime-Version:
	 In-Reply-To:From:Message-Id; b=YpAXgoOTp7e+U4wvYM9VjxpsICRBgO8ixR+e0Jp00I5xh1XX0FjSUwrXySNYw6syygkqpe4UVx1K0CQTgpTSy6oAo96ut3bQav/Lr4q4yc9RngcUng3BrncfEN5AS0O0PrAweEGpx9u+hjxCV1VpVG+aYslzNiSNCN2erm0yOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=KXQwlwDV; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="KXQwlwDV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1771001668;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=G2BnGX26PUJwPNtKkgDw/Z/6YxRQh+f8bAqoAuDkZEc=;
 b=KXQwlwDVoeV68Rlu0oEVJu4Lg47uzpXzUtH96viL2v3Xs68gacIGKwNCoVOZFcoyyLaEer
 ymGWnnngyfo4xnbaHcYKZMF1Fv6BI5KnF7xgLrYwoacbnPZklLjpxDYvNBEkdu8RAg+r5z
 15ZlDskw2mYj4Vyz9Z1pXpOw5T3Sp5brjn3WpRqsrC27JahEe6zAvBfY0Qxyci+3l56LXV
 oK8ibWD51JQu4BLfsLxqw/56CKfqq1neAfXyDosFOReQ5Z5e9qQa8MYjTSkiczPQmhbM9M
 GS4XvgXZVpEA2+ql53FXQ4APk5fmFePZNHxY5DvGHD1b8Ll0K1wKm6EKfeArBQ==
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2698f5742+765c66+vger.kernel.org+yukuai@fnnas.com>
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Sat, 14 Feb 2026 00:54:22 +0800
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Sat, 14 Feb 2026 00:54:25 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Reply-To: yukuai@fnnas.com
To: "Jialin Wang" <wjl.linux@gmail.com>
References: <20260213073829.182168-1-wjl.linux@gmail.com> <890f2571-fb46-4ff2-b7ea-7cfa10bc8797@fnnas.com> <CAG18Jnyvs9Ob2WKQV0LQYGrq3F+czrRukhxW5JCza0iZQvbh-g@mail.gmail.com>
Cc: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>, 
	<lianux.mm@gmail.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <CAG18Jnyvs9Ob2WKQV0LQYGrq3F+czrRukhxW5JCza0iZQvbh-g@mail.gmail.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <a18d26f4-a494-48b2-8024-4de1047afb25@fnnas.com>

Hi,

=E5=9C=A8 2026/2/13 20:24, Jialin Wang =E5=86=99=E9=81=93:
> Do you have any specific thoughts or suggestions on the best way to combi=
ne
> these two mechanisms? I would really value your advice on the implementat=
ion
> direction.

Implement a new model in iocost, you'll configure bps/iops_limit the same a=
s
blk-throttle, you'll also need something like tg_dispatch_bps/iops_time() a=
nd
throtl_charge_bps/iops_bio() to calculate cost by max(bps_cost, iops_cost).


--=20
Thansk,
Kuai
