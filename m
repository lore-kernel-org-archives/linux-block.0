Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6057176FA7;
	Tue, 11 Jun 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097639; cv=none; b=i3l2uVij7Ng5VHAaCRmlKwDovVRCdlhLTmbX4aTD7rT4ydfMIbAd99rOB+2vo0uOZhPAtT8uOktCoPDCuUItB4u0ZRkoZfYNWi9fY1275rahcdH91H/bb8vPO4jyZJWbpK/b99zvhrajWz4p2PpZ3xADo6mLwZPDdMldgWbe9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097639; c=relaxed/simple;
	bh=eO/SU6/Ukvz9yz53+xanZdbexobUG1/nTCp0LPHQuOw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O5Q4nkm2zIhQDslcjU1TkFdq/+qeduTMSBILKrYn4P6H5fXWj7eMNipF5/lPaAF+LBosLZclbhUQZSUlge66JB+9cMaQxIAd3B19Xb6/RLvA0h9jyRFrTTuNwkO3YhzIg/vvmSuz0Q5XdNz3cpHuwoQ5/RNMon1ZBVPWxuBZhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FftRtfIl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FftRtfIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718097309; x=1718702109; i=markus.elfring@web.de;
	bh=SSWdIHLeK6c5qkRxJRQIzSFopdFgLqZQ5bZ8370mvc4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FftRtfIlHxGUAI3vCcm4yTpn/7z8WsjG+Em5dB5ND9N5eedR+QTMfkd+w7F2Zs2i
	 WI1Yj0slkHGiDMKMlDkpOiP/MjEK/B6R2dAiV03zMK6+t4kT7xBeCDDQ888uoe/W3
	 HMJ+HG6g52cDLWKEcQbr6xXdD9cRTtNwHwz+bFZPPzkQ7TcZrvW0MggwyEXpoOwch
	 F1SP/+OJXN2UQv0MqjXDYRgbkFIKPiQyMGI39/lLF6bCcLm4PLaCKaVl0+whiFMsB
	 SB0PgbV6ShDjyXNFTfm7jH/gkRm4xnMBSXmDKl3ZdmJohCKk1XemhGUQoO6np/E5N
	 r5idNtThZcYbX7sxNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqTK-1rq7cJ2zhW-00J0sU; Tue, 11
 Jun 2024 11:15:09 +0200
Message-ID: <0e1ac9ca-c241-4b48-a219-d1aaef2a752a@web.de>
Date: Tue, 11 Jun 2024 11:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ye Bin <yebin10@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig
 <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606062655.2185006-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GHmc89SQ4Td/zPwUg//USd5islR+tdgleigB+jmBeZEuq6FZ7Dy
 fkE7CjeiMfQNvzY0YK08nYlilwmnduxqbtLEXlZPIHy8TtJwqsAsxfDMtv1kVgp7vN7HY3T
 IALqM09md0BMzdXXkahjw/wqc3/g/o4um3hx2fvO5m4g3LdePf+xlz9QuKO0YSskYbKSlDW
 ouYkrcSzcG4LaTCOdkrZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w3g6y7385Ok=;4OLDESrn0lp0xrLZI+q1mYjtpDC
 9L4XwYlMGBU/2knpMHxRGtTguQQPeZkUn9hbbhdJEbPFwKVuasnXIFwsFPPZMJWGF9Gyi5AdU
 p2/eh5PYU7JjePGFXBpZuGx5XzQAULZfIJqL3J5wx0xVh8v4k18N+f/UiMmgqVRhUdafKaK5A
 Vjuvpu5YRwyP4ZaoiHmzSaLZxFMm8rAaGBoCp24NpeW8eOYXiBufOe+roIN7J+3U0i1RO20M5
 ibiygZB/TDIGdrs9L4FzHsK0UZvGL93mO/3aLCDIdHIZtml9pvBSI9vMWtqOaQ1lZwN9GWrnn
 XVz0VFlULaG85q/vFA2450eAeTuFWrQ+f0wPCIZ54LPwyy/bGCMqhtVdjGFY+/LHyZeMD3R6a
 dqQytdUotZXhiS5/f3pfvC3DcWQZFmjSAJed9btt0ovvy25dK/EJiQMLyGp7ZS/w4i7TfZ5Sf
 RpsDfzZ65tCEBD+iWOM2HkNTcH91z5c7FAQeclUgQeN/Fen8vAr2eZ5OMj7hPPJHya9BbL6rQ
 JoiO5Gu3MYgjmhHYVNqdPaLjh1TLMVOvgth8ETDFRpS4sBh2VWPFhatcBaZYvOdP8eXxM8sjK
 ftgSY1q05gPDkmgL3kVTG+xpDRT5wG/zQgS/gOcuzl5Bq6iGmjmXjyXVuqsQ2iYEhAOmZpXue
 gCx8qIA+QByymh0Zwrxr4B+hHfguxyA3d1JmrVMKmS9XzrIsEbSBj0Uer8v/MBbU9k7tNblRI
 FX09N3GphcrQdp2SBs4/aZi6w0LFVeRdWqpYu9CJhwdHpyxPlLEDJ9wjmNcyq9xiRm199crh4
 h2dGqmiwCRC1yvvmWZpUy52+P348tLJ7LBdy0p3mQiSDo=

=E2=80=A6
> The root cause of this issue is the concurrency between the write proces=
s
> and the block size update process. However, this concurrency does not ex=
ist
> in actual production environments. To solve above issue, Verify if the
> segments of BIO are aligned with integrity intervals.

* Please improve the change description with an imperative wording.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

* How do you think about to use the summary phrase =E2=80=9CAvoid null poi=
nter dereference
  in bio_integrity_free()=E2=80=9D?


Regards,
Markus
