Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81B221571
	for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751100756; cv=none; b=Ns7/wLlwFwdWH2gjWyQCirZz08GiOC11X1fcCIJe6WPOrUsZvH7HlTpg9GXuZC/VNzxOzFC2/WhJH31n9Ty+ZgNSDM0+krzrEh+Oiq3w0nkIIUhXaDUB3cZLzDJo+CGr95UR4HEsbedWf9BYBCMOfuWwBqtBZposs7CQTn5EHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751100756; c=relaxed/simple;
	bh=BUQMioHeGdXZNtH47YBZfYs6CeT4m8a1aYzLaWeEh64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID; b=RZujPaXFXYoibyUWDmpgQYNFaXvFI7531EN/kGP6Oa+7YW3agCVXQjb0b3Oa2RIyFb2OaD/E4Mzjjw4Z46th3zFydDa30u34gcn39Ks2iZEyoezAHjcrDUxR9vUZr+CJuqP6wTBnbYodg+u7tGuFJ5GeYq8C5Wo7S19cHIzNsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b=hJNGReoq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b="hJNGReoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751100747; x=1751705547; i=r.sommer@gmx.de;
	bh=ludqfOCokOGviYg+sO1Hn2e0LZ82GFMSvJxZJP2MgLg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hJNGReoqf5aMP35qhGcI7UE/enczAFR0GjR195Acm484izoi2iPAUERFBNYRN393
	 dtT2eI3f1V/zjo5uJU4Yn6BzYPiogSw2vTQiraUwyqQ4VxADrp6Do3OScJVC0niwm
	 gbhM2iM7yI1fO+ZLKmaOWG7dILPhKqcLQ0i52AYzOoeEOGZ7NrH6TB3oSKAqrhclK
	 8k261GK0Iv7fZxZhfq3/rRScD2SfniXanauDuK5gV6UbiJMzvwlc8lo8+3O0t3Azs
	 s2Gtw7HjJg3B26MWsWFx/OpzG8P7I4/toSRYfPM4q+1/0FHIbgmHeW8srR2OI1aHa
	 /cBTChc1JESqKGBpGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pc14.home.lan ([185.17.207.23]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1umyBH0vmy-00u0R4; Sat, 28
 Jun 2025 10:52:27 +0200
Date: Sat, 28 Jun 2025 10:52:26 +0200
From: Roland Sommer <r.sommer@gmx.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: "1107479@bugs.debian.org Salvatore Bonaccorso" <carnil@debian.org>,
 Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens
 Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
In-Reply-To: <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
References: <1M9Wyy-1uRqo614XE-00Glyf@mail.gmx.net>
	<gbw7aejkbspiltkswpdtjimuzaujmzhdqpjir2t4rbvft5o777@faodorf33bev>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
	<zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
	<1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
	<whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
	<1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
	<iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-ID: <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
X-Provags-ID: V03:K1:AQk/5puEnPuyf+Qii36U+R5QsuILxuHqs273d3jrLykJlyGsKw1
 uPIWTyT4vYSXgsbvkzLEkgjf4gjhaz+8Y9OdLwrSRZwWNDkVAHIZUuSfjn+cABdu2OwJ+LJ
 W1Rle7XYgr9uzqJpBc9IXNOS2Iyd6b2yF1vitTCUHGSeAkXADRO20j5IPa4qhXq3T8mwWC0
 0zvPiJnASd0GvgriVSfgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rEvNZthyjDM=;alljeksRQy8OXtMN8AHJWeZR2hN
 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

Hello Uwe,

> That is surprising. I would have expected that the only effect of that
> blacklist entry is that the module is not loaded. I don't understand
> how that entry makes a difference if it doesn't prevent the module
> being loaded.
>=20
> You can try
>=20
> 	update-initramfs -u -k all
>=20
> maybe then the module isn't loaded any more on the next boot.

I'm sorry, it is.

> The sr module might be enough to handle a DVD-RAM.

Ok, then lets try it the hard way: rename
/usr/lib/modules/6.1.0-37-amd64/kernel/drivers/block/pktcdvd.ko and
reboot.

-> dmesg reports

Jun 28 10:38:06 nb06 (udev-worker)[2081]: sr0: Process '/usr/sbin/pktsetup=
 -i 11:0' failed with exit code 1.

-> lsmod reports pktcdvd not loaded

-> And most important: DVD-RAM fully operational

> Puzzled!

And now? ;-)

Best regards,
Roland
