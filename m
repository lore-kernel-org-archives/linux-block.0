Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E7279DBC
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692024; cv=none; b=mVPeCBPHde7Dpdui0ZEsTPG+Dqc2SSUj6pj6sf0e+cQ/gcrGaoxnLYBP4ygRjVdJEQL8IJXsngKrEGlUa+DDnMWXAODIwcTU3W+wC5bULbGvGF+h4ea4menWW70I7N8LrLg5kAV6MhAQNOdEKmndjS8p/rolvJSzNH9/0Pt22B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692024; c=relaxed/simple;
	bh=T241F5rFx1+wRJKDvrverWW11YcQKph8dHY7KAwqbtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcVC+ACed9Z2vbJxHQhXJC62GF3VIbBqPkyIFeuRc3haJ4VK7cq9smFgsqD1biT8Cuc2/zucUZMlZtihsp3MCrfygw+xf63N0gSJWqD9Zjc5YtZWazl75Ppy9i509hFTLrw8pZ+GLIph/t7MhBd74DfZBPBxIJjupKorQF4RYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nzLQvAtb; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nzLQvAtb"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bQs9x0TGpzlgqTr;
	Mon, 23 Jun 2025 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750691795; x=1753283796; bh=rLtZYBm/Mbhs8YTzk7xRLTo0
	+TLvEx9li8/ucTQzXhg=; b=nzLQvAtbd6j/chEz4Gqvg6SJWTzad5rPmMS61Osx
	sxtiUy3gcFYNqE4BGkZPgNc4f0q8gy4jEvpldDGNser7lqPrgq5tO7lPRm3ZHajt
	3IuIcshZ6LBG55AmvquOV5esJ88lVbJowKdU5KG3Iazqd2WRIKevpetBrA3bCC9B
	MvutI5T8BfBsmuIscctUESpGk1CRMfLdqpV+RykZVdzlsvS2JgCjdCkBc2dL9Wp7
	i1RrClJQh2gsfL/qMUoFuqm+b01lYPqGbs7u2gyrdJn8C0Ufc92debIMDwQzpQSs
	Cuqc/KSMmCcIOq2VbRT8ZZiOANBmuorE1NyEaVuccurefw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fKbclv6GtDKm; Mon, 23 Jun 2025 15:16:35 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bQs9s134vzlgqV5;
	Mon, 23 Jun 2025 15:16:31 +0000 (UTC)
Message-ID: <ab941c5e-43da-4421-a90c-c7efb73ed8ce@acm.org>
Date: Mon, 23 Jun 2025 08:16:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block: Add a workaround for the miss wakeup problem
To: Keith Busch <kbusch@kernel.org>,
 Fengnan Chang <changfengnan@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20250623111021.64094-1-changfengnan@bytedance.com>
 <aFluCdqZ-QYXOKf_@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aFluCdqZ-QYXOKf_@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 8:08 AM, Keith Busch wrote:
> On Mon, Jun 23, 2025 at 07:10:21PM +0800, Fengnan Chang wrote:
>> Some io hang problems are caused by miss wakeup, and these cases could
> 
> Wait a second, what's the cause of the missed wakeup? I don't think that
> should ever happen, so let's get the details on that first.

+1

Additionally, there is not enough information in the patch description
to conclude whether the root cause is in the block layer core or in an
(out-of-tree?) block driver.

Bart.


