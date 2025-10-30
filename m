Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D536E375;
	Thu, 30 Oct 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847698; cv=none; b=r8VbOxtVI+eoldOAQdY3/n9YdmHQ3iM51c/L98YsEVpo5S0ZsBseIPfhIXk+4c9RSYMhgUhpdukP/jKNbfQ2yVmdYstvDTZ23N0lCD332LzCAUamA8iQLuu3ItcLAE2wwK3dsstmXEAxSjMtj0GRqeNHRU5GyK5K+bIJmPbdfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847698; c=relaxed/simple;
	bh=T9zIm0gSu4kD3QxXQl0Q2BQyodM1bhAdjnLFxbtSi50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhd3YSeeMSkIvUvzFhHPNLRbDHE7vi2EnmtBp/S0zxHG0vyHb0ucqm4cQZrXA8JkZlPV1wHNAxOFOwWtmvg7kz/9KgeNKG9k9BR0mSMYAKsYcm4gki7FpJIitY5z6bIP4yrEi+XqJuWjgTGYm/ivZ35CSny3Rx56xcFkhy/IlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WQKLZHod; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WQKLZHod"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cyBtQ5pjMzlgqTq;
	Thu, 30 Oct 2025 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761847692; x=1764439693; bh=T9zIm0gSu4kD3QxXQl0Q2BQy
	odM1bhAdjnLFxbtSi50=; b=WQKLZHodyoO/cFA4rZnuxmcTMPl1J6lZjczTQmQX
	0lcomaVrcWTUgYDDmtuob7TiXHXGNo95h3OkBUL85WxvT+C/mnpsrJaAPDCKsEC5
	Zj40yTrdh//p2wWeBFQ9layhw8PZQqPzLoY9bg2XNAc5NNTf+Uqx7PwlTom6OoJI
	hmqRzKx5nzt6+X1Yw9ejYkXrpnIY2E5SMV9fXwRK1sDeMuBsWxxXQj9TU3S5nk8D
	k9r4SuPgd/+Dztv0Wn7+nikUZ3KS8njwiE61M9o+JygfvYFjIVlSh/7YtfeYUh/M
	kTd4i7n0fDTVhVCA/gsCMfRY+XWISS9iMrR+TMpX0Ohuaw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6tTr8fDkTX7R; Thu, 30 Oct 2025 18:08:12 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cyBtC3RfszltBDW;
	Thu, 30 Oct 2025 18:08:01 +0000 (UTC)
Message-ID: <1b4dd7b7-2af2-4026-b6e2-be517b249ba3@acm.org>
Date: Thu, 30 Oct 2025 11:08:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store
 callbacks
To: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Nilay Shroff <nilay@linux.ibm.com>, Benjamin Marzinski
 <bmarzins@redhat.com>, stable@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
 <f4ef82a5ca88901653ce07fb0313c144a0fdb6ac.camel@suse.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f4ef82a5ca88901653ce07fb0313c144a0fdb6ac.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 10:38 AM, Martin Wilck wrote:
> So the "deadlock" situation for the other sysfs attributes that you
> handled with the timeout in v2 will remain now? Are you planning to
> send a follow-up patch for these attributes?

Only if agreement can be reached about the approach that should be used
to fix the deadlock for the remaining request queue sysfs attributes.

Thanks,

Bart.
