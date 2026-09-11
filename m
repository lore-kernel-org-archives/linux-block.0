Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A4476075;
	Fri, 11 Sep 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133199; cv=none; b=rXUHxqVIOvXzI7psEFWkvZKBgvfWIepREm8AQvmFag62f6I5EyGPokYo85p4V7/vUNCZ/BKjKC1N8bBN1CTLj3zsuv134d0Swc3ZVcnep5PlUnNvciBGLcTeYgoWGVEVdGuYTb/fiSX7/vKb9qI+hPQv2nvUpVFx8ogdLZcaXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133199; c=relaxed/simple;
	bh=5SNgYt0Og5PizNXuj2seGZx1s9j3Gc+sbup7rqOyQtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTuezz1ky/ckoHgMWZu43R7u/k3j7Q6rG9ZXSjmBJjkc6dpFjXCjqZDWhj8xsO5fgOEEkqr/j4loDjeZRwLNAO99jVK9a2SQc0QA4gdpPAXd+k39HzSftYA5St4XYyYjUxvoVi3hwUMAM21PN4NXZbTU0ansQHBD7iTRqMWa6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wcwOBTew; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wcwOBTew"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hhFgd0366zlfwJB;
	Fri, 11 Sep 2026 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789133176; x=1791725177; bh=oyAYQmUekWykInIy8DJFeLF8
	1/4M/B/awGBINpSMfs4=; b=wcwOBTewyRtmaR4XDi8co7igum9aW1TlEoXGCYiJ
	qx8cjYVoFBVcGKzygIJfO6Jy0l9QtXyU7Sk3HFZQeiLsT4waASG5aZ27+ohAxtC6
	V1ayq845C/SSqIN7VIGUNLPDAl8sufHJyFtoy49lixQcYXLugwNdXNK1u4JLuurF
	6QgXk0qfZpXii5uQWzul0Qp77Sh7jkhQCPSRSFyG0nDHmQOJUZyn2ssNPuP1D471
	vyTJPoNl5bsW97v1CW3F/IG7oZrWP49nbBNPO+w6mCTbQO/rjXrIZlqYZmModOVU
	j+JeFhJgyVqBERS0n8OViONZvnNP6rUV5CbS6kixuqxViA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GbOTp2oya2F2; Fri, 11 Sep 2026 13:26:16 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hhFfp1RLbzlfvqM;
	Fri, 11 Sep 2026 13:25:53 +0000 (UTC)
Message-ID: <2144051c-268c-40b1-8c22-4be49f0edd17@acm.org>
Date: Fri, 11 Sep 2026 06:25:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Linus Walleij <linusw@kernel.org>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 2:07 AM, Linus Walleij wrote:
> The community has a built in tension around this:
> 
> - One camp that are enthusiast like yourself. That kind of people
>    are running the show inside arch/m68k on Amigas and Ataris.
> 
> - One camp who get their paycheck from present day companies
>    and constantly on top of the latest technology. As can be
>    seen Qualcomm just taped out a brand new ARMv7 SoC
>    named Kuno, for example.
> 
> As you can see this leads to a bit of tension.

That summary looks incomplete to me. Every time a kernel API is modified 
that is used by the RiscPC code, the RiscPC code has to be modified too.
Removing the RiscPC code makes modifying kernel APIs easier. A recent
example is available here: "[PATCH v5] scsi: core: Drop
Scsi_Host.default_lock"
(https://lore.kernel.org/linux-scsi/20260831095821.3486994-1-john.g.garry@oracle.com/).

Bart.
