Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C52080E9
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377069; cv=none; b=W0J+faY7U4/RpHM91l5Wejlhx9uLL0EY5SNoGN9n1txS/wmtDmlUlI9vQ9s5mFtfRi+7D933ryao3oPWdJeBk78Cx7+koGZFfLSvgWT8lBWgLoOT8d+eBhWG1xMpOtAFHgMaiLMMsDsSIUB3LG7rTGjHm19yucZv+n3/7uu/fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377069; c=relaxed/simple;
	bh=C9/sUssDMVJtO4isQG7BQTSJeUxz734QDsNXnFksEes=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GRU/yqJFETxfF0Gzi8J+HQFQS+5G4z6Bf1p9zVlR9LaZlpQevAWFbPU9LY3NdN69ugwTrauYeT4BroYJpep+0soBDbeiFwOoYIxWgMn5OdaKyeTx7mbCF0oInPIFKPeNkgXqjSZ2LBtEhO+kjWwtM4o4HshXeNFqIecLOff5bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u6KXpAb5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u6KXpAb5"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBqd72wl5z6ClL8y;
	Mon, 16 Dec 2024 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1734377065; x=
	1736969066; bh=C9/sUssDMVJtO4isQG7BQTSJeUxz734QDsNXnFksEes=; b=u
	6KXpAb5w2AN/Zoxt6+gskiwlicqhMmAgCIde+ozlK1pgRj3HOq9bBlm+69TLzhII
	xPan3FAl5n9DFDobUO4/hJTlmteEUH0lMwnoZ63ggtEXITnNaTgimYQaKqd3dB2v
	rOtQdCPOpLxuy+WkiW+gjicf6G2erCcGefUX9JvBmEbhtgCmG+omMA5yae5SnUbD
	oD41YOL9i9QgaERz9yvv5DGPOOEZj75v5922Gib5bDY6OWIeMHZfnb+GM4dh9dlE
	E7eIyTtENZXtLhLQqG7Na2qjWkB593ItwbpAgiPG3jHEpf4b4DJq2N7lPuPjZaWS
	LWpj9AnYdqpv71DmpRo+g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ta7oP5lh7xq9; Mon, 16 Dec 2024 19:24:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBqd46ZJsz6CmLxR;
	Mon, 16 Dec 2024 19:24:24 +0000 (UTC)
Message-ID: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
Date: Mon, 16 Dec 2024 11:24:24 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Subject: Zoned storage and BLK_STS_RESOURCE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Damien,

If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
against all kernel versions I tried, including kernel version 6.9. Do
you agree that this test should pass? If you agree with this, do you
agree that the only solution is to postpone error handling of zoned
writes until all pending zoned writes have completed and only to
resubmit failed writes after all pending writes have completed?

Thanks,

Bart.
