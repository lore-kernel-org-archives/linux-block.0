Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1503603F6
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588139; cv=none; b=UdeN8dHWO/Sf/th58l5umYJyg+INNFEoi/YVtIXcKi0JchFYx3GfVY7ac6jZZGQlN3fdJ+3dEgm58NA5Z111x2BCKf0WFGesvnuuK/hKkkdeXcQBYzqQaFvfuTaeh5/ZTJ8yyO3P3kmBadmnurhFsKw0naH4nyRc9vUDINRSGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588139; c=relaxed/simple;
	bh=X/ZoOKuxTpaBiVWND2hYPlQfQoDug7v33c8I4Bzax6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP4oM44qydZnVhy89boz3M6yrvu68K8KtzmCqQZTvvM9dkp+55K5BLjkMigzOxRR3KkQgFCcNSvu/DrjAYfM+CbHJPwIEptstFbinKGX9ys/onch2moFJBH2NopdwEc6FvLlB+/OKA0GFhfqhu1U0sBh9pj6Bv/gd2qysRgIIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YASbfpHD; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YASbfpHD"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hTGGx4yxVz1XLyNC;
	Mon, 24 Aug 2026 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787588134; x=1790180135; bh=7Rljyqg+JmWnWscHCecu/ZRV
	hvys8jHuwOcZRZ7hZ6w=; b=YASbfpHDdTi6iypPnxLiAqRC7b5nuumAsWaxwe71
	EWPHSkDkBSyTOsTuQqtIeD7rgUvaptit6rGxk/jH4Awx74mXbXpPWrdtThlkEOAd
	goe43Ab7aIQZwR32nseG1pMQuzCg6NHXMMHZqhmgKqwUORH+TF/C38JeKVA21mL4
	uWkiqf5rYAcb9rugi4K48EjnbBXP8QjXsEeo8nJTJyoaoh+678w+/F5AatSGFXbU
	v+WYx/5w67ODanijYN2aE2OZED/fshESUpLgj/PTK2+L5giotdDXRhBjIP1H1A9g
	4XN4sTTPmFFy4b+c2JlWN1KYpUJYL/elvknnahoaFMTZbg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KD4HRZH2SBaZ; Mon, 24 Aug 2026 16:15:34 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:32ea:c263:e437:419c] (unknown [104.135.182.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hTGGs6Ptrz1XLyhn;
	Mon, 24 Aug 2026 16:15:33 +0000 (UTC)
Message-ID: <d998a691-4c43-4feb-ac5c-d174208c01db@acm.org>
Date: Mon, 24 Aug 2026 09:15:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] loop: Fix race conditions in loop_validate_file()
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <cover.1787255652.git.bvanassche@acm.org>
 <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
 <b7f88eff-7886-4a85-9c97-7c88ba856780@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b7f88eff-7886-4a85-9c97-7c88ba856780@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/26 11:12 PM, Nilay Shroff wrote:
> I see that with the refactoring and the changes in this patch, where
> we now take an explicit reference to each backing file while
> traversing the loop-device chain and hold the corresponding lo_mutex
> while checking lo_state and acquiring that reference,
> loop_validate_mutex may no longer be necessary.
> 
> In particular, loop_get_backing_file() now atomically checks that
> the loop device is in Lo_bound state and takes a reference to
> lo_backing_file while holding lo_mutex. Therefore, if loop_clr_fd()
> or loop_change_fd() concurrently replaces or clears the backing
> file, the validator still holds its own reference. It also appears
> that loop_change_fd() and loop_clr_fd() for the same loop device are 
> already serialized by lo_mutex.
> 
> So I am wondering whether loop_validate_mutex now be redundant? If
> so, it may be worth consider removing it as part of this series.
> That would simplify the locking and make the context annotations
> considerably cleaner as well.

Hi Nilay,

That's an interesting question. I think we still need
loop_validate_mutex. Without that mutex the hierarchy could be
changed from linear into recursive after loop_validate_file()
has verified the hierarchy and before the loop fd is changed.
Removing loop_validate_mutex might introduce other race conditions
than the one mentioned above.

Thanks,

Bart.
