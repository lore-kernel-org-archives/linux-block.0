Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86B398F98;
	Thu,  4 Dec 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879861; cv=none; b=uMSSt7SxVUvmttPFYAGfly5L3SoyyzAbWrA4zDWtiGXDtRQg5xm9In1CC59hpn5JdDK5BpK2KMwgQHiuRKs4AFeZdx+3ri8AZXhUBA3QftoHMNPDG0kH2Y9EFwi//J27Mm/gQQ8ntGWy22S+sCzgs23M89W3lS1c+CkCICWr3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879861; c=relaxed/simple;
	bh=ZCn2qpD9CNnD+VHrPDYRhycXHcj0FEGMiFdnEQwtU4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYZlXEekN9cMzyEEFbPrZIyRt3ulAs8xGKteHMo6UGQvixg7Mo2+0ILsIo+wG/eIScmq51VCdAF8xqr4crKapoVHG5hLAFNsI3qoy6DqZjRAznIJ2pYD6rNty5Pr8tK3ILzQVBj+6ZSkcqVG9Xc0P7+0iJbPERJwtU71UNa3Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o37YQ/Mr; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o37YQ/Mr"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dMmFG5PdJzlm2Cj;
	Thu,  4 Dec 2025 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764879855; x=1767471856; bh=ZCn2qpD9CNnD+VHrPDYRhycX
	Hcj0FEGMiFdnEQwtU4c=; b=o37YQ/MrK/oTr8ig/nG60k8PC0RNBxkmExounFR8
	Tv4mZzEg2lkrUbNBfqToURY7Msj+9DuPoTltHolpBxVdjD9E1bUVGqC0vFZYrNAk
	2ExPGwBk5Dj111Te3n5JG4FLTXeYSZqIg2VHW2yb7z7i6GrB2yBKR1v570FnuoEA
	sGfzDDKdAPM3paElUYDfarsywnP5w2pSwthN6+r/Xty30gDJofN/hNeeDFmmZCyc
	QWzEiDwVWCDG1soY0HyOKq3J56pMJRwkPk89BOYweJAfa+FyKBH3867ZunjfWEk0
	HjNlPejQD45hbLL+9drzee+b2kcAdnAb/SDH1FjYlTF6fQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Aarkzny0G2Dp; Thu,  4 Dec 2025 20:24:15 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dMmF315czzlfc3v;
	Thu,  4 Dec 2025 20:24:06 +0000 (UTC)
Message-ID: <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
Date: Thu, 4 Dec 2025 10:24:03 -1000
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
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204195759.GC337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/4/25 9:57 AM, Mohamed Khalfella wrote:
> I do not see how running this code in another thread will solve the
> problem.
blk_mq_freeze_queue_wait() waits forever because nvme_timeout() waits
for blk_mq_freeze_queue_wait() to finish. Hence, the deadlock can be
solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
I/O and does not call blk_mq_quiesce_tagset() then the
blk_mq_freeze_queue_wait() call will finish instead of triggering a
deadlock. However, I do not know whether this proposal seems acceptable
to the NVMe maintainers.

Bart.
