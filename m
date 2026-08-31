Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A136196E;
	Mon, 31 Aug 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209746; cv=none; b=id9B0P9xhgw0eEFSVqoJ7I0YgY0hkOTa4xvfNgdcmnwEsfO952eUlCYJJbfM+fZrNMzzAWSA7VlZpagxrxsiBTWr3Ua6nWQyGuAax/cOFnj4/DNT+g1hAlmYxdnA+inx0oqx0dzvPQv6VI0v2LePmFuarmJzFWX505B/iBN6qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209746; c=relaxed/simple;
	bh=N8D3gfWFFaacOxE+y7IY8hMmFaWjJ/5ePp0ae2BCeps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj8nG1RSYeABljThTehcStaA04YGdf0+6Z7yXnyxJ04IIkdMQ0sFI1T7ef0G7osH3s8LfQSStfJwsZTNMrSRTIWV5VgHdzjPO35vCgRmdwKl+wAl1/6edI0dm5zvWZeH3Lo/EfC1ovECfxsGNU+NNFEYoL8kH2Qs1sxtdtYNBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NnHA15F7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NnHA15F7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hYh8v6QgQz1XM0pP;
	Mon, 31 Aug 2026 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1788209740; x=1790801741; bh=nCyDjwBEtM92hHXiIwvWaPmi
	FnCtabd7MOq+4ScQySc=; b=NnHA15F7f4OkkXLJG/MzONJ9sln/af7xEOBId1rN
	9SXz22x+fcqoR0HYwRl3Fj1KVnUSfWce5DIaGOzEaOLBYoIlL/wmZ3l4GMOW+DMS
	ahQCYmIq288ftK5mdcXetKQndQHRc85/L5K4s+5PbemN5voUogA0x4k9VvIub7Y3
	QxtE0fmFN6IEoD1xIdoPZ2DdcjIbyUr0TSVfJdB0p6801fHVPCSHabKmW6eZTmUd
	JAdMe3+vH7eu6xyCxI2Gv5eih+tcSfJ8ibr3DPlZfiMVUb9Gt4TdRUIc2PS4wrDv
	vEHM6HZgTPyWY3rUG61eZ+41pFQ70xwEuhyb6uXUyetdGQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uRVNb9rAlnq8; Mon, 31 Aug 2026 20:55:40 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:a104:ffdc:9983:687c] (unknown [104.135.182.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hYh8p4pc2z1XM0pH;
	Mon, 31 Aug 2026 20:55:38 +0000 (UTC)
Message-ID: <164f232c-45ed-4b77-84f8-c36987c891e5@acm.org>
Date: Mon, 31 Aug 2026 13:55:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] BUG: corrupted list in
 blk_mq_request_bypass_insert
To: Keith Busch <kbusch@kernel.org>
Cc: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Christoph Hellwig <hch@lst.de>
References: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
 <2cf45e85-176a-4209-86ad-8f389a9a4282@acm.org> <apWWsVUm5ri7b4oR@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <apWWsVUm5ri7b4oR@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 7:58 AM, Keith Busch wrote:
> We want to be able to retry eligible commands that were caught in the
> crossfire of a controller reset.

Got it. Is my understanding correct that the NVMe driver may trigger the
following call chain for a request that is already on the hctx dispatch
list?

nvme_cancel_tagset()
   blk_mq_tagset_busy_iter()
     nvme_cancel_request()
       nvme_pci_complete_rq()
         nvme_complete_rq()
           nvme_retry_req()
             blk_mq_requeue_request()
               spin_lock_irqsave(&q->requeue_lock, flags);
               list_add_tail(&rq->queuelist, &q->requeue_list);
               spin_unlock_irqrestore(&q->requeue_lock, flags);

Can this scenario trigger the list corruption reported by syzbot?

Thanks,

Bart.
