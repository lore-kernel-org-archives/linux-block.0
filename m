Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225C27D782
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982566; cv=none; b=YWNv5lGecA0oL5mEU8pCmMoNeKZwlOWBFK33hXKJRonsCS8e4eXN4jp5BCgV0GHaCVOnpaZDQ2QsxJo4bgfOfLTjQLfCa8TxsM2Ag2V6XOmYCztzCHCwSTsLrxjMxwlqxwwhATiY0mQJFUT3GB5w2H7K1vfhnLjStNbtqjaeDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982566; c=relaxed/simple;
	bh=vk25w3y+pKb8LEk6sc4+StXEp1xeKEfhZQhwN4wqcMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=NJgf3Da4DkevPJor/cgfqDcJAGjaO/buf8P1DG4/9hVuS0D2bFDxn2WSY8nMbOizuSjtWxdGRDoPBeuzE5HyRk2kqRiv5PrBkFAR6k0UlhucIAO+wCwULSF2q6PgEdtNcrxvD+lKw3LpLMHs5VLtzBz9YOXKCWhLHfvPWbSN4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HShsVefy; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HShsVefy"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d6GZk2TyXzm17F9;
	Wed, 12 Nov 2025 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type
	:content-language:subject:subject:from:from:user-agent
	:mime-version:date:date:message-id:received:received; s=mr01; t=
	1762982557; x=1765574558; bh=vk25w3y+pKb8LEk6sc4+StXEp1xeKEfhZQh
	wN4wqcMg=; b=HShsVefykUU3daBW6agXDzr2GKQ8wZnIx5/hAnzzcITbU/zDUsd
	PPmfl3QrcGfP5DGzmrKony+FKu1KaZJILOTBn8FrXlC0/cFGPHBKvLuA/20xoy64
	VO9bip119I7Nb/FIaExyGVoKZPaYryBTiyCFdol9Z3QdmgEL4/jVCpT3RjpSEQKN
	lMcOZS6EVHsPeNFMs1iG+DVR08KXxpHH/sRXqdqjKrHcmExREBcni+fbQDjWHVnY
	U7ouKWHQo62EVpTkviT+mYEesxOV/z1sMKJptnHTdubNBI6uI6fgcvuvcv1qxEZq
	6DQAYZSXLRfJNmbl7h5gtECo15UIRreABEw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QDcSqnf910cb; Wed, 12 Nov 2025 21:22:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d6GZh41YWzm17Dp;
	Wed, 12 Nov 2025 21:22:33 +0000 (UTC)
Message-ID: <cfc75c41-a230-44f4-8e07-fabb1838e02f@acm.org>
Date: Wed, 12 Nov 2025 13:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: block-io/for-next build fails
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Building the block-io/for-next branch fails on my setup (commit=20
0c9d2fd731b3 ("Merge branch 'for-6.19/block' into for-next")):

io_uring/net.c: In function =E2=80=98io_send_finish=E2=80=99:
io_uring/net.c:533:26: error: =E2=80=98REQ_F_POLL_TRIGGERED=E2=80=99 unde=
clared (first=20
use in this function)
 =C2=A0 533 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (req->flags & REQ_F_POL=
L_TRIGGERED)
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~
io_uring/net.c:533:26: note: each undeclared identifier is reported only=20
once for each function it appears in


It seems like a definition is missing for REQ_F_POLL_TRIGGERED?

$ git grep -w REQ_F_POLL_TRIGGERED
io_uring/net.c:if (req->flags & REQ_F_POLL_TRIGGERED)

io_uring/net.c:if (req->flags & REQ_F_POLL_TRIGGERED)


Thanks,

Bart.

