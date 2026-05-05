Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E493845B3;
	Tue,  5 May 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978697; cv=none; b=PqCmxDFjVmHbFWA8slhndDuqvgoxdbNRUEgyzoGT9gXjco4zTF9Cdq777x2+or3Q+R3fxDMdaMS6nXkl4v/9gyN5yAjx3rPf6DSxrocQgzdoDY5EMFyYtIRWeQWAAYgu8lYfHynQKav9FT4UkEfVQLIrSaNFEJIed4Mq0chz5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978697; c=relaxed/simple;
	bh=5Dy+uqqG81IVVF7jNcyPT96dYqgXe053xO3iZv+ix0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/kkbmtPjUMsJzl/hqyirSZ00lqK12irjDIPvUzPhOfIl9qjdHVOvCcnwkPIU/eyYd9EITC1j/P4dglxQZRFiGVLp7QEg2+h4B6//XIfRaOnUQDZWDgFwGtJrYQ60Sz0eTXD4z1CRyP9J+cdW+AutfvZcgNlbUMB9eXac67kLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=S9TbMjId; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="S9TbMjId"
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 2D79C815C4;
	Tue, 05 May 2026 13:50:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id VodCBu0SHa60-hOYYrlhz;
	Tue, 05 May 2026 13:50:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777978232; bh=5Dy+uqqG81IVVF7jNcyPT96dYqgXe053xO3iZv+ix0A=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=S9TbMjIdu0xyA+J55RtRFNNw+iov2WmXcB80m4HiksMcJtA3lToDrkGfzX2+VMkK1
	 aycfj3gb81NP9K9CbCV+I08d/pQL6+/YGpH+16rLEgq1xwQ6fovwoKrRtcP/ydkVxJ
	 vKZ05HxUkBNekDiQAcZIpT6HhitV/MBCu5x/S8hY=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cc43af47fa75a7fe4bea41fda91dd2e49723243c.camel@yandex.ru>
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	 <hch@lst.de>, linux-block@vger.kernel.org, lvc-project@linuxtesting.org
Date: Tue, 05 May 2026 13:50:31 +0300
In-Reply-To: <2026050551-rice-cider-db2e@gregkh>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
	 <2026050551-rice-cider-db2e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 11:57 +0200, Greg Kroah-Hartman wrote:

> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.=C2=A0 Please read:
> =C2=A0=C2=A0=C2=A0 https://www.kernel.org/doc/html/latest/process/stable-=
kernel-rules.html
> for how to do this properly.

In this particular case, "it or an equivalent fix must already exist in Lin=
ux
mainline (upstream)" is hardly possible because related stuff under block/
was massively redesigned since them. So I would prefer to wait for feedback
from block subsystem maintainers before doing anything else.

Dmitry
