Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5C279327;
	Fri,  5 Dec 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903192; cv=none; b=GF2HGpfCU9nqreyCFldbWk1pHSTtdTfg58ioSMDPVcBVaPv5uooDU0+fJEHZon+iRlto89mUswiMWynve4f2V+xgHcey5GkqlLfjzVUDopmtkhvvKDhdDMeKOvm/BXhqFITeJrrKo62cMqVr3NVT3eUNU9GkEHvqRtY9aEH34KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903192; c=relaxed/simple;
	bh=iDeTfcx8x+HODREkQsaIliiDoXQQuUTEK4A31JqLPhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoqQqPStD3iEStMCYPl76gz60ejFi799n4aZOg9BnESUFzbKkVT9zuOJl7z8u7V+fUmb1KGDSOKEns3+KV49bc4zVn0bTLsJTfRcPXx0lLX0d/jJ5OruiAFPoRBjx77mFXFmImM1d9Ie+37PvaCf8/+DWJzPfI1CD6+155aDLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zZtBu71+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zZtBu71+"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMwsq68G1z1XLyhF;
	Fri,  5 Dec 2025 02:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764903181; x=1767495182; bh=2RaQ5X4uV+CM2Mlpi5SEV8Va
	vuECY7S0RBgOdY2QNs0=; b=zZtBu71+2GCtkuF0igOpYvRJ+Jw7FHwR/8AGwqaQ
	ptmGr1heomjm06bOOyEwUwcq/Zroy4xn6x6C2Rg0o366ZaeuM6Qiam+f3d6TqJyo
	Xu8p3INeLJ034pKHGpYbpAQnYJENHztOxqKu/YE0CUjatkgeB+eQx3J4suEywZ3P
	5GVnUdmcHzY6EDLieNn6Q+Phthez3majjG6gSgwOObeoH7Vh41OGHopwdnRCX7CQ
	tl8CzNUnF7TfcaVS2udLReoniMLCGPjrtwHJH2RAbZxWyJx4On6gyEeceANE+pLj
	1PqzmJ8OmDL2WZXTy6cfvC9vNU4BTYZX6u0qidNOYd50Zg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5YhPdnh1roj9; Fri,  5 Dec 2025 02:53:01 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMwsd3xM7z1XM0nx;
	Fri,  5 Dec 2025 02:52:53 +0000 (UTC)
Message-ID: <0efc5d59-53dc-44c6-9466-1f662af7ee7b@acm.org>
Date: Thu, 4 Dec 2025 16:52:49 -1000
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
References: <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org> <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org> <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aTI2L6j50VWjp7aW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 3:32 PM, Keith Busch wrote:
> I'm not interested in introducing rcu synchronize here either. I guess I
> would make it so you can quiesce a tagset from a context that entered
> the queue. So quick shot at that here: [ ... ]
The approach of this patch looks very interesting to me. I will take a 
closer look at this patch when I have more time.

Thanks,

Bart.
