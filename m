Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABA263F5D
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912537; cv=none; b=ABU6+MJzxtRIxs+iiq3uAOEQbnCGcpydkGNgRmPgVaO68Q0UaJGZMK6ZtXgTyGBswM8DaCOHQe9Vo6Co6xC9gd/vFkiOODWSxU1HJzpmV8Yy8bc0FsVqz8oaIdNS7g76mpeA49OnZh8XefTRkjja0LcZ0o27BzkPxChUX3jjYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912537; c=relaxed/simple;
	bh=ITfM3Vm8yRBmlg81kwiZtxomlwdH5yqI25xqYSqdFF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdjFe6EVu6uBboAj+VvdHa/N9OF5pesUKgLNS0HtGrw4EwvSAu9Id6gMQqg4x2Znm8Oh7KsGL46pGwlp3T9OYnNuwihqaAlPvIXVrrjC1xkUkpH6WkqsZOpFiYiO5CBoNruZOe4JfBA8E/oq9R+xLb0RvolP3xyb+sdg1U1OBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gImaJ6z7; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gImaJ6z7"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bbXdf3xdKzlvWhD;
	Mon,  7 Jul 2025 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751912533; x=1754504534; bh=LaGc1Kj+La5YRGYG8suHYsQI
	Ur42LYNX8Hl55vSeGak=; b=gImaJ6z7iu8LYPK/7s5Ub1BFkLnEW/dgZHOv/Bh5
	dv5FzyqLHoS5sai8ixf1zURo6mCS0xGnZxHHKzsyfSOcRU75Dx3Lx1ScAC6/Vg6z
	OhAPD2SUSV3SHKhegXLZUO2sZK4+FyQ699mLuKZzgF2kDaDYMaQQvsMRp95vU3C7
	wG1DCEq8y0oCKifeDc9KmayaQiSA+AULjFeKvthum8dH8mrKiRZO1hjlYHCS6dMJ
	+Npzqn746DD1GZ0qAVl74hDW4zGCbfZMe3iI8H5lhnOYaFCCXqmC1cj49g6I69ll
	q0YUb5jqhx4CYaqYjxV6FlF+IPcdwAAxU5MQ54bs8xfEeA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XyuJeAWFIJ6E; Mon,  7 Jul 2025 18:22:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bbXdY3cJ7zlvRyX;
	Mon,  7 Jul 2025 18:22:08 +0000 (UTC)
Message-ID: <bbf1ec71-6a6c-440d-9ddd-efb5c5e10d44@acm.org>
Date: Mon, 7 Jul 2025 11:22:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
 <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
 <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org> <aGXiH1HqSlLk-QSI@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aGXiH1HqSlLk-QSI@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 6:51 PM, Ming Lei wrote:
> The dispatch critical area is much _longer_ than queue_rq()/queue_rqs(),
> block layer data structure may still be accessed after .q_usage_counter drops
> to zero.

I think the above is only correct for block drivers that set the
BLK_MQ_F_BLOCKING flag. If BLK_MQ_F_BLOCKING is not set,
__blk_mq_run_dispatch_ops() uses rcu_read_lock() and rcu_read_unlock().
After q_usage_counter drops to zero, the percpu_refcount implementation
uses call_rcu_hurry() to invoke blk_queue_usage_counter_release().
Hence, when blk_queue_usage_counter_release() is called, a grace period 
has occurred since q_usage_counter dropped to zero. Hence, all request
processing and all dispatch activity has finished for non-blocking block
drivers. For BLK_MQ_F_BLOCKING drivers a synchronize_srcu() call could
be added in blk_mq_freeze_queue_wait() and also in
blk_mq_freeze_queue_wait_timeout(). However, I'm not sure this change
would be acceptable because it would slow down queue freezing even if it
is not necessary to wait for dispatch activity.

Thanks,

Bart.

