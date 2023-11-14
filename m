Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F93405D3
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9cI0X9t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563BFA
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699970398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYPXXj5daXKu0nSGHby7zzX70NLqmYuwNX64bvFkFvM=;
	b=g9cI0X9tOJugEfAFcv0xNBUUMAE359AIDrB6ro8psDRt4R3zJ0kulnSeiFDzEYF0PhB2LJ
	oqM97kDKglhOR1g6Zsq6egY4Pyy4pqkCm8e/8Q3QiVYDC2lWrE6agZNHSW7TaCBfgi/EKE
	XuuQYlg2q11Oj/gR98zCqB4TdjQrdC0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-R6yk9k3TNuy4v33it-GHow-1; Tue,
 14 Nov 2023 08:59:55 -0500
X-MC-Unique: R6yk9k3TNuy4v33it-GHow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 819153C1CC41;
	Tue, 14 Nov 2023 13:59:54 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 533612166B26;
	Tue, 14 Nov 2023 13:59:54 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 3B7C730C1A8C; Tue, 14 Nov 2023 13:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 37CD33FB77;
	Tue, 14 Nov 2023 14:59:54 +0100 (CET)
Date: Tue, 14 Nov 2023 14:59:54 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Li Nan <linan666@huaweicloud.com>, Zdenek Kabelac <zkabelac@redhat.com>, 
    Christoph Hellwig <hch@infradead.org>, 
    Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org, 
    dm-devel@redhat.com
Subject: Re: [PATCH v3 0/4] brd discard patches
In-Reply-To: <c1955b5b-4980-55dd-a1b7-54c19831d9d2@huaweicloud.com>
Message-ID: <c2653ea-b4ab-4131-50f1-82e450633194@redhat.com>
References: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com> <c1955b5b-4980-55dd-a1b7-54c19831d9d2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-1372342412-1699970394=:3371809"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1372342412-1699970394=:3371809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 10 Nov 2023, Li Nan wrote:

> friendly ping...

Jens? Do you want this patch series or not?

Mikulas

> 在 2023/8/10 18:07, Mikulas Patocka 写道:
> > Hi
> > 
> > Here I'm submitting the ramdisk discard patches for the next merge window.
> > If you want to make some more changes, please let me now.
> > 
> > Changes since version 2:
> > There are no functional changes, I only moved the switch statement
> > conversion to a separate patch, so that it's easier to review.
> > 
> > Patch 1: introduce a switch statement in brd_submit_bio
> > Patch 2: extend the rcu regions to cover read and write
> > Patch 3: enable discard
> > Patch 4: implement write zeroes
> > 
> > Mikulas
> > 
> 
> -- 
> Thanks,
> Nan
> 
--185210117-1372342412-1699970394=:3371809--

