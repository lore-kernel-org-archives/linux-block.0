Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E83DDDDB;
	Fri, 24 Jul 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927320; cv=none; b=R7rguREEBvVJlB7GZB0kp2xfs3khHFh6fQa1zH2yCagoLBEyd8umQJy39udVYzaf21b5a7gxvdXBLbOixmhDxaox4NDO9n7jTLSKzp/+oHeRCQ42mxwZHkjuf+2BeAijxeq4nh9WC0Viu+7H0cg1qmYKZJUsA2RWl8gHE0M/23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927320; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfrByOlKraF7utX5n7h+6QQ3kKZpYxBBANuscPAG6OzJONPvc0FbwPol9grmotcGoUr4wcHE6b0TU5a2bjsg8SrJf2aIrYNZ2EIj7VF2MraVdq8E41crb355vd8hJn55ja37S8szm16eqyoG41Hl5VzAppNdl1aZIh/es0cptlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=m6SXFcjE; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="m6SXFcjE"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h6LFH0D9hzlfvpc;
	Fri, 24 Jul 2026 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784927310; x=1787519311; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=m6SXFcjEQRgnl3us3nLOTJHJYWLVtKn14EcX5UMO
	p+eO0EIQQM0ABJOJ7CbIsYARUZb7a6qzy3OiiO6CwWtke5wh18c21gzS/KSffa9n
	lPfhAeHOgdb7tdiJhHqajBtaMteQfid7Kk+VpbyOowrj3oFMhJnZnlq41Pm7JDxp
	MgFz2iUY/jC79tXM89ZIl4bMz/+3Xs0m077l22V7aECmJWu/rKu+YveNEHLCMAyp
	eNehaWE2AqRfUY4G7p1N70NbZYGm3x0NCJ9mqjdqwKDtbpYXizx98OVAM6RP865a
	79LPJJA87gq1MbcST3IVtRZJx75u+rxonJrIeB8KUK8joQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XSwhZ3u6d_J8; Fri, 24 Jul 2026 21:08:30 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h6LF75py6zlfvpW;
	Fri, 24 Jul 2026 21:08:27 +0000 (UTC)
Message-ID: <eac38948-0f15-42a2-9e9a-d268c0b0533b@acm.org>
Date: Fri, 24 Jul 2026 14:08:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/9] null_blk: free zones array on device power-off
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-6-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260714041805.1088702-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
