Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0C60DE6;
	Wed, 24 Jan 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097593; cv=none; b=G3yrBX4vJ6BbXkhpAjm4tz/e0HBjnyRJ01e9QcdOVODwD1sMlUEUiBvdDDFGiyu7SWNSNuqcvnclVT6TaBHJyff/U8iL/PJPdM6Xe0fZ3UgG0ztYDGKXci31SdQmGkKzHb7YLuP6l3qB5TRwL5gizzKPmsJYNH+JbB+9oumvNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097593; c=relaxed/simple;
	bh=UX+V6m3P/BH5d0y63xcfewjjX/2BPQOrDlQlcjtdifw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tTBW61Bv+iJDYMg2379D2MiQOrn6iYULTsc509Vzbul04CrumUYJt4cCn8OX5nj+Z7+r3CCKCwAB6Zz7DEWCreKUjzh3eVgH4wCSaTC28mk+we//mXxLL6oeN9nTfTWjz2+lt50bPNEcvcLLLNL1bUHFu5z2+Vyc4lqy6TtT7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lUF7A/gL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgjGdE5i; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lUF7A/gL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgjGdE5i"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8B9873200ABB;
	Wed, 24 Jan 2024 06:59:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 06:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706097589; x=1706183989; bh=i7tME4Obkq
	6tIWMZkSqVPdKH8Vwld2eBrrHRmGPBcEg=; b=lUF7A/gLVNogk++qHxhU7CMiCa
	4Iz9/+dWPnRLN9kwPxwoZLPJSmq/F4sHvp6pOLCIuOc+A33dhk1smvZujex8Xb11
	JeODSdLwWXljXJGVPVbEwEQ3geG8Wcj3WbsJEwrxu+dDvVUW00o/vq/mgH8Wgl91
	iJNTm6PZ6B4Vex+HaX9lVLig3m9rVB7ykwR514+Ox0bNx2JpaRAqoZyVVzJZrlHn
	PJxnFTwuHCx8k/3R7SU6xSejHFwlbpbwtjYY+sXAjIHckhn/K7Fkt2b1kMl/uJU3
	9CKwqoj4Ybvf0oFJIENyuw+J2E1XQ38w5IQZRGc2yIScKuA8Tk8kKDAuYCVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706097589; x=1706183989; bh=i7tME4Obkq6tIWMZkSqVPdKH8Vwl
	d2eBrrHRmGPBcEg=; b=LgjGdE5iSU6UttzIRJ32e8TgCXim3gKmCUWDUIHeoc6W
	3mee0wEJ/yR3sKhU833OAtZIaLZEaS6188sZfii8olktlsDFUIEI27nPISxPnsDB
	i8P9GwwXT8G3+mnTqQ+xd5BvVFaqveaiXzZTUcCHa5xEm2bQS8xOAl4rSXnvp1AH
	d5VFU8bozBOqYwQR1+JInBuQzbzHNfXxfcnqXKPkqt9FA92td4Taxb2RlyuImRO3
	f8HX6vVF/y9oSloqEsjc+UkBPv5AiTsPSzeBmsDYQZlMEMHdE2HPM2E98Da3Kcvq
	AYpiV/rd0Uj6Fp6aOzt+D0qDTdDBMMohg2ol+ZNQ+g==
X-ME-Sender: <xms:tPuwZXPlZobUrrOiGdNo7H2eQO12x_8QAvDOFX2-FoXeAdif5P9VCA>
    <xme:tPuwZR8g7zMuYTMBcMj7wcWWm5-PQMVVRIYhzoQBdedNatsJ3xs9_2aS6vQB7_-t-
    0mweLaSJju-jmCMyig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tPuwZWTfoGk77YbXTUKgtNT8fAPmFPSZ6i1cXG1D-rZB-OKCmnSPhg>
    <xmx:tPuwZbthRm9LKdSjRP0ajyLV-v2NjPXf755cN7vC4HNMj2hyFFo4yA>
    <xmx:tPuwZfdibRsnzTWH6uN_wD-H0nEow74c2Mslnxuo3OHY4wGBorai9A>
    <xmx:tfuwZRvwbC4JYsFBFV8JzlPggEPJNysNtvVT5uDEQ08wAnJ1uStK4w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 594DAB6008D; Wed, 24 Jan 2024 06:59:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f38c2db-3aae-42fe-ab97-dd027b90b690@app.fastmail.com>
In-Reply-To: <20240123091132.GA32056@lst.de>
References: <20240112054449.GA6829@lst.de>
 <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de>
 <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de>
 <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
 <20240123091132.GA32056@lst.de>
Date: Wed, 24 Jan 2024 12:59:27 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Ming Lei" <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter
 reference is held when splitting bios
Content-Type: text/plain

On Tue, Jan 23, 2024, at 10:11, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 03:57:16PM +0100, Arnd Bergmann wrote:
>> > It would be good to fix the one or two that could use highmem and add a
>> > depends on !HIGHMEM for the others
>> 
>> I would prefer a runtime check here, as one might still have a
>> multiplatform kernel where one machine can use highmem and
>> another machine can use one of these drivers, e.g. in
>> imx_v6_v7_defconfig.
>
> Well, if someone can come up with a good runtime check that's fine with me.

I assumed there was a generic way already, but it looks like
there is not, and adding one across nine architectures would be
nontrivial.

Let's use your initial suggestion then and use a Kconfig
dependency. I still don't like how this may impact users that
currently enable highmem and use one of these drivers, but
on a more positive note this might help us kill off HIGHMEM
in the future if users instead choose to go with
CONFIG_VMSPLIT_3G_OPT or similar.

The Marvell driver still needs some other solution of course.

    Arnd
