Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A0361DAB
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656163; cv=none; b=ifb1oOXFceYi7Suu60mzNIBCuP/PL3BSrBfHllCaOTDnwsWWmu8l8Af9IGegthmVtyppZSyS8wk0Le0IYtjdsKqathw7x8TnVkxsEa22uz5tsiXFaaSR1QSwTHGHH5s+VvQcBR3TH53ae+Lwp6HhsmhVmcuVhltmlFEyWULUtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656163; c=relaxed/simple;
	bh=K6yxeuOPTkK9WYTQomSuJKp/AEo8GhOr0vcTI0vQFSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbckpXC4CMWoV9bo/qzD1aC2FJiw7rMYF/XOsgYj0bmNcsMlTFrXaXxAaKN4nTbhjKbjM3eakoNC++OBCGmAbvnw0vyF9kDK+TYkRzJgR6DCf9vb0W2kiMyrUUQ4vmfuDxwUWXt/dpjacusrXP564wV0ues0/Y8uGNTWnPCOFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2w0r0ZVQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2w0r0ZVQ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR45Y4q6Cz1XM0p0;
	Wed,  4 Mar 2026 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772656153; x=1775248154; bh=UZR7uovX52MtB0hQ5X1P9Yuo
	kOp6fDjExEQh4vmGpcs=; b=2w0r0ZVQcxxAzHkyeHR8WUxrVimMN4ESkH8Ao5P/
	o72IqUaX77Wi38vxgR+v4CuQs6NFKZhSV5MeKS/d9evwT3baLtdZfOcDIE0GKoWJ
	J0fHepoNCgPxX4hZLjO8BGLeDghfdIkOyWV5MyDvqh5BkpMAkruTMbLaCocZqAZ4
	vxnrkoVG4UWO+MRqzLiMK262vk9RuuR+3Xz4oTZ459gN7l9dhkaqqYhnTgqHF3KK
	QFiG52ae3P9LIgix6/zEiM/XdayHJDC1wzofkdq0OqcNSpAl9iWyvdx4UlQTLtAF
	KBaggycwFvqhXcEeF6wBfHczTV5t1ctASKv+5Mf6YuPR3g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ndoRFqO25wca; Wed,  4 Mar 2026 20:29:13 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR45J6wfNz1XM5kt;
	Wed,  4 Mar 2026 20:29:08 +0000 (UTC)
Message-ID: <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>
Date: Wed, 4 Mar 2026 14:29:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] block: Make the lock context annotations compatible
 with Clang
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
 <aaiP-EE4M0iywHzc@slm.duckdns.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aaiP-EE4M0iywHzc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/26 2:03 PM, Tejun Heo wrote:
> On Wed, Mar 04, 2026 at 11:48:22AM -0800, Bart Van Assche wrote:
>> Clang is more strict than sparse with regard to lock context annotation
>> checking. Hence this patch that makes the lock context annotations
>> compatible with Clang. __release() annotations have been added below
>> invocations of indirect calls that unlock a mutex because Clang does not
>> support annotating function pointers with __releases().
>>
>> Enable context analysis in the block layer Makefile.
> 
> Maybe I'm in the minority here but are these annotations actually useful?
> What do these capture that lockdep can't? Can we just remove these?

Every Linux kernel release cycle new locking bugs are introduced, often
in error paths. Clang can detect many of these bugs at compile time.
This is why I would like to enable lock context analysis for the entire
kernel tree. This patch series only covers the block layer and block
drivers. The entire patch series (needs to be split further) is
available here: https://github.com/bvanassche/linux/tree/thread-safety

Thanks,

Bart.
