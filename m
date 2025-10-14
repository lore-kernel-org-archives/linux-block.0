Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4F30B508
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457324; cv=none; b=qKPXe02oAUlzGEtaHqHe8j8cP3D/uy1+yDJrMX9naIeS/BbFNxsycg92jZOJa540GO5QJrntfPjBTY6xYu6utLsZRSIv6KWWsYA4EAYHaRekO1JPEGRF3QS5Q22NT9+S+yoO9KEZz4O/lLfkiAQvcDMvZxai4xcNhHAtGV+/Kxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457324; c=relaxed/simple;
	bh=17B3RSecJSLiMTAjeSJgkq5MMq3YQC6lvQkpMzKWeS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N57D5RMPRLG+keOoQLCS40dxshD46tiYAPbFlf3c2efWZGvvREyxrcB8h0Xr8nKFj9KqdAYbhbch1g89LU3tY5LHa/yuzVGIdGn+Ahlv/kb/oUgc7LvX8lKicDzPwAwRsRyGoh/YkX4yIDkZgqmN1lYyn6sYIriEtf4DmCqQnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZD0W8fsl; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZD0W8fsl"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cmJhV204dzm0ySc;
	Tue, 14 Oct 2025 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760457320; x=1763049321; bh=sAQk7tNP65W/y8HLEa5ajCN1
	i4HIMOUYTRKKBZcicDM=; b=ZD0W8fslNTek+Da6dl6kdFe+Um/uwCTTZIkzNyrg
	jESgWnVulKRJ88uOshvkq7m1VYL/5xfr6FynNXI7+UP58GVTpxzHQdD4wrzWhxp7
	yA2JdT4dj06zJA8zGvrD30hKzzgy1bwRwhcJiiJMw9M48JWmvK2EFKg3JvfXuRla
	t2esF82EnYyAAY44OfH0jK0pfgqoWKkMBWrgYaQYD0iNBCrOnnPRy8W0yOhH2Lf8
	mIYkFmdWKiC2fa/BNYyPn4B5E4xnzWfo8okCP5BOR63MojEgDH4hqCBIpkatIKyQ
	0RlCiVARsWTlOWF4RaynH9vqGnx3Qc4wjWSnkLjoc0pFzg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XHJoz3Ao3uY7; Tue, 14 Oct 2025 15:55:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cmJhM19nqzm0yTq;
	Tue, 14 Oct 2025 15:55:13 +0000 (UTC)
Message-ID: <18b78a23-4f56-4767-a3a4-4356474339ab@acm.org>
Date: Tue, 14 Oct 2025 08:55:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: Switch back to a single dispatch
 list
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai@kernel.org>,
 chengkaitao <chengkaitao@kylinos.cn>, "yukuai (C)" <yukuai3@huawei.com>
References: <20251013192803.4168772-1-bvanassche@acm.org>
 <20251013192803.4168772-3-bvanassche@acm.org>
 <aa88f2ce-7320-b71e-c1b7-e9e6a9b3dcfc@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aa88f2ce-7320-b71e-c1b7-e9e6a9b3dcfc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 11:10 PM, Yu Kuai wrote:
> Do you still want this request to be accounted into per_prio stat? I
> feel we should not, otherwise perhaps can you explain more?

This is something I don't have a strong opinion about. I think it is
possible to exclude AT HEAD requests from the per_prio statistics but 
I'm not sure it's worth the additional code complexity.

Thanks,

Bart.
