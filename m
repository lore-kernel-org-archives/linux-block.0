Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2736E460
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327734; cv=none; b=RbNG8g6poOP2dSz1k9+Ja0jpaY5M+BaKhAP1jtXWgT9tcSqMlviSd9dxkPmUyVD6bkTrkup7S46JSOBnnTT/kv2oSTuXiMU6e13ptg1sAFVT/zFREOe9EhoCk5ol1kdMshNeBCxvUZ6amLJKtYGnaUDO+6Pr/1Ux6gljpR1EZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327734; c=relaxed/simple;
	bh=O+NgwJJrFdIAgy++/hfur4P8yglYD09wPlrABKKWcME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnCTuhiLYMYtyX21lB1dYihOakQ34dU1iWJshdgCrCWSruNt+V4mDSKZmpI2TTiH3teJIfFDFG0vzZfVrN10urGJ892Kwuz4WE0Ug6D4fDs+7JBUw+pLQypcfcYcHGBEGBk6vMiCCwibZcps2yLlbIjWawuMZe77T9KicRDycY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rVirMnIN; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rVirMnIN"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hRPz85yzkzlfq9x;
	Fri, 21 Aug 2026 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787327730; x=1789919731; bh=sSHpxHiKQVTtIoaqiKa+8f1e
	iZSTKXwfUB3rFEHStLk=; b=rVirMnINgZh5mpvQxlEEPhKjcPeue0TeSF/zjJjC
	CSRUNTgTxK/R271ZEz4qVwkLLWG19nhQm8aZ2d6E0Rw1WK0ppdREwqY6Peayeg5M
	KZSXMY1SgfQsRIB/tYrIMGBL/FM89WvZF/c7UnVm+JRGD53IzxpMRMuTsohYEX00
	2+50w6ZYYGifbeP8s8244nDPCtcfvAGM8UM9Z8UuwusfdJrORLJkQcq+jyHFDpob
	5tTADFBQ7+Zn/v11Syzr3jEKUZm6eCXOaQ2aDLPPJD55Wrxgo4NVolVn7mXX9zlI
	VOHlhVTlmeKO5gWwVUikkBLGuWcQ2o1MT/1hs3Duq/Ns/A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NiS07IjMjurc; Fri, 21 Aug 2026 15:55:30 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hRPz34RsRzlfvqQ;
	Fri, 21 Aug 2026 15:55:27 +0000 (UTC)
Message-ID: <a168cf4a-a699-42dc-aadc-8befb2abc653@acm.org>
Date: Fri, 21 Aug 2026 08:55:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to
 GPL-3.0+
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Li Zhijian <lizhijian@fujitsu.com>,
 Akinobu Mita <akinobu.mita@gmail.com>
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:53 AM, Shin'ichiro Kawasaki wrote:
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/029, 030 and 031 are licensed under
> GPL-2.0 only. These test scripts source GPL-3.0+ shell code, but
> GPL-2.0-only code is incompatible with GPL-3.0 code [1].
> 
> Relicense these test scripts under GPL-3.0 or later to resolve this
> incompatibility.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

