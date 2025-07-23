Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEB285CAA
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283364; cv=none; b=iSXEhOHVg6rkyT+nEQpXpmMYdSDayY183MR4QDXAMu/LaYpCZxMacvbwhs6R2Q8RqwPgc78TurrQsKtrlp3eDDmqrpSmMNPJpEEwYJBT+KAFL07UZcZa6JeFQ4E44/UgHxEJGiq0zFqOGlwEDytlqYE63Jv6dJQmeWokcQ7crnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283364; c=relaxed/simple;
	bh=yUdFzk2ifSE01sauNskT8y3l8U3KTa9I3dfD88zPJyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBSiw/hS3lm9Yc8LCP298YuWnvTqZiYSfDmspiOYarCrFz/9QQMkOrwuUg6UpsdczOTGArrD53ta06SKi4t7S/zeU1RDUd92BmP2FlE8WA4pApSk0BGgN5vdiRBsuAP8O9jIKPCzwaEWUDOFVOuzxhnKDekwQTUlYAJieNmeelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WxVBNvLO; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WxVBNvLO"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bnHbh3kDxzlssxt;
	Wed, 23 Jul 2025 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753283359; x=1755875360; bh=yUdFzk2ifSE01sauNskT8y3l
	8U3KTa9I3dfD88zPJyQ=; b=WxVBNvLOpjbYyT3cbgeKTbWIjCEN+FiZPCxT7kcG
	y/Ej2/qDp3xjXwTPtSLz5Fe+AdaUzkSa5Bw2DdvEM4MKaSm0vSzBHA74e76GCAOM
	rE8RSVz85i+fdSA5t9RtiTHf+rsEe74ku8Ci391YSi0c1YShxE6WaX/yVIsqmPX/
	lj3mKPxTlR05fXamxWmd7gOALRMFUcV2/uUi1sQCP8oORgtWCvnS6aGDjgjUSS10
	78Y1Oqxi1zj67/FQgjAGHK8bvn+gJLd1u7NzxnqV2P0MOHev/osid9WW9xZ/ZzaJ
	aHtJuiq86CaE0LIVYkGmfY7KJhjxohC7N/15Fu27IB25Aw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EyTrEubYshv1; Wed, 23 Jul 2025 15:09:19 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bnHbc5Py3zlgqV5;
	Wed, 23 Jul 2025 15:09:15 +0000 (UTC)
Message-ID: <9830a8fe-7c03-454d-b3d5-95e3df5076fe@acm.org>
Date: Wed, 23 Jul 2025 08:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Remove several superfluous sector casts
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250715165249.1024639-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250715165249.1024639-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 9:52 AM, Bart Van Assche wrote:
> This patch series fixes one bcache bug and removes superfluous casts of sector
> numbers / offsets. Please consider this patch series for the next merge window.

(replying to my own e-mail)

Hi Jens,

Do you agree that this patch series is low risk and that it is ready to
be merged?

Thanks,

Bart.
