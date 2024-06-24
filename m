Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB71386DA;
	Mon, 24 Jun 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229426; cv=none; b=d64zuZLNAoUta63VPiC8bfQS9tya4akwMyxyXySk8UPLhg+grRtl9fSwBp5V7CsSovSJZ+ypoxSnHfNPokbCTdry0FMgW1Ahk4qlH1YLtF6rwGWoVqVIXGHtZBomtCuYjyZiCnrM2lrA7J3pUXp8znorbCDj90PDQ8/+vk7jdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229426; c=relaxed/simple;
	bh=rf3ndeDJhEWP+M6CohKCaCCA2ikeqoukdX1sw5tM7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jng54M2BN6g94wdU7Ei8D9kJ0n5LiRvzDgnCBDx9R8Yr1V6aYWnH8EndkSAqX+AGFW8qnZYTzVF9ZgbmRmxIHE9G5OjLUPjIidw2u0GER+LsFQeoHHI3DteZGZ7cw+g5jyj4FcKa/GemyjCVyz/6D8tpLuD8hzOdBQJCa/MVCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HDBGSjKY; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HDBGSjKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719229408; x=1719834208; i=markus.elfring@web.de;
	bh=kQnixXovs1rVbARPRiGh60zwV7J4BuYooo3fLFqaWKI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HDBGSjKYy1s1eImSqm/YOgXOSa0KG/bxHhWPrPvPwOOsz0ImCKYibzCjrs5MeptK
	 MrhiMyxq1GNJv3pT3UkTRMM+9CWDzCh08BIh8dmGLm8Dxsqbc1Z/h/+ZFo3wjJAIZ
	 REzGEmFSMDEs0y1PgdHfSvQC2DfzxwoAecXcmHNvFC9KLdxQWqXLfHwDYyAhlVT4O
	 j6AEBeSHJ7xBeqn2J05gZNlPxnPgklefCoM773TOJV9NfPzRPhEXabnSqMhnn+Mrb
	 bMCFqHRpc71zClxLi1LrxUmMw6sV+/zQVltATnshxjdz+7tJyjOfNgdKyOnGn4/Q0
	 vr7W+WFM4J4Xf23kWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1sa44C1UI8-012ydn; Mon, 24
 Jun 2024 13:43:28 +0200
Message-ID: <74d3454d-6141-462d-9de8-b11cf6ac814c@web.de>
Date: Mon, 24 Jun 2024 13:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
To: Chun-Yi Lee <jlee@suse.com>, linux-block@vger.kernel.org
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>,
 Justin Sanders <justin@coraid.com>, Kirill Korotaev <dev@openvz.org>,
 Nicolai Stange <nstange@suse.com>, Pavel Emelianov <xemul@openvz.org>
References: <20240624064418.27043-1-jlee@suse.com>
 <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
 <20240624110137.GI7611@linux-l9pv.suse>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624110137.GI7611@linux-l9pv.suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2vSVncxPuAtq2in1aGT1tuFEEIu3belkC4agn58SDgVuFmFMP5Z
 tDq5aE2Ne4VMVNpqsvyemjdkBO/myYwrdPNIca28y4LJbGcJCsnKKmzOnjqYZuPNbFC6C8w
 YTWnLZBaBOdnTRZsm3/ZH/Hs2bnTJ5OuRDvxxGiIY2D28oU32JNuHR0qlGIuHY+McJ7aFKj
 vvmfaHwCwxq1icQVapIkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8lhSuuBh9fI=;aFhCcEShFFP+/JOIEsPaighCfes
 8wtvO7OK0PiuS78JnBXuhYdqSjDxEwNz5bStREUBieGmsPufMstY9AdLMnUBvCvAm00c9z/3c
 LGobkGBzIybMQ6svSJI5PTScTwE5s3Jpld0A2Ws/X+XhMpVhYL6q24NXKW52eR8wsZ/Fah5qe
 YgIAhzW6GXuTlXOtVleswfStn1i5fdsEjq94vbOcoKycZOAnkEbnFOnHibyIylmeMdSl1DfgL
 NuZR0EiWw88hrboXdPMoTNmdKrQ0GTrqTLXpLuIjx6arSgAE+CvpC98mewusTA6UEFGZotmsX
 lofWnPTfmKRcpLvpqvA2kc9GV8mzOIYdZ5s1OFEameOYxM/1YphBf4Dv69XozxkAidjApdmmG
 2HeMCG+raag7+dxNRLo+DaAS9scm+1FfGpBrG5HYrwITHzVFMOAdyc8FfMw1QsvvgnAWZA8QG
 xU5L5lnieHqecjGn1slGEi2hyDikUvtRnfC9Avsje4soJM5D+PLZne+CPH2LbLr+V8DG9EJ2v
 uf6Nc/8IFqewtOy7sGdoFufctFenRbhjSg5D5vPh9rmFMIpdNASiRyGLGDvYlGnzkS7u3Kdqm
 KY8TBDB7fqx83mKJTu+My2F7LwfLDfAkbehZaSbpppCu3LBg0efbaZX+MOwP9OHFMLqWk8MFE
 fDo+ozK+RMSMWSaqN+yuCIodfWbHDGLFOR4klKuKR8/9SAYNwYxPOv5DxKzRbuDfgyULpiXIO
 eA1dNZgX73hhWehrZiwdE1XHhfCEZ/7O9P/dPoF0tYLDDmIGIwjFtVBWrmYWUEdOp3Vd47Rms
 l8Jb0PGvByB8CRrQD4wpSc7t+asNDa1dlPFDen0GNJdaE=

>>>                   =E2=80=A6 So they should also use dev_hold() to incr=
ease the
>>> refcnt of skb->dev.
>> =E2=80=A6
>>
>>   reference counter of =E2=80=9Cskb->dev=E2=80=9D?
>
> Yes, I will update my wording.

Would you like to improve such a change description also with imperative w=
ordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94


How do you think about the text =E2=80=9CPrevent use-after-free issues at =
more places=E2=80=9D
for a summary phrase?

Regards,
Markus
