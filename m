Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF4DDB2;
	Wed, 10 Jul 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641253; cv=none; b=NaJgGxgaZPAJJR2oxuknEqkZlhq6PGwG433HelgxcRSMG1IvqJ6HKB8coIGKtpeVqLTsnSpLMltMR4JIGMoUtMYPR9NX5cdrRswdWJrcFwqIM558W0ZYbRxcGIECAIvpH6qndX6PW6PSPg6aiw0JQQNbvT94v4NWlUFTEnMthCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641253; c=relaxed/simple;
	bh=EKMCeAS57TE550yBaeOFrP8YAT+/kLTYbYMNOa4LwGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZpSTK58VFGvYjpz+FQ+XTK47iaxTyrDuz35H6dReQlSfNOIlbUDWLTmQUyKegewbX9cHAthOZArYIrbAr//vAA8b9ViB9GOStgjmI2VRB2HKiHJFbc1+cW4UrAL0bbVBXWXpeYNxOZSJmS7CdWz9/m6UFS+2ajiGqGrVNUryNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p/4sLBk5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p/4sLBk5"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WK7pj2rg3z6ClbFZ;
	Wed, 10 Jul 2024 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720641243; x=1723233244; bh=M749JjHhNHCAKUEXV/3E1vJ7
	nZgEUsDMi5XwoDq+L4g=; b=p/4sLBk5C+BJ6P4MyqsUFeL1XAWLjUU30iJH9rGd
	T/qK+S+4EJPk/kQl1nDzAykoEmCf2cwO+/NFtF4BBQhJhyW6X8CP8kQgaiYYaRky
	V7bl2+8Q3J51EFFOKbPkxY7+7y/hLyI4S9gWlrCDL+R1X21UOgZQ0Qh+6tkj3KRF
	yeQ96Mmo+bmDHfq/nrjj+QddeYy2MkbgNRs02OqfH+nj5ArVPuvrXDCIquYlyIzs
	hFUq9bn/yvvdK5zfc3yD77T0QTo8p03Pl9gXRSoNcOsr3rpBPgYOmA17AWowvC63
	gc1p2dCZt1R5EztigEeACPr7Gb4E0YfOqWj8Qqzmftuimg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7lIpeoc1bMRP; Wed, 10 Jul 2024 19:54:03 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WK7pf3zXNz6ClbFV;
	Wed, 10 Jul 2024 19:54:02 +0000 (UTC)
Message-ID: <29e50fff-fa7f-4b92-bfe9-7665c934b7dc@acm.org>
Date: Wed, 10 Jul 2024 12:54:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240710065616.1060803-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240710065616.1060803-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 11:56 PM, Yang Yang wrote:
> +	/**
> +	 * @swap_lock: Held while swapping word <-> cleared
> +	 */
> +	spinlock_t swap_lock;

Why is only swapping 'word' with 'cleared' protected by the spinlock?
If all 'cleared' changes would be protected by this spinlock then
that would allow to eliminate the expensive xchg() call from
sbitmap_deferred_clear().

Thanks,

Bart.
