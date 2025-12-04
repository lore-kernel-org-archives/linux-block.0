Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D0286D63;
	Thu,  4 Dec 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875230; cv=none; b=IHCWsqXfLEb5mkUVFnRSEKhNPnSlS7PdAOtAcg3Z7xsls7BssOnNqP5nTdMN3QDrnoG/qieuH8tEEyvT+y48xmpPHurrMMK6Uh1wQOC36gcBdaYGOa39heTcDgWdbgAvw4n4feLRb98Tvnnz5Up7tJjuBMTv7q6+NT8v492X2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875230; c=relaxed/simple;
	bh=9z9kLeY5DYOVlHM9zpdwcoUUCBdXdLFLwQESdtgXMjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiMosRWLgynvI0JoRYMfSik5VahdvcnEGdMySIK+PFJ2x4tPn+ApcvDDKUpcyhE3kfffa/+E096beqxlcZe7/criZ7gzbxhf+8ciz+axtoneZTRRi0mBQL66o2heST9G2/K/GbtKIplLsKoYVdFYDLLMfhhK9N+H9dbcReCC54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aA1XOYX6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aA1XOYX6"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dMkX86PqhzlxWdb;
	Thu,  4 Dec 2025 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764875221; x=1767467222; bh=Sxd/Aif4YOWMwisvLZs1jz8U
	DO3+wD2UJitwu5+0+40=; b=aA1XOYX6RSpT8owyMnR+f1C+LVSP+WXgI1mbf7U1
	VrBv+EyKudu3LzWT4/8cbIKwlh5fDVdw9JAWqpGAmJTBVTsgMcLy9OmdUu//t++O
	qjwyEI44j0fwfKecnwTZRVmDsQevOKrqPHi1pV0RsCZZTQZG7QcR/p8FlnKVbPd8
	vq7V9h+fib6qOGIjfhcDa85m4m6HGtw5vQGhg5qshMz68C8SCSqBWQHAoGM4x6cY
	ax6373nIg3XTHMBkuKRag5EdcTFxv/i2HEs0+hAGdTesyeR+7x6EXBzta8aJfKkH
	Op1rg+VbxTry6veh8LgpD52p85pKpxLUs+AHfpRsK4YiQw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JGOgnh3WSgQO; Thu,  4 Dec 2025 19:07:01 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dMkWt4TLVzlfdfW;
	Thu,  4 Dec 2025 19:06:49 +0000 (UTC)
Message-ID: <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
Date: Thu, 4 Dec 2025 09:06:47 -1000
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204184243.GZ337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 8:42 AM, Mohamed Khalfella wrote:
> Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
> take synchronize_rcu()? It is not in IO codepath, right?

Introducing a new synchronize_rcu() call almost always slows down some 
workload so it should be avoided if possible.

 > I can not think of an easy way to do that. Suggestions are welcomed.

I can't find the implementation of nvme_dev_disable_locked(). What
kernel tree does your patch apply to?

$ git grep -w nvme_dev_disable_locked axboe-block/for-next | wc -l
0

Thanks,

Bart.
