Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4282D82
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261673; cv=none; b=kjKpxoNcyrj93gIJvjBxjJKfrTAtTAVqi+ATNHZpaRmHy/KfLPuqVWWJKASjDDiadQFJlxG+qzeyX2vU052R12bPYF3srWEimXXObNgkkDjQk5dHR3LQbIlO7gqs0ywri8fMMj3bJbiVq5KMxeWsyECeiA57YOgmIFRlB92d03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261673; c=relaxed/simple;
	bh=xUdiC/C/FB1HermFhx2PZsedDIOi30jxcmWujhpcSF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kvjv2pf85h80nHyWZ4u1Il7vtajQd2/bF6oJ8vgGYUkiQYtuJ09lD76NkekMRdVdo8h4Rse55cGfnNkyeGyA39YViX9bLbgddGw20/WaHRLBe9eb4dF2v4qEV3NFB2U9l0vl55R+8Ak9OLwK6/QF96XsREab1XN/1LbgeTze+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eG/WGId+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG/WGId+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713261671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpBP92ju/zKUelRiCD1w3lUYbwSRJMYjtZlqPjhPI5o=;
	b=eG/WGId+yvMFkl7oP1RiYgziuEZ/uNeAx5FpGgbLciJe8he5QSrrXP/85rXpnzw15GRN4+
	vPcToY1hkijI6qPQ3W/SJof82nm5r9ly51/CFccMLoewHFb/ye0KQ/YTpD/0WryID4wv81
	/6WrPk0uccUc8dAbQHPRq7pfBfg9o1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-2wn-X8ofPNqkbDwzZINy9g-1; Tue, 16 Apr 2024 06:01:09 -0400
X-MC-Unique: 2wn-X8ofPNqkbDwzZINy9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0F78011AF;
	Tue, 16 Apr 2024 10:01:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F035828D;
	Tue, 16 Apr 2024 10:01:05 +0000 (UTC)
Date: Tue, 16 Apr 2024 18:00:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Changhui Zhong <czhong@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, ming.lei@redhat.com
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at
 io_uring/io_uring.c:2835 io_ring_exit_work+0x2b6/0x2e0
Message-ID: <Zh5MSQVk54tN7Xx4@fedora>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk>
 <Zh3TjqD1763LzXUj@fedora>
 <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Apr 16, 2024 at 10:26:16AM +0800, Changhui Zhong wrote:
> > >
> > > I can't reproduce this here, fwiw. Ming, something you've seen?
> >
> > I just test against the latest for-next/block(-rc4 based), and still can't
> > reproduce it. There was such RH internal report before, and maybe not
> > ublk related.
> >
> > Changhui, if the issue can be reproduced in your machine, care to share
> > your machine for me to investigate a bit?
> >
> > Thanks,
> > Ming
> >
> 
> I still can reproduce this issue on my machine，
> and I shared machine to Ming，he can do more investigation for this issue，
> 
> [ 1244.207092] running generic/006
> [ 1246.456896] blk_print_req_error: 77 callbacks suppressed
> [ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
> flags 0x8800 phys_seg 1 prio class 0

The failure is actually triggered in recovering qcow2 target in generic/005,
since ublkb0 isn't removed successfully in generic/005.

git-bisect shows that the 1st bad commit is cca6571381a0 ("io_uring/rw:
cleanup retry path").

And not see any issue in uring command side, so the trouble seems
in normal io_uring rw side over XFS file, and not related with block
device.


Thanks,
Ming

