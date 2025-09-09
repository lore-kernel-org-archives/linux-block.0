Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731C34DCFF
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431146; cv=none; b=IpwqJvw5svK57tVbIOKz/vulOVKfJTaCk2WMcmHdVSm1DGp00kRHyjCd1nXYEpstl14tFe3iYnNfsY2+2LzDFzNMPDNqNALY6AGeN+ekZkauuDRK01fCh5bHSDf3eRdXSJZiBJjZDpawoCFI6hEfS2WvFN6e11MlXw6Cac9o0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431146; c=relaxed/simple;
	bh=8CHr7K7d1f1v8CLSz72YmFzCdsX5ZJJa0FEZjgunY7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C55c4dJnsM6ba1fJn3xm4NWKrJdIL3OW/g1N+0QGYLU1OlfWPT8VHI23IDo586bJxQ5+Wp7VakNKhR1RPwamaE0K96CwBcrbh9QbP3aRgJT1a5/G45wKabPVtA/37Cx78n8Df/OnAqnzK8uxbAMqOslGiyTr2FxKpaT3FLx4tqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILhxlYXa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILhxlYXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvU0fSTgyz2cMM7lj4jbJRyN5QgDN88AlP1jEm41ccg=;
	b=ILhxlYXarP9hF64rhXDuFVlcDA4bB36+nKAiZdsHnK7pYKXqY0lsRge7otShspmajKSYko
	oBEQdEcWcsSYE9DghLPcWyV+l+fqdfaftskFWqY9Kuwzih0kf/q5NAjR2u1a/FpxCyqkjT
	D5HytPzo+0984lhzIKwqsGqlfnxnOPQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-rZq0yZUDPwW9rfJ3H8udsQ-1; Tue,
 09 Sep 2025 11:18:58 -0400
X-MC-Unique: rZq0yZUDPwW9rfJ3H8udsQ-1
X-Mimecast-MFC-AGG-ID: rZq0yZUDPwW9rfJ3H8udsQ_1757431137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDCE3180057D;
	Tue,  9 Sep 2025 15:18:56 +0000 (UTC)
Received: from localhost (unknown [10.45.226.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEFFE19560BA;
	Tue,  9 Sep 2025 15:18:53 +0000 (UTC)
Date: Tue, 9 Sep 2025 16:18:52 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <20250909151851.GB1460@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > > On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
> > >>
> > >> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
> > >>>
> > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> > >>>>
> > >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > >>>> made sure the socket supported a shutdown() method.
> > >>>>
> > >>>> Explicitely accept TCP and UNIX stream sockets.
> > >>>
> > >>> I'm not clear what the actual problem is, but I will say that libnbd &
> > >>> nbdkit (which are another NBD client & server, interoperable with the
> > >>> kernel) we support and use NBD over vsock[1].  And we could support
> > >>> NBD over pretty much any stream socket (Infiniband?) [2].
> > >>>
> > >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> > >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> > >>>
> > >>> TCP and Unix domain sockets are by far the most widely used, but I
> > >>> don't think it's fair to exclude other socket types.
> > >>
> > >> If we have known and supported socket types, please send a patch to add them.
> > >>
> > >> I asked the question last week and got nothing about vsock or other types.
> > >>
> > >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
> > >>
> > >> For sure, we do not want datagram sockets, RAW, netlink, and many others.
> > >
> > > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL
> > > being used in net/vmw_vsock/virtio_transport.c

CC-ing Stefan & Stefano.  Myself, I'm only using libnbd
(ie. userspace) over vsock, not the kernel client.

> > > So you will have to fix this.
> >
> > Rather than play whack-a-mole with this, would it make sense to mark as
> > socket as "writeback/reclaim" safe and base the nbd decision on that rather
> > than attempt to maintain some allow/deny list of sockets?
> 
> Even if a socket type was writeback/reclaim safe, probably NBD would not support
> arbitrary socket type, like netlink, af_packet, or af_netrom.
> 
> An allow list seems safer to me, with commits with a clear owner.
> 
> If future syzbot reports are triggered, the bisection will point to
> these commits.

From the outside it seems really odd to hard code a list of "good"
socket types into each kernel client that can open a socket.  Normally
if you wanted to restrict socket types wouldn't you do that through
something more flexible like nftables?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

