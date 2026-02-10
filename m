Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44019148850
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748295; cv=none; b=k79m9WcfjAnfM6FzR1/5GOE0u1+cAdzwp8bVTipeLtmQHsqeDvZu9YWBOR6jyXZPG80vl7x5P2KluL16VxRzfEA50JRWXTe+PfeikTsXP4MO8Vn/0NgL8EPQI8gf8xQNESIJSjGhCxmVO22Hz1hsgF9o6S/703Ffqr4k+OKnRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748295; c=relaxed/simple;
	bh=6AzQS43yTBJ5NGqjOLytz71SzECT8CJ6Powv6a4cwNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xe9pNRMy09yf47aCv+p+c9PaZHMsvmuakjR2bd1uX+kUBehSl3Qom2Bvxdn3WMdXsEYXw+vye+sjEKWkSQat4C609mL2A36SiK7b+EvafCN+S6yNYGxj3FLJ/AwJV3/QDOTdbZ7aCGAmijswK9H2rP63g1xS9WFXidwb3N1o1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=INgNoVPW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="INgNoVPW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f9VWg3ZJBzlh2ry;
	Tue, 10 Feb 2026 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770748286; x=1773340287; bh=6AzQS43yTBJ5NGqjOLytz71S
	zECT8CJ6Powv6a4cwNg=; b=INgNoVPWTghdISvgFYQCgx/fFQXsj/KpV2bUMOzc
	6b4Y8Vv0yZ2PSaqzArqBc/EAv6TOqA/RENWfBXU8wcv2pjB2SUjUyp/8EPrgEzWr
	2rlsfJONbjc9vEYrN+XJhTH/EYqTfpWddUe7Z2XUw5kMuEQhrt4pUq8zWHMlLB2A
	YfUwBQr1IL9StIQNNnW93Imyb2bi7htQc/gg6+wsIBXTXde49DHskQ7uxe+6N75q
	BbyMsMDkiqt+jKoHCF8tkncy3J4LJGe5z3r57njJV9zazsPAWQZOm+tcq8trROqg
	SFbcCWSY5AhESsaxFdpYRRBw/6mrumuFVZWF2CxzgCdb3w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Espza_s5LMsj; Tue, 10 Feb 2026 18:31:26 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f9VWd1knhzlh1Rs;
	Tue, 10 Feb 2026 18:31:24 +0000 (UTC)
Message-ID: <07f7ee7b-06fc-4fb7-a826-d465562ced24@acm.org>
Date: Tue, 10 Feb 2026 10:31:24 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication
 solution
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Jia Li <jia.li@ionos.com>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org>
 <CAJpMwygcLdvWNSwj0uy=FBwZyu+DhQSPCvc=CJfiLRvmbfwsKw@mail.gmail.com>
 <CAJpMwyhe-UmSkv2vzFPS-o5JRRz==kw-nNbY8RiyQKQykpumrg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJpMwyhe-UmSkv2vzFPS-o5JRRz==kw-nNbY8RiyQKQykpumrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/26 5:06 AM, Haris Iqbal wrote:
> We did some quick runs to get the sync time and performance numbers
> during syncing.

Hi Haris,

Thanks for having shared this data. Instead of performance numbers I'd
like to see more information about the implemented algorithm.

The description at the start of this e-mail thread says "The proposed
solution tracks dirty IOs through a dirty map". How does the dirty map
work? Is there a single bit in that map that tracks whether any of N
logical blocks has been modified? If so, is the worst case behavior that
logical blocks 0, N, 2*N, ... are modified and no other logical blocks
are modified? Does this mean that the worst case behavior involves
resynchronizing N*M logical blocks if only M logical blocks have been
modified?

Thanks,

Bart.
