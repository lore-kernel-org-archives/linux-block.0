Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBE28A1F4
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929148; cv=none; b=HmO1bJlFE3Btaxuw+/oVtMtOTv4lAn0udcT0F/wo44f/mXI4ds5PSPLQFpvP8oKrOQKsu4NvSVFo//9Co3SKVkrpqxnN1i/PNEgo41kcgyF9wiVaTggvDhX8DebPJeoNs/n0e8CpiG1keR1ZyPtv3tN687ReElgUD92N227wxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929148; c=relaxed/simple;
	bh=eszdKR/Dc+TlS6kR/tGR4fN6QDRMcu/yz/APhEGp6nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYrf3S50xyyxMU5svj/5I8aushQffOSyOZJTj6VqxlG7rl4zSDgJ+HyZ0paGQGM6uS0KGk69C44xYNPj2hzXc4tbMWl6xuaCu/GWRDI+oUCTpV5mfgWerecpU+Z55USk6ZWy9GC6BnMwZ+7Z5Jc2QoIAf1ZKoW0CQroXhDOJeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zIPvQfff; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zIPvQfff"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b3CV21XVYzm0pJx;
	Thu, 22 May 2025 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747929145; x=1750521146; bh=s57bJoApfhN3Ugu1fprM3k8L
	ddcH5gXboy5RHzbmk3w=; b=zIPvQfffDLXzignnpTgcui+HwohxixkQAyrYl7t7
	wnRaRV1H3b7t8n1lmF3CRcsYpA6i3BOqbl+wc663y1DGASJcKLL39uOTtWZ0fAnq
	MxbW2UQiwzW0/85Vhi2dTOqMYQiSU+zpEZHhsgO+ul2/CbiJoW2LFgChBcQU6ZUm
	mhtEK9yvTE4BAJtOx8yl6llNV73fZ19PC27T38cGwSHPimXStA7/wi64VkzAArms
	sbWGyBGr5Qf8zk13oM8OBI64zcJCtdzw7+3S2U/e1e5V1mABI9aYk9fqVDqO0yP2
	oywOiMViD11VR9S8f8ZHP57tN5iuYfnDDKKYwdXCXGkpSQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msTfILHaveXp; Thu, 22 May 2025 15:52:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b3CTx5RT1zm0yQZ;
	Thu, 22 May 2025 15:52:20 +0000 (UTC)
Message-ID: <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
Date: Thu, 22 May 2025 08:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] block: another block copy offload
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 3:31 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I was never happy with previous block copy offload attempts, so I had to
> take a stab at it. And I was recently asked to take a look at this, so
> here goes.
> 
> Some key implementation differences from previous approaches:
> 
>    1. Only one bio is needed to describe a copy request, so no plugging
>       or dispatch tricks required. Like read and write requests, these
>       can be artbitrarily large and will be split as needed based on the
>       request_queue's limits. The bio's are mergeable with other copy
>       commands on adjacent destination sectors.
> 
>    2. You can describe as many source sectors as you want in a vector in
>       a single bio. This aligns with the nvme protocol's Copy implementation,
>       which can be used to efficiently defragment scattered blocks into a
>       contiguous destination with a single command.
> 
> Oh, and the nvme-target support was included with this patchset too, so
> there's a purely in-kernel way to test out the code paths if you don't
> have otherwise capable hardware. I also used qemu since that nvme device
> supports copy offload too.

Before any copy offloading code is merged in the upstream kernel, a plan
should be presented for how this partial implementation will evolve into
a generic solution. As Hannes already pointed out, support for
copying between block devices is missing. SCSI support is missing.
Device mapper support is missing. What is the plan for evolving this
patch series into a generic solution? Is it even possible to evolve this
patch series into a generic solution?

Thanks,

Bart.

