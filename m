Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB22D8371;
	Thu,  4 Dec 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764890586; cv=none; b=iSDH4l5tujaUrnmtN9dHrx0DmoWwxlxI1fx06z7DwdmXrK1mRsNc7vlSFGDEJXoH3EGd8gkFsOin/eWIUAuQxTDpPZO/fiBqbnyOqgnxVx6M9E2RZ8cAuxRC7wJhLeL/lfak1oJtwC64Vu3pdlJZVw87NjQUx9UWTFQlGOm4HQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764890586; c=relaxed/simple;
	bh=EJpv+ErNdSq0qEHVcKWgOqaEioKBuSkfq1rACQnUnEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3KGYUsDBUpLimcXiJe1/4+yA3LC10SO6vtEl72mMGuCSF2FwsNryR9oL1vUwipEOQCzNX4pXQI7oygPRuXFTxo19u307dSRPOniZTNJ0ujVUhYpeXR6jK5h6XhLGGOUPG08TXm55Alk7xbyeAP3Bq0rjWdKAtX/aTXGL7RuZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sH0eaJo3; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sH0eaJo3"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMrCX3ByMz1XLksh;
	Thu,  4 Dec 2025 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764890581; x=1767482582; bh=l83Pny9GYXrwKC6pNJtZuDPN
	UiGnu/Vd9NOnnwLpAL8=; b=sH0eaJo3AYqTeDnqXPUzIam0eBKY7WvIX7EjIbq2
	kAVb59TQmTFQhGmXI1W9EaEHeFGFPciarIMZtDfDAp+fNfjtePe+1K+VEaPfefs5
	bDVHA9zqabMcyKk5nruNAjh4FPnh3WkfGJec36KwcENjvbxozhyspcc3ZE7qCo4W
	jLW9yw4wjxne1ZyoXZ2uQSSfHdA04v9K12A4J+f7jXcnZ22Up+W8gNpps0EXErsx
	X8n+vDL46aSAOOWXZifiHJmGEFQ8Qeqiz/TdxEn7Ma8zFMkTKtKppnnz6AuXHuP+
	xWe9lslBCDBCbYOmQTRAut0YGCDcf/tgvRHj5KxF3s/oSw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pzA6pr0CsDbO; Thu,  4 Dec 2025 23:23:01 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMrCJ6QBtz1XM0ty;
	Thu,  4 Dec 2025 23:22:52 +0000 (UTC)
Message-ID: <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
Date: Thu, 4 Dec 2025 13:22:49 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Casey Chen <cachen@purestorage.com>, Yuanyuan Zhong
 <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
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
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org> <aTH8opTiwJxH2PMA@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aTH8opTiwJxH2PMA@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/4/25 11:26 AM, Keith Busch wrote:
> On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:>> Hence, the deadlock can be
>> solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
>> and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
>> I/O and does not call blk_mq_quiesce_tagset() then the
>> blk_mq_freeze_queue_wait() call will finish instead of triggering a
>> deadlock. However, I do not know whether this proposal seems acceptable
>> to the NVMe maintainers.
> 
> You periodically make this suggestion, but there's never a reason
> offered to introduce yet another work queue for the driver to
> synchronize with at various points. The whole point of making blk-mq
> timeout handler in a work queue (it used to be a timer) was so that we
> could do blocking actions like this.
Hi Keith,

The blk_mq_quiesce_tagset() call from the NVMe timeout handler is
unfortunate because it triggers a deadlock with
blk_mq_update_tag_set_shared().

I proposed to modify the NVMe driver because I think that's a better
approach than introducing a new synchronize_rcu() call in the block
layer core.

However, there may be better approaches for fixing this in the NVMe
driver than what I proposed so far.

Thanks,

Bart.
