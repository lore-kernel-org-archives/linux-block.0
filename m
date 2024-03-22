Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5857312
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123886; cv=none; b=dEfi1oRhD6V5pKPLMOjwFrShVDAx/cbu7GJDJjbFjUKGY0Kv4ZfaHrEqDNwryk6vZWPRwmte3WYpgmXc/3xw0UB/d2nj7lYuTba9iSYg3wuzYcfMr6OzH0I37dSaWni/ZHVKMEWjIRGeXB3qRyGQArszlyCAuQa2vxpbK8U3pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123886; c=relaxed/simple;
	bh=rLojx5TSaEUfPG7H5Rmd3Nykze0nj+uAA/pJp8TCAyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfhSFdkygIAvu3pEyv6xCn0eB2yEEqzn+LvRtvcyLYIsIM558P8faQD/NTwf6uN3zDkLIQzWF/Sh7umNxvHTnCpFY14sG0cKLK1d71WI24IFm35doTXzi4QUeC9nMNzW88JA0illdwzNJgmtC11e/Z8WjDx9svnIOOOmrgUwSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LHyXaPcB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LHyXaPcB"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1S4X5P98zlgVnF;
	Fri, 22 Mar 2024 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711123882; x=1713715883; bh=rLojx5TSaEUfPG7H5Rmd3Nyk
	ze0nj+uAA/pJp8TCAyc=; b=LHyXaPcB+MjNdpYFWj9PDd0aXq9AnwNqzdTGS3zz
	oXhaIQmvPAn2ZUJTnxnjA3YwoU9+J+DtwA/SSCIkA7z1vYlI9BDM5QFvBtWM+DsM
	URjpWEOybkQ52WCquenMUHFbzECHvHce90yitZXxaX8C1oxCRCQRRM5qU05GxY6s
	nZjY3rfIX3TlyigBRdTBvAcETvyxz0bkAd8UAncHY6q/aBbf2UzsUexwoU282Oti
	mzqMed1c8apVyuwD8dpeih8n27Qhp+q/4HM9M82t7mBd2xLrj2xKBCmxMt8JV9WY
	LUeZZC6EA5OCC3HKeIWd6Pv93n2g/l4aZWRR/kwNqQdtsA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bzNljYDr_elW; Fri, 22 Mar 2024 16:11:22 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1S4T6TnYzlgTGW;
	Fri, 22 Mar 2024 16:11:21 +0000 (UTC)
Message-ID: <1b01dfd7-82cf-49a6-8fa4-dc90ba350595@acm.org>
Date: Fri, 22 Mar 2024 09:11:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240321224605.107783-1-bvanassche@acm.org>
 <ZfzsMIGnaGhWCw80@fedora>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZfzsMIGnaGhWCw80@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 19:25, Ming Lei wrote:
> But the code you removed is actually for providing fairness over multi-LUN,
> do you have multi-LUN test result for supporting the change?

Hi Ming,

Please take a look at the blktest in this pull request
(tests/block/035): https://github.com/osandov/blktests/pull/135.

Thanks,

Bart.

