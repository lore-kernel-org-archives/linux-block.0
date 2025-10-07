Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D23207
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829797; cv=none; b=Y9PC0ov0FuyHEXHbed4wj7XwRRzjWWTWTvIJG21yU9L03EQLK2xgtPR7jHZ3rOtD+OEeExNN702f7bmpOoHsQQ9Mkoh7hqEQdaL4sPs5ypLK5dz57Nrb5chz9uY2aRmjOiVJP0NGfE4UKGYw69Ep9H8bmRL9ihVzpTNJjc3QIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829797; c=relaxed/simple;
	bh=ilmFrr3LCwcra5m9tmGAOW8WKW53HP6/xp0tnYANASQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tnq5vfaiWaMaQM0v0Tmp6GzL+UX/fJpr2AxAAg0Yhgg9dhazO4hxcXsiU/8/MMOeiKQ/PG7GDuEUyNsoMbu4nBz1/O92Ybovo2rIGCLM78RcflsR7t9YCWoxmlf2HxDkrGlllUpzafzPYdLLcRX6BKm1kmIK8/MMFNaON9tPSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=prIDOY9q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="prIDOY9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759829788; x=1760434588; i=quwenruo.btrfs@gmx.com;
	bh=F6QRGNxuUpTfa4Co8Fx+tiPUjuYNfubyrIjlXUJoEeQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=prIDOY9qHfuf94fXXTY9hRnKzhZ2aQjqXV4Xbl4Ls6MeqvzaxT4if3ik+omhAhAM
	 Fm+Ze1JaYQna7TNM+MZvALnRxGOMYNyhbat4dUsmAlDMMYd7juTbiMKhJTxf2aeSk
	 mRTzkMndrUUoaVPyhTjse1nj1y+1DFyEHeR1iDKGibc8EazbqzOLSz9RjpOHgzHmG
	 puMQsAkwRog7GxVCvu1jWFhEEKAnWMcQOL6g0B8zxyEJArpOrW9LnZeYtg2/gHAWG
	 7E05eaF81wCOEAiICwR8dZSdhR2benUZ+e+PgqJoZNO2j3q8sq4V21bwcj+J91OJM
	 JurDk2xHn0YAokjrNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwXh-1uzlX02ptR-00BrU4; Tue, 07
 Oct 2025 11:36:28 +0200
Message-ID: <bf5d56b5-4212-4d83-b3da-51fd200a37cc@gmx.com>
Date: Tue, 7 Oct 2025 20:06:24 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cleanup for the recent bio_iov_iter_get_pages changes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
References: <20251007090642.3251548-1-hch@lst.de>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kZcq3brceq8rLMLjpizQRLrNSK69zRP1QJlidRMhDIbWTyaeCEx
 UbQZ2fgDmlw4/cBoKi5G5ZvZuIgrnjpclLojn1gWrIqw0lVMh9GMJ+5WvER5RI0b/FXA7+B
 wy8Mr2pn2QnY1nJ1m+W0Z7EQG+Ueus10Iyw+t7QZczf8wsRRneZ4Br8sEQgJhUnX4VIqblQ
 sQ6c6mhDWqpf1mVuXSMZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bOsGTJx2fE4=;jk+3KtGseluFq2WHwbOvVr2v8X0
 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
 d2OY7NkiKdUaoGo/L8HocUptAc=



=E5=9C=A8 2025/10/7 19:36, Christoph Hellwig =E5=86=99=E9=81=93:
> Hi all,
>=20
> while looking over the bio splitting issue reported by Qu, I noticed
> that some of the recent changes to bio_iov_iter_get_pages lead to
> more indirections than really needed, especially with the bcachefs
> abuse now removed in 6.18-rc.  This small series cleans this up
> an prepares for the file system block size splitting needed by
> btrfs bs > PAGE_SIZE support.

Looks good to me, and makes my later changes much easier.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
> Diffstat:
>   block/bio.c            |    5 ++---
>   block/blk-map.c        |    6 +++++-
>   block/fops.c           |   13 ++++++++++---
>   fs/iomap/direct-io.c   |    3 ++-
>   include/linux/bio.h    |    7 +------
>   include/linux/blkdev.h |    7 -------
>   6 files changed, 20 insertions(+), 21 deletions(-)

