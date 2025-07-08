Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033592E54B2;
	Tue,  8 Jul 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991842; cv=none; b=MuNvneM4F+QE60hy92ULlHb4dK5rOi1L4f+u4Q9r6ubmALUWDZ/hD3X9PTcjvvd3Eq6pUi2X+Wo0NdckUHCYniE27oiF4hWozfw3bq1UgOVRyoosTi+djkEktdHC3PyLJo32ASDxo4h8ehKerys2brwV5BAlu6UH6MOOQyIRSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991842; c=relaxed/simple;
	bh=5hNTFrE0bpBaPPbMXhxAESHBYjh+m+dxnlVSSAeGXAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvMSzuo5SN/IAycJVAQi/6DKyV34UCsgV8wYqJG89rJ4uI1wpjb1LJT7lUnLtzRNXTWhDe6J44E12nHazKEllzkc+F4B/Aj1PUxQQHlnRzvBBIadEIPRLzSb34rbXNA1BED0yvVx36Rn71m2O1c+w4Q2rjvNaRa77xxvSKLuhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f58eezT/; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f58eezT/"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bc5yd3LCvzlgqy6;
	Tue,  8 Jul 2025 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751991831; x=1754583832; bh=5hNTFrE0bpBaPPbMXhxAESHB
	Yjh+m+dxnlVSSAeGXAU=; b=f58eezT/silJaQsprkEDvvH9KkUwFlNnp0hirGGg
	1rsUrHdyIWJ7wGX+W+1QB5IXr7n5poiEbhGZfKAZtir0K0gjYaDoK0r8bNks4w4f
	G8avDIh5ZetwZHKH0vmXZ+6bavSCrQ+enyz2kgT+ZxdYPQylWAFTShEngIN6ys8h
	SPWBj8F6Kd0we+va8KpCEWPgNTbGFyiGlJWIQQ3yPGSW514AW3JligIIopquQzqM
	JWMJ3Oj3ddZ63XrTAW2BMc6yWCrnvsLg1lAHk8uKcd9F+9furB/QyDUA6Jw83MmZ
	f9JRp8JoK9mDCPVO+GVWpD5vhPSOTL5QykJn8ZdYrd7h9w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3XEFc24SopK7; Tue,  8 Jul 2025 16:23:51 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bc5yS2pY3zlgqVj;
	Tue,  8 Jul 2025 16:23:43 +0000 (UTC)
Message-ID: <d9894a7d-3531-4c2a-a016-1b560a13b2d8@acm.org>
Date: Tue, 8 Jul 2025 09:23:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
To: Hillf Danton <hdanton@sina.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
 syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>,
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
 nbd@other.debian.org, syzkaller-bugs@googlegroups.com
References: <20250707005946.2669-1-hdanton@sina.com>
 <20250708001848.2775-1-hdanton@sina.com>
 <20250708012450.2858-1-hdanton@sina.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250708012450.2858-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/25 6:24 PM, Hillf Danton wrote:
>> nbd_init() is already called only once because of module_init(nbd_init).
>>
> Ok Bart is misguiding.

No, I'm not. I didn't write anything about nbd_init().
