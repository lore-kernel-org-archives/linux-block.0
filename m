Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C343BB138
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777861; cv=none; b=F3roWRiZuXE+IdDdbg7cYttIElHpVkcaQJtXJOCGMp0k7VJwVDCO6VymNlzXBN9ba86bd7WEOHq26Qqu8n8sz4oIBtUUyWBlOUT7m4Q6vtY278lff2dPzOltYyktSExqzPwuj77Pyv8AooipGeI9OuQsPUn8jaJ+HuNunKaGOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777861; c=relaxed/simple;
	bh=XJY46SFT2tw2woxSL2npCopcZjdubF3ln/dU0E9oYLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAueaIs+XXbj6h3/ZomtuzY8x8s/lxqaDg3visBorp2VBFaLEh4LiQ+3P0gxp/n3vhABqgIyl2fms5QxQFlUvdJF8SNrUl7uYmYsqsPoNokehxOOngOa8XYLo7J/DSFzW5scldqEDQtLb886b/nYgGDKOTO+NQ8PYCNRJ/ruSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N59/3a24; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N59/3a24"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hDNnv3sW7zlfvq4;
	Mon,  3 Aug 2026 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785777855; x=1788369856; bh=U/pBYlriS+hGl/mEfXCZmryU
	ra6D6qRJCW/5SiruY00=; b=N59/3a246fGMtrys0RJXJLbzE73bVqLQwDo0Bx8k
	UaV9cBAZl0TXgY+QjySASGRggshpPhLAetEyvbGIA441oW6L7Yx/4MEwep/vyK8E
	AFCU2+bdGz6RpoJhre6FarDMqD3xwu9KBQILte2OidAHbUrVAK3te6k0dbdkdv6N
	FcJ6hpSi7zcL6Jm3hl54FqUgMnGXA7zu0KTrquBjXI6Tkdp0cRlodA2oGkdNp2Dx
	4fPue9H+6SCA10N4jjlXGMm+I5zzh5D+jkCOP2oSHLIzORkELejFt1OnIYuB44Al
	bNp3lpJQ21EF31W6SNIKtzv78HJtKvNMFwICa8PVG1QjQA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3hvtqiLCSEc5; Mon,  3 Aug 2026 17:24:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hDNnn1b4FzlfvpM;
	Mon,  3 Aug 2026 17:24:12 +0000 (UTC)
Message-ID: <7f909bdc-b151-4aca-8602-434685ddc9a5@acm.org>
Date: Mon, 3 Aug 2026 10:24:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] aoe: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Justin Sanders <justin@coraid.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <a5fdc2b4d52006c20e2519f2c395d5d5102cb52b.1785440858.git.bvanassche@acm.org>
 <38edbd6c-c0bc-4d87-af0b-ec5f6be27f0d@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <38edbd6c-c0bc-4d87-af0b-ec5f6be27f0d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/3/26 5:53 AM, Nilay Shroff wrote:
> As I see, iocq->lock guards iocq->head. So shouldn't we annotate
> iocq->head with __guarded_by(iocq->lock)? For instance,
>=20
> struct iocq_ktio {
>  =C2=A0=C2=A0=C2=A0=C2=A0struct list_head head;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __guarded_by(&lock);
>  =C2=A0=C2=A0=C2=A0=C2=A0spinlock_t lock;
> };

How about integrating the change below into this patch?

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 54c57b9f8894..7ceda4ee4e55 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -51,8 +51,8 @@ static struct ktstate *kts;

  /* io completion queue */
  struct iocq_ktio {
-	struct list_head head;
  	spinlock_t lock;
+	struct list_head head __guarded_by(&lock);
  };
  static struct iocq_ktio *iocq;

@@ -1717,8 +1717,8 @@ aoecmd_init(void)
  	}

  	for (i =3D 0; i < ncpus; i++) {
-		INIT_LIST_HEAD(&iocq[i].head);
-		spin_lock_init(&iocq[i].lock);
+		scoped_guard(spinlock_init, &iocq[i].lock)
+			INIT_LIST_HEAD(&iocq[i].head);
  		init_waitqueue_head(&ktiowq[i]);
  		snprintf(kts[i].name, sizeof(kts[i].name), "aoe_ktio%d", i);
  		kts[i].fn =3D ktio;

Thanks,

Bart.
