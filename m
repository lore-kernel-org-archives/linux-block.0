Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA31D7E41;
	Sun,  3 May 2026 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777782420; cv=none; b=baYu/2mLyA0taTdCNeaSepb75bJEwa84QeMscNcFWt7w6lVQBVx3OIOPzJvXqOWpDP7+yzVIywcVUB2kntbMxxe+BEWdPfKJpqL1dhGGM4CpY8/u3m27VLkYkQ4lsDO6yOR3ssODU1VORVtG+HWtwZY28LC5X3RzGuj9XXeiNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777782420; c=relaxed/simple;
	bh=zyQhfMBJeQdk9WXBPBwGmRiUbXf1GYIV2aY9fQEqwFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=styqXxUfDDLp82TsJBkpOyP9IEPvtcyHdMdVj6lfV5zLT20cvyPq0iwF4cf16CiWMiXLmko5kZHJ7EYxSQ9Gqr9SJ3owUdpN9qf2p2vGX/VgSD554ad1lPUN7qrHAXVQPY45h7P3ici9J0YWdtSFtystUdA1fHCHcbANoHmZXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Co51Nmdn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Co51Nmdn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g7WvP5lYqzlgtd0;
	Sun,  3 May 2026 04:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777782414; x=1780374415; bh=eWNCNYNW1OLGDs3jn4yxKUa/
	WfheV8gev4NydlF+8O0=; b=Co51Nmdn2ZIwqyqyIBiRHczCgM8hzRG19hOF/YC5
	7rvbIdFmb5hn6OZ7LpCD+N0PP9QeGV8JL9Z1AJbE4ep2rOEukyjV79sT5RD41Lmp
	DKFwSptOtyBBIkmuxwrGWaF68O87OchMJNY6QYTSBG6RKZgCgnyGeoI12WWsJlBz
	pahONUPuTsydDlgLyrp0V/1jRSXnY6kiWrkzn5Z0GE8NRDl0mByaaX/tHOR2Sp+8
	tse6BjS+pPsjEjJoI/QJ6kSKdgxJ8Vz9AQOuyPpPoSz1mZn6VeeOQNSE9Rmut2d7
	GPCxbyFbsDl6RwVpCSsAkgcmlvfamh0AY3zT/FYVvnkTGw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tHmFPVX3d8d3; Sun,  3 May 2026 04:26:54 +0000 (UTC)
Received: from [10.211.8.206] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g7WvG6KskzlfdfN;
	Sun,  3 May 2026 04:26:50 +0000 (UTC)
Message-ID: <d8a4d967-ca1b-421c-a452-d440df9535f2@acm.org>
Date: Sun, 3 May 2026 06:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: restore mempool reserves for non-block
To: Carlos Llamas <cmllamas@google.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20260503001734.858296-1-cmllamas@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260503001734.858296-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/26 2:17 AM, Carlos Llamas wrote:
> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")

Hi Carlos,

Please help with verifying whether this patch series is sufficient: 
Christoph Hellwig, fix /dev/sg allocation failures register, April 15.
This patch series can be found by searching for "b520c4eef83d" on
lore.kernel.org.

Thanks,

Bart.
