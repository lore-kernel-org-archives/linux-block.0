Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685980;
	b=k9jCKv3sDK0aqCnAwzsq1MXn50UodIRjxQzB3uiYA3t0cPQX2uf3DoGruMOwjW2AfZ9k
	 Jg6cNLUofKZ5qGi/xYrqhL5d9mtzpYduCYFpyAEW65fxA93RmNo0kQADdmJ3pwNGCdDm3
	 5+zzfz4GiX3Gm4H95ffaO/8tFZTiG5Pu4iwClQJfkM/O6Ij5yWIa9llYU80NylhUklMVS
	 z9tx2AbYiUVbYMd/wrkeypMxB9hY0MdCy3ad7VBNhzwz4tZjl49Dh0Aitvhhu6o9sL8Dw
	 SGa5r+IZlwmUe+Mj8r52d91vs2T3xvCh2YPqoZxy75Osa9gUR9U0v+Oxhq+wfB87aQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rUe/fDB85DFfM7fh+QFYZ6VWMP/4KqUiMHPEMUaN3YU=;
	b=NAPeR0YELWevGImK2+UmKlMT3kW9Qc8ysjT1RXo4qX1M+aqbICDjgQqdbljh1TIHjgd6
	 nLRXaOdpa+LMGeMNuHy1B3StKypTJxLiubmR6zonSCl+bRv0yWXe8fLq6yTY93RwyDF3W
	 ZYJ6NiaJQNu+Dv/iW7+PCKYHCkwXg4ssNl1x42vvCQjvvo0Uxqeb9S3mKNfOUftlBOBqE
	 UNj4vV4wwGpeU1Qod1yxpZRMjjXG5ZGj2K0JCdLZcgjr9AST4g32l1mLVgJUUegAZgI61
	 EEm9OCOEZExYpLa91In0I7v3zQTzKyWKLOqNX9J5nEC0uIbMOLT2fEUKENsfaY8AJ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EihQGIJ9;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9EE606A31E
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 16:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E9EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EihQGIJ9
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j9WZM5r97z1XM4Tn;
	Thu, 22 Oct 2026 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792685976; x=1795277977; bh=rUe/fDB85DFfM7fh+QFYZ6VW
	MP/4KqUiMHPEMUaN3YU=; b=EihQGIJ9SayYyWEWp12HMne+sMheeeIg9euLwqRJ
	OPQX51UuR6/f9ctXpF2+7ThKXiYyVXORahvNojTwaJYlM6tpmBWGY2J8EkWwdeZS
	yj7MtcdLIEHZ4eJ94Gd6dFyM6Fe4Q1t60TmfgoKIAhEqdn6ZIK7fHyQJ/ukmFllK
	CU65TGlAZx2y1P7/iKFgbwMHhhOQNLZdRf7AIQMUblyzT9+VYzL8BklYHZd8EBIr
	Sbf7etIW7UPTeCif6kAQygBm88QofOhLE6DNYj6wf+z84+Wi3BwkIjWQHtreE/aj
	uHJp1es73dvnRG8xUSEvwUMbawaS6AlJbbIzalehJxWohw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id diFMy1hHes1x; Thu, 22 Oct 2026 16:19:36 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j9WZJ2Kvhz1XM4Tl;
	Thu, 22 Oct 2026 16:19:35 +0000 (UTC)
Message-ID: <5c7b9f30-893e-4127-8ffa-3d5b7224674f@acm.org>
Date: Thu, 22 Oct 2026 09:19:35 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix recursive i_rwsem locking in
 blkdev_write_iter()
To: Zhenxian Ma <mzx199711@gmail.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: hch@lst.de, syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com,
 Tal Zussman <tz2294@columbia.edu>, Julian Sun <sunjunchao@bytedance.com>
References: <20261021093332.17334-1-mzx199711@gmail.com>
 <20261022062513.77372-1-mzx199711@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261022062513.77372-1-mzx199711@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 11:25 PM, Zhenxian Ma wrote:
> Drop the outer locking in the fallback.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
