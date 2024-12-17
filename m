Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEE158DD1
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463534; cv=none; b=ZLULDMfP4yH+rMB5Iy9+p9y8kiWiQcupXpIEY9udZl+kTytN38fnwI1jqasy4Yc7Atch8FDzcGEAwZ1OydYFji8qzoyk8zlgH3UV3Uzk3JzXr/sY2rDAjyaUeqDmO9wX1W5S8pAU2eniq42MabwTIE9tb2bSsFih4xBTojVunvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463534; c=relaxed/simple;
	bh=ZZ3FRUgNREg3/aZvtb9GZ5RS23xzKqHv2s3+TS+nTZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur7Npwot8lqFgIfZp3md0IgzhfKbKC3NOrToUPhFYuWFT1YjXz+hI4Ayx95rbiSbp1ENEdJFU0mcetGdcfxAAu3PCXj4xsZSJtdTxmRBXRhgbqScSO+NuiWjq2nZ8FnboKYV5cf/vgphN78hdRAEy9IpskpM2fbMILASjzVQMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=T85mj1ic; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="T85mj1ic"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YCRbp4Cghz6ClY9D;
	Tue, 17 Dec 2024 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734463524; x=1737055525; bh=ZZ3FRUgNREg3/aZvtb9GZ5RS
	23xzKqHv2s3+TS+nTZE=; b=T85mj1icrCVVRBUtjOJrEOjXlSjfEGQSoK8IzhaX
	sTKGHrLOvam0Y+Bn6w5Yv5oqyqIQEqJTWYF/80YpKf0y94vy71R1laKWhAEp+3v0
	VlYO+zNtyL/CPxg5bqcwygqwu+5kYzP/tc0PwJ8VS0rRR07OPtA2se8ouFrzGxwN
	7mUJCbkSeEKuu2vu89lp7XMdQHDkca0Ix+72scidZ+fAK1OKH7FnNl64l8raBKhQ
	eKLF1O3iLlbTaUZD0w6raa4mpDM+qzL1F48Dbn0ZXhM2k9KjXiY5HCgXuAZnhy5O
	vYi7vxc1aTTcHEkWmEPw8tziuKT9Bs22ZIvR0Eq6wzGr2w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VdoFWPECVydo; Tue, 17 Dec 2024 19:25:24 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YCRbl4Jt9z6ClY9C;
	Tue, 17 Dec 2024 19:25:22 +0000 (UTC)
Message-ID: <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
Date: Tue, 17 Dec 2024 11:25:22 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 11:20 AM, Damien Le Moal wrote:
> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1

Please note that this e-mail thread started by discussing a testcase
with --numjobs=1.

Thanks,

Bart.

