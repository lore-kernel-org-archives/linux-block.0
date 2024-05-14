Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48951E480;
	Tue, 14 May 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700934; cv=none; b=BFe4Br46jsIaOn8fbwjmzDFhmzS+ljunCZpq28+/zSpPGcgpxo0v2jLmejbIU25j0OV7EziNetds25Z4QoMS0I8m1wvUBmvDHtcspf1IJPLmldXSSZBFo98E86w1jTrqKau6xY6wg8KwNAXUWH/+cVkEhK417J1rxjcztz1Kljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700934; c=relaxed/simple;
	bh=SoQbPUWxjuqB+n6gFAZO19Vdp2vroZPMEa/RFMCFvbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmWVmj3iWskrXZ+bQHdCeiNMu8ug/T8nKHjQIMzJiyJg2BekjXa5wVy0Y5f489gBu3k8k94Sf0p6Dn7cQmYERnAgz+3+jPyxsiBFcZSvETXYwU5O+HCkYGWXf7jGkJDY9U/vrTSCn/pn0V5c3PJUcA0hBnAfF3UsF+7cve7aE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YPkQtHr0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YPkQtHr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715700914; x=1716305714; i=markus.elfring@web.de;
	bh=SoQbPUWxjuqB+n6gFAZO19Vdp2vroZPMEa/RFMCFvbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YPkQtHr0zu+SIwBO7X/Ck26TsRZiCSr0mGja7XWK5C7HjtYAhICMVTUOu839walo
	 0QdbYiEfDLAv8pRa6IFt/mu/kieWx9+4rgfdTi1wqtkFnOQ6VGEREkBDOBg8slNCZ
	 bdfJrqSuBaXsK0pSCLpfDnuhURh2pXksEzbN7PsrxltTssud6hIJ/5RZHAyeHLaFE
	 0ZuQOvobgftzt/WzMVHlSDllO/bws1V/je/yW5LwteuFH0QBRfKjqgVXSfw8JOfQ2
	 HtDhIUg6Y1SSGkjKSJnUvZnTRMhniOSdcC57RJ2TGhbUoQGGODmO7EN71QVtvkvgY
	 RlK0CbQfIA5NC6gfQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1spLXQ1gfO-00jham; Tue, 14
 May 2024 17:35:14 +0200
Message-ID: <e8331545-d261-44af-b500-93b90d77d8b7@web.de>
Date: Tue, 14 May 2024 17:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
To: Chun-Yi Lee <jlee@suse.com>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chun-Yi Lee
 <joeyli.kernel@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
 Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
 Pavel Emelianov <xemul@openvz.org>
References: <20240514151854.13066-1-jlee@suse.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240514151854.13066-1-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fcZPHpdMdYfE0uS8qeE7j3Ylbn43JMopNHDsYQV+r0PbpW6+1c/
 L+M7MUop3bLNG66Gth86c9Io6zCZ4SYcOsn3PVFw+lfR5R9t8HPo+HglFxBbM/beKqXwV+A
 rMZA2ORzZBI20Shg3pfCK2lZqGWixL9zqeUytlAlRD2j9s8FMlqkmZTwiEGBuc/4NCDtett
 rPDW4HYm03VeeqT/4543A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6I+Qgqut20Y=;KKxnByEwbtSb0a0f5l0OIb+jA57
 ISpL5Glnx4xcxK/cbpCLrpfZPApEmvrY3m1ELObL28qHVdWIddKDjE65ovaIaxM/j7MLizFLe
 kcarZUePKtUGaKOO+X1or58PvGcmH+XldnM0KJgow9JS9RGBJIkmdWXvT1WVtmB2GF3113rA+
 xUV0EUQjLfLBYBnKtRHIFdr/e0orijwC+pq0IZtWHLEEGgVWM6RS5HoKWACgN13KdLIN4Yx6n
 5VGpJG45YnGAQyv3XFpIkPdRakHnubSXU9e6Ws4ZaKxkujqVevA3wX4A9cN+/Jd7IxUCiwCSQ
 y919thdyBNGzLnLrzw5tqf/07bZFmPfuC2roipZfJCWktRedaSyUi+jKVWoZwMfNbuD6C7RLo
 YOqsrS/pEQORAPZUOuUr3uplYLMdQvNONN8deicyW0xaiuidQVrJuaSMS4hbuuCfQXOhSKJLc
 /c3pd1wWEuJuBn2w/mpirHqTSx0p/UC8pxf4ZTJHVNjewbTtqdgnu+qVHiHTUmSk1uT7kdUUF
 OeqcRCnWYB9S2BCNCubglzl26TjtS8tfsdHDg0E8OazOqEnDKuM7ej6dvC6dprHrreEThJWIc
 z/Hxpx7Ner8sXKsYXc0UWp/Ed5s1Wnt/zA0JrdvB1crdKsQMEQkPwRNb1PThUb+YRZFd+Ja70
 ZifucfsgnWMsFu3ybYWRK4F4QDqNV4grt2EZOEBe8ZmAVPP2Rt0vcSfVn8//A7IWE3vo35R8x
 NrYky8OFntbpBtsq3+OKOeGFJyXWYskCg8Hv2JEz2N7BbFsVwb7NU+/e8KriGYZzEY7Tjrk8T
 mxFHr62of0Y/RLm6oNayW2dQSnXmQw1euLShpvKrHfK+w=

I suggest to reconsider the version identification in this patch subject
once more.


=E2=80=A6
> This patch makes the above functions do =E2=80=A6

Do you stumble still on wording challenges for improved change description=
s
in your patches?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

=E2=80=A6
> ---
>
> v2:
> - Improve patch description

V3:
???

V4:
???

Would you like to include issue reporters in message recipient lists?

Regards,
Markus
