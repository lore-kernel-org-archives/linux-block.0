Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11983258EC3;
	Tue, 11 Nov 2025 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890746; cv=none; b=EZovYZn0GawTmZmhQF6Cq3DeZi+WiQE87GIQt0JQ4+BpLyKSFqF0kJIWfwZVM1Kpemio8IjpY1IoIJWuxToo2lTFkR4Q5aE3XbwvCm7WfvPmrWoRjGds2fB3LtazIRL0rwhFJ7nYwVI44me72vDfZBZZ2p/EQkWjUoeAaGypdYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890746; c=relaxed/simple;
	bh=zZspFEIONzo2s7jrCnVvGHGcavlaKjA/gURAB4TOlhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK8h5ldcpZyFP5qOt7sB6EpRH0o10nt7GL0fYLMzc7OIMOGMpXrXlfBkNgrQF6ghpDtPymOSWnztckbqtAGgzuucrxrX2BpS7hXiZ+F1fv/ed6UhdsbSRqnLciA2kS9vBv5BvUjNheXlvNRlWAuBu21vJ2rVoUJ7aOkAqJiBVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=InbOY9zd; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="InbOY9zd"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5cd36vf1zltMJm;
	Tue, 11 Nov 2025 19:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762890741; x=1765482742; bh=A0qul/NRindRW7dqkrtxqmTC
	OAdijRjlc/bCFBsSYjA=; b=InbOY9zdbcUjwPCNTjxbmNmt8kBVHKHK60jNkyMz
	37AcVNHBsTHWNENkjnifXTsodwQtpXfWBdZ/lbgSSzHTGC+nDPRTqtwp0IdkqaMe
	w+p7hc5uj0+ygRnKBzSp7LDUaNGOsN/Icwqu8fvWjGJccPmCrFYZjuAG3/deazfG
	RmfGLB4QjikCDJAcva9Qm/EHyrzWuopTerw2XNgzxNK09Jhj5kSvqrNDqK2aqxlU
	Qh36vrkFNZu9lSoXf4xCU539TvClWX5G9gbU3rJhtJqdmjdfsqWAPN+a0SGaxrT/
	XrImG1wCE8jmAVmCXReMHJYx2uegWAj4/ou/O9kY+mEa1w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 70KoVjDkexMS; Tue, 11 Nov 2025 19:52:21 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5cct60W3zltMJh;
	Tue, 11 Nov 2025 19:52:13 +0000 (UTC)
Message-ID: <0b146bb8-3f7f-4d78-842f-a08b43e5f4b5@acm.org>
Date: Tue, 11 Nov 2025 11:52:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Remove queue freezing from several sysfs store
 callbacks
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>
References: <20251110162418.2915157-1-bvanassche@acm.org>
 <b1820392-f21b-4b68-81fa-0cf123c981ba@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b1820392-f21b-4b68-81fa-0cf123c981ba@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 10:25 PM, Nilay Shroff wrote:
> I applied your patch on my linux tree and ran some tests. And as I earlier
> suspected, I found the following race from KCSAN:
> 
> [ ... ] 

Thank you for having run these tests. It's unfortunate that I couldn't
trigger these KCSAN complaints in my tests with KCSAN enabled in the
kernel configuration.
> So from the above trace it seems obvious that we need to mark both
> writers and readers to avoid potential race.

That would be an intrusive change. I don't think that the kernel
maintainers would agree with marking all rq_timeout and all ra_pages
reads with READ_ONCE(). I propose to annotate both the rq_timeout and
ra_pages data members with __data_racy to suppress these KCSAN reports.

Thanks,

Bart.
