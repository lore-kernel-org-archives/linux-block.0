Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762E238C1B
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982281; cv=none; b=fYgSAmo1fwN9n596zQiP6GZKexyhn3s2MTDhgHrWZIcSZJwNVyFoGRu/iCEpurrMJ4pe2soyFM+BHziIxa8GIquvP5tsF30aLxaunYyGWDbqtWWuP0s4/2KnD3sGIlncStVNdHfLcBkpK4zIDw9G+wsl6I9UbZmT3YrDxeboOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982281; c=relaxed/simple;
	bh=jv/h7RW9VPWCJi8PKzPhgz74GeDXNY1BzR0eSKu/X6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6wOOUhOn3ishCnjZoHXtJ2kSauXejSWr4Rf+BB69J2/Lz/IXz00k5Zz3mSSiHhLZXuCqJSq+6oRt4KFhuR51WLDsvaP97o+44GjiybLXp15OTfd+AUec6KwNlKjfF4vkp+ir1Vm1FeX2jSlbK3ZaflWWYrlYEY804CTGOqjGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOsxYD4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOsxYD4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763982279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dj4aD9OHkRc+idg8PqslDsENxuTCxgqBYCZ+pFPNN/8=;
	b=OOsxYD4uzNaQ0NXymZt0V2ykZ1fm2HNH8XJ1+zIp4RGkS5+DltQQrF7oOrBWT4dWBi3A1N
	PWS+YWfwSm55zgCdfTVu1IbhQ0yFCuZI2W74Y7miSvo+t7Rnf/zHhHBelPgZgUn6G1vGGf
	c30xpookaBcK3JDPap+bKqTQqbVnN8A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-HY_Y74OnOtiQcY1b1TE0NA-1; Mon,
 24 Nov 2025 06:04:35 -0500
X-MC-Unique: HY_Y74OnOtiQcY1b1TE0NA-1
X-Mimecast-MFC-AGG-ID: HY_Y74OnOtiQcY1b1TE0NA_1763982272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B741956054;
	Mon, 24 Nov 2025 11:04:32 +0000 (UTC)
Received: from localhost (unknown [10.45.224.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E0743003761;
	Mon, 24 Nov 2025 11:04:29 +0000 (UTC)
Date: Mon, 24 Nov 2025 11:04:28 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	Eric Dumazet <edumazet@google.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Re: Userland used in writeback path was Re: [PATCH] nbd: restrict
 sockets to TCP and UDP
Message-ID: <20251124110428.GA13479@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
 <aRyzUc/WndKJBAz0@duo.ucw.cz>
 <20251118181623.GK1427@redhat.com>
 <aR2JjR1yKHCCPalO@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2JjR1yKHCCPalO@duo.ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 19, 2025 at 10:10:37AM +0100, Pavel Machek wrote:
> On Tue 2025-11-18 18:16:23, Richard W.M. Jones wrote:
> > On Tue, Nov 18, 2025 at 06:56:33PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > > > 
> > > > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > > > made sure the socket supported a shutdown() method.
> > > > 
> > > > Explicitely accept TCP and UNIX stream sockets.
> > > 
> > > Note that running nbd server and client on same machine is not safe in
> > > read-write mode. It may deadlock under low memory conditions.
> > > 
> > > Thus I'm not sure if we should accept UNIX sockets.
> > 
> > Both nbd-client and nbdkit have modes where they can mlock themselves
> > into RAM.
> 
> kernel needs memory. It issues write-back to get some.
> nbd-client does syscall. Maybe writing to storage?
> That syscall does kmalloc().
> That kmalloc now needs something like PF_MEMALLOC flag.
> 
> mlock() is not enough.

There are loads of use cases for NBD over a Unix domain socket that
have nothing to do with storage.  nbdkit supports all sorts of purely
virtual and remote devices.

Practically, we use this feature successfully all the time without any
issues, so we'd appreciate it not being broken over some very
theoretical concern that you haven't even been able to demonstrate in
a test case.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

