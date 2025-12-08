Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CC2E7F3F;
	Mon,  8 Dec 2025 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222117; cv=none; b=rD2L3q4XW8YUe4RY5I6pSMJLcONds95AKUnZkRMzc7zBk/0opTctLVM74oyGIGb0HiwJiWXfn903pxm/gvgka0VM4f/CAzLoDY5QkkIVuSJDM55wrDSzbxmS8ttrdwTBDU5xaKcvcv0sWhmoDtgIy4OrtFhq57bKd6RnHUBgcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222117; c=relaxed/simple;
	bh=HDG2uAXVi3aBUveh41tkplU2mdOLTj6LlZHJwXiWifk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfyvb8FI5k/D/HJJjp6HbV0MlN9WuQmNRlk74yIpOVK9/MGtRTGwUI4Utz2GEHFhKaU3lZbQOgNug7fyjeQEfYW/40OYUo2tDGGuX0KF626qZHWqHgAlHHLk0+VXfAJncSr9i/WALQCgvVZYi+x+OcAz8t19NUlGx7o138WQqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b9fAYPba; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b9fAYPba"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dQBq74rTlzllB6W;
	Mon,  8 Dec 2025 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765222112; x=1767814113; bh=HDG2uAXVi3aBUveh41tkplU2
	mdOLTj6LlZHJwXiWifk=; b=b9fAYPbaqu7ggMD7kMyMnXKY7btF9Igt3HnAVlhq
	l6d8nhs+OaR90pdkfB4/yTy089e3+907XiWDXyiMTQifwBWa5sJihnrBm4Gzz3fz
	/oTULTg2YY37EGjOZsYgF5O+bxFQq8cM/FJJn9TOkk931ccSyxbyGh8tvZnJ8U4R
	gdPlkOxWYr4e8NEJqS4yGw45efTeDna8r9JZiOhgtIWdt7s/O2S4KOU9doIb0ptV
	eQmvi1zb8Bc0dVZO9UYhw/DpnKMAU7+H6Me2R/fY7f+pMVAozpCqTz52gzeToTGM
	kpRK+te3CvjrLESeUJ2ZsMEdRWkkGVAquNXbzexmdKHi9Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5RbHWmiYFzdk; Mon,  8 Dec 2025 19:28:32 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dQBq05xgrzllB6J;
	Mon,  8 Dec 2025 19:28:28 +0000 (UTC)
Message-ID: <3e559a9d-9867-4262-903f-d54e37141d38@acm.org>
Date: Mon, 8 Dec 2025 11:28:27 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 2:17 PM, Mohamed Khalfella wrote:
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.

The above is hard to understand and probably should be split into two
sentences. Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
