Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45129B8E8;
	Wed, 11 Mar 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247801; cv=none; b=PnTQRo7zWJbJZB91n7wL3WoIvGCMB3qpQc6423LlLwWLXw/Uj3Q2rN+kaNY1PDd2t2Y+wUYmNiXAzvISrqvL7nYqzsTPEGJAsubi3NeGOBZe8eacqPs8dKGQ+KgGqmyUnYI4Jc+fhayV4g2VNEPMGZJTXUHTnjU1FbWjeOBVHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247801; c=relaxed/simple;
	bh=gHccC3CHKJob3oCvAB8HLq8tXKoXQ1ZpScg165gmSrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2WKY/nHkdTIKGCFNxL/i7bJlcc9DPLv1gnmxhzrZ5trMpfaFTAK+0JOuHFrA7o4rAcc2k6m9HQG92MM5AKiYbKO404OxaEWckvMR13vrvxX3C8ZaT5NBOJrmokcyUz82M56e/GG/TO58xZKf68wH9gr9FX+wHt2NUd08pu2fW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EwwCwKUm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EwwCwKUm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fWGv66CKlzlfl7L;
	Wed, 11 Mar 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773247791; x=1775839792; bh=ccZtHWXsBCpJCuDGYX4TbiD6
	sbKX4f7/OBYKG3a4jCk=; b=EwwCwKUmthCu5i4rlJ2yBqVhufvgIL8l76tQKQ7x
	XfPfyJDsPzAG2uTB0Fu+yTCWFfhKGQtGHZ8qhQXSk6W88V8kGq0GptHuhBFmJJOr
	n3NwW9XWjLiqfqbS1kUAU/Dwv7YKZoCDTVgfltjHwYZlXnPGM7FCXMJmPEFtGrnc
	zW29LiSO3Dkb1d0z5SAMtndqqSibr3GOBVnvBnPOlEzMhG8EhjCzWVq3ckQPN8ML
	xAwJHzBWDhUWuw5GleugHqikXHf6dRF0Em8LByeFgz6Xb8Ivs29px6T127+Jx4Ti
	Xb0cHcz0qdZM4SUrLTnPj7glh6+L5ouoKTy7Pw23BYAvBg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x1wlsCwcGjhM; Wed, 11 Mar 2026 16:49:51 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fWGv20Jrlzlfl5x;
	Wed, 11 Mar 2026 16:49:49 +0000 (UTC)
Message-ID: <445d61ae-c579-4558-a127-62291473ac6f@acm.org>
Date: Wed, 11 Mar 2026 09:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: fix pointer cast spacing
To: Richard Lyu <richard.lyu@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311083510.183631-1-richard.lyu@suse.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260311083510.183631-1-richard.lyu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 1:35 AM, Richard Lyu wrote:
> Checkpatch.pl reports the following coding style issue:
> ERROR: "(foo*)" should be "(foo *)"
> +		struct p_trim *t = (struct p_trim*)p;
Checkpatch is for checking patches before these are posted on a Linux
kernel mailing list and should not be used on code that has already
been merged into the Linux kernel tree.

Thanks,

Bart.
