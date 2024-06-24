Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FD482E9;
	Mon, 24 Jun 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218428; cv=none; b=Y5PuvCMj101faDdPqEXC7RZpomXVd2Cre3skkW6csbq4ptUBi7sE9erdwp4GPgIPcFBdhnlRYbf0kr15mnyyagBwzA+FA+RIcEF8FQ4faOrL2XbT9BoK8voIvb9NWYfYHQAqQSZJWFnMPBrjGexOHcI+ZXPuIv9dWEdaGfjmC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218428; c=relaxed/simple;
	bh=2iC3OAZUdkr3cecsPtODKyYUOgdaRd6A31pCpLjqsJU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ejJbsVgBg3uPDkLYAW+o4XfCQuGQ5xWi3nXyXKDgcH0R3gSnSVTwiMGxhEU/r64Dwn3ZwsFLGh2NdFEE4tH6+iUZ8SUXgqJCRKLvF+ucSVm9+fABva3LFJiz/mlewHQvVWkx+jVwKV2dn2oRY6c0QiMZWj3rnowQv4MlSeZczeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cbpqr/XW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cbpqr/XW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719218414; x=1719823214; i=markus.elfring@web.de;
	bh=quptaO3sMTWvPEWJGB+j2YmWgat56aBOPDyMx6hFleA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cbpqr/XW5/VyL9bpb0sk3T4J+BOOG7xgsjgB4JTlAEbH3/saNv3JcBXwWts/xPXW
	 Yrbr7Tn3PStcX2NwDErMv7WTEU75xBcmv0aKxjoVplLQ5nyQzXtI9uZOihF7gLP1c
	 ZDtV3SIypGmn4UTbtfEzXcUpr/S9ZVHq0Wc94zroaSLGRFk8skTx2Cik+UeunRAhs
	 kyvEG2Yf1GfxLsIoQpXGZX/FDdwpuYuwQSDt0PH6dCnSNo/2je+yq7wbjXT3efJMz
	 cg/HysQqsieAbegO3ZXAtU8HC0kCMnGUJR5Xjf+0xE4KEQ5oOlFnkn6qg4sZ2FbzA
	 hjYhB8gFD8S8MK+Edg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1sDf1H2z13-003xqP; Mon, 24
 Jun 2024 10:40:14 +0200
Message-ID: <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
Date: Mon, 24 Jun 2024 10:40:13 +0200
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
X-Provags-ID: V03:K1:iSn68H/Lgad4x+RMsNh1BPWd8ohG0oON0K0QX/GKwsjogND5bv1
 pF4ptpU86FcxypNGTr5jCHEn/lKcVt1UHWpJvxMtSqLXVlApwag6YWGP7Rpiy9Db9LQql4R
 AqZLeTQn/05IYlddIQMe98B1uzzL5HELCCcd1QPTiNxcrb+Oyrum8oV8Bpcqsn7nrhtZe7c
 ySPqcRadQfNyQVX1/uM2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j5spKJYYLGw=;c+cC/hdszDPaAIenepF3KnnnvZC
 z5mZM1wh0pygfKG929CBJvtlve0WUJjsj9KBlrB2E2uXWfBB1i5Mbeqh9kMoeHSm7rK5AbXIO
 801nc3hMT7AawPx3CRH4vGNnj9kxARG9/6r+iPK4JWOrFlRwfBUghYydqiVO+Y2ghR/XAeXxb
 AdTpYIcuddiV34lRDLkC/T48oYgqmGjNIPHfU4mudrpnt1Fx/JSVXsapUZ0aHChYJ3wJ0/ZjG
 BaUM+Rxbc0828RsyHojSDGIH99C7Ol1qGuGcUmO7tvG0dIOtHP8V/fuK6fbly9fhNKZbfxL4u
 NnQs0MqKHVriP+1AouF5PSltORe2qSaUaTP00N1mY4QOnzipPnQM7tPeR9vorJsOoMk7PXmxZ
 qP28eBG/0UPL0QC5whbigRkiOfq6diu1yQxhk0h8Ey2X6FWCZ7mKph2a+H2z4NIERIYXHMjgy
 XrjJt5O+DwFF5xz9g6+UVXp/HQj/iDfl+TihJPqTi968J/k6lR7EfcJG2pOmw1ov5krJFjjW2
 gsPfHTYrbcXw3aYjWpi05IcltDEpWU9y2g6dFlZP8dvU+yaZcxldpc6iTFzVzmzui95gEqxaw
 NAlNB7Fq6IODcsoZDYhJLixdWNW8flBFfE2rnRzPxLBGDP9NiOJZJNjWorfJYHoasEpDYEFhH
 S1yPP5SLV/rFIcF7PPM9YIvChLSjRBrA1AI1aU54zyjh4v2VYVfw2QYSdkXEHhsjLS+R2IApc
 FKBieKxePoNhq30wlOtqhVxVIPiThTEzHlQHr3cwzx/pzfalX4CYqKQFJgnmOAlIXzn4wYxmC
 OKTOJPVLJTDv6EDiEHG99up9WtduNceqTFEZ1aHCGifqI=

>                   =E2=80=A6 So they should also use dev_hold() to increa=
se the
> refcnt of skb->dev.
=E2=80=A6

  reference counter of =E2=80=9Cskb->dev=E2=80=9D?


=E2=80=A6
> Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in a=
oecmd_cfg_pkts")

Would you like to add a =E2=80=9Cstable tag=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc4#n34


Will an adjusted summary phrase become more helpful?

Regards,
Markus
