Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6C394483
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691979; cv=none; b=GIACiNNBy2y864mTzyhZP6djbs1REsjW8T9CiDOwa0nfVC5sBeI8szrmZFc5OeyN7nnjG8LdEkk0I9MGTSiMVGA+aGCMW3ibxU7Lt9sG01oXU2Au3XU2+/7njr0R8R6CulerA2gI24EE0bPBrk7wq7JUDezTiBx6Uag1FJjlMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691979; c=relaxed/simple;
	bh=JnbixaVcAjuN8MtbUTE2h6/+kTANKuq3K/2CDyl42po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o90THvNJJ3zVzxdyHykr9vM4MemAoKKGfi8wXIwsnNLDm8xP33UbUdtu5JOges8fTTwqZ9++VO/YRQwaWQT3+nF5Z0vtq8WpzkfdTtdckWWafjqgj4JC7xEKbVB9XfpJyLuNIEIgSCrS0xUl6k7+z8L5tzLPmJ6HfFnun/vdAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=B5O0HpIZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="B5O0HpIZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR953tQJzlgyGM;
	Mon, 16 Mar 2026 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773691973; x=1776283974; bh=JnbixaVcAjuN8MtbUTE2h6/+
	kTANKuq3K/2CDyl42po=; b=B5O0HpIZiqeZqzJhx/RpK1rWCTh1vzYo0EpajCZP
	nD9LX0nTOvWbLal5vEadkLx6KGjXMw0HGr86l1lSclHiEqHt/sWLpm2WOzFqzzo+
	ycG28OHSqUYz8/JwHeByt5Ed0kaOg1JRNvRfnUWf4UJQ8Y/cIb8XeaARE2SAbTxM
	tuRQlOqcbNDCK+A7AEeuuAnpKvaUiOy606RAXGvSwuaT0ObZIX8s0uKaF2ho1TMj
	4KUgG4/pw5Q6RIlAOrbwSo4fUVHzyqPXLDSyczpKMYRvoYIALG8uyo6MgCLv3USY
	7Pok035ceTO7QdPRCdvTu/KnO9OIAVbBjzl6/0kUp79DIA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1Q_uP8edoYkm; Mon, 16 Mar 2026 20:12:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR8y3RxrzlfgPY;
	Mon, 16 Mar 2026 20:12:50 +0000 (UTC)
Message-ID: <013185b6-62ad-43c7-8421-4dbdbaa3501d@acm.org>
Date: Mon, 16 Mar 2026 13:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
 <20260316200901.4111651-3-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260316200901.4111651-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/16/26 1:08 PM, Bart Van Assche wrote:
> Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
> removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
> Hence, remove these two functions.

This patch is a duplicate of https://lore.kernel.org/
all/20260316174747.3871924-1-bvanassche@acm.org/ and does not belong in
this series so please ignore it.

Thanks,

Bart.
