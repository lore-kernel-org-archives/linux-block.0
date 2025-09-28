Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D344C98;
	Sun, 28 Sep 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067322; cv=none; b=D9TXYPLhKx6G3y6UVjYTBEI7TKt1BsLJAwroh0BHYZoKBrINnjyEe2BLRNoFliL8FFbHM7RFCxtsXQiM/5eLig5p/DhfXkrwwBVWk4UE/PT+9WcR4etL5Yum81Bc9wH4lOXXVVTYViNJnWcbSM9zcEVItpbUFbNXTcz0PR0PRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067322; c=relaxed/simple;
	bh=T78lkvz4NHBEAD/qi90ZP6MFj9B9bdxbDxvA1l5EPYQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XT5tT0kPQc/C4h5r7mLzxKoef4aKEUosP1ULzoRKdw6QWW9nAWPlL+HrShuUMXgeGrOjCu/+RX7FduWRcQkT4c/auK9I1AgCfiao0E7O4kwdl2VFJNIRjxTMpAb/NX8qVhrs5N/vm4C/cP/QXgAZTxJ1f0ZNdbOwfxG+6+U+2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=smEp3eel; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="smEp3eel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759067308; x=1759672108; i=markus.elfring@web.de;
	bh=T78lkvz4NHBEAD/qi90ZP6MFj9B9bdxbDxvA1l5EPYQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=smEp3eelS7nI2eoZBF59ySuF551SY0kW4gEHtvHC9ZB/DDohJYvEdOTjUCLsHJVi
	 CBMqRkv0HWXIbiCQoYp3qLTXYlHusmX+r93XUUIzzsi2KV4HQWatL0Fj4RLNWCKpJ
	 m3AUDsjeWwmRYIOE1swuV1P4xkoRjIixS5KzqjD5dNG2o97JOQr0BM/n4WDnVN+ZP
	 qEqqu4D55Sp7xyz/uJxytlIcaZaOFapiEHN4KbHP4wxALEYjIPVPcZ1IQ+H9v8D5S
	 GMh2qDud7SNaA2MdlOidhCwF0zdKWXDMlMKhXN26CWeo+mvNMVxIx5+hRYYpVqot6
	 oiOCkjAm0EnNhmC4rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1uhCJj0Ivz-00POMY; Sun, 28
 Sep 2025 15:48:28 +0200
Message-ID: <9f6acb84-02cb-4f76-bf37-e79b87157f1e@web.de>
Date: Sun, 28 Sep 2025 15:48:23 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Chen <chenl311@chinatelecom.cn>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Cc: Li Chen <me@linux.beauty>, LKML <linux-kernel@vger.kernel.org>,
 Yang Erkun <yangerkun@huawei.com>
References: <20250926121231.32549-1-me@linux.beauty>
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250926121231.32549-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:liPxP31WF6bcH2oVDd71Kwmdl99u1cejFWuz250Xmci+b27l/U3
 Izn5Pd561zBVfLZKhHDj7jf1ryaGpU52Efnaxzqcp9YxaklAUjNz+ygdsucAvL5KjspJHG3
 9UZ9ZfUSA1tAib6BNqnhI3yyEJP+OtNt9niBDD+Nm1I2OVg6oeZPRuJaE0i0bFwMhevU2NL
 GEOh/KrG+dt4LUsr4kuFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VdPELCcMQ98=;1EcnOCdY9O8tibBxkvoZ11h+cbk
 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

=E2=80=A6
> Fix this by calling fput(file) before returning the error.
=E2=80=A6
> +++ b/drivers/block/loop.c
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/file.h#L97

Regards,
Markus
