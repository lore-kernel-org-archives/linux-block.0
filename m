Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0838F25A;
	Wed, 15 Jul 2026 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131324; cv=none; b=nZavo2xOQ8K9q03+6c5Lju4ZnpLhAeq2KWx67fI0x1FItmZriA/buX3c2Rb63S77nWPvCnE2gYCtKqmAsE1ETuExEOkeOALkEhDX+9xZpmujsVfkVgS6X6IjkxwtRpVLVVPoneRRvma/rmllSQ+jv9ykTHP2+B2UgEBmet28xeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131324; c=relaxed/simple;
	bh=CtPnErgxzlUsTa1PT902ZiLrDLKGVfd+NI4BqbPs3D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kmcCwg3nICmdaN3gHYIF6GiKEaAm5ahCzmvJGEFRS4cwmWurY6OurdXYLvIk18MGIy119kvhwjNIAaDCvNIgIHH0dcOky59QtfGtILEjcvuh95LVkhfNpql++Bd7KU47TNMKHj4+gd/Mslv/XjtMqD8P1HXUNKbQKzY+ZJZereU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tdIBtwsh; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tdIBtwsh"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h0gsk2PsTzlfc9G;
	Wed, 15 Jul 2026 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784131319; x=1786723320; bh=CtPnErgxzlUsTa1PT902ZiLr
	DLKGVfd+NI4BqbPs3D4=; b=tdIBtwshicjSXaFZ5pvrwnjKSx6RrctXnfkxUV9H
	1FOME0CNUFcCUp1PRoN9orHXIn0DIqQEU4A0FtAlQuX7dQ533uBcNWOHC7sNF8+z
	1YLvU5JROV45MLPn4BYM9uooPeAnwU/kufB4GIsDVIryN+urmxNHcuMU6TLPTXDk
	uYu7RXrCGhbFnlRdSI1dewVtroGZ7ORey5yGTb8MuDseTF0FNHd830P1PtkMxLpd
	bqqtlETxzrRF0aLxGXN9j6LP6rNf8Hd7H5LzAww1bn0JYutvDq1h49+bykRxeEA3
	PIGhVs3WBKjfapfcep/8GQDvekLD34QXAMw2MwXaqohjCw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nRrhdntD9B8N; Wed, 15 Jul 2026 16:01:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h0gsc03xfzlh30R;
	Wed, 15 Jul 2026 16:01:55 +0000 (UTC)
Message-ID: <e1f2d5d3-6974-4294-a459-89a5f6c360a9@acm.org>
Date: Wed, 15 Jul 2026 09:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] general protection fault in lo_rw_aio
To: syzbot <syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Christoph Hellwig <hch@lst.de>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git@github.com:bvanassche/linux.git block-for-next
