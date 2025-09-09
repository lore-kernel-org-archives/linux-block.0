Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1431CA7D
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438186; cv=none; b=B8knASxjHyP/GehRHkOwM2DjtPSOqfp7t+gDbpVjpEFROeiq7reTrAsbrBWc3aqvwBq35dWlXRD4pCxx4YDaUjX3196ZWGVNo3s1bh0Cojl0oRzcOuVR6CCw55IbKa/Tr5NYUmNsQFifn5PaVxqN5chLvoWgxdd6n5j2ZMwy9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438186; c=relaxed/simple;
	bh=1776x5WNuqGQXUdGA1Vx2rw6TH5/YKvwrIJKYIxvYXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxRBRJvaUBeC88BIQu1T3IX0PJ+ZGqqleSjFU5iFJqO5RwYfho1N1km46r0F/j5xjQzaA5XpwDmPfDYKHNuqTtsj7wLR+/Bnx2uVbg+v1Fj4asyq3j+dkY9vDC6JFp44dc5oeZMqmTXJ20dNb8+u/lZSax0P2f/JPeuzAyFkkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVP1spJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVP1spJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757438183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+QDVhIlXWVQYYj2EpRYmCRki550WcQuDpwFnUZzK9w=;
	b=YVP1spJ6wS1Oj7i8G0LtRXHmN97wMdePK4HxsQt4NRnjCI7DOWJPryGsivGML+jPHnjEsC
	CCC1VkpLaI87SiqGlBMyEGPK4UBlr6XfpYwdcS+2OnYXnx0aqi7r0rw3+d3o6/g79+CoI/
	vijraMbZRU1qoBT+sHxSoDL7a1DHq8I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-8q5rAUrtNUyreY5zjAp-hg-1; Tue,
 09 Sep 2025 13:16:18 -0400
X-MC-Unique: 8q5rAUrtNUyreY5zjAp-hg-1
X-Mimecast-MFC-AGG-ID: 8q5rAUrtNUyreY5zjAp-hg_1757438177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CF4A195608E;
	Tue,  9 Sep 2025 17:16:16 +0000 (UTC)
Received: from localhost (unknown [10.45.226.196])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2D5A1800447;
	Tue,  9 Sep 2025 17:16:14 +0000 (UTC)
Date: Tue, 9 Sep 2025 18:16:13 +0100
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
Message-ID: <20250909171613.GB2390@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909151851.GB1460@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

So I was playing with this (see commands at end if you want to try)
and it turns out that the nbd-client program doesn't support vsock
anyway.  Of course you could still call the kernel APIs directly to
set up the socket, but it wouldn't be straightforward.

nbd-client did support Sockets Direct Protocol (SDP) but support was
removed in 2023.

The userspace tools like nbdinfo (part of libnbd) work fine, but of
course that's not relevant to the kernel NBD client.

Rich.


Commands to test vsock:

  $ virt-builder fedora-42

  $ nbdkit --vsock memory 1G \
           --run '
      qemu-system-x86_64 -machine accel=kvm:tcg \
                         -cpu host -m 4096 \
                         -drive file=fedora-42.img,format=raw,if=virtio \
                         -device vhost-vsock-pci,guest-cid=3
   '

Inside the guest:

  # dnf install nbdinfo
  # nbdinfo nbd+vsock:///
  (details of the 1G RAM disk will be shown here)

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

