Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2C13210F;
	Mon, 24 Jun 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228547; cv=none; b=NYwUWvlDlZrvL8MnMcQOZMSNT+UDmRwtIQY3rRCOp5BmeNP2NQVJOgN9NL0ULNK64feaz3ETerdqSTf7ty0fT0Js6ugWG7bYZkTMbTtcgkT8guNtM3oFJqO92mRkhx7IIp5i2czEsq39ohWT1y58iFjWbUabfqyqVV/9TJeK6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228547; c=relaxed/simple;
	bh=W+Od/xdu7fJvPbDjVdQXS0nEF6AudVWgglSNsQYl48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emHj7M1OEnxzz8qshUM7sClErH9SP0eGUvpnZ0i1lFrBGxpejCBo64y+U2XOStOpeOb+CMYTO8lk+zdi0Y087ef7NpMszD0dNCxhpSE8Qa1KMDBeSzazCslyZGQOWgLnPmSNThcAID8Q5iHNO5ARD5TKl8EJUEOy61h5g6txuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WhbIIPsv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WhbIIPsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719228535; x=1719833335; i=markus.elfring@web.de;
	bh=W+Od/xdu7fJvPbDjVdQXS0nEF6AudVWgglSNsQYl48E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WhbIIPsvyMMv3qLuzqEpCsXWNLd5MI0ScQSEiCrVQjZj/6vP4oxbqOqwsaULW1F4
	 oVvXKLPtoxnz3auJSWfFOaQT2KORLn1fzUi9bNlSMqk7oOw/jWFixJzCxzrqlb1Kl
	 Cr9olzyHR7GzwJ7BtbXgQ2kR4NQMAC3pRYte8dS8AsEtmyfQwoN6QkGSybEEUxbF6
	 1tf2HhpZJVBPBpxTHV2TtwU865oMujVqYzdyWtQNiFq3eBM0SbgFvkCEUbvIcKfam
	 tplSHPdMc/T0Kgs110ifAxUhz16i0MyzharVJa0/qFiE2zNHyZGbBAuWfezcnmDRa
	 Zz8yYNW7IJedLZ2Wng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1sMG6n1UVG-00BM6u; Mon, 24
 Jun 2024 13:28:55 +0200
Message-ID: <8d076c38-f5d0-477b-9b9b-bceee3e2fec4@web.de>
Date: Mon, 24 Jun 2024 13:28:54 +0200
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
 <e44297c0-f45a-4753-8316-c6b74190a440@web.de>
 <20240624110449.GJ7611@linux-l9pv.suse>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624110449.GJ7611@linux-l9pv.suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HgMl98ZoBQNlDKB/XPSzWGvOEv0sndZjLM1zLv9laQtbhwF2ecC
 qlxYvUFiA/+esJhvnQ8lDPwdifKhIcN/eUIG27USNsOgzWHhfAUbgVFkBWds6w0M9zcrkmC
 gzooqU/tFCq7r992xylVa0Hz4HotSMKgGQNhYtu7XbRPOtKQ5fs0vMifYvuTCqf6QrfMJOv
 yeLLv5IRINmocNRxQdlCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F6TkXs+l3WI=;mDalcAG2+hF+DB8raCUqk5y8zSZ
 mZFbHtSIFrrP2kUCoEGi2sZMfPjySolKROsHmU6SdGs9oLLts1+q0D3RYKmbMsycValwVSkp3
 mM3O/DEyw2ffFETnXtP/G5QWC6kCt9OwQDiQ7v2WlZECtcLskY8bjZOI1eyiMreu7s1Us31Q4
 pzN4DbNUFt9FApfHfB3/JxZUfElfN5h5i9DbcuOU/cNjM/lyrO0Ku7WWzAuortuLUCmZLEAa/
 gaD23g3lt0tMP4XFOD7HVF0F9XRlFN25fe+hQ8R9lMcSFDKGGubmtupgf9qqlOaZOFdzncJ0Q
 POjeergBkV6fPcPXAZWb9ZZM1VRYrKwzgYarzZuU+O4sVA6mu+8pfFwChldLxVZU76svxKkoQ
 O+OL8Cr/F0Hgl+ZTrI8WT7Cy+zxkZyB5E6T8+D5PttX3CE7UwUkDr4bB2MlBc+Z48RLBV898T
 lztzBBiDqOHWv3tsgWLKH4y9EsLgLIi3WM8zDIwMc926bxLjvVg04UpNIedPndTjN2kh2cDzi
 i1L27Fat1n+TnltvtLjdABO9Vr7cFwkUfRxzdMttM4vyC4BLPMsJvpk6EnoOUceLU+ZNxJVWm
 O4XUJ3MPRHdBFrPCLnyx0/fpYP7pmGu1kqnYia53JndL0OEcRzu9sDwT88nt7p3e0II1HCVOX
 t7ReZ2/EBIe+m1tzKInSN3ow0I9wh7BcZMObiepzKr3r8gOq8jDnpavx8ep3Ivm3DJa994mJi
 gZfHlIoTYtQGIJm3HrV7EIzPWl/vdoZ0ruVOv38q8crJY80o8HLwfmkkE0qvLRJmYW6nKLAay
 t/1ILwptX6JC9vfE+ccjodDVTodApd2yCtSosZ4s9DD8A=

>> Please reconsider the version identification in this patch subject once=
 more.
>>
>>
>> =E2=80=A6
>>> ---
>>>
>>> v2:
>>> - Improve patch description
>> =E2=80=A6
>>
>> How many patch variations were discussed and reviewed in the meantime?
>>
>
> Only v2. I sent v2 patch again because nobody response my code in patch.
> But I still want to grap comments for my code.

How does such a feedback fit to my previous patch review?
https://lore.kernel.org/r/e8331545-d261-44af-b500-93b90d77d8b7@web.de/
https://lkml.org/lkml/2024/5/14/551

Regards,
Markus
