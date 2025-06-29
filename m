Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1981732
	for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751190374; cv=none; b=s83f123zIi5FkoC3xnF2ItRQ79nwsvAZ4hqYWC4aFM3X6OMPG76cR/5cZSROq/LjY5bpAhMoCY68FrYrG5y1hvbLC406Q92WMSXl68QYM20arYuB1xK6wYl5p5bOL9fZalu5vJ1asFlJ4V41+j559VN9J69y28cuE/BIDZsXSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751190374; c=relaxed/simple;
	bh=onC3KwefzRjw6W1kOe6P4xlwkAl6ylp4bFsD1N/x2Rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID; b=Opi/ak3n5O/5a28vhW6LJHJqlEaxubgVTGvXREoaQFVr+5hmVLcuOCl+g+Q4B9H6aGRCLvzmDq4kcGM6+7q9pZcA3W38DO8erpL5FLri+0YGgmpi/TTGWAPT4dC3PkzeDwne2nYxRkGrvU3lAqpny4NhD2yrLVUrk0ALR5RRHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b=KCyUUlwE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=r.sommer@gmx.de header.b="KCyUUlwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751190361; x=1751795161; i=r.sommer@gmx.de;
	bh=onC3KwefzRjw6W1kOe6P4xlwkAl6ylp4bFsD1N/x2Rg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KCyUUlwE2mzui64YteFBRmgL5dYxtgPvttLjHWfgIDYcXLnZMD2P406PyTLWiYne
	 0XaHXonxDytTlNFUe/2zJEO2Iz8+aT17V0U16mhVyGnzlokjc6JLHFNSC4V3bJw3q
	 mS8v+53RrH/Qwrwmw6FP5qRnOgQqCPKyLlBlbxOvxt0pp+Xlrq7x2tbQXVYMdL2hL
	 OQxX1dl+zt7oRFH/fPwa9MrECoj6g0HF9tIv4BfgPwA2u4pcdQiqQvAyYgPoQzh9s
	 0OX0hOAB4klG2hKpVemxJCaIPWUVtDYrz0eb6mAwiyfNZROBUaMwyjZoL5vJMDmTt
	 UUS7dxO4bfGe7qmQ/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pc14.home.lan ([185.17.207.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1v9q7W2c4J-00p8vZ; Sun, 29
 Jun 2025 11:46:01 +0200
Date: Sun, 29 Jun 2025 11:46:00 +0200
From: Roland Sommer <r.sommer@gmx.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: 1107479@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Salvatore Bonaccorso
 <carnil@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
In-Reply-To: <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
References: <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
	<zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
	<1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
	<174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	<fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
	<whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
	<1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
	<iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
	<1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
	<aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
X-Provags-ID: V03:K1:ZX7PfZCWWv7kSv43GxzySdrXbU3e9sqyxlbw3NWLKu6W6qbr1aV
 FO6p+zSS8LeUXUJVMIy00Is4mQG9DD0PJ68y/90zC+BiMdWJOtpFgso/8Mc1B4AEborYwaY
 5hvgL538TBZHd45l6h6ssLIk3I6nuuvOBT8WlMqd83vRsfr2R3rVN+HASo4MkzaSJ004r6Q
 wUU6i19/9IiMNahN6h1zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LvSZer08XnA=;WN/vnEbUWR9nIn1IaVaEUBwtHbT
 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

Hello Uwe,

[correcting CC recipients]

> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
> explicitly, the blacklist entry doesn't help for that. Without the
> kernel module renamed, does the 2nd DVD-RAM result in the blocking
> behaviour?

Yes.

> Thanks for your report and helpful testing,

You're welcome. This is the way how OSS should be treated (at least in
my opinion).

Best regards,
Roland
