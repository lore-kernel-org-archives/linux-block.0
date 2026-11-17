Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956638;
	b=SAgepQnw/rQOEBcCiC23Z4+Gh+UujgREg/qGEFa2ZF1OTji/rT37B+hW9I3zYKPiPPxS
	 YXHxp1joz/MqQNhe+VHJEj3xUBw6flBRljG3LsO3VB8/4DwBZWmuqrHtoiC3EqtLzXpnz
	 YqA9CTqaO/JiRs05UGvsnmGTRJFmCseTR/VGZONq8xoGqfSo9Cxu6dGrAYR3A+0q9grnW
	 GLL/LQbYz/daaHKac3IYHNIvHLjSgACfMEp/Sq8ySjLkmD3RfypOIJF2RhxVq+m32h77I
	 eeiNOUKXiyY8BmNF9reBA/g64FTjx0by2PmPeipx7ArtGS+s4A/2h2ohQnVFd78yZdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q0EAFPXApLmIVrfHiK/3JTT7SOx9ckBBPwY3H6fh0BQ=;
	b=DtLmSTJILY6gljQrInbeIm2O2MU3GMcXgj2bLm2s/hJpSpBuA/ALapEmqphxvE0TlxH7
	 MQE6mk5aQvOnxaOk9tIv8O/bgA7cJ8k7DowIllSsCHUf7+RY5LN9OK2ZbS11vQqbC3s5v
	 q8phtn8fnVq5xMhUh2VEfmrVp0+dXmMxlF25gBfCGmArR+oLH/6mOFh0YFYZqvt9eO2KG
	 6sKPazadzlc1QKjK+mVmmZWWqUZntRvloyWKZ58mexoWwg439u7NFIq0Azp5amgkMBUnz
	 SxBYTalNsAU/+ZJpG/x0GNSEpi+ayR7ykR1fVLGcTzg1asdfjr5kxcAvNvDeo2c6vrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yYDUJR2v;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD45606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD45606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yYDUJR2v
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jTgJs3yZ2zlpHwl;
	Tue, 17 Nov 2026 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794956636; x=1797548637; bh=Q0EAFPXApLmIVrfHiK/3JTT7
	SOx9ckBBPwY3H6fh0BQ=; b=yYDUJR2viG1Xd2vNrpUUexKR6Zibz9Z6g4R91p9K
	y2O1auX/F9eXfHjAYlAvIgg1eAoh+lTNt56vEKlBM+y6gp78aasjq+Kj965VXbba
	6FlBiBJqq7038LnWkd/9bXemKM14SxJd01Uw5h4rz30HXRlAJBFNicPnLIWL5gv/
	qf9bOVtmi0RvOqWRDbOvPRxFJundxyY6mkpUyjEcg4HE5TGkoPVSNZxcT1rwSkh/
	jAX+peXJ0HpjU8o/BPtJ0vDCzmRUAQBrJg/d+QGYRXvGtTX9nph+BiZwQHkWDbIx
	X4aXnp0RJmVd1KIH2OUyAQ8cEkkexbj3Yg2kPIIzAL/P0Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id e4Epru_058y9; Tue, 17 Nov 2026 23:03:56 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jTgJq6Fpqzlg7MN;
	Tue, 17 Nov 2026 23:03:55 +0000 (UTC)
Message-ID: <8de875b7-e7e7-47b8-8cf9-6d07c791a53c@acm.org>
Date: Tue, 17 Nov 2026 15:03:55 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] nbd: Defer request transmission to a workqueue
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Eric Dumazet <edumazet@kernel.org>,
 Aibing Chen <chenaibing@cmss.chinamobile.com>
References: <cover.1794865298.git.bvanassche@acm.org>
 <3868f992-20ee-4b04-9416-40a5a333cc27@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3868f992-20ee-4b04-9416-40a5a333cc27@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/26 6:47 PM, Jens Axboe wrote:
> Something like this _really_ needs performance numbers.

Hi Jens,

Measurements for the most extreme case (4 K IOPS; Unix socket) show 
about 5% less write IOPS (310 K -> 290 K). I think this is acceptable
because anyone interested in peak performance will use drivers that
yield higher performance, e.g. NVMe over TCP. I will publish the code
that I used to gather these measurements soon.

Thanks,

Bart.


