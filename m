Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097122541C
	for <linux-block@vger.kernel.org>; Tue,  7 Jul 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443241; cv=none; b=tOSSUbmtiEI8H5MCsnJsm3LIxzUHg8oGXK4t2LCEA7VYNuWZOiBJAWAV2W+n+JSHBoe2lKV5bhwRJoNY1SPt2oEVbPJdoAdMF+2FUG1K+CafAmOaoSccG01AAmDR0jj/fVbEOLZe5xJS7ThO79Fp/sU+9rvgPAUIRolIu+9couU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443241; c=relaxed/simple;
	bh=gA2mfMn5fwu01AXU/FBChgTrVM9QhF3Ex6JcRhtETPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PgTUnEiVlMsyQlQoXbWoZZcDBbzHcXNxJakfR+Xdyc9AYcRzhz+7tOXEKtSeW3kemRhA0yKoThdxicAgqXeAfmRSu5IoYe3L0PSUygscxRkPsPGxMHPll3xW4jnY8WOnyfMTPZYDPe7uSNen4XUheOq0PJGtfNzLFdAT7G7ifmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JJscZB8K; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JJscZB8K"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gvnPF3Xzxzlfddm;
	Tue,  7 Jul 2026 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783443229; x=1786035230; bh=PJZu6wtzIkrJQ/9Fuoo3hJwD
	wFNGPGwUlfbKrFSHL+I=; b=JJscZB8KqIwheJCAlbIeLdkDXei+kxe7rrKZzVcq
	bLoHYjbqadifq5sgm5EcEOB6JUm9X08/slAbmSf8J8hMXx5MNhiNbjFzzYQsHr2o
	K2uEcyM5k01DeigVkq2EH6rTDnzizZlH/IzLDpZtosj8lgFCE4JHDLKyHgE6zTqO
	pc5W99UYTPWhB+71G/ximSiCWWalPL5AITDTGLf6wO0l5Y9o/oDqWmmxwKAgx/x3
	040ZMftQ23HccguRzw4XE3KQzmo9n6kdqcIshBqRKgEGNkvh2/fA8b9ejOJ3ZJI1
	YtGW5r3Ky0IAQ1jtWxXAAzplXhoHRoFASbILuB68nKQvxA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oAdW4KKNtePk; Tue,  7 Jul 2026 16:53:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gvnP669rczlh1V7;
	Tue,  7 Jul 2026 16:53:46 +0000 (UTC)
Message-ID: <a3483c0c-f303-462e-a9d7-162c1160ba2b@acm.org>
Date: Tue, 7 Jul 2026 09:53:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 Ming Lei <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Li Zhijian <lizhijian@fujitsu.com>, Akinobu Mita <akinobu.mita@gmail.com>,
 John Pittman <jpittman@redhat.com>
References: <akyeX0hlcrnOC0nT@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 11:38 PM, Shin'ichiro Kawasaki wrote:
> To the authors and the contributors,
> 
>    I would like to call for your responses. Please let us know if you agree to
>    modify the license of the files from GPL-2.0 to GPL-2.0+ (or GPL-3.0+).

I'm fine with making this change.

Thanks,

Bart.
