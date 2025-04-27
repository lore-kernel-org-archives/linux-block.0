Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220783594E
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745723446; cv=none; b=XVameBPbv27oCQUTce6dkvt+B32msShC84wobNO7wyzXuRf2r9U01Cw9ukRLr5Wnxs0ozXlljM/n0F4bWSP96E1cxG9LBXubJpcrhTvCMf8GjQVKYc7u5Mf5X1z3Foy6HYAeRA5iU0iY08gz6bIhcNPePL3/AyXvJQZT13WA4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745723446; c=relaxed/simple;
	bh=ZL2JtVCTdnttfew+PW/Fhj30dx1kDxgULLErKBgLmRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0QhrLDLCa23uIvDgowaZ4Fg+ojc1pXF5Fnzzrm7o6qL3rCK0OchRzqA/lVdPm12iS9e97/VkAaEzhGQtKZs2LivwlYVlwnxYbXakaQJ1s8WTgKwY2X8czvA3NTNlu4ANEpqmFV/Ioq4lJAH4Wk3Bpst74xt+d5Ev4dopj8sbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsJvGW3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsJvGW3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745723442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag4C3NW8TXzP4XHQ623DNosVLh70/ylHvpEX7UJzfeg=;
	b=NsJvGW3EGkTE4Lm9icRBNZ+4W4Vp2WPM6FuJ+rKdZAiP2vwwsAh0IZE7h6oG0SULqM8QjD
	zu/mnAOcLt9G0XsYGUA+tIvY8NulLa42BgsxSLYqJKouM3iUv7lpTMtaQ9MvT/JbGEaNQc
	mgvTtQAVWaXtKlZSwgu4sg9UEXi76Jw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-HUOY_lhdOsGtn0WayQAvVg-1; Sat,
 26 Apr 2025 23:10:41 -0400
X-MC-Unique: HUOY_lhdOsGtn0WayQAvVg-1
X-Mimecast-MFC-AGG-ID: HUOY_lhdOsGtn0WayQAvVg_1745723440
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13FFC19560BB;
	Sun, 27 Apr 2025 03:10:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93BD930001A2;
	Sun, 27 Apr 2025 03:10:35 +0000 (UTC)
Date: Sun, 27 Apr 2025 11:10:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
Message-ID: <aA2gJqKs31-_diER@fedora>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-4-ming.lei@redhat.com>
 <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>
 <aA2XwIcOPysPTra9@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aA2XwIcOPysPTra9@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Apr 26, 2025 at 08:34:40PM -0600, Keith Busch wrote:
> On Sat, Apr 26, 2025 at 03:42:59PM -0700, Caleb Sander Mateos wrote:
> > On Sat, Apr 26, 2025 at 2:41 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > UBLK_F_SUPPORT_ZERO_COPY requires ublk server to issue explicit buffer
> > > register/unregister uring_cmd for each IO, this way is not only inefficient,
> > > but also introduce dependency between buffer consumer and buffer register/
> > > unregister uring_cmd, please see tools/testing/selftests/ublk/stripe.c
> > > in which backing file IO has to be issued one by one by IOSQE_IO_LINK.
> > 
> > This is a great idea!
> 
> This is very similiar to something I proposed off-list, and the feedback

Looks we both think of it, :-)

> back then was this won't work because the back-end ring that wants to
> use the zero-copy buffer isn't the same as the ublk server ring
> recieving notification of a new command; the ublk driver has no idea
> which uring to register the bvec with. Also, this is using the request
> "tag" as the io_uring buf index, which wouldn't work when the ublk
> server ring handles multiple ublk devices due to the tag collisions.
> 
> If you're can make those trade-offs, then this is a great simplification
> to the whole thing.

The io_uring fd & buffer index can be provided from 'ublksrv_io_cmd'.

https://lore.kernel.org/linux-block/aA2RNG3-WzuQqEN6@fedora/

If we only support IORING_ENTER_REGISTERED_RING, 32bit is enough for
io_uring fd & buffer index, and there is still 64bits available if not
taking UBLK_F_ZONED into account.


Thanks, 
Ming

