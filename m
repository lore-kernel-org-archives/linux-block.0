Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AC13AA53
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510967; cv=none; b=V5tzPyW02X16Nc+gBZ6V69LLBX2Tllb3jgL2Onp7kNEj6JVhOUU0/tBP3mQEgRUhMJBWu1t2sH2dy7JgF35NnsG8amw7iIY3vwB+jKKVqYYNu29D0ao+hFHANw74E08oqdyO2cgegy8JCrQUBRCljeDLCLBL9plE14Tp8NbKasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510967; c=relaxed/simple;
	bh=CMRNx8iadrmS4+l5sqARO+gpI/6BGSkMWdW1S3PuOa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv5B66/r7CUfrCiOpLwE3dsOtqGz68amtSitEBEqeOOtj9Xy5V9jSW4nIcTXlvRgr/EUal7Z30M7SGBX8BqDnErvzlB6urzvk1HHq98K3f83+lNdqqJ7MAgwLGW/YpTAChSH+NOwqkUm74reJzfMvaHvDdQfVBjGSeP/q3pr1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XfbRWVSy; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XfbRWVSy"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgnxw5VlLzlrxW7;
	Mon, 14 Jul 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752510963; x=1755102964; bh=CMRNx8iadrmS4+l5sqARO+gp
	I/6BGSkMWdW1S3PuOa8=; b=XfbRWVSyk6ZXniM/JgFgIF8Bp3ayptnXMeKHsQIY
	pI+JLiV/t4J0nSrgMnDwD/9ZhTNT5W0ekXvPGDUGEzm3L+ja76SKrOf1orkS5KyV
	EaL+0tXxVK+RCII61auUtc2Rm1sF++T3skLkXWlmaLk0S/jXzlHSmfQCddX1RfOf
	/akcOBynpmgmVi1HoS+XVk971Dl7rfDD3wKgyQ0BUGXys/8jA/cTfKQRekga9EeQ
	TGhwjCPLNzw4xgMxDIsqLZ106vPlkTNsBhBm0WgPgmNZUzfgyvQBqGnmyN38YrLv
	F9LBckrHsZgrbRa3SRywzrqZ0HE/0S7dsACJEUquWU7CYA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LFYUPuwvoJoM; Mon, 14 Jul 2025 16:36:03 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgnxr4MKczltKjX;
	Mon, 14 Jul 2025 16:35:59 +0000 (UTC)
Message-ID: <0a3afa9d-513d-456b-95f0-770e1d543adf@acm.org>
Date: Mon, 14 Jul 2025 09:35:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] block: add tracepoint for blkdev_zone_mgmt
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-5-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> Add a tracepoint for blkdev_zone_mgmt to trace zone management commands
> submitted by higher layers like file systems or user space.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
