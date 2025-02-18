Received: from 001.mia.mailroute.net (001.mia.mailroute.net [199.89.3.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961828629B;
	Tue, 18 Feb 2025 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917471; cv=none; b=aYHt5sUdqGzkMwMbevG67vKfP+GZgrUHu3bvjwDttADS3F/eP6qguzONgG+egLcI4AVettq2p2OEysjoJk1r3j4/6skTBlVydRT/06O9JF+3ScPUGtDC0KsOwm3BJhYQEdTGIjDBLzfIVgimNnLvLNyvAgUwo1nBDhs7aCT0jxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917471; c=relaxed/simple;
	bh=kCmoXvGtdX3xHMk0kwjR6YvFtUveRkTB815tpRMtgh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD+01zke7IaNkwlmoih6f/EdEKtEfcZ8U0Ka24EyDSbPfQivHPR39U+SOClyfUoK1lyK9DZw0a6Z5fxNDeqK0KWnoOwxZCqP61R2thxt/atcQiS3TukWkka/N4YS06ToSR9mULPEPQHcW+PrSq2+/C7y12DphbjJLjZUkIn2lEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y7AGmSlW; arc=none smtp.client-ip=199.89.3.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y7AGmSlW"
Received: from localhost (localhost [127.0.0.1])
	by 001.mia.mailroute.net (Postfix) with ESMTP id 4YyDXV2skrz1Xb877;
	Tue, 18 Feb 2025 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1739917321; x=1742509322; bh=92vphjxGRpPWF2H9SmmPDtnz
	qLQ6gEb/VnixK6UxtKA=; b=Y7AGmSlWBV+nVckc93MaUSUv0WI2aieQ3NCSG4eJ
	/QhqBHYtcS0MyoAVVAvC47nka+evFaz+R9Wq2C6rkyipXZIULk1j9OJo6PrNO+NL
	/c6gnXAXQRNILRzCY3xAVns3eoUXqyo682yPgefivVBaQzI197B8q+wfeaus2wlZ
	qwtXEsa89Qo0Zm3+9mmvLZC0Az3ct/V2hkQP74o4qv1VS+9JSwY0XH/w3wOO/0bn
	ioynKAZfSgw3ZYdluSAuGmOAWSlajuSu2ArOwWk2E6ZfMuStL1OA+hPxKPukjMGE
	3hfYpBeQaufZZJOIYTjVR4iY67IzjgwGvCpSmQc9Ue247w==
X-Virus-Scanned: by MailRoute
Received: from 001.mia.mailroute.net ([127.0.0.1])
 by localhost (001.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3K0IWF3JI-4B; Tue, 18 Feb 2025 22:22:01 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 001.mia.mailroute.net (Postfix) with ESMTPSA id 4YyDXM4Dqfz1XY6MG;
	Tue, 18 Feb 2025 22:21:54 +0000 (UTC)
Message-ID: <6c3d81f0-aee5-4619-82c4-3ce72bdce317@acm.org>
Date: Tue, 18 Feb 2025 14:21:52 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
To: John Garry <john.g.garry@oracle.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Oliver Mangold <oliver.mangold@pm.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
 <KP4HxjAbrINQTT05XxqLFD7bPj5ONsT3hTQJYUyXtoHBYc7-xFNDZUN3R8pWT-Cd1Q5fguKy97Oy8UJv5Nj1Cw==@protonmail.internalid>
 <f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com> <87r03vfpkm.fsf@kernel.org>
 <464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/25 9:12 AM, John Garry wrote:
> On 18/02/2025 11:40, Andreas Hindborg wrote:
>> But I am genuinely curious if there is a reason for not setting
>> `bi_vcnt` during a clone.
> 
> I think that it came from commit 59d276fe0 (with the addition of 
> bio_clone_fast()), where we assume that the cloned bio is not having the 
> bio_vec touched and so does not need to know bi_vcnt (or bi_max_vecs). 
> And it is inefficient to needlessly set bi_vcnt then.

Hmm ... I prefer paying the very small performance hit caused by copying
bi_vcnt rather than having to deal with the inconsistency caused by not
copying that data structure member.

Thanks,

Bart.
