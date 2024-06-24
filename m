Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484097FBA4;
	Mon, 24 Jun 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221287; cv=none; b=ZTqD8QoJJIugO9Nt8N63GVLf3nYGwBl2UY+ip1qT09hjIYgrWoH7kFOW1BU3F/EaIMdrGdj5Xf22Ro+LsCBZ8XCdwx/2XOXkbe5A+C/DFV8iQwQJpt1MFKhsLjKnOP3ToACXzMtWomPfzG6qvvfgJl3iMRBsAgG2ZHJxqSJNSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221287; c=relaxed/simple;
	bh=DqctyptmWGn2arqo56CIqkooxnyFfmr39v3btcFTusM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QgoS7EcQoiiHK0mPEWwAvVI4a8SEALNe9to1zhD9Kw2fCypgHhmHdkwlmVIJ+Q2E8smtyibUpU45duo4NfD0w9HLzVCTsFUZkZ3NG0jE4QFK24BZJFAnQJlvb+rELOSTOLhplEzBc2LfxkIjff+R7w4gQNJNTIjUtJRMxPSUNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q6WXeD48; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q6WXeD48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719221274; x=1719826074; i=markus.elfring@web.de;
	bh=DqctyptmWGn2arqo56CIqkooxnyFfmr39v3btcFTusM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q6WXeD48wMbTBj//PpI1iKofRevss9nPQ+dpXqcZen7tAVs3RGLVt4c7KQD5CLJl
	 ayu+zB//TVX3iFXk8n0xoJSsvoTQzWVYyXt4JEp3pKd14lr0PigrKbmDtFigMYtXG
	 5F8QZnBqOtvnx4IxFPs/jSPg6Nyp08OYY+VWO0Y8U0axyIt/fv0PfF4+NOBn8OpKW
	 GfenQ6tyJUlcD1QwmTGxBe7e7bHi4mlcDqaE0LB3zT71WKrsXJWv+78PADD4IZ9GN
	 lDq+aIEjZ6WUxm0JVo8cmhz6R3oxNJVkF2dY66tWTAXohxrcwd0gvPgyICdwBcgge
	 iITbB9f4Vvm7dly8Lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1sCqIk1ngu-0039j1; Mon, 24
 Jun 2024 11:27:54 +0200
Message-ID: <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
Date: Mon, 24 Jun 2024 11:27:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chun-Yi Lee <jlee@suse.com>, linux-block@vger.kernel.org,
 Justin Sanders <justin@coraid.com>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>,
 Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
 Pavel Emelianov <xemul@openvz.org>
References: <20240624064418.27043-1-jlee@suse.com>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624064418.27043-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7HVH/51jI7CyBTnb+/gmFxsa+Kp2XpH4BFFMCXDZpjJmNrbCMt
 54xj4FESQnMqQfoFL5QulTH83uhZAojUyVtOGwAFkwF8QFFIuZCsaGu11B/B7rG5Q8hTRGI
 96Dy+DcEgL6DVhapO/v7OESoyPIMHqEDYjaQaV2/UJ4De9NM0ebs+adU+/L2vIL79HuEjUd
 5yGkUkkGLtZhndb6UM0Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JVPe30/mQqM=;jy8Yj98OKDfpnx3i6k5I7x5XSbL
 ZROY+LWGPzuVbAiFCg7YA3GjoDH4m81ZIiOxYw3jU2uM0NyKFEU+oTYWsFP/cwe3AeN8xUo42
 igMRJwTfsDGgv7RDoTVJpZeQmmK5mF4dqZLvIvehlPsmxfJR9JJl1EGm1D63S2T8fB5UKNstA
 50yLLvYnUVcdE82IKquPk4iW0gJQXFWs2pyNw0BjOAZDuCLHoxu7KIGaLgyibzjNaHvnfLJyu
 +hW9jskFv2K/aaWU0Z/hrNfZgeyTpYns7++ewt8QVhuuxb/rNT6Rat5Dm5BT0OlpO5P1wIk41
 XC9q0LC4lj9e5Qi01gaTit8vk9Q6yvkc7eaABkDaCE5uTa8k0UXuJP4lALxrQcJoaThqbL28r
 O/E3TIGQTH+ZZuxS1Ubqxto77Sl2XDJEXyz6h+D5AvHui6mX/VY9BVa9IujvcHrMBjhpjJfjD
 YDy8Rvho7Z9li+GpgaKtSJuwB10C9iEvQ/BNm+Iv52D/IM0ADy0x6jqbXPXwaxUhNOqbIwlZi
 czvxLm1sVIC+BtYdpJue95R+1YPjUV1K+NAJa0N1+it6+vj9YczglOk05pGrav9yqHKVUHhmO
 N0Zj6mx9yYRohNJmMor2ltMl/N+/TWr2Y7OECClZhnoWkmOoi1o+v2f2O8cRGFbmdwXHeTCiL
 dHnMZ07EGqD9E0GuAJYeGf0YM5w3TzE7xyMpnFcH59fcma8Q34WAhC+jhwQHOVsL5dp/5jgla
 nLCTo/O2SvXyXIBWhtQTNoluhk9OGr3nvHGG44h9OowsduEhvTiG515UWMlKB9jd2rKI5Rndl
 7zx18r3gVFeFYTlexNpUaaozije096+IMiZ6nFTjhDUCo=

Please reconsider the version identification in this patch subject once mo=
re.


=E2=80=A6
> ---
>
> v2:
> - Improve patch description
=E2=80=A6

How many patch variations were discussed and reviewed in the meantime?

Regards,
Markus
