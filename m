Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9271CBEBF;
	Thu, 22 Aug 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336706; cv=none; b=mRhn8u/dr9rOwO8csg7c16YXJHB+gAcicMezeiZxs3cvRdLsXmNmFc9Znr0dUwPaaZyivdKhioZ6o4HJD5hb++q6G3IUATvhURRrxKPHWjUZR+O74uXd3fVECKhEnoxzmZ0NXlo1rgXs91JfkH9ZTVnZgmBZf5hSdYs1pqgwhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336706; c=relaxed/simple;
	bh=5gAn08tl0DWw9UTcGtfFWbARqnR/Yvy1JbPAIXA+o/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX0fULm3lmkMvSl5cKZGCCZO0EzNTzJtf8Y1KAjAsEoAKndpGFdlpHxxwsqe16rhlKx0YY5E+cZ+6mmkcVnTA60Xhu2He7iwdgRo4W/p68j1Bv27LA7fs0sDZJnt/m1H7KFnIIsGdPfCHV2q4aYcUJvWt1rojtYrjZszP0S0Roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iayurmIL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iayurmIL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WqQTC6Xh1z6ClY9L;
	Thu, 22 Aug 2024 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724336697; x=1726928698; bh=A7yFaIGsFtQ/Bafrc7gGhxSj
	CNRGAj8JHNdgO2uxxPM=; b=iayurmILqnEybKQXnzw5y6A7YPTUlHSXOEPjy5Wq
	s6Lqo494HmCoYbb5UZ87Cn6tvajKUZuScpHKUZkEjS5rfh0s4n4L5rPcTr8D2egU
	8Fxa10+ArC5J9EwHrqTyPhyJ7/57Kriu/H1COPnZKY3XOFrsYnWoV/duKe64TYnI
	hH7hb9VH9qq4Cka0me+ROlzR7A0ITIooVqn2Q9UfjIpA6Vy86ZmsCcNT6mcOmC/c
	QuHmj+3/bIrL9p4cygKiCKhFHyLmgMOmcY7i3wPbgoU9IBYK//WZ1isbteX8mvuk
	7opqTY9Y7SmvQoUxe6SUtWFGtVb9bcXu2aAlbtVMAkkaNQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Vh6dqYTRNtGE; Thu, 22 Aug 2024 14:24:57 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WqQT11wDxz6ClY9F;
	Thu, 22 Aug 2024 14:24:52 +0000 (UTC)
Message-ID: <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
Date: Thu, 22 Aug 2024 07:24:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
 mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, bvanassche@google.com,
 quic_nitirawa@quicinc.com, quic_cang@quicinc.com, quic_rampraka@quicinc.com,
 quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
 <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
 <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 3:46 AM, MANISH PANDEY wrote:
> On 8/21/2024 10:52 PM, Bart Van Assche wrote:
> > What is the performance impact of the above change?
 >
> No impact at all
Is this a good summary of this email thread?
* The first email in this thread reports an important performance
   regression.
* In your previous email there is a candidate fix for the performance
   regression.
* Above I read that the proposed fix has no performance impact at all
   on any setup.

Is this a good summary of this email thread? If so, do you agree that
this must be confusing everyone who is following this email thread?

Thanks,

Bart.
