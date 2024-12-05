Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F51D5AC6
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391606; cv=none; b=gXstGMWtJ8Zy1l3Ek9A4Jt0Z8hGZJ/IkHrDei156kZCs8cyN9dk9C1K2i9lfd+m4Rckiyugidy1YYNScywdkGE65bPd0vyn2+GDeWSSdBs3WRk5f3E/OnxRmX5PSVjfjgZA4DapyMu50p4eIEfqB1CbZYMVdVQd+OZYAkMwpyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391606; c=relaxed/simple;
	bh=AEetenBIqjRA2xqBCfxJejWYCiE0GL1mtdT+KSfkhU4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bM9MFMuaPHdHeZP4t+I7QsBKKUbRBAXpU5drLUD9vEWqeBhGZVykbhEExx9klUAM/AxrKHIpvG3tlxj0e6JHkm5ae0Iar301pBVq+9qJvnhymsnuH/AywDDFN9wbWVLby0F5GKBIcsR60Rr/Y/abeRFloKE5+nJClY/+qykqLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/oyVGQN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/oyVGQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733391603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEetenBIqjRA2xqBCfxJejWYCiE0GL1mtdT+KSfkhU4=;
	b=A/oyVGQNDPAOpKcqbYQHoCWDLHhTabeEFOTw7HRdymuUFzM+YVrg5jfQt9T/dBWgAh2w90
	jzkugspGMR7pEtUohq8lgV9bt31DZDi5pywGHyMuuvWE/YB8bqFZGVmE2YktGvxcGmCpoY
	sltDIhiUI1qd2ke9qco0mlet0S80rXw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-gMhMgaGROFa5PPjvrVRLgQ-1; Thu,
 05 Dec 2024 04:40:00 -0500
X-MC-Unique: gMhMgaGROFa5PPjvrVRLgQ-1
X-Mimecast-MFC-AGG-ID: gMhMgaGROFa5PPjvrVRLgQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDB1A1955DD8;
	Thu,  5 Dec 2024 09:39:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1A2F1956095;
	Thu,  5 Dec 2024 09:39:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAFj5m9Lsgt+iGE6JQV6OgUTNeGb1iiOsXz-eYqGC5Vg85JXL-w@mail.gmail.com>
References: <CAFj5m9Lsgt+iGE6JQV6OgUTNeGb1iiOsXz-eYqGC5Vg85JXL-w@mail.gmail.com> <1225307.1733323625@warthog.procyon.org.uk> <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com> <1695261.1733381740@warthog.procyon.org.uk>
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
Content-ID: <1757449.1733391576.1@warthog.procyon.org.uk>
Date: Thu, 05 Dec 2024 09:39:37 +0000
Message-ID: <1757450.1733391577@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Ming Lei <ming.lei@redhat.com> wrote:

> Sure, please forward because I may not do it without syzbot report context.

I've forwarded it with the patch for my bug on top.

David

