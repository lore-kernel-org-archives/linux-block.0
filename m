Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863753D75DE
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241294; cv=none; b=D91Y2rRyucrl5yXtz+LWshyVqtPc5ELgwIE9/ourij6hHxXFj9LaM8zNxh1KwDBoSBsNJgC2RdncNm5a+pvhAlt2s2hMYdcsgveG0sk0x8CCDa3Z99zelf6ShWEoxiRZl4SfJJYvaux7SUOJtwI1iSJt+IQ2MhvA7r029rtfDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241294; c=relaxed/simple;
	bh=dnxkZkGebXZJqqXrCVxINXyXS9cfex7zVICWKwz47M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWQPmBFXXxCkZjOVwBASqaQ71NsvuDgp/i6jksbhnjsqszK+pkL7yCJAPmgRrOYK86HR+oiRhU+Nk7dXJBDcvPsTIvQ634jQxYUKbdxkd7RNvma9I0fJi6QRvdcA95K6QvS0M56U6qmvVaDGVKClBUjHNfVH/JZsCiqdgJlx+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NaQNrQuG; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NaQNrQuG"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hQp0r6X4Dz1XM5jn;
	Thu, 20 Aug 2026 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787241290; x=1789833291; bh=JXd4zKQfREu4uEqd8S9gCVC9
	RpABdFPSrju+sy7QjnA=; b=NaQNrQuGVSqMs3Blf9meSbKM39Jze6LnX3ccaGlc
	lVr0oWVRGKzQWKBldO/M9grI+VfkznuAB8dSK07+/S0pQv3DsqVx4IyOH943MU+X
	8kz6vZiDIsK6sW3XN5UvmFz0Q1OmARw1VVBM5rFlraNVH+e7IgHbXh7QITpZSwFn
	aMFgr+YZYv3/X7teC8t1vxN6avzciqYyv0utf39RRlob/eDWfZS+DozBKz8K3v0H
	/9uL1en0nlrn9tsZgUxq+EfS/hu28nWcYdCAmHsVIpAKkLwFwObpB3cLJNGsnX7J
	NSvzZS3+0B2QQGJEAZGZncJBgfChAkyLpBXoivKwK1KeJw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x2i5T1EvRwo9; Thu, 20 Aug 2026 15:54:50 +0000 (UTC)
Received: from [172.20.20.20] (unknown [73.15.155.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hQp0n4Ptdz1XM4Sx;
	Thu, 20 Aug 2026 15:54:49 +0000 (UTC)
Message-ID: <954f42ce-fbb9-4c51-a6de-198aa18797c5@acm.org>
Date: Thu, 20 Aug 2026 08:54:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: add module parameter for
 prio_aging_expire default
To: Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20260820021246.2681624-1-yebin@huaweicloud.com>
 <20260820021246.2681624-3-yebin@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260820021246.2681624-3-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/19/26 7:12 PM, Ye Bin wrote:
> -static const int prio_aging_expire = 10 * HZ;
> +static int prio_aging_expire = 10 * MSEC_PER_SEC;
> +module_param(prio_aging_expire, int, 0644);
> +MODULE_PARM_DESC(prio_aging_expire,
> +		 "Default prio_aging_expire in milliseconds; 0 disables I/O priority.");
Disabling I/O priority support by setting prio_aging_expire is ugly
and probably will confuse users. There must be better solutions.

Bart.
