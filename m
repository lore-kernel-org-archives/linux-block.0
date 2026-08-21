Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAC2F8EA3
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327690; cv=none; b=mstFgRoAaleepegvrLeIuE0yfB6h98GfRIB2nXIk68Mrj0frlC9VllT4pJ+k6Ie7hpMO12+baVGJvW7uwYSb5LttPNELR/wt0CgKrwK0ExX3jFfzEv6f8AUgnUOxOQPA8EyQ+XnNMf3g2CAg1WD7cFc5FZLUl3DQbLcsBNkIFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327690; c=relaxed/simple;
	bh=+1C0jW/Nk5u8NlCQqBZfozixKzhytwK0KvQbeBpiLvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnhnEnModWzfoTT4PH9vWieSVJ2TTmQVXFQ0RABr09xp/Km3nkn6ubgZSlbnlQoaxaDrKAA/c1GlZyovxag7eZ3fvD2RJjO/tkmIRhNCv8l3GYswBgi3k08orqk5kRfCMAjXkj1OjgWQ4enCspKJfNhCsXIP+EHjew2BmbhSbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jcbXBVZo; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jcbXBVZo"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hRPyJ4rzDz1XM30j;
	Fri, 21 Aug 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787327686; x=1789919687; bh=C+CrwYuS6QFoxkx+4Up4nZZv
	bIQxgSVSxBgl0ZrWtPA=; b=jcbXBVZo7/1Joi0OdxI71Sr9p6DMXvjQ2gsOQ829
	ShpRnsSJL21Iud/oCO9g10lwFjuOLYfwsLOQ9EgKUYaNWzVmFKVIjNWiRernzqyt
	8CVN+/r16vHeEhAEWm3vDKanJgWb36z0xublCNGeuR6yCGfpVxFqzFYDAuSfLwop
	/K5jUiH0XEYrBHU+HTSd3wkMH+GerMZc3QXsfeaELYeNrN7gjrZ9+eRJjIBtZHVg
	VMsiYScYpmmWAJ3eSlaIl7TfqBYfwcL29Rr9Vj+67RukLUnwBbQOdaGazTtXABEr
	9f7eqWUpcVmXNrtY2rEu3WiD/T08aHS2zE57vgmlnxCGfw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zx3Zh_K4LWlh; Fri, 21 Aug 2026 15:54:46 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hRPyF1Ly0z1XM4Sx;
	Fri, 21 Aug 2026 15:54:44 +0000 (UTC)
Message-ID: <31a8249f-416d-4fe3-9fd5-f4a7fde54b23@acm.org>
Date: Fri, 21 Aug 2026 08:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/042,043, src/dio-offsets.c: relicense from
 GPL-2.0 to GPL-3.0+
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc: John Pittman <jpittman@redhat.com>
References: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:55 AM, Shin'ichiro Kawasaki wrote:
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/042, 043 and src/dio-offsets.c are
> licensed under GPL-2.0 only. These test scripts source GPL-3.0+ shell
> code, but GPL-2.0-only code is incompatible with GPL-3.0 code [1]. The C
> source file provides the helper executable used by block/042.
> 
> Relicense all three files under GPL-3.0 or later to resolve this
> incompatibility.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

