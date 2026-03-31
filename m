Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCC3E8C75
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973586; cv=none; b=FMcJvaVDRRbelvQjc2jQETSmjOPMljGe1dRUOoTNt/bllWdYefAoX6McpOE55g4rcQC5PDiETIFcgPpf1uFrmmsS0DxLMM0QVMlQzZZjxb4LaeMEO7yJptYv7oT7fHFyafCuRUJD5nkUbxvfbqpoQZ3t68w+MbZRpDwz7JumgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973586; c=relaxed/simple;
	bh=NH51tSOZOgzrxTGgcxWpGi8u14xDpOKoRu+KYTr+FMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dhzfj7E5iQWgfOTWIcemYIBwWXap7P80p3UY/47+5obE5cQgdmgl3LYD+YorTVqUmLVc6KXyQ+lgaYE3EzxeU4vXYjvpUEO7gfbK5O3UbJ/dmyOMLqjc8NDVBVIASx3KHmceXo8NZ1rsIdbh8truZbUVdfgDHOV6QbC73K1HyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DKXp/rky; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DKXp/rky"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4flY7H0hz4z1XMFkQ;
	Tue, 31 Mar 2026 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774973576; x=1777565577; bh=4nX0bCMlfiGwV6a9jPMFZWlv
	Prgt6fCHGDib2EbYTiI=; b=DKXp/rkyxNGu7ULvUPzZWrLE98efCxfkb/bkGEGN
	LynGo4oTdnv4kVh/8SnSECEMIdKPzt16N7QoqUVGsncPBrLaMkGvSrFdndepZ1sM
	Muk/cPsVaIRx+iM0Vvhqg5slCIJ6gWa6DDTCCyWBRaR7POMphUJYiJ9CdILkgSJi
	0jF1/9B8cPvvunD1vsdPcIkVeSilGILIAQsPUKQQpJomh+BkrpuEjytJVeSjxH3z
	1qnP4IEUi73AEe4XHvtoqREX24XN4iq/YMUKvIhwawXpuVJLYbdYgo/CxedZHhDr
	LAfnMRUqeubnM3HbFaOvkfy7xEpiibVh/b7MIOgFbmMKLg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YXj08l__SEH7; Tue, 31 Mar 2026 16:12:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4flY7C1BlJz1XMFwZ;
	Tue, 31 Mar 2026 16:12:54 +0000 (UTC)
Message-ID: <70b6d783-fdd3-4dce-807a-80b0967906a3@acm.org>
Date: Tue, 31 Mar 2026 09:12:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] block: Reduce the minimum value for the maximum
 DMA segment size
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-5-bvanassche@acm.org> <ack5VqUS_gRuxodF@fedora>
 <7fe454fa-d39b-4d2f-a238-297df2261cdd@acm.org> <acsb_mLxDz8RpXF1@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <acsb_mLxDz8RpXF1@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 5:57 PM, Ming Lei wrote:
> What is the exactly code path you are trying to cover by changing
> BLK_MIN_SEGMENT_SIZE?

In the solution I came up with and that we are no longer using in 
Android (we switched to the upstream approach) there were code paths
that are only triggered if max_segment_size < PAGE_SIZE (see also
https://lore.kernel.org/linux-block/20230522222554.525229-1-bvanassche@acm.org/).
I'm not sure there are any such code paths left?

Thanks,

Bart.
