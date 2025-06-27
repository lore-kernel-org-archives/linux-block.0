Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B562185AC
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020360; cv=none; b=ZgAz9KYOBZcUfHwvy8zGDxj8ra5DhoVJJgrEce8tgTMtkzemvz7heWYeZLARJU/mzsPNOkqT6EGc9hGVKlofRhaR+8X2IKHm59BHYnWONxtV22gNesIxOyqypNIh+Bz6wLaqLUdLxoON1r3d4wmpGSgD2KV/bMeSoKsTCqrdIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020360; c=relaxed/simple;
	bh=bvDDpwtXl9NUSb6fO1iMjuA1vku9pKsFYiD3eCX8s2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID; b=H93KmwBTvje8kjxpYG84wxMhHqViE1gFntjhkmn/AkyGQ3crk3wO6w7biXtuKITQC4W9bw9yHownZCQks2VbUFEqpVGkc2py6HsCfkLPgDnPQ8SWyOxdZkaOW+vz6fMoS62FbMUwx49FUX+XsfOvf/vtnyxdxFCpuQGdl5apFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b=Fj7OwFKg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b="Fj7OwFKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751020354; x=1751625154; i=r.sommer@gmx.de;
	bh=YIx81BmJksG+Ba3D5uSxJvEzrQyT4l1hm+tU2oxD628=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fj7OwFKgRpvhqNd1iUyODZh/CKeC5mJrM3WLaAcVniWROw/PV+3nlzIOcu+L4p6H
	 7d+IrFsFmG6EZXV840UzTN27/MOw+vdM0HnQQffjmxjsdKuKnhVhTWfIOI6JSoQB2
	 pgTMAZ+x8HrT9PNbDS87vKbMjub2x2J+ODhdTGxAalwtsinaCrIUlAiAnO7mtmw6F
	 5hnuagMmJENsqn5buX4D9NSEVaAPFKrTgbC7oK0CNG118lL5HIyf1yQs5Z2D/EkaF
	 0RFW5PtwA1WZ8BD+I1FcZk3YXEjgZpdZ092oCRC/B38ugXfnlo907GYwNsLwgf8QU
	 9JM6HUMzgDydJbVuIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pc14.home.lan ([185.17.207.14]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1uiLwo1BqK-015DQq; Fri, 27
 Jun 2025 12:32:34 +0200
Date: Fri, 27 Jun 2025 12:32:33 +0200
From: Roland Sommer <r.sommer@gmx.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: "1107479@bugs.debian.org Salvatore Bonaccorso" <carnil@debian.org>,
 Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens
 Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
In-Reply-To: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
References: <aEaMawE-Nn8QSjgS@eldamar.lan>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<1M9Wyy-1uRqo614XE-00Glyf@mail.gmx.net>
	<gbw7aejkbspiltkswpdtjimuzaujmzhdqpjir2t4rbvft5o777@faodorf33bev>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
	<zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
	<1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
	<whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-ID: <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
X-Provags-ID: V03:K1:JnF9BmM3gVMa9xRWaph/xogxEKLExS7fEmUHIKMxfTqZVyTMCP3
 FPvpvA9yWgRhT8eTqO4Z2qG235F1TDyfoVnkcsaf+9RCTKWoe3//hP31Lbwe2UFlauhAMlJ
 Gy+lykcGUZzN0uKJ0nCgswFcRuUBy/WoMyCay4VfkNtUskvJAVl6E7jsQCe11KOjbszgg9h
 k98RUvBBzHSDVE3JHgbQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7VA8FuzbnqQ=;hxyfmzInbhUVXOFrnjnq+tvOH7/
 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

Hello Uwe,

> The pktcdvd driver is essentially unmaintained and there is a chance
> that you don't need it.=20
>=20
> Can you please try:
>=20
> 	echo > /etc/modprobe.d/debian-bug1107479.conf blacklist
> pktcdvd
>=20
> reboot and then test again? Please report back if any functionallity
> related to the DVD-RAM is missing without that module.

With that blacklist entry everthing works as expected, even blkid.

> My guess is that it's fine and the resolution is to stop building that
> module for Debian.

Hmm, it's still loaded and I'd assume DVD-RAM will not be accessible
without it:

[  168.063968] pktcdvd: pktcdvd0: writer mapped to sr0
[  168.091270] sr0: detected capacity change from 8946816 to 8946812

lsmod | grep pkt
pktcdvd                49152  1
cdrom                  81920  3 udf,pktcdvd,sr_mod
scsi_mod              286720  5 sd_mod,pktcdvd,libata,sg,sr_mod
scsi_common            16384  5 scsi_mod,pktcdvd,libata,sg,sr_mod

systemd-analyze cat-config modprobe.d | grep pkt
blacklist pktcdvd

Best regards,
Roland
