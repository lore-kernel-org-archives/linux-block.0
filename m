Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F034F49F;
	Thu,  4 Dec 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876729; cv=none; b=ovV6f80IcpFwtRx8hMiGiDXXOqfw4WP+8tKZKNopbJAbWo82Ogr/qvBekWVPzTzwihes18jukAtKFXhyATlKH15vaz+PTyNzu20+wSbC6K40xzUdb4oe5xVQs8paRuH4bL1QpS3QB6zBVwIiG4FSfb1hA2TGHwMZYlPkXAoEJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876729; c=relaxed/simple;
	bh=WAe8RL5TUbaOLzi0X07eRq+XPerge4ZQDYpUeeEnTBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFD+oxWsz9+ZQWIk9ztuVdyOtM4cd2gyA2+sGg8berecQ+0/ydv5e5AL7D2NKPEhuaLZu2LnWgojMF/zznIjUQF+uFH+jW0I6IhFlw8t6ion1fqo0nYfWDaDXULP20oul/G4q1AJP29NWYqaVGbudXOEz1frDY1ESt/pu2G7Aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YNcB1XcU; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YNcB1XcU"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMl524dvSz1XM0pg;
	Thu,  4 Dec 2025 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764876723; x=1767468724; bh=oBtxSOgzd1VlGzgFhViRN3bD
	jRi/zbapb0CSg4HM0OQ=; b=YNcB1XcULY1+fahNQL48zDch88kZ2jF3alXFk8nS
	wfBu8etQsjH7LlxJ5apJTtkRZvrzkwEOemE4BUbIw77LyRXrKv0iVN8OHsDYlwMV
	BC/dg3aVdYlCdmDPnWTI9qw+a08jIgGGefs1VSstJpA+lZ4utiZg5lBWoZQZll2d
	29yXzkvE2C5VbGN6VU4dH6kcOH5YBTy/2Q9xPsL46f/zVRToj3E55Cg6Wfyvn46r
	Iguj5oLhAmASLSdb7N4JBt/6WkIA4Wpl8Emk47Ir2yrGGBAJ7VoIvQwdzK6StEAB
	+nayfE9d4ZS0Du3zin/9WSuqcUioFGGb9e2LrmyREisE8Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NaudrHerNdNH; Thu,  4 Dec 2025 19:32:03 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMl4s34Kbz1XM0pF;
	Thu,  4 Dec 2025 19:31:57 +0000 (UTC)
Message-ID: <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
Date: Thu, 4 Dec 2025 09:31:55 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204191555.GB337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 9:15 AM, Mohamed Khalfella wrote:
> The stacktraces are from old 6.6.9 kernel.

Please always include stack traces from a recent upstream kernel in
patch descriptions.

> However, the issue is still
> applicable to recent kernels. This is an example from 6.13 kernel.

Thanks, these stack traces make it clear what is causing the deadlock.

 From nvme_timeout():

	/*
	 * Reset immediately if the controller is failed
	 */
	if (nvme_should_reset(dev, csts)) {
		nvme_warn_reset(dev, csts);
		nvme_dev_disable(dev, false);
		nvme_reset_ctrl(&dev->ctrl);
		return BLK_EH_DONE;
	}

Is my understanding correct that the above code is involved in the
reported deadlock? If so, has it been considered to run the code inside
the if-statement asynchronously (queue_work()) instead of calling it
synchronously? Would this be sufficient to fix the deadlock?

Thanks,

Bart.
