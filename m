Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FF360ED2
	for <linux-block@vger.kernel.org>; Thu, 21 May 2026 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377672; cv=none; b=QtEtODRbQil0DH3iig3xHjSec9QWwEIt5+5uh7f1A5AQeP4HcsAamddzkdnAazbK2w4sUQR/3jcht5Zwg+FvRwSAvbZ02FJkBWkD1brRxlJida3NoPgZBgeCOqQt8QnXiAHWEtCICJhPnz28s6Qg82Q6ZADP/Ow8+8r9gYtoaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377672; c=relaxed/simple;
	bh=9ErAw1Zb6aa+m7oqL2YVPee4QnxIvJj3ONcd/MmhSog=;
	h=To:Cc:From:Content-Type:In-Reply-To:References:Subject:Date:
	 Message-Id:Mime-Version; b=k69Vk08NS48cjyfhitQomi4cDZOWMDZNDzyCmTTqNgQDTpxqcj9frKOzouhmOv5bY/QTm7+tBjfYzzRLLNGuDTa8p6B1P3QwNcUxneOOiCpwKT7hnk8ApAAn5VS9kqqzDy+sECEyHFO3kxeVF8nWsx2kHheyRdsPyDW1AyIMfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=lwJZzYQZ; arc=none smtp.client-ip=101.45.255.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="lwJZzYQZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779377620;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JKdmFuzP482HzYamYbY48eH9v4Y/Lu58oHdGa5a3aCk=;
 b=lwJZzYQZCzVfG0Ue+i2YO5TsBJmchZUa9iuUIrp9gry6I+pYFCOQpsN5Jq2bnscKAswNDR
 faB8U4pucLaXzJhBTTE9Elo06qRGoPM8+M++ZX9R3aUTH+WRC5pOuTp+l215EGZMIbuZps
 xTgTc7D+cTKemTpt1xKLF0ZSYc8VqgmmxsyCt6SLFnc9yRjW64j5J7jdmuGJp/MaItlUj0
 UVrd7QklvJf3oplFBKWeN484c8rdvqdSqxZAAjQMZfO8S6RpeLG/rTPJnIBsDN19Nas88e
 cy3wVj6I5Qoq16baHhh3EMB+yrgwzerObRBDAoToO59MyO85R729ZoC/Tkox8w==
X-Lms-Return-Path: <lba+26a0f25d2+794018+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fygo.io
To: "Julia Lawall" <Julia.Lawall@inria.fr>, "Yu Kuai" <yukuai3@huawei.com>
Cc: <yunbolyu@smu.edu.sg>, <kexinsun@smail.nju.edu.cn>, 
	<ratnadiraw@smu.edu.sg>, <xutong.ma@inria.fr>, 
	"Jens Axboe" <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251231170117.143488-1-Julia.Lawall@inria.fr>
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.188]) by smtp.feishu.cn with ESMTPS; Thu, 21 May 2026 23:33:37 +0800
X-Original-From: Yu Kuai <yukuai@fygo.io>
References: <20251231170117.143488-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] bfq: update outdated comment
Date: Thu, 21 May 2026 23:33:35 +0800
Message-Id: <bcacb5c6-2108-4691-b55e-f76683b8d2ce@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

=E5=9C=A8 2026/1/1 1:01, Julia Lawall =E5=86=99=E9=81=93:

> The function bfq_bfqq_may_idle() was renamed as bfq_better_to_idle()
> in commit 277a4a9b56cd ("block, bfq: give a better name to
> bfq_bfqq_may_idle").  Update the comment accordingly.
>
> Signed-off-by: Julia Lawall<Julia.Lawall@inria.fr>
>
> ---
>   block/bfq-iosched.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thansk,
Kuai
