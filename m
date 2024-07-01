Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419838DD9
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876091; cv=none; b=RQphMpEiwwaQO8qNAUg19BLx5p80hC9j6ejGyjA7BmA3DpSAOEai80xxrcAWJx+09HpnHR7GJ1bzNqmm6lJRduc+v128rAgxkMQqQ9Mudx3Dn2BuxbibUVK3GHlNclSBTL1DdScFl7zFHJ452sUARLktg1LUBTVuUI8whM2iRdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876091; c=relaxed/simple;
	bh=RxxzTAlf6M0F+FdydyHWlXK4JD9TgbumFM6PV61w53Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhGHW+twkRR/KMe2KVlvs1SAIXwiSlAhPjWogQ8Q93Q5/72i9hkTAA5VM6+DoP0tdwj9OV5FWoYoHRUNTt/Mo5q/NV4xuAdM1gpn+VF3u+ezXaL7VRGTwwLgXDI8M0Ea20MvszEhyMTdDCE3XEtIi2a9PfbGNCGNAIMSIB86uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=x6q/reZu; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="x6q/reZu"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WChr86ktSz6Cnk9X;
	Mon,  1 Jul 2024 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719876086; x=1722468087; bh=RxxzTAlf6M0F+FdydyHWlXK4
	JD9TgbumFM6PV61w53Q=; b=x6q/reZuYw+swaPbVvKO3WgzDaOe/A2Q6rj5M4Nq
	FyKnL8hFvlTU7awnh1m8yuuFsYSA8MhXhoS5PsrFi3iv1q7zQ2MLTkJKFRA87YqO
	E/OGWDnNJpfpS6lFoh1b6O4CY6Glv5EGiyYark/IRmhcc4pSPBbvRALVAAelC5iE
	LU9RIukek1xXsCQSQ0caVp4Tp1FL3HZq3tN6HdyZLluHq6Tpp0YE2DRBogWLiBN3
	GtUBNSpFbmvDSCxfWFUgo7TBNgegcGFyeun9TePTyRiOIPVax3Rad3R76UiBEQ4t
	93ININxN5i3tIibv9VJE4Z94jO9UsVj3Apf4bYy06M9UGw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4BdspZc2xxeW; Mon,  1 Jul 2024 23:21:26 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WChr44hXvz6Cnk9V;
	Mon,  1 Jul 2024 23:21:24 +0000 (UTC)
Message-ID: <0b028352-8554-4075-9500-d10ff21e8cb6@acm.org>
Date: Mon, 1 Jul 2024 16:21:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjIgMi8yXSBibG9jay9t?=
 =?UTF-8?Q?q-deadline=3A_Fix_the_tag_reservation_code?=
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
 <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
 <8bdfaa1201874892b166a5b5c59ee9c7@BJMBX02.spreadtrum.com>
 <366285cb-b099-4c8e-ba52-63c34b55db7f@acm.org>
 <e0edef374df6415cb2e68539c0189614@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e0edef374df6415cb2e68539c0189614@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/30/24 6:30 PM, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> Can you help review this serials patch from Bart Van Assche?
> https://lore.kernel.org/all/20240509170149.7639-1-bvanassche@acm.org/
> [PATCH v2 1/2] block: Call .limit_depth() after .hctx has been set
> [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
>=20
> These patch will fix the issue "there may warning happen if we set dd a=
sync_depth from user",
> For more information about warnings, please refer to commit msg:
> https://lore.kernel.org/all/CAHJ8P3KEOC_DXQmZK3u7PHgZFmWpMVzPa6pgkOgpyo=
H7wgT5nw@mail.gmail.com/

Hi Zhiguo,

If these patches pass your tests then you can reply to these patches=20
with your own Tested-by.

Thanks,

Bart.

