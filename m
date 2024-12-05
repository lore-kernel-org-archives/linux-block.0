Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2A1DB94F
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397565; cv=none; b=IrU7YoWuY4Dj5cqP7177Juy+K5YnnboqPtZt25JNaGdQJ2rNscJYel2GeBHO8qJCvpYT/hgPB+cYNDau3WHv3Sjal0pwcwj+yOp3WPfFwcH2KGJ8NzpLv/XjcxKfuzhKOIqh3NM8RZA80XNbtjaFKLAUcOj5dBYzBhtVhGgyiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397565; c=relaxed/simple;
	bh=Dj0wl6j81BP5ezzS+B3g052+OLpTSEViE/LBIdXY3QI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hgAcBVjumOfSPggw2O5+W3FoVFep7fTklVceHNXbnSapOGrbNp2swL9qL8V/IH+gSNCeKktPk8QNSiDZd/9TIqhB5nhFU5ARx8fja6A1vTSIFUlN9CqHMbAAYJWKHuCUFOEUQtU1ycPlQcTfoltIfP+AigPT6hW99Z/nox8c0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSxje4/z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSxje4/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733397562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj0wl6j81BP5ezzS+B3g052+OLpTSEViE/LBIdXY3QI=;
	b=VSxje4/z56lreQF4bagJhvWrLwf9l2lk6G0n6Ou/1LwJVKuGpi/p9G45/H5/PVnvneVLoR
	G0eFhzp6nHEj/sGbkkhzdfVzX9yLPR2nrqqFpvgah9t2XLp0DTZzyp2u3LMJJ/gQlr+KAn
	vXAd/9l8h2Eqa+R+yfbs4qbQv50HJlA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-vPjMI2VmMMGNcpbFZ0cZ6Q-1; Thu,
 05 Dec 2024 06:19:19 -0500
X-MC-Unique: vPjMI2VmMMGNcpbFZ0cZ6Q-1
X-Mimecast-MFC-AGG-ID: vPjMI2VmMMGNcpbFZ0cZ6Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499FD1955DA4;
	Thu,  5 Dec 2024 11:19:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D396F1956052;
	Thu,  5 Dec 2024 11:19:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1757450.1733391577@warthog.procyon.org.uk>
References: <1757450.1733391577@warthog.procyon.org.uk> <CAFj5m9Lsgt+iGE6JQV6OgUTNeGb1iiOsXz-eYqGC5Vg85JXL-w@mail.gmail.com> <1225307.1733323625@warthog.procyon.org.uk> <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com> <1695261.1733381740@warthog.procyon.org.uk>
To: Ming Lei <ming.lei@redhat.com>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    linux-block@vger.kernel.org,
    syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Subject: Re: Possible locking bug in the block layer [was syzbot: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1762771.1733397555.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Dec 2024 11:19:15 +0000
Message-ID: <1762772.1733397555@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> Ming Lei <ming.lei@redhat.com> wrote:
> =

> > Sure, please forward because I may not do it without syzbot report con=
text.
> =

> I've forwarded it with the patch for my bug on top.

That seems to have fixed it.

David

