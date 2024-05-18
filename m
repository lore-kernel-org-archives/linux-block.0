Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48251A2C10;
	Sat, 18 May 2024 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715998481; cv=none; b=DTzO+hXNDm5inmTk1hP5CbZ/n0XVbjdPfxkuhj/saIxlofaxarMPmXlIdSgLlY0E2GPe/WoW8OIMQh4HESweN1ZpIsTh5XvUCmR7OI8M//ffhPjITGr6wZqqbuB+5NJu9ssmCJFZymla3pXseSNzG3RQMbLAYWNw1h+3MNStvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715998481; c=relaxed/simple;
	bh=UbQnzm+5CypOEttM2+Nl4mA/XfIDfwurp0+enqNeHJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+M5LOJDD5NxTFponx1JJ/62bG9EDYYK5WC1Oz9PK9TdlQA3MQYJ2dKqp0DAFHOMimDW/5ZqgGxPVdEUFtDfeEZnkoFiSLpY9hdFmuJKVO1cugsI4+hN3GfC9m/VgjBVaAWR5vPO3FP6CK+kCKn9MIM3IJpWqJ1Qrnhzhq6fT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D6ZKS0Cr; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D6ZKS0Cr"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vh6pd59hwz6Cnk8t;
	Sat, 18 May 2024 02:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715998471; x=1718590472; bh=UbQnzm+5CypOEttM2+Nl4mA/
	XfIDfwurp0+enqNeHJM=; b=D6ZKS0Cr/1tgAnBkdZaaZ2nVPOp0wOyTn6xfKt8P
	wwEzE9bX2OEeuSAa6xK+0KhwhfZHN+5SD1TR7Q2HhpUHKkkCfw8eoztVRmxBbOfU
	zuHaY++ET/uBi6DsC/wo7Kio4Kj4LFlbK+GAfylAumJa38p9Hn2jNHkB2AaOcwhc
	7g9yRNKRoFCTL/5VhVTPZCYxZGDS5KpzZP7AyfrmK1kG4zUCT9BQOqMdYdN58iNH
	zrg86TI123bkTZKF76YRjx/zDY/PmFmcFYlXNhZDwkUOlfQsHikqUjSovKTAyfah
	RNHOFipv8dQw39amspgHanLc83F5qc/wBiM2u1rX8qOLfw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 31GtY76U9S_a; Sat, 18 May 2024 02:14:31 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vh6pY28z2z6Cnk8s;
	Sat, 18 May 2024 02:14:28 +0000 (UTC)
Message-ID: <81d66a3c-89fc-443d-bf8a-3c080d2049de@acm.org>
Date: Fri, 17 May 2024 19:14:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] block/mq-deadline: fix different priority request
 on the same zone
To: Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <a1c24153-007c-4510-9cb3-bc207e9a75e8@acm.org>
 <20240517014456.1919588-1-bo.wu@vivo.com>
 <a1da2c7e-1b29-49cf-a45f-255d3b8b0da2@acm.org>
 <a65ca1ef-1c9a-4d40-8e11-d9dc2cc75e1e@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a65ca1ef-1c9a-4d40-8e11-d9dc2cc75e1e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 18:52, Wu Bo wrote:
> Yes, I noticed that 'zone write plugging' has been merged to latest
> branch. But it seems hard to backport to old version which mq-deadline
> priority feature has been merged. So is it possible to apply this fix to
> old versions?

If you need this change in the Android kernel, please either submit a CL
to the Android kernel repository or submit a request to Android Partner
Engineering program.

Thanks,

Bart.

