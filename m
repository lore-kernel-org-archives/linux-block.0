Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281487;
	b=vUNYeCSpxMXrHD9SDgHxs/1ASyAi2vbh09TYpohtb574qidHN90g5dGts/O8+T+vAbVe
	 l9u5MtIEEtxn2SYRT0JazNhwurhi9ix0UOjIwEITjO1jqqxrUWytU1HVv9hX9mFjbJ/l1
	 Q1q9sSXuWljxqbRhNCE/G8Lxd8pPxf1MNRhIRRD50k3qZOt41JslhQDJY78lhMHTaG47V
	 Byf5EekawMoW4jp8KVmY2Ak/IV3Drxhio/pfx8fXKj7uNKA1cA3qbnp42c47hhMhh3QBc
	 t7Ces9huYqYXIr+lU9hFSv65GUYxAyl3Z4GIc9X3ikPDZ6qrpNsjr8srsjqUtYV85PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=q2xEk318stCghrlIrW9didzhntYxJYBR065U1dSrXiw=;
	b=wtRilt74uaOSKB+/RA6MjSEQOK+sJpiaggdzA3qBi1fziyi52Bm1tp7ht783KqJWByjB
	 75a9iYNy4PP0+6rvg8QpfqtBDBN7f6HjvnZx9g+rzfncdvy9n+19e3wO91rGGiWxAFJpq
	 nKCyyGML/CkdoGb06SeDISv/K6W6P1lWzFOQ3aEiwedFmpVXZ6SMyawXJ4nGjInvw/R7d
	 ypyjC+TBMsGbqafNrhRWbocDLdqLAeIQ2wkgtPjRhiHgBeKY0lQO7WGUcvNZqtO3J5gbR
	 RT5KnNoCzc82I5wgr1VPyJ7As5yh6qY72rzk3JWba8k/f0cl1g3vF7CUxsaIK1PMYig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="fJBe1/vj";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673D606A32D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5673D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fJBe1/vj
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3006152eec.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793281485; x=1793886285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2xEk318stCghrlIrW9didzhntYxJYBR065U1dSrXiw=;
        b=fJBe1/vjyxbYvmPGRF32wIti2+b0qBZ5U1DFuX9vrsp3pzM8QZyT50/qnNdvIhcHuB
         BRvsz45uhCWqR4tb7L7mK0e9fGfXX5WerttOQCJGGznvT4CFWaOuEN2dJ7NzT4sFTiPq
         O4zh8/8O1TDKbiJqq7G0p7/fsJBBzMpubRGzwLhdOU++dmt2KgpCsoVVLK5agdLUsZrL
         nTV6EejRmAoso2SZA2GWgY3Fq3Qw0DIIjBTWQdblwYgSh1wb2YXt3Eiwjan57w1rDw1s
         rV9Zw80PJmJvwr00sArhWUCgho+PPPde9jjYZ2RFMgcBYJ4kGGw3Ubgv9Qwman+ttD5+
         thBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281485; x=1793886285;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2xEk318stCghrlIrW9didzhntYxJYBR065U1dSrXiw=;
        b=P78BBHckJnjHl0miFEMnIMgpbz0yugy9aL5oLwQst6E412qwi9aplvG6LRj7xJ6joG
         Ku8EOTnjj4bXShZf8OdwHxe0ZYF/n09IgZsNAY8iseAu8Ti404T5e2Bcb8WviRvf9LgY
         unLWDLKKu0Ce22uDhc73VvmueDDPr3Qm4L5X0WLQupznhncCHzwJSHpXUae/76wEC1LS
         UNvhNAU6sczgdrCWPod25TOxwi+xvwhM/7T1UNzboewELlBQ2+syAkOUbl4usU08aoaX
         TZPbuFbT2SZ/L6F9E/VXBVbOpydAnIQnFTcKmv8mIVyIQWNK8iTWsADxRa4RDq1AFSjE
         I3pw==
