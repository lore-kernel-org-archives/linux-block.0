Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFFE494A19
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687030; cv=none; b=QME8JUbc0XiY1vIeNLCCV66SLtbTYnyWXKzSD7XkLlYBv49tHzoQDpz6BYXrX4bylnlj3dLaP+intZ2BHpTdHdh2cAYvE53cBcltNE68+AhPudtlzOZrKoXJxjg43NkTAB43VfavvBJ5SqOptfBUxDfGQtz7z/VDnAcALH7v2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687030; c=relaxed/simple;
	bh=//OyCPFODt9WWRcc3+70UONwCSivWbTtAeKxTLmZs1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbFqHMsg2tANc/8V0onHv+illqe5KSrCUh5+MTTYxtib3heRC/PxYXVCKlf5Fauvnv974KQ37XV5eMN1hs5bcwaJW8/PXhhCwT5m/5jPgDFOmoqnI3lBIz8iHwDz7PLa9u3LpEAIxm+a470YvH51Svdl3SmbXESgD46LLWbTx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=N8sTDJ6G; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="N8sTDJ6G"
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5f11:0:640:6821:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id C767E82CC7;
	Wed, 13 May 2026 18:43:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp) with ESMTPSA id XhNiH43RTuQ0-2eNjmJCd;
	Wed, 13 May 2026 18:43:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778687015; bh=//OyCPFODt9WWRcc3+70UONwCSivWbTtAeKxTLmZs1A=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=N8sTDJ6GPpMu/Mm4X0oEC1ZGp1DNUuq56+SoYX9t1aXPi/9jeJwJlt1/9nNf5c5hn
	 gooIqXv1Y5c5F0wz60MZvA3CulxPfwMbnN7+zcYhZFCno+gGKd/aZucxsnVe0Zz9u6
	 oASF3hQH7bjnJOwU6945TwUXh4U9j/26C5LTxpU8=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <f2d980020f2735d3acd25e660bdc4918b6745782.camel@yandex.ru>
Subject: Re: [PATCH] block: bio-integrity: fix memory leak in
 bio_integrity_map_user()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Weidong Zhu <weizhu@fiu.edu>, Chao Shi	
 <cshi008@fiu.edu>, Sungwoo Kim <iam@sung-woo.kim>, Dave Tian
 <daveti@purdue.edu>,  Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, linux-block@vger.kernel.org, 	lvc-project@linuxtesting.org
Date: Wed, 13 May 2026 18:43:33 +0300
In-Reply-To: <CADUfDZo972nK0iE79ogjob5_VN2-i-7L5XypDbdW0bupNfTo+g@mail.gmail.com>
References: <20260513070515.528861-1-dmantipov@yandex.ru>
	 <CADUfDZo972nK0iE79ogjob5_VN2-i-7L5XypDbdW0bupNfTo+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 07:32 -0700, Caleb Sander Mateos wrote:

> I preferred your previous patch changing iov_iter_extract_pages() to
> free the page array on error.

Me too.

> Even though bio_integrity_map_user() is the only current caller that
> requests iov_iter_extract_pages() allocate a page array, others could
> be added in the future and forget to do this freeing.

It was in the past. Again, the whole thing was started from 6.12, see
https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yandex.ru
(the commit message is somewhat messy BTW), and I'm definitely interested
in supporting that longterm too.

> Is there a reason you decided to modify bio_integrity_map_user() instead?

Sure. Such an ad-hoc quick fixes are much more likely to be integrated
within a reasonable time and effort from the maintainer. OTOH better wait f=
or
Jens' answer before doing anything else.

Dmitry
