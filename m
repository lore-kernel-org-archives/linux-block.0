Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45417A300;
	Thu, 23 Jul 2026 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768580; cv=none; b=FfQRAbiNfh0+9dCeJi3HFU17UHYvBiaA26gaRf+oKDUkHr5wonGQsBy5AsPQpCAEHCjKlz3uGfnCtxmSOyuTtbLsD3FuD+RhY+QaGXN5ylZqzwcq9UdSvQJbjheRGvhXPFARihPZezykyL8QN7n4AKFZQ4o8yxoME2NA2IyixkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768580; c=relaxed/simple;
	bh=QYcM38Ff4R/5NJ9E2ioHy0uQxPnU2NNaD5JJQVeJECg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+YHfucJ07ffK5P+5xcIzyyl4FGkOyAievapVdS25ZtkBX42gJj4hHt51/M3ys4KMqsVtxO+PtXvnNPToRZdWq/mJFWNmbbWpVbeXVAiGC4AsZwILuCrzglc18+RVjAjKFpm/liBOm1fUPixSb7cthe34IIsg+i3ymSK7mY5xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZZUADrjg; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZZUADrjg"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4h5CXX0Gr2z1XM5kY;
	Thu, 23 Jul 2026 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784768570; x=1787360571; bh=QYcM38Ff4R/5NJ9E2ioHy0uQ
	xPnU2NNaD5JJQVeJECg=; b=ZZUADrjgHlJ4PSGhgCVVXdVNGvKUY5PCPVNGAWe5
	n5qLU2p96UcJbKV4ZjV6H+x4nh0hDfygC7HLj4p4gm1p01+6qvprJibb4nlmy8ZK
	KH5ss3fwwtS4rpiaMyKoIVTK47AaVcYzXOBej++2ahnXdIKcgVc83u4cG5zg0xFS
	m+U6WxYI8Nq+hRLQJijOOVq+x8Dm8/mzl2b/E4uhV7LXdOTHDmln8dML9yauM0UM
	tGh7oNxMoWtTr7iP7Z0uzhxpfdGuRnyP9Bb44tzuqIu/irjMbkvFFAYm3s/9/x2E
	fyZqswpaU/JJO/5SWn/gcF6eoJsof80PDbmlGoNmrdMROg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3LojP614dqlJ; Thu, 23 Jul 2026 01:02:50 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4h5CXS65Dkz1XM5jn;
	Thu, 23 Jul 2026 01:02:48 +0000 (UTC)
Message-ID: <625c8daa-832f-4b9b-ae9c-446a024493f0@acm.org>
Date: Wed, 22 Jul 2026 18:02:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSCB2MV0gYmxvY2svbXEtZGVhZGxp?=
 =?UTF-8?Q?ne=3A_hold_elevator=5Flock_in_debugfs_next=5Frq_show?=
To: =?UTF-8?B?5YiY5Zac6ZGr?= <liuxixin@kylinos.cn>,
 linux-block <linux-block@vger.kernel.org>
Cc: axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>
References: <4gmvbeouu7qb-4gn345cmtdpg@nsmail8.2--kylin--1>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4gmvbeouu7qb-4gn345cmtdpg@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/22/26 5:14 PM, =E5=88=98=E5=96=9C=E9=91=AB wrote:
> I have verified the patch.

Which patch has been verified? Your patch or my patch?

> yet locking with dd->lock does not take effect.
Is the above statement based on analysis of the source code or on
actual testing? In the latter case, please share the reproducer of the
crash and also the KASAN output triggered by my patch.

Thanks,

Bart.
