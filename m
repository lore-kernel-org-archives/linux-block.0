Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F972EA159;
	Fri, 27 Jun 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037054; cv=none; b=EZwuO4v0VBs4fusZJ6aYBUtQZzbUfGyDSPzLb2KGb0jXpC0tcGZk6bT9YaKfgyx2D88KA8QcNvgOLRN92kjcjVrgxtnIMLC/ktCBWDwahVCaYlc8PIh+uv325oJ10FWjwOm+Zkxv0+sTzW5I6Dl63iKaJtceaOotPQL0pfNjCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037054; c=relaxed/simple;
	bh=t4nnXnVLbMeu6uCk07CL3es50V7NSScr2thgSrL2oj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glLy3LUBJMtP0Kgr5oIhJv0hXnfyffMXPEIwLnh1+Yndfr9nVOOs04zaavfxky++pS7lxvaDbjy8JUbIFccqI8XJUsrSaK5GrvW7w7WBspBErtr6J7hMTCKwcFN7y2xb9XwZFNgkHVI1dRZaH6nNb8iR/ihb+luk5I/9f+1VCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OaZ+X8EH; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OaZ+X8EH"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bTJsR22HvzlvX8d;
	Fri, 27 Jun 2025 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751037050; x=1753629051; bh=t4nnXnVLbMeu6uCk07CL3es5
	0V7NSScr2thgSrL2oj8=; b=OaZ+X8EH1w74TDU8/38Koa8VCuy4Ez+tKm5hGnKi
	QEJ4BxsTINGsyE/2dHwRquIFFMSFDKTtuJVvijlZVKAbvtsLu/A/CcMO+nj5HU9o
	DtIu8A205XIa6+mTAaZWcqGVv4IQX06iRaJNmZ9AJtjJTCNQsfZ9MN0/Hnw2h+i8
	BhQ8DDrUOdoWI4j9vksMg14mNwCbYphl31/nkX/rBN2DO61nYGi2uAXCvi62sKbR
	O6x21d1yVPVUXFrnKPpVNdp/p/V+wYk3CzPOKlBuFYuUdCY874S6cbgMlYnHIStZ
	gDhbTQZWqYjJy1DwzU64pPj+cOBmgn52rn9NmMJL8boxqw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H-oLh7ZuUa70; Fri, 27 Jun 2025 15:10:50 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bTJsK0syQzlgqyt;
	Fri, 27 Jun 2025 15:10:43 +0000 (UTC)
Message-ID: <344a0eef-6942-455a-9fb2-f80fd72d4668@acm.org>
Date: Fri, 27 Jun 2025 08:10:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
 <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
 <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 11:16 PM, Nilay Shroff wrote:
> Thanks! this makes sense now. But then we do have few other limits
> (e.g. iostats_passthrough, iostats, write_cache etc.) which are accessed
> during IO hotpath. So if we were to update those limits then we acquire
> ->limits_lock and also freezes the queue. So I wonder how could those be
> addressed?

Is there any Linux distro that sets these sysfs attributes from a udev
rule? If not, I don't think that we have to worry about these sysfs
attributes.

Thanks,

Bart.
