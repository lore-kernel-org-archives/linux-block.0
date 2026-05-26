Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AA7E792
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823949; cv=none; b=miHwxsXlgDY6xTLZEg/EgK2id0bMbgtOqqHH+kaGgHG/pGwGF2oh2L8xnN8mPqG62Zqn7A8a12eZYjHBg8JK67FvOO/TX+l25rtViDVtNiQTEwusT7JkHqQVCICtJT0Cm4Xs5LqgU4Zt6niiLYHi+X5LGLMrncNk+InjOTEJzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823949; c=relaxed/simple;
	bh=RSJtADIKcRmryOkMD7dNQ6wuexfpKKTQfAVqoANnbWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHppidUhjrmKaTKj6Tx6dxP2MqGjB+moYZgAnvi3OthD4ZCWxXySHBf59nM/lxeGvbhn6VrLSHDRziTlX1D2Yc8tFR0p/8UNnCrd8F57yuS8kFvYi5A6uASQRJJlK0Z6PQKTrO3maGRYLCTRrg2jvsPUpkeg7wEkaQXfDUfQ/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XN/XBdZ/; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XN/XBdZ/"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQ2vb3B6Nzlffv7;
	Tue, 26 May 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779823945; x=1782415946; bh=oBXJUHfGJ0FzPvjL+KL9l0GL
	nhHpdq9pTrymKVJurNY=; b=XN/XBdZ/iDX9mNZvTNa5QBnEpdGR7utCxMF4KGam
	VAh4fx1NR4ivaE695KurYaAfr5s6IWvb5WiKBGOE7MK4EtLHO88n9tyw/W4HNhYl
	nXs1feRRisU3Isl0hVCrD1XTBL7sF1oVFWkDIRzMCxXIKkm4S7toIB1fAgBtm7Cj
	tBaVnPDBwTjo7df0jB5OBSkYBQRwCZdvIfyuKCTM0wWlTSZ1sy9vDPj3psyr19BM
	3pLSgaluKCzPrHuHGvObvmGQc79evp0KcT8pphix1mwMgXJANiP5YN/p38pzblmO
	85s4Z+a6Vw4VWRwd7AuPczb+KZkyuarzAhWWoUpdtYR86g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2xinDceacHnE; Tue, 26 May 2026 19:32:25 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQ2vY0p1LzlfpMB;
	Tue, 26 May 2026 19:32:24 +0000 (UTC)
Message-ID: <2b099adf-ad1b-4399-8225-96a1a77f8441@acm.org>
Date: Tue, 26 May 2026 12:32:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bvec: make the bvec_iter helpers inline functions
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260526070042.1817997-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260526070042.1817997-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 12:00 AM, Christoph Hellwig wrote:
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.

Thanks Christoph!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
