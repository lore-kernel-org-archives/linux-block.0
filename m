Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B417C208
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381750; cv=none; b=ETOFQBcno5HaHPVa6BBHx+P8MYcW0BJ9QKdFNygqmZisqt+UhQ1mV1O7N2A0g7wANrJq2Czwf7Z6LyXoFFD2zyOPssTl1/AtS9V5e/RB85qfT6cgBQMI9eUc/5iiDb3eNiHc9ELC42j9F8D+o6aU8roBZLuGse5vORi7hVpd82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381750; c=relaxed/simple;
	bh=62HYgqB/RNaGRehc+TDHiBhE0EgEylU6R+8FXB/0uYk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=S7oauYPW7wC+SGr2U6UqVGUsYxFAwUPO3lEyZR4BxDuPT0jGhfCjdSKb3ZyTI01tuGbpQX23SZMkEWQ71Wf7T13yp8Lc7uEEhQtzWe9d784YCgi60fZeSDKKx1NP6uyBC9Jxn3hgaY9mWeYFeZQv8f8QpMczwrx1YOts7NECDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=az2r5KPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az2r5KPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733381747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfG3GJfBMSNs5+h7rkqIYVTKHbFzErZ/qzyn3XUiz7M=;
	b=az2r5KPJ0ugIctPjVAqztPZBAr73NDXtt77Dotg7TaGKPFE00h/iZOqvIaJR4Zd1XsTDEF
	aTesc8bSOgjudZef6M8MGRdvxsnJNIJqU71b5sPbLaGGEcVl8BgPXgN4zhw2L/+KRLqQVR
	PKptLdnqlQQ7xf/01oAaEmAJE6N7arE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-Cm5xet5bMG-S0-OYU2gMSA-1; Thu,
 05 Dec 2024 01:55:45 -0500
X-MC-Unique: Cm5xet5bMG-S0-OYU2gMSA-1
X-Mimecast-MFC-AGG-ID: Cm5xet5bMG-S0-OYU2gMSA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 535451944B35;
	Thu,  5 Dec 2024 06:55:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F93C19560A2;
	Thu,  5 Dec 2024 06:55:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com>
References: <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com> <1225307.1733323625@warthog.procyon.org.uk>
To: Ming Lei <ming.lei@redhat.com>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    linux-block@vger.kernel.org
Subject: Re: Possible locking bug in the block layer [was syzbot: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1695260.1733381740.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Dec 2024 06:55:40 +0000
Message-ID: <1695261.1733381740@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ming Lei <ming.lei@redhat.com> wrote:

> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-b=
lock.git
> for-6.14/block

syzbot isn't on the To: or cc: lines.  I can forward the request if you wa=
nt?

David

