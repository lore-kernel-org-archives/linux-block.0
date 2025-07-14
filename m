Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A32494D8
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510887; cv=none; b=fH4ZR53nhAj2MW62QkWQzfsEUxdehhUV+SML/F/LX9oq8gRLIzEkVfQ8GuPS9H92LgyJU8WfhsuXFDa0v0DoI5MiomIPp5YR/qSEyaqaQ/0OV9rgMkebQhcfUe4tlt37BL5Mk8wHn85qPMmT7XDD6dGY9IclyXwLsfZGwu61mwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510887; c=relaxed/simple;
	bh=b123rPCK6o5Ku0/SuFcLNa6PIcwS9bx2cyG8/f6jPTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpiIvdOWqAPJncOdYUo8s25Hzid1Z6YuMm9h8MSjTjG2jhSL70BVt7NRUktV0tr+4ROgZ6yqEE7biQJCUDRObbq0GYT6Wf8RzkHCXVUbcRgKoKvaJ7V9OId6lIbGV3Xyx6q+bqaUjhdujFeAcdrojnKhqRMhFb/pCDtmzcqeOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pBTXmtjw; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pBTXmtjw"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgnwP30TvzlrxW3;
	Mon, 14 Jul 2025 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752510884; x=1755102885; bh=b123rPCK6o5Ku0/SuFcLNa6P
	IcwS9bx2cyG8/f6jPTc=; b=pBTXmtjwddcSkQXnvevA1ZFThUuIhn+2R3VZetR8
	9IKwM7TLvlNfckESxeLDlTRhV9s9psSIL9axkf3QlJ5nVJL77JAFlyFwbVwOCGur
	s1dzZWIwYCEpMPJnW/0pnHr0b/4xuHYFFZNY4SPDcZm1YkSpxNctpiEGqtSV9jI7
	vGq9QqW2tgCOrzV7oja9zYkrFEONZ3Vn+ALQv5uDTSCyh3urfVp/2SqzFlsqeUM9
	R+LP14BIZRxQ13vZZlrHC8Cjxcj8w8XHVKTRzFFcxlloml2Ii9EzkKpZjdSCNt/6
	djcNo+P64TzhtaTk96OHpMcRU/fpijX6OIucIerDktutew==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cEHcObvCv51y; Mon, 14 Jul 2025 16:34:44 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgnwJ5L2pzlrwfP;
	Mon, 14 Jul 2025 16:34:39 +0000 (UTC)
Message-ID: <92a13d0b-27db-4834-9d95-166fe4cbc9a5@acm.org>
Date: Mon, 14 Jul 2025 09:34:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] block: split blk_zone_update_request_bio into two
 functions
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-3-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> blk_zone_update_request_bio() does two things. First it checks if the
> request to be completed was written via ZONE APPEND and if yes it then
> updates the sector to the one that the data was written to.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
