Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B93DDB02;
	Mon,  6 Jul 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343583; cv=none; b=R3AHo4bKdceTeqhW+CIaxY5uwki19E8dRfXcNKRcndGSnYUk0jx/jkcVRCC/CrM/Gb6WyjMvpu66OEBd8cz6yD/6sCjlBrpWRsLn2DMJ7lRl5fT0BwADhuxLnBO6B9SwVCOGem12KnfYtGxbZAjz5dPVvtK1zxhWNUV5mYJEFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343583; c=relaxed/simple;
	bh=wRCIa2yWKGtXfZLhGMfRbokRZ/xG5DKkIlGrUdCjGdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sql5LVJr1oSOgdl/xqDJ5r+mCza0HBIFy89pTxymw/SaQghtO4GyLWrkrc+ggOO7LogwtN31KZSXrEG99PHzkGlIfykWVBIbe/DWvxNCvACYV+aac/NIw85aepefDfoi5SRoB/0b0CW9C6wjoJ2utkQpkpBB4dHAf3Q/2B/d+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EsNFidRS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EsNFidRS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gv4Xs59cczlfvq8;
	Mon,  6 Jul 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783343576; x=1785935577; bh=XjDi0Jo7s790/BaHSZuBsua2
	fa7+elFsXT94RESt5Qc=; b=EsNFidRSmHaByg1dH3AKRJDyoots2+97ion9R3BH
	pYxGMTar3yA0CKwjzZT6fNTiDqk0AzpcoMUXBGJ7KWhDl0FOC9YIk4iVOZ9cRIP8
	KAd5LiH11pGheH3WWOtoYsHgbbOq9yrvG33Mtn0DhuG15r3AAeFUZQ8BHBoBR8ti
	qqlwO7lHc80Sgacyl9h+DQ5wBEDwW9xamC0TqCpANXY7AG65SNINOb40KEg+vl9g
	mPnbAwwsGI7fgWqFD9Ucf/JVi/Lq2CN2/URSj96X+MXugcPW8NURak8CRu+p+v3b
	RRlKTa+EPfJI7KPm73SybKLu3dSmi2mljQGKV4V6DIUdQA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4VAp4U85OalG; Mon,  6 Jul 2026 13:12:56 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gv4Xg5Zy8zlfdvj;
	Mon,  6 Jul 2026 13:12:51 +0000 (UTC)
Message-ID: <9004743e-f522-424e-a1ab-8779ecc6da02@acm.org>
Date: Mon, 6 Jul 2026 06:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] null_blk: give the file-scope mutex a descriptive
 name
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-3-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260706123507.3809871-3-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:35 AM, Zizhi Wo wrote:
> The file-scope lock mutex mainly serializes access to the global nullb_list
> and related device setup. Rename it to "nullb_list_lock" to make its
> purpose clear. No functional change.

 From commit a2db328b0839 ("null_blk: fix null-ptr-dereference while
configuring 'power' and 'submit_queues'"):

     Writing 'power' and 'submit_queues' concurrently will trigger kernel
     panic:
     [ ... ]
     Fix this problem by resuing the global mutex to protect
     nullb_device_power_store() and nullb_update_nr_hw_queues() from 
configfs.

This makes it clear that the "lock" mutex has a broader purpose than
only protecting nullb_list. Hence, the name nullb_list_lock is
confusing. How about using the name "nullb_lock"?

Thanks,

Bart.
