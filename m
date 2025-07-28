Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B494253B40
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697654; cv=none; b=eoQlCmpVyQUXY5iqWdyYENpZjU1h8VHUkmIKHII34Gn2v2aGHQFvWdsz7DjlmxEfhfWo3Gh6LX8asRAywoCrlTADvu/VPWJie2nY5cJfKTFaiKZ+Dy7nDV5UUr9arC/4r9kzbmKzTCTLQFkNaKTZ8ZWFWSZhDSOL7FKoFyoeYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697654; c=relaxed/simple;
	bh=2WYLlFBuSxQfs/1LLevLDi638tIfmaJgKR/TD+MNXy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9xKAn6amqfXQabmtqv7KF9TTH7DOUo0LgP4LanE7+rZb0Y2vnHGe5HJSGl3Lr8pFQ6wM1UDY1B6NbVCRnMfepjoPHQP318V8wUF1Cynzl5PvD2ABpyh+4dlrG4Z+TrjHCtqnstGV3qsMqD3zAu4DdIsDwj//AzgwKU+lZD7CxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ouiTrzWs; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ouiTrzWs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 872DB43193;
	Mon, 28 Jul 2025 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WYLlFBuSxQfs/1LLevLDi638tIfmaJgKR/TD+MNXy0=;
	b=ouiTrzWsgD9QlmRLC5hcGPNPP91KeeRXF4nZvJhiVN1D4S9W0y8DP8Hylel8so4beu8/gB
	qnXsZsihGVIBfHo5ZAKgmUW4Vu+lZuyQPAhlsejd6D6HzlC55MYj90LvlIrsKu+gqFjFJ7
	5yNPDW3aDzBpwn8ONjHXN3Q9+DSoUxQpNkDUPeYKk69k07rwxXXhQwThA+kG4sQCuUe+ST
	abgISZCw+eo2oSlVw4pdbzcsFPbxLKZq/XQ4ahFIytIkqyAMQabIy9j52UnNYGSBjuD2xd
	4jlCq2aZEWnxZHTsvsKC5Qi/XnKW3UMhohdDgH7nEfgbCRsvaiRbS1RqstcBZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>,  linux-block@vger.kernel.org,  Christoph
 Hellwig <hch@lst.de>,  Ming Lei <ming.lei@redhat.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 8/8] mtd_blkdevs: Remove the quiesce/unquiesce calls on
 frozen queues
In-Reply-To: <20250702203845.3844510-9-bvanassche@acm.org> (Bart Van Assche's
	message of "Wed, 2 Jul 2025 13:38:43 -0700")
References: <20250702203845.3844510-1-bvanassche@acm.org>
	<20250702203845.3844510-9-bvanassche@acm.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 28 Jul 2025 12:14:03 +0200
Message-ID: <8734agsjv8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopegsvhgrnhgrshhstghhvgesrggtmhdrohhrghdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehmihhnghdrlhgvihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtp
 dhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Bart,

On 02/07/2025 at 13:38:43 -07, Bart Van Assche <bvanassche@acm.org> wrote:

> Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen,
> protecting request queue changes with blk_mq_quiesce_queue() and
> blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
> Hence this patch that removes quiesce/unquiesce calls on frozen queues.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Sorry for the long delay, I initially marked this patch for applying it
on my side, but it looks like it depends on the first patches of the
series, so I'm not taking it.

Here is a formal A-b in case this patch must be carried through another
tree:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Otherwise let me know, I can pick it up at -rc1.

Sorry again for the delay.
Thanks,
Miqu=C3=A8l
