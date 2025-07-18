Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64864A930;
	Fri, 18 Jul 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818234; cv=none; b=gDFn57miB2UQ6ht4Ov6FcCO+gtbzF4eub2loURjqEuqLLBb9jZ4ksdnQVKJj/426K+q+fG09eYxVV1Vug0aBpHkgYXtcXXEY6CplQI/0XkqnFgwyq5IHYEE8dWPAu3LR/7Tn9oqflCqaeRp/SlgMlyZj7ygZjihisA5MhrRlSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818234; c=relaxed/simple;
	bh=gYGih3/nAWPbnA5XUPrsx2LwK5Fph9cIZ/7Tf8CK1lA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KX6ZvtFRUp5Z5qmXcmfjdheGCuBrejedWpfM+48zNYn7IqMtHt89iumjR/Mc1kg8C4YeW+3ZqdgA2of+4XTm1mT2QG3qxmQHjCZZB1cTzFsqEV0hkUPGmM0jOL6xGEOIEs4BlCKD6otMKs4RT4Ix22r8mKjxf8zGDx4wvnZsdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hdhcZyMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H4gIoiam; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hdhcZyMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H4gIoiam"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CACCEC00A2;
	Fri, 18 Jul 2025 01:57:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 01:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752818231;
	 x=1752904631; bh=8prtNj5CpD9krb2BT6qx+o4RQFBkx8mt31o4Dc7z/xU=; b=
	hdhcZyMvslp/q4rv28LzVQd3OwCVPpI19ez5TyWgJ28JceSiN0XEhiwpPu4vfBiv
	vTQfB5jU6gqz52+WscQNkTrZqtYLWN0XEY+sbZuNI462/Pq23+tf81OQCPB/tdK5
	Zk5wAaiZuTi74yr/9qoMm6Ge+hSPynnVHpMrkKGXwLXSmFUHIOzNl1GFSyskNCZa
	009B4HDbPxGsfviNwDoWu45unTvYV9X1t4U8M6XN2p9OoIuzXDzcmOYO5HUMrR1I
	U34clf3swC7A+4MOwgW0Xhu6aDczPQTqEyOPhMih88f3xf74qKUg8avp1Q+Krtvp
	bG0MuzVfmCtp1qWyPGYEYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752818231; x=
	1752904631; bh=8prtNj5CpD9krb2BT6qx+o4RQFBkx8mt31o4Dc7z/xU=; b=H
	4gIoiamzsfEoH1GE5Jls8UoMjxAGkvZKi5qgQK5vXYMpnFCRK8TtZMgB7Vywgl6/
	qw98wnrlmh/z5tLxKcJs6HuVg2uBGWW1OV14hKFASsW69b+rW1y6rhXFQcCYGXm4
	L1VnIEtwN59umjN/b2MidvtT9HGRiSKZJtBSnnmjWPh0qRu339VxCIYnkux2Ti66
	oDBFGjrExx12MOajOgB3inOGbXAr9hMZwqnCGe4kR/pkFewqHOYHbGoAK+7VH/BT
	exvkKR/w60hC7knswFg4mr4SFX3+oHaB7In9oEFUbcrVZt4IGMZjtpZjc0ndJlJQ
	9eLjaZ606QKIEm/yuKlRw==
X-ME-Sender: <xms:NuJ5aAbESjLfgbKPVu74X-K-ZLmCXqO4iwPeLwk_HOC1cIsa2maTAw>
    <xme:NuJ5aLb2cMfduns1i4pszlK_l74r-5MwasRBJRwbIDBjDc1fhHCaLS3N8wtQbjDkw
    xYb5feQD-yrbHcu62k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeivdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgtphhtthhope
    grshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopehklhgrrhgr
    shhmohguihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthht
    oheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NuJ5aNLufc_ohkIXbF6zmAaUR-e0EQ5wBuZIb8dTk6yxefZ5RLO31w>
    <xmx:NuJ5aD1hdKGoLdKuIgc4xsLvF1Y-L5dx72ZWzSy-iUQIHoBg3mkEYg>
    <xmx:NuJ5aOb-p4VevkA5ZuNe1S7LUAW4I0QOxWvdGOO7gCFxvAnebm_qMg>
    <xmx:NuJ5aFjOhwHCgv-GuO8EWIV65Enm3KlRrXDExTHDuDj2MSBRB1qELg>
    <xmx:N-J5aKRBiz3Lg40sHeOfZAfhKV3CU2qwWFwzfGPOiGFZPK23fY9kJwre>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 22B78700069; Fri, 18 Jul 2025 01:57:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9328f7417d0aec28
Date: Fri, 18 Jul 2025 07:56:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Klara Modin" <klarasmodin@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Anuj Gupta" <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Kanchan Joshi" <joshi.k@samsung.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Keith Busch" <kbusch@kernel.org>,
 "Caleb Sander Mateos" <csander@purestorage.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>,
 "Alexey Dobriyan" <adobriyan@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <b6346235-cc66-4ce0-8768-52a1a89fd699@app.fastmail.com>
In-Reply-To: 
 <szmagqqo6lx36ozaqd5qf72xnzoi4e23jbfehjli6rfbvhps6w@if2cvmlgvmxv>
References: <20250711084708.2714436-1-arnd@kernel.org>
 <szmagqqo6lx36ozaqd5qf72xnzoi4e23jbfehjli6rfbvhps6w@if2cvmlgvmxv>
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 18, 2025, at 01:37, Klara Modin wrote:
  
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 9ad403733e19..af2e22e5533c 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>>  			       void __user *argp)
>>  {
>>  	unsigned int max_sectors;
>> +	int ret;
>>  
>> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
>> -		return blk_get_meta_cap(bdev, cmd, argp);
>
>> +	ret = blk_get_meta_cap(bdev, cmd, argp);
>> +	if (ret != -ENOIOCTLCMD)
>> +		return ret;
>
> This check seems to be incomplete. In the case when BLK_DEV_INTEGRITY is
> disabled the ioctl can never complete as blk_get_meta_cap will then
> always return -EOPNOTSUPP. Or should the !BLK_DEV_INTEGRITY stub be
> changed to return -ENOIOCTLCMD instead?

Ah, I did miss the stub.

> It makes e.g. cryptsetup fail in my initramfs. Adding -EOPNOTSUPP to the
> check fixes it for me:
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index af2e22e5533c..7d5361fd1b7d 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -569,7 +569,7 @@ static int blkdev_common_ioctl(struct block_device 
> *bdev, blk_mode_t mode,
>  	int ret;
> 
>  	ret = blk_get_meta_cap(bdev, cmd, argp);
> -	if (ret != -ENOIOCTLCMD)
> +	if (ret != -EOPNOTSUPP && ret != -ENOIOCTLCMD)
>  		return ret;
> 
>  	switch (cmd) {

I think returning -ENOIOCTLCMD from the stub makes more sense,
but I don't know what the motivation for the -EOPNOTSUPP was.

     Arnd