X-Gm-Message-State: AFq9FYI/KWBjz+BTb3REDFhUujPM6GAVqUUEb29MaH42P/pojUYV2YV0
	1dM54krXgWvp0Sio7irk+mUzKZewtN3o9XV6tTdJzXlKanZuEhBPdV8LFsY1F0VnHCWOdni1iqA
	l3CKCj24=
X-Gm-Gg: AYBFou1XqHfCPP0qNNMAW4ck3aN2gAMm+LzxCu09Fm0Lq6ZWFwNAglQB6j4KfW7mKjH
	hKcN0QMFrxKkQmQTUnf2Tw9gZ/BsA2UGdL7Dhh8KJwJtvn+LmX+nab78Crmycx6m2wzGDjtMcH7
	7HeAirqGUhI9LubIpMJ4YSrHPSCHSY6bMdJy/stXTJ9p7LCsQZWs1BLNM+NbW1g7tXIHobIQ2hM
	SUMwzhxHbNxNE5yRrEL1WTvbjr4VrJ6T2oRt+JT3vnmGXismXitJX8byXcdFCrYaPjJ7UhXK2Sd
	KUTdgwe+spPXwJcRN8asxj+WPqyBJTLPFt6VbWVi4wBAXng6P07/CZJbimV10wGdzWVNaDg32jD
	th/gpL+F6DIyqhbQV9Pr7PxjNyZh+43VyC3cRDgjsEcXN8FceKbzPIca4+U4ObA+pjsg8d9rHbw
	3TsbLafeio7JIFHhlqrljsQJjs4BX+S+Du+PvV1ULxabNWaiqt6J1zkzfGt2QeHtFIEc8X857yz
	k++8+uxeKh3MWuApdpT3bIM2WD7Zf5aBXOcysTwFTtA3wsMg90pEZEQ1RmlIZKOLi9zFcfFNyaX
	euvH+zrB62VDiKXGmUzAOlKR51I1c63+qPDtHLZjlaxYNLY9aE6qKe5FBUlXdYqNbXcu1BWJY64
	ecPXrXPryGjdg
X-Received: by 2002:a05:7301:6195:10b0:35d:95e4:267d with SMTP id 5a478bee46e88-36a200c3b89mr7658330eec.27.1793281485257;
        Thu, 29 Oct 2026 06:44:45 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390929asm21976894eec.12.2026.10.29.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:44:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261029091047.3085558-1-wuyuehong@cmss.chinamobile.com>
References: <20261029091047.3085558-1-wuyuehong@cmss.chinamobile.com>
Subject: Re: [PATCH] block: fix kernel-doc warnings in blk-map.c and
 blk-mq-dma.c
Message-Id: <179328148355.1447413.12784819790561394252.b4-ty@b4>
Date: Thu, 29 Oct 2026 07:44:43 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 29 Oct 2026 17:10:47 +0800, Yuehong Wu wrote:
> make W=1 reports excess kernel-doc parameters for bio_copy_kern()
> and blk_rq_integrity_dma_map_iter_next():
> 
>   block/blk-map.c:366: warning: Excess function parameter 'op' description in 'bio_copy_kern'
>   block/blk-mq-dma.c:379: warning: Excess function parameter 'state' description in 'blk_rq_integrity_dma_map_iter_next'
> 
> bio_copy_kern() derives the operation from @rq and has no @op argument,
> and blk_rq_integrity_dma_map_iter_next() lost its @state argument in
> commit 91e1c1bcf0f2 ("block, nvme: remove unused dma_iova_state function
> parameter").  Drop the stale parameter descriptions.
> 
> [...]

Applied, thanks!

[1/1] block: fix kernel-doc warnings in blk-map.c and blk-mq-dma.c
      commit: aa977f5d96745d5ce61eb2da4b121a3299004ca8

Best regards,
-- 
Jens Axboe



